# Tambah hostname shineeducationbali.test ke hosts (jalankan sebagai Administrator)
$hostsPath = "$env:SystemRoot\System32\drivers\etc\hosts"
$entries = @"

# Shine Education Bali - local dev
127.0.0.1 app.shineeducationbali.test
127.0.0.1 landing.shineeducationbali.test
127.0.0.1 api.shineeducationbali.test
127.0.0.1 shineeducationbali.test
"@

$content = Get-Content $hostsPath -Raw
if ($content -match 'shineeducationbali\.test') {
  Write-Host "Hostname shineeducationbali.test sudah ada di hosts." -ForegroundColor Yellow
  exit 0
}
Add-Content -Path $hostsPath -Value $entries
Write-Host "Hostname berhasil ditambah. Buka https://app.shineeducationbali.test dll." -ForegroundColor Green
