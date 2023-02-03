<#
.SYNOPSIS
Builds all artifacts.

.EXAMPLE
build.ps1 -configuration Release
Builds all artifacts in the Release project configuration.
#>
[CmdletBinding(SupportsShouldProcess)]
Param(
    # The project configuration to build
    [Parameter()]
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Debug',

    # Clean previous build
    [Parameter()]
    [switch]$Clean = $false,

    # Run tests after building
    [Parameter()]
    [switch]$Test = $false,

    # The verbosity level
    [Parameter()]
    [ValidateSet('minimal', 'normal', 'detailed', 'diagnostic')]
    [string]$Verbosity = 'minimal'
)

$target = "$PSScriptRoot/src/factorial.test/factorial.test.csproj"
$buildArgs = "--nologo --configuration $Configuration --verbosity $Verbosity $target"

Push-Location .
try {
    if ($PSCmdlet.ShouldProcess($target, "dotnet")) {
        # FIXME unconditionally clean?
        if ($Clean) {
            Invoke-Expression ("dotnet clean " + $buildArgs)
            if ($LASTEXITCODE -ne 0) {
                throw "dotnet clean failed!"
            }
            Remove-Item $PSScriptRoot/bin -Recurse -Force
            Remove-Item $PSScriptRoot/obj -Recurse -Force
        }

        if ($Test) {
            Invoke-Expression ("dotnet test " + $buildArgs)
            if ($LASTEXITCODE -ne 0) {
                throw "dotnet test failed!"
            }
        } else {
            Invoke-Expression ("dotnet build " + $buildArgs)
            if ($LASTEXITCODE -ne 0) {
                throw "dotnet build failed!"
            }
        }
    }
} catch {
    Write-Error "Build failed!"
    # we have the try so that PS fails when we get failure exit codes from build steps.
    throw;
} finally {
    Pop-Location
}
