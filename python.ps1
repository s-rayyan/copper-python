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

# Func that takes object and returns object
$ps_input = [Func[object, object]] {
    param($prompt)
    Read-Host $prompt
}

# Action that takes object
$ps_print = [Action[object]] {
    param($msg)
    Write-Host $msg
}

# Inject them
$scope.SetVariable("input", $ps_input)
$scope.SetVariable("print", $ps_print)
function Check-Syntax {
    param([string]$code)

    try {
        $source = $engine.CreateScriptSourceFromString($code)
        $source.Compile()
        return $true
    }
    catch [Microsoft.Scripting.SyntaxErrorException] {
        $msg = $_.Exception.Message
        $lineNumber = $_.Exception.Line
        $column = $_.Exception.Column

        if (-not $lineNumber -and $msg -match "line (\d+)") {
            $lineNumber = $matches[1]
        }

        Write-Host "Syntax error on line ${lineNumber}: $msg" -ForegroundColor Red

        # Show offending line if possible
        if ($lineNumber) {
            $lines = $code -split "`n"
            if ($lineNumber -le $lines.Length) {
                $errorLine = $lines[$lineNumber - 1]
                Write-Host $errorLine -ForegroundColor Yellow
                if ($column) {
                    $pointer = " " * ($column - 1) + "^"
                    Write-Host $pointer -ForegroundColor Cyan
                }
            }
        }

        return $false
    }
    catch {
        Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

if ([string]::IsNullOrEmpty($pythonFile)) {
    Write-Host "IronPython Interactive Shell (type 'exit()' to quit)"
    while ($true) {
        $line = @"
import sys
sys.path.append(r"$HOME\copper-python-main\lib")
"@
        $line += Read-Host "py>>> "

        if ($line -eq "exit()" -or $line -eq "quit()") {
            break
        }

        if (Check-Syntax $line) {
            try {
                $engine.Execute($line, $scope)
            }
            catch [IronPython.Runtime.SystemExit] {
                break
            }
            catch {
                Write-Host ("Error: " + $_.Exception.Message) -ForegroundColor Red
            }
        }
    }
}
else {
    $code = @"
import sys
sys.path.append(r"$HOME\copper-python-main\lib")

"@
    $code += Get-Content $pythonFile -Raw -Encoding UTF8

    if (Check-Syntax $code) {
        $engine.Execute($code, $scope)
    }
}
