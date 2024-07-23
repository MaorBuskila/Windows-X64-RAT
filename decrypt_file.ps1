param (
    [string]$inputFile,
    [string]$outputFile
)

$KEY = "jikoewarfkmzsdlhfnuiwaejrpaw"
function xor {
    param (
        [byte[]]$data,
        [string]$key
    )

    $output = New-Object byte[] $data.Length
    for ($i = 0; $i -lt $data.Length; $i++) {
        $current = $data[$i]
        $current_key = [byte][char]$key[$i % $key.Length]
        $output[$i] = $current -bxor $current_key
    }
    return $output
}

try {
    $plaintext = [System.IO.File]::ReadAllBytes($inputFile)
} catch {
    Write-Error "[-] Error reading file: $inputFile"
    exit 1
}

$ciphertext = xor $plaintext $KEY

try {
    [System.IO.File]::WriteAllBytes($outputFile, $ciphertext)
    Write-Output "[+] File written to $outputFile"
} catch {
    Write-Error "[-] Error writing file: $outputFile"
    exit 1
}