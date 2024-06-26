# .EXTERNALHELP AzPolicyTest.psm1-Help.xml
Function Test-JSONContent {
  [CmdLetBinding()]
  Param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'ProduceOutputFile', HelpMessage = 'Specify the file paths for the policy definition files.')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'NoOutputFile', HelpMessage = 'Specify the file paths for the policy definition files.')]
    [String]$path,

    [Parameter(ParameterSetName = 'ProduceOutputFile', Mandatory = $true)][ValidateNotNullOrEmpty()][string]$OutputFile,
    [Parameter(ParameterSetName = 'ProduceOutputFile', Mandatory = $false)][ValidateSet('NUnitXml', 'LegacyNUnitXML')][string]$OutputFormat = 'NUnitXml'
  )
  #Test files
  $FileContentTestFilePath = Join-Path $PSScriptRoot 'fileContent.tests.ps1'
  Write-Verbose "JSON Content Pester Test file Path: '$DefinitionStructureTestFilePath'" -verbose
  $testContainerData = @{
    path = $path
  }
  $config = @{
    Run = @{
      Container = New-PesterContainer -Path $FileContentTestFilePath -Data $testContainerData
      PassThru = $true
    }
    TestResult = @{
      TestSuiteName = 'Json Content Tests'
      Enabled = $true
    }
    Output     = @{
      Verbosity = 'Detailed'
    }
    Should = @{
        ErrorAction = 'Continue'
    }
  }
  #File Content tests
  If ($PSCmdlet.ParameterSetName -eq 'ProduceOutputFile') {
    $config.TestResult.Add('OutputFormat', $OutputFormat)
    $config.TestResult.Add('OutputPath', $OutputFile)
  }

  Invoke-Pester -Configuration $config
}

# .EXTERNALHELP AzPolicyTest.psm1-Help.xml
Function Test-AzPolicyDefinition {
  [CmdLetBinding()]
  Param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'ProduceOutputFile', HelpMessage = 'Specify the file paths for the policy definition files.')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'NoOutputFile', HelpMessage = 'Specify the file paths for the policy definition files.')]
    [String]$path,

    [Parameter(ParameterSetName = 'ProduceOutputFile', Mandatory = $true)][ValidateNotNullOrEmpty()][string]$OutputFile,
    [Parameter(ParameterSetName = 'ProduceOutputFile', Mandatory = $false)][ValidateSet('NUnitXml', 'LegacyNUnitXML')][string]$OutputFormat = 'NUnitXml'
  )
  #Test files
  $DefinitionStructureTestFilePath = join-path $PSScriptRoot 'policyDefStructure.tests.ps1'
  Write-Verbose "Policy Definition Pester Test file Path: '$DefinitionStructureTestFilePath'" -verbose

  $testContainerData = @{
    path = $path
  }
  $config = @{
    Run = @{
      Container = New-PesterContainer -Path $DefinitionStructureTestFilePath -Data $testContainerData
      PassThru = $true
    }
    TestResult = @{
      TestSuiteName = 'Policy Definition Tests'
      Enabled = $true
    }
    Output     = @{
      Verbosity = 'Detailed'
    }
    Should = @{
      ErrorAction = 'Continue'
    }
  }

  #File Content tests
  If ($PSCmdlet.ParameterSetName -eq 'ProduceOutputFile') {
    #Common - File content tests
    $config.TestResult.Add('OutputFormat', $OutputFormat)
    $config.TestResult.Add('OutputPath', $OutputFile)
  }

  Invoke-Pester -Configuration $config
}

# .EXTERNALHELP AzPolicyTest.psm1-Help.xml
Function Test-AzPolicySetDefinition {
  [CmdLetBinding()]
  Param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'ProduceOutputFile', HelpMessage = 'Specify the file paths for the policy definition files.')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'NoOutputFile', HelpMessage = 'Specify the file paths for the policy definition files.')]
    [String]$path,

    [Parameter(ParameterSetName = 'ProduceOutputFile', Mandatory = $true)][ValidateNotNullOrEmpty()][string]$OutputFile,
    [Parameter(ParameterSetName = 'ProduceOutputFile', Mandatory = $false)][ValidateSet('NUnitXml', 'LegacyNUnitXML')][string]$OutputFormat = 'NUnitXml'
  )
  #Test files
  $DefinitionStructureTestFilePath = join-path $PSScriptRoot 'policySetDefStructure.tests.ps1'
  Write-Verbose "Policy Initiative Pester Test file Path: '$DefinitionStructureTestFilePath'" -verbose

  $testContainerData = @{
    path = $path
  }
  $config = @{
    Run = @{
      Container = New-PesterContainer -Path $DefinitionStructureTestFilePath -Data $testContainerData
      PassThru = $true
    }
    TestResult = @{
      TestSuiteName = 'Policy Initiative Tests'
      Enabled = $true
    }
    Output     = @{
      Verbosity = 'Detailed'
    }
    Should = @{
      ErrorAction = 'Continue'
    }
  }

  #File Content tests
  If ($PSCmdlet.ParameterSetName -eq 'ProduceOutputFile') {
    #Common - File content tests
    $config.TestResult.Add('OutputFormat', $OutputFormat)
    $config.TestResult.Add('OutputPath', $OutputFile)
  }

  Invoke-Pester -Configuration $config
}