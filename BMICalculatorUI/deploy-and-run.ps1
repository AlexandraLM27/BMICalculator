# Căi
$uiPublish = "../publish-ui-temp"
$apiPath = "../BMICalculatorAPI"
$deployPath = "../Deploy"

# 1. Curăță wwwroot
Remove-Item -Path "$apiPath/wwwroot/*" -Recurse -Force -ErrorAction SilentlyContinue

# 2. Publică UI în folder temporar
dotnet publish ../BMICalculatorUI -c Release -o $uiPublish

# 3. Copiază UI în wwwroot API
Copy-Item -Path "$uiPublish/wwwroot/*" -Destination "$apiPath/wwwroot" -Recurse -Force

# 4. Publică API în folderul Deploy
dotnet publish $apiPath -c Release -o $deployPath

# 5. Rulează API-ul publicat
Start-Process "dotnet" -ArgumentList "BMICalculatorAPI.dll" -WorkingDirectory $deployPath

# 6. Așteaptă și deschide browserul
Start-Sleep -Seconds 2
Start-Process "http://localhost:5035"
