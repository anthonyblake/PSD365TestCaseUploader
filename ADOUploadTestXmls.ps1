#ADO D365 XML Uploader
param ([Parameter(Mandatory)]$organisation, [Parameter(Mandatory)]$project, [Parameter(Mandatory)]$pat, $xmlLocation='.\')

$ErrorActionPreference = "Stop"
$imported = "$xmlLocation\imported"

#Get XML files
$xmlFiles = Get-ChildItem $xmlLocation -Filter *.xml

foreach ($xmlFile in $xmlFiles) {
    write-host $xmlFile

    [xml]$axTestXml = Get-Content $xmlFile
    $xmlPayload = New-Object -TypeName System.Xml.XmlDocument

    $workItemName = $axTestXml.Recording.Name
    write-host $workItemName

    Write-Output "Root Scope Nodes:"
    foreach ($node in $axTestXml.Recording.RootScope.Children.Node) {
        $id = $node.Id
        $description = $node.Description
        Write-Output "Node ID: $id, Description: $description"
    }

    # Create the root element <steps>
    $stepsElement = $xmlPayload.CreateElement("steps")
    $stepsElement.SetAttribute("id", "0")
    $stepsElement.SetAttribute("last", "50")

    # Add the <steps> element to the document
    $xmlPayload.AppendChild($stepsElement)

    [int]$stepId = 2

    function Process-Nodes {
        param (
            [Parameter(ValueFromPipeline=$true)]
            [System.Xml.XmlNode]$Node
        )

        # Check if the current node's type is not 'Scope'
        if ($Node.Type -ne "Scope") {
            $description = $Node.Description
            $type = $Node.Type
            Write-Output "Step: $description"
            
            # Add each step with its parameters
            # Create the <step> element
            $stepElement = $xmlPayload.CreateElement("step")
            $stepElement.SetAttribute("id", $stepId)
            $stepElement.SetAttribute("type", "ValidateStep")
            $xmlPayload.DocumentElement.AppendChild($stepElement)

            # Create the <parameterizedString> element
            $paramElement = $xmlPayload.CreateElement("parameterizedString")
            $paramElement.SetAttribute("isformatted", "true")
            $paramElement.InnerXml = $description

            $stepElement.AppendChild($paramElement)

            # Create the <parameterizedString> element
            $paramElement = $xmlPayload.CreateElement("parameterizedString")
            $paramElement.SetAttribute("isformatted", "true")
            $paramElement.InnerXml = ""

            $stepElement.AppendChild($paramElement)
            $script:stepId++
        }

        # Recursively process child nodes if they exist
        if ($Node.HasChildNodes) {
            foreach ($childNode in $Node.Children.Node) {
                Process-Nodes -Node $childNode
            }
        }
    }

    if ($axTestXml.Recording.RootScope -and $axTestXml.Recording.RootScope.Children -and $axTestXml.Recording.RootScope.Children.Node) {
        Write-Output "Nodes where Type does not equal 'Scope':"
        # Pass the child nodes directly to the function
        foreach ($node in $axTestXml.Recording.RootScope.Children.Node) {
            Process-Nodes -Node $node
        }
    } else {
        Write-Output "No nodes found at RootScope.Children.Node"
    }

    #Write-Output "$stepsElement"

    function WriteXmlToScreen ([xml]$xml)
    {
        $StringWriter = New-Object System.IO.StringWriter;
        $XmlWriter = New-Object System.Xml.XmlTextWriter $StringWriter;
        $XmlWriter.Formatting = "indented";
        $xml.WriteTo($XmlWriter);
        $XmlWriter.Flush();
        $StringWriter.Flush();
        Write-Output $StringWriter.ToString();
    }

    WriteXmlToScreen $xmlPayload

    #Send payload to Azure DevOps!
    $bodyObj = @(@{
        op = "add"
        path = "/fields/System.Title"
        from = $null
        value = $workItemName
        },
        @{
        op = "add"
        path = "/fields/Microsoft.VSTS.TCM.Steps"
        from = $null
        value = $xmlPayload.OuterXml
        })

    $bodyJson = $bodyObj | ConvertTo-Json -Depth 3  # The depth parameter is used for nested objects
    Write-Output $bodyJson
        
    #Upload D365 test cases to Azure DevOps
    .\ADOTestCaseUploader.ps1 -organisation $organisation -project $project -pat $pat -body $bodyJson

    $dest = $xmlFile.DirectoryName + "\imported"
    Write-Output $dest
    If (!(Test-Path -LiteralPath $dest))
      {New-Item -Path $dest -ItemType 'Directory' -Force}

      Move-Item -Path $xmlFile.FullName -Destination $dest
}