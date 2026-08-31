[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, HelpMessage = "The fingerprint of the key you want to check exists")]
    [string]$KeyFingerprint
)

$hasKey = [bool](
    gpg --list-secret-keys --with-colons |
    ConvertFrom-Csv -Delimiter ':' -Header Type,Validity,KeyLength,KeyAlgo,KeyID |
    Where-Object { $_.Type -eq "ssb" -and $_.KeyId -eq $KeyFingerprint}
)

if ($hasKey) {
    Write-Output "true"
} else {
    Write-Output "false"
}
