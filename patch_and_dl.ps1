# This will completely download the youtube.supermemo.org website and patch it to work.

Invoke-WebRequest -Uri 'https://youtube.supermemo.org/' -OutFile 'index.html'
Invoke-WebRequest -Uri 'http://yui.yahooapis.com/combo?2.9.0/build/yahoo-dom-event/yahoo-dom-event.js&2.9.0/build/dragdrop/dragdrop-min.js&2.9.0/build/container/container-min.js' -OutFile 'yui_dom_event_v2.9.0_min.js'
Invoke-WebRequest -Uri 'http://yui.yahooapis.com/combo?2.8.0r4/build/container/assets/skins/sam/container.css' -OutFile 'yui_container_v2.8.0r4.css'

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
$newString = "/"
$oldString2 = "/iv/images/"
$newString2 = "/YouTube.htm/images/"
$oldString3 = "http://yui.yahooapis.com/combo?2.9.0/build/yahoo-dom-event/yahoo-dom-event.js&2.9.0/build/dragdrop/dragdrop-min.js&2.9.0/build/container/container-min.js"
$newString3 = "/YouTube.htm/yui_dom_event_v2.9.0_min.js"
$oldString4 = "http://yui.yahooapis.com/combo?2.8.0r4/build/container/assets/skins/sam/container.css"
$newString4 = "/YouTube.htm/yui_container_v2.8.0r4.css"
# $newString5 = "/images/icons.png"
# $oldString5 = "/YouTube.htm/images/icons.png"

# Replace all occurrences of the old string with the new string
$newContent = $fileContent -replace [regex]::Escape($oldString), $newString
$newContent = $newContent -replace [regex]::Escape($oldString2), $newString2
$newContent = $newContent -replace [regex]::Escape($oldString3), $newString3
$newContent = $newContent -replace [regex]::Escape($oldString4), $newString4
# $newContent = $newContent -creplace "(?s)$oldString5", $newString5

# Write the modified content back to the file, overwriting it
$newContent | Set-Content -Path $filePath

Write-Host "String replaced in $filePath"

