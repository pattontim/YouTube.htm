# This will completely download the youtube.supermemo.org website and patch it to work.

Invoke-WebRequest -Uri 'https://youtube.supermemo.org/' -OutFile 'index.html'

# Specify the base URL
$baseUrl = 'https://youtube.supermemo.org/'

# Specify the files to download
$fileUrls = @(
    '/images/transparent.png',
    '/images/icons.png'
)

# Iterate through each file URL
foreach ($fileUrl in $fileUrls) {
    # Construct the full URL
    $fullUrl = $baseUrl + $fileUrl

    # Get the file name from the URL
    $fileName = [System.IO.Path]::GetFileName($fileUrl)

    # Construct the local path to save the file
    $localPath = Join-Path -Path (Resolve-Path .) -ChildPath $fileUrl.TrimStart('/')

    # Create the directory structure if it doesn't exist
    $directory = [System.IO.Path]::GetDirectoryName($localPath)
    if (-not (Test-Path -Path $directory -PathType Container)) {
        New-Item -Path $directory -ItemType Directory -Force
    }

    # Download the file
    Invoke-WebRequest -Uri $fullUrl -OutFile $localPath

    Write-Host "Downloaded: $fullUrl to $localPath"
}

# Specify the file path
$filePath = "index.html"

# Read the content of the file
$fileContent = Get-Content -Path $filePath -Raw

# Specify the string to be replaced and the replacement string
$oldString = "http://supermemory.info/"
$oldString2 = "/iv/images/"
$newString = "/"
$newString2 = "/images/"

# Replace all occurrences of the old string with the new string
$newContent = $fileContent -replace [regex]::Escape($oldString), $newString
$newContent = $newContent -replace [regex]::Escape($oldString2), $newString2

# Write the modified content back to the file, overwriting it
$newContent | Set-Content -Path $filePath

Write-Host "String replaced in $filePath"

