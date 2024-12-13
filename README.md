<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![project_license][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<h3 align="center">D365 Test Case to Azure DevOps Uploader</h3>

  <p align="center">
    PowerShell scripts to iterate a folder of D365 Finance and Operations developer XML task recordings, parse the XML for the test steps, and upload to an Azure DevOps project as new work items with the type Test Case.
    <br />
    <a href="https://github.com/anthonyblake/PSD365TestCaseUploader"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/anthonyblake/PSD365TestCaseUploader">View Demo</a>
    ·
    <a href="https://github.com/anthonyblake/PSD365TestCaseUploader/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/anthonyblake/PSD365TestCaseUploader/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>

<!-- ABOUT THE PROJECT -->
## About The Project

PowerShell scripts to iterate a folder of D365 Finance and Operations developer XML task recordings, parse the XML for the test steps, and upload to an Azure DevOps project as new work items with the type Test Case. 

This is useful if you need to avoid using LCS, but want some automation in the creation of your Test Cases in Azure DevOps. This may be becuase you are using a BPM not in LCS, or you may be using Power Platform to deploy your D365 environments rather than LCS, or even preparing for the near future where LCS will be deprecated.

The project contains 2 main PowerShell scripts.

`ADOTestCaseUploader.ps1`

This script connects to Azure DevOps via the API and uploads a single pre-formatted test case. 

`ADOUploadTestXmls.ps1`

This script is actually poorly named. It iterates a folder for XML files, which must be developer test XMLs generated from Dynamics 365 Finance and Operations Apps task recordings. For each XML, it opens and iterates the markup looking for test steps, which it adds to a payload ready to be uploaded to Azure DevOps as a test case. It then calls ADOTestCaseUploader to call the Azure DevOps API and upload a new work item with type test case, including a payload which contains the test case steps.

`AllowUnsignedScripts.ps1`

You may need to run the command in this file to allow you to run the unsigned PowerShell scripts in this repo.

```powershell
set-executionpolicy remotesigned
```
> [!WARNING]
> This PowerShell script is currently crude. Files aren't cleaned up after uploading, and there is no error handling. If you are having issues, please reach out, but you may need to tweak the script for your needs.

### Built With

[![PowerShell][PowerShell-badge]][PowerShell-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

From Dynamics 365 Finance and Operations Apps, create a number of task recordings. At the end of each recording, click "Save as developer recording". This is the XML containing the test steps we need for Azure DevOps.

Save the recordings to the same folder as the PowerShell scripts.

### Prerequisites

- D365 Finance and Operations Apps instance, to create task recordings
- Azure DevOps personal access token

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/anthonyblake/PSD365TestCaseUploader.git
   ```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Usage

Run the following PowerShell:

```powershell
#Upload D365 test cases to Azure DevOps
.\ADOUploadTestXmls.ps1 -organisation your_devops_org_name -project your_devops_project_name -pat azure_devops_personal_access_token
```
This will convert any XMLs in the source folder and upload them to Azure DevOps as test cases.
_For more examples, please refer to the [My Website](https://anthonyblake.github.io)_

<p align="right">(<a href="#readme-top">back to top</a>)</p>

See the [open issues](https://github.com/anthonyblake/PSD365TestCaseUploader/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Top contributors:

<a href="https://github.com/anthonyblake/PSD365TestCaseUploader/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=anthonyblake/PSD365TestCaseUploader" alt="contrib.rocks image" />
</a>

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

Anthony Blake - [@anthonyblakedev](https://twitter.com/anthonyblakedev) - anthonyblakedev@gmail.com

Project Link: [https://github.com/anthonyblake/PSD365TestCaseUploader](https://github.com/anthonyblake/PSD365TestCaseUploader)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/anthonyblake/PSD365TestCaseUploader.svg?style=for-the-badge
[contributors-url]: https://github.com/anthonyblake/PSD365TestCaseUploader/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/anthonyblake/PSD365TestCaseUploader.svg?style=for-the-badge
[forks-url]: https://github.com/anthonyblake/PSD365TestCaseUploader/network/members
[stars-shield]: https://img.shields.io/github/stars/anthonyblake/PSD365TestCaseUploader.svg?style=for-the-badge
[stars-url]: https://github.com/anthonyblake/PSD365TestCaseUploader/stargazers
[issues-shield]: https://img.shields.io/github/issues/anthonyblake/PSD365TestCaseUploader.svg?style=for-the-badge
[issues-url]: https://github.com/anthonyblake/PSD365TestCaseUploader/issues
[license-shield]: https://img.shields.io/github/license/anthonyblake/PSD365TestCaseUploader.svg?style=for-the-badge
[license-url]: https://github.com/anthonyblake/PSD365TestCaseUploader/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/anthonyblakedynamics
[product-screenshot]: images/screenshot.png
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Angular-url]: https://angular.io/
[Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[Svelte-url]: https://svelte.dev/
[Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[Laravel-url]: https://laravel.com
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com 
[PowerShell-badge]: https://img.shields.io/badge/Built_with-PowerShell-blue
[PowerShell-url]: https://learn.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.4
