param (
    [Parameter(Position = 0)]
    [string]$pythonFile
)
$ironPath = "$HOME\copper-python-main\net462"
# Load IronPython DLLs
Add-Type -Path "$ironPath\IronPython.dll"
Add-Type -Path "$ironPath\IronPython.Modules.dll"
Add-Type -Path "$ironPath\Microsoft.Scripting.dll"
Add-Type -Path "$ironPath\Microsoft.Dynamic.dll"

# Engine + scope
$engine = [IronPython.Hosting.Python]::CreateEngine()
$scope = $engine.CreateScope()

# PowerShell-backed input
$ps_input = [Func[string, string]] {
    param($prompt)
    Read-Host $prompt
}

# PowerShell-backed print
$ps_print = [Action[string]] {
    param($msg)
    Write-Host $msg
}

# Inject them
$scope.SetVariable("input", $ps_input)
$scope.SetVariable("print", $ps_print)

if ([string]::IsNullOrEmpty($pythonFile)) {
    Write-Host "IronPython Interactive Shell (type 'exit()' to quit)"
    while ($true) {
	$line = @"
import sys
sys.path.append(r"$HOME\copper-python\lib")

"@
        $line += Read-Host "py>>> "
        if ($line -eq "exit()" -or $line -eq "quit()") {
            break
        }
        try {
            $engine.Execute($line, $scope)
        }
        catch [IronPython.Runtime.SystemExit] {
            break
        }
        catch {
            Write-Host ("Error: " + $_.Exception.Message)
        }
    }
}
else {
    $code = @"
import sys
sys.path.append(r"$HOME\copper-python\lib")


"@
echo $code
    $code += Get-Content $pythonFile -Raw
    $engine.Execute($code, $scope)
}
