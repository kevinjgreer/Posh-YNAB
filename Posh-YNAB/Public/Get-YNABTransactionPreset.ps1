function Get-YNABTransactionPreset {
    <#
    .SYNOPSIS
    List transaction presets.
    .DESCRIPTION
    List transaction presets from the preset file.
    .EXAMPLE
    Get-YNABTransactionPreset -PresetName 'Coffee'
    Get the Coffee preset.
    .EXAMPLE
    Get-YNABTransactionPreset -PresetName 'Coffee','Soda'
    Get the Coffee and Soda presets.
    .EXAMPLE
    Get-YNABTransactionPreset -PresetName '*'
    Get all presets
    .PARAMETER PresetName
    The name of the preset to list, accepts a string or array of strings. Supports wildcards.
    .PARAMETER List
    Returns a list of all presets
    #>
    [CmdletBinding(DefaultParameterSetName='List')]
    param(
        [Parameter(Mandatory=$true,Position=0,ParameterSetName='LoadPreset')]
        [Alias('Preset')]
        [String[]]$PresetName,

        [Parameter(ParameterSetName='List')]
        [Switch]$List
    )

    begin {}

    process {
        # Import the preset file if one exists
        $presetFile = "$profilePath\Presets.xml"
        if (Test-Path $presetFile) {
            $presets = Import-Clixml $presetFile

            switch ($PsCmdlet.ParameterSetName) {
                'LoadPreset' {
                    $PresetName.ForEach{
                        $name = $_
                        $presets.GetEnumerator().Where{$_.Name -like $name}
                    }
                }
                'List' {
                    $presets
                }
            }
        }
    }
}
