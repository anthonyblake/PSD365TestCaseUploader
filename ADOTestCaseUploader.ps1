param ([Parameter(Mandatory)]$organisation, [Parameter(Mandatory)]$project, [Parameter(Mandatory)]$pat, $body)
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f "", $pat)))

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json-patch+json")
$headers.Add("Authorization", "Basic $base64AuthInfo")

$requestUri = 'https://dev.azure.com/'+$organisation+"/"+$project + '/_apis/wit/workitems/$Test%20Case?api-version=7.1'
write-host $requestUri
$response = Invoke-RestMethod $requestUri -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json