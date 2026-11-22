# 🧚 FolderFairy

**A little magic for your messy folders.**

FolderFairy is a simple PowerShell-based file organizer for Windows. It automatically sorts files into folders based on their extensions.

## ✨ Features

- Automatic file categorization
- Preview mode before moving files
- Safe file movement using an explicit apply option
- Automatic folder creation
- Duplicate filename protection
- Error handling
- Organization summary
- Unsupported file detection

## 📂 Supported Categories

| Category | File extensions |
|---|---|
| Images | JPG, JPEG, PNG, GIF, WEBP |
| Documents | PDF, DOCX, DOC, TXT, PPTX, XLSX |
| Videos | MP4, MKV, MOV, AVI |
| Audio | MP3, WAV, AAC |
| Archives | ZIP, RAR, 7Z |
| Others | Unsupported extensions |

## 🚀 How to Use

### 1. Preview files

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\FolderFairy.ps1"
```

This displays the proposed organization without moving files.

### 2. Organize files

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\FolderFairy.ps1" -Apply
```

This creates category folders and moves files.

## 📁 Project Structure

```text
FolderFairy/
├── FolderFairy.ps1
├── README.md
└── TestFiles/
    ├── Images/
    ├── Documents/
    ├── Videos/
    ├── Audio/
    ├── Archives/
    └── Others/
```

## 🛠️ Requirements

- Windows
- Windows PowerShell 5.1 or later

## 🎯 Purpose

FolderFairy was created as a beginner-friendly PowerShell project to demonstrate file handling, automation, conditional logic, and safe file organization.

## 👩‍💻 Author

Created as a Hack Club project.

**FolderFairy — Making messy folders magical!**