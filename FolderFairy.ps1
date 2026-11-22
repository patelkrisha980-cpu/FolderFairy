
param(
    [switch]$Apply
)

# =====================================
# FolderFairy - Your File Organizer
# Version 3.0
# =====================================

Write-Host ""
Write-Host "================================" -ForegroundColor Magenta
Write-Host "       FOLDER FAIRY" -ForegroundColor Cyan
Write-Host "  A little magic for your files"
Write-Host "================================" -ForegroundColor Magenta
Write-Host ""

$source = Join-Path $PSScriptRoot "TestFiles"

if (!(Test-Path $source)) {
    Write-Host "TestFiles folder not found!" -ForegroundColor Red
    exit 1
}

$categories = @{
    "Images"    = @(".jpg", ".jpeg", ".png", ".gif", ".webp")
    "Documents" = @(".pdf", ".docx", ".doc", ".txt", ".pptx", ".xlsx")
    "Videos"    = @(".mp4", ".mkv", ".mov", ".avi")
    "Audio"     = @(".mp3", ".wav", ".aac")
    "Archives"  = @(".zip", ".rar", ".7z")
}

# Scan only files directly inside TestFiles
$files = @(Get-ChildItem -Path $source -File)

if ($files.Count -eq 0) {
    Write-Host "No new files to organize!" -ForegroundColor Yellow
    exit 0
}

if ($Apply) {
    Write-Host "APPLY MODE - Organizing files." -ForegroundColor Yellow
} else {
    Write-Host "PREVIEW MODE - No files will be moved." -ForegroundColor Yellow
}

Write-Host ""

# Create summary counters
$summary = @{
    "Images"    = 0
    "Documents" = 0
    "Videos"    = 0
    "Audio"     = 0
    "Archives"  = 0
    "Others"    = 0
}

$movedCount = 0

foreach ($file in $files) {

    $extension = $file.Extension.ToLower()
    $destination = "Others"

    foreach ($category in $categories.Keys) {
        if ($extension -in $categories[$category]) {
            $destination = $category
            break
        }
    }

    $summary[$destination]++

    $destinationFolder = Join-Path $source $destination
    $targetPath = Join-Path $destinationFolder $file.Name

    # Prevent duplicate filenames
    $counter = 1

    while (Test-Path $targetPath) {
        $newName = "{0}_{1}{2}" -f $file.BaseName, $counter, $file.Extension
        $targetPath = Join-Path $destinationFolder $newName
        $counter++
    }

    if ($Apply) {
        try {
            if (!(Test-Path $destinationFolder)) {
                New-Item -ItemType Directory -Path $destinationFolder -ErrorAction Stop | Out-Null
            }

            Move-Item -LiteralPath $file.FullName -Destination $targetPath -ErrorAction Stop

            Write-Host "$($file.Name) -> $destination [MOVED]" -ForegroundColor Green
            $movedCount++
        }
        catch {
            Write-Host "ERROR: Could not move $($file.Name)" -ForegroundColor Red
            Write-Host $_.Exception.Message -ForegroundColor Red
        }
    }
    else {
        Write-Host "$($file.Name) -> $destination" -ForegroundColor Green
    }
}

# Display organization summary
Write-Host ""
Write-Host "================================" -ForegroundColor Magenta
Write-Host "       ORGANIZATION SUMMARY" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Magenta

Write-Host "Total files scanned: $($files.Count)"
Write-Host ""

foreach ($category in @("Images", "Documents", "Videos", "Audio", "Archives", "Others")) {
    Write-Host "${category}: $($summary[$category])"
}

Write-Host ""

if ($Apply) {
    Write-Host "Successfully moved: $movedCount" -ForegroundColor Green
    Write-Host "Organization process completed!" -ForegroundColor Cyan
}
else {
    Write-Host "Preview completed successfully!" -ForegroundColor Cyan
    Write-Host "Run with -Apply to move files." -ForegroundColor Yellow
}

Write-Host ""