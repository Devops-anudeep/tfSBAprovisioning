param(
      [Parameter(Mandatory=$True)]
      [ValidateScript({
        if( -Not ($_ | Test-Path) ){
          throw "File '$_' does not exist"
        }
        if(-Not ($_ | Test-Path -PathType Leaf) ){
          throw "The tomcatZip argument must be a file. Folder paths are not allowed."
        }
        if($_ -notmatch "(\.zip)"){
          throw "The file specified in the path argument must be of type zip"
        }
        return $true
      })]
      [System.IO.FileInfo]$tomcatZip
    ,
      [Parameter(Mandatory=$True)]
      [ValidateScript({
       if( -Not ($_ | Test-Path) ){
         throw "File or folder '$_' does not exist"
       }
        return $true
      })]
      [System.IO.FileInfo]$destination
    )
$currentDir = $PSScriptRoot
# Get version number from tomcatZip
Write-Output "Fetching version number form the zip file"
$tomcatZip.BaseName -match "apache-tomcat-(?<content>).*-windows*"
$versionNumber = $matches['content']
Write-Output $versionNumber
# Check if temporary directory exist and expand archive
Write-Output "Expanding Archive..."
$unpackedTomcatExists = Get-ChildItem -Directory -Filter apache-tomcat-*
if (!$unpackedTomcatExists) {
    Expand-Archive "$($tomcatZip.FullName)" -DestinationPath "$currentDir\"
}
# Copy to destination
Write-Output "Copying to Destination...."
Copy-Item -Path "$currentDir\$unpackedTomcatExists\" -Recurse -Destination "$destination\Tomcat$versionNumber"
 
#$ports = Get-Content "$PSScriptRoot\ports.json" -raw | ConvertFrom-Json
 
# Change ports in server.xml
#((Get-Content "$destination\Tomcat$versionNumber\conf\server.xml" -Raw) -replace ('8005', "$($ports.shutdownPort)")) | Set-Content "$destination\Tomcat$versionNumber\conf\server.xml"
# Rename tomcatXw.exe to correct name.
#Rename-Item -Path "$destination\Tomcat$versionNumber\bin\tomcat9w.exe" -NewName "Tomcat$versionNumber.exe"
 
# Ask if to install service
$choices  = '&Yes', '&No'
$installService = $Host.UI.PromptForChoice('', 'Do you want to install services?', $choices, 1)
   
if ($installService -eq 0) {
  Set-Location $destination\Tomcat$versionNumber\bin
  #Installing Tomcat$versionNumber as a service"
  Get-Location
  cmd.exe /c "service.bat install Tomcat$($versionNumber)"
  $logConfig = $($logbackFile.FullName)
} 
