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

    # Run tests after building
    [Parameter()]
    [switch]$Test = $false,

    # The verbosity level
    [Parameter()]
    [ValidateSet('minimal', 'normal', 'detailed', 'diagnostic')]
    [string]$Verbosity = 'minimal'
)

$target = "$PSScriptRoot/src/factorial.test/factorial.test.csproj"
# FIXME argument splatting?
# $buildCLI = "dotnet build `"$PSScriptRoot\src\Nerdbank.GitVersioning.sln`" /m /verbosity:$MsBuildVerbosity /nologo /p:Platform=`"Any CPU`" /t:build,pack"
$buildArgs = "--nologo --verbosity $Verbosity"

if ($Configuration) {
    $buildArgs += " --configuration $Configuration"
}

Push-Location .
try {
    if ($PSCmdlet.ShouldProcess($target, "dotnet")) {
        #FIXME remove boilerplate, use array splatting
        if ($Test) {
            $buildCmd = "dotnet test " + $buildArgs
            Invoke-Expression $buildCmd
            if ($LASTEXITCODE -ne 0) {
                throw "dotnet test failed!"
            }
        } else {
            $buildCmd = "dotnet build " + $buildArgs
            Invoke-Expression $buildCmd
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