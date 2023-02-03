# Sign build artifact(s) with code signing certificate (Authenticode)

$cwd = Split-Path $MyInvocation.MyCommand.Definition

$certificate = Join-Path $cwd mykey.pfx

if(!(Test-Path -PathType Leaf $certificate)) {
    Write-Error "Unable to find certificate file" -Category ObjectNotFound -ErrorAction Stop
}

$packagePath = Join-Path ($cwd | Split-Path | Split-Path) bin

# EDIT: Specify packages to sign
$packages = (Get-ChildItem $packagePath\**\factorial.*.nupkg).FullName

$cmdArgs = '-CertificatePath', $certificate, `
    '-CertificatePassword', 'zeissimt', `
    '-TimeStamper', 'http://timestamp.digicert.com', `
    '-HashAlgorithm', 'SHA256', `
    '-OutputDirectory', (Join-Path ($cwd | Split-Path | Split-Path) out signed)

foreach ($pkg in $packages) {
    Write-Information "Signing nuget package $pkg" -InformationAction Continue
    & nuget sign $pkg @cmdArgs
}
Write-Information "Finished signing nuget package(s)" -InformationAction Continue
