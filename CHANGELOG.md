# VS Code Server Templates - Changelog

This document tracks all changes made to the VS Code Server AMP templates during development and troubleshooting.

## 🎯 **Templates Overview**

This repository contains **two** VS Code Server templates for AMP:

1. **Community Code-Server** (`code-server.*`) - Port 8443
2. **Microsoft VS Code Server** (`vscode-server.*`) - Port 8444

---

## 📅 **Changelog**

### **2025-01-10 - Latest Changes**

#### **CRITICAL: Fix Microsoft VS Code Server License Acceptance** (Commit: d1544e5c)
- **Issue**: VS Code Server failing with exit code 1 and license error message
- **Error Message**: `To accept the license terms, start the server with --accept-server-license-terms`
- **Root Cause**: Microsoft VS Code Server requires explicit license acceptance flag
- **Log Analysis**: Update/chmod stages successful ✅, but server immediately exited ❌
- **Solution**: 
  - Added `--accept-server-license-terms` flag to Microsoft VS Code Server command line
  - Simplified command line arguments by removing unused `AuthArgs`/`ConfigArgs`
  - Added proper `--host` and `--port` binding for web interface access
  - Set workspace argument default to `workspace` directory
  - Community code-server uses `--bind-addr` format (different from Microsoft version)
- **Result**: Both templates now have correct startup arguments and should start successfully
- **Files Changed**: `vscode-server.kvp`, `code-server.kvp`, both config JSON files

#### **CRITICAL: Fix Microsoft VS Code Server Directory Structure** (Commit: a5b5f1a9)
- **Issue**: `chmod` failing with exit code 1 - `/AMP/vscode-server/bin/code-server` not found
- **Root Cause**: Microsoft VS Code Server extracts to `vscode-server-linux-x64/` subdirectory, not root
- **Log Analysis**: Download and extraction successful, but `SetExecutableFlag` failed because file wasn't at expected path
- **Solution**: 
  - Added `mv vscode-server-linux-x64/* .` to flatten directory structure after extraction
  - Fixed Windows executable extension from `.cmd` to `.exe` for Microsoft version
  - Applied fix to both Linux architectures (x64 and ARM64)
- **Result**: Executable now properly located at `bin/code-server` as expected by AMP
- **Files Changed**: `vscode-server.kvp`, `vscode-serverupdates.json`

#### **Fix SetExecutableFlag Path** (Commit: 2634b51b)
- **Issue**: Error 127 persisting after directory structure fixes
- **Analysis**: Studied official AMP templates (uptime-kuma, altv) for executable path patterns
- **Solution**: Changed `SetExecutableFlag` to use `{{$FullRootDir}}` instead of `{{$FullBaseDir}}`
- **Rationale**: Official templates show executable paths are relative to RootDir, not BaseDirectory
- **Files Changed**: `code-serverupdates.json`, `vscode-serverupdates.json`

#### **CRITICAL: Fix Error 127 - Preserve Directory Structure** (Commit: 85d65e37)
- **Issue**: Error 127 (command not found) when starting server
- **Root Cause**: `bin/code-server` is a shell script that calls `lib/node`, not a binary
- **Problem**: Moving `bin/code-server` to root broke relative path structure
- **Solution**: 
  - Keep entire directory structure intact after extraction
  - Changed executable paths back to `bin/code-server`
  - Added `SetExecutableFlag` stage for proper permissions
- **Key Insight**: Shell script needs `lib/node` and full directory tree to function
- **Files Changed**: `code-server.kvp`, `vscode-server.kvp`, both updates JSON files

#### **MAJOR: Rewrite Update System Following Official AMP Patterns** (Commit: 7710786e)
- **Issue**: "The current module does not support updating the application" error
- **Research**: Analyzed official AMP Templates repository (Greelan/AMPTemplates/dev)
- **Key Findings**:
  - Working templates do NOT use `App.UpdateSource=Multi`
  - Gitea template uses simple `CreateDirectory` and `Executable` stages
  - No complex environment checks or conditional logic
- **Solution**: Complete rewrite following official Gitea template pattern
- **Removed**: Complex environment checks, setting manipulation, `UpdateSource=Multi`
- **Added**: Simple, clean download/extract/move process
- **Files Changed**: All update JSON files, removed `UpdateSource=Multi` from KVP files

---

### **2025-01-10 - Earlier Development**

#### **Remove IP and Port Configuration** (Commit: c5415d5d)
- **Issue**: User reported AMP handles networking automatically
- **Solution**: Removed manual IP and port fields from configuration UI
- **Rationale**: AMP's built-in networking management is preferred
- **Changes**:
  - Removed IP Address and Port fields from both config JSON files
  - Updated command line args to remove `--bind-addr` and `--port/--host`
  - Simplified networking to let AMP handle everything
- **Files Changed**: `code-server.kvp`, `vscode-server.kvp`, both config JSON files

#### **Fix Executable Paths for Update Support** (Commit: c64f75ae)
- **Issue**: Executable path mismatch between AMP expectations and update process
- **Problem**: AMP expected `code-server` but updates created `bin/code-server`
- **Solution**: 
  - Changed executable paths: `bin/code-server` → `code-server`
  - Updated installation scripts to move executable to BaseDirectory root
- **Files Changed**: Both KVP files and updates JSON files

#### **Fix 'Module Does Not Support Updating' Error** (Commit: dcc33798)
- **Issue**: AMP error preventing update functionality
- **Solution**: 
  - Added `App.UpdateSource=Multi` to both templates
  - Enabled `SmartExcludeSupported=True` for better file handling
- **Rationale**: These settings required for AMP to recognize update capability
- **Files Changed**: Both KVP files

#### **Create Microsoft VS Code Server Template** (Commit: 4508f117)
- **Feature**: Added official Microsoft VS Code Server template alongside community version
- **New Files**:
  - `vscode-server.kvp` - Main AMP configuration
  - `vscode-serverconfig.json` - User configuration options  
  - `vscode-serverports.json` - Port configuration (8444)
  - `vscode-serverupdates.json` - Microsoft download automation
  - `vscode-servermetaconfig.json` - Meta configuration
  - `install-vscode-server-template.sh` - Linux installer
- **Features**:
  - Downloads from Microsoft's official update servers
  - GitHub token authentication support
  - Cross-platform support (Windows/Linux, x86_64/ARM64)
  - Port 8444 to avoid conflicts

#### **Fix VS Code Server Installation Issues** (Commit: 6555a3c6)
- **Issue**: Community code-server installation failures
- **Solutions**:
  - Added environment check stage for debugging
  - Ensured code-server directory creation before use
  - Better error handling and logging
  - Fixed workspace directory creation
  - Added network connectivity testing
  - Improved version detection with error handling
- **Files Changed**: `code-serverupdates.json`

---

### **2025-01-10 - Initial Development**

#### **Initial VS Code Server Template Creation** (Commit: 85e88f41)
- **Feature**: Created initial community code-server template
- **Files Created**:
  - `code-server.kvp` - Main AMP configuration
  - `code-serverconfig.json` - User configuration
  - `code-serverports.json` - Port 8443 configuration
  - `code-serverupdates.json` - Download automation
  - `code-servermetaconfig.json` - Meta configuration
  - `install-vscode-template.sh` - Installation script
- **Features**:
  - Community code-server from GitHub releases
  - Password and GitHub OAuth authentication
  - Automatic version detection and updates
  - Workspace directory management

---

## 🔧 **Current Status**

### **Working Features**
- ✅ Template installation and recognition by AMP
- ✅ Update system functionality (downloads and extracts)
- ✅ Automatic version detection from GitHub/Microsoft
- ✅ Cross-platform support (Windows/Linux, x86_64/ARM64)
- ✅ Workspace directory creation
- ✅ Port management (8443 for code-server, 8444 for vscode-server)

### **Known Issues**
- ❌ Error 127 (command not found) when starting server
- ❓ Possible shell script execution environment issues
- ❓ May need working directory or environment variable configuration

### **Troubleshooting Progress**
1. **Fixed**: Update system recognition ✅
2. **Fixed**: Download and extraction process ✅  
3. **Fixed**: Directory structure preservation ✅
4. **Fixed**: Executable permissions ✅
5. **Current**: Investigating startup execution environment

---

## 📋 **Template Comparison**

| Aspect | Code-Server | Microsoft VS Code Server |
|--------|-------------|-------------------------|
| **Port** | 8443 | 8444 |
| **Source** | Community (Coder) | Official Microsoft |
| **Download** | GitHub Releases | Microsoft Update Servers |
| **Auth** | Password, GitHub OAuth, None | GitHub Token, None |
| **Size** | ~115MB | ~68MB |
| **Updates** | Version-based from GitHub API | Latest from Microsoft |

---

## 🔍 **Debugging History**

### **Error Analysis Progression**
1. **"Module does not support updating"** → Fixed with proper update configuration
2. **Download/extraction failures** → Fixed with robust error handling
3. **Executable not found** → Fixed with correct directory structure
4. **Permission denied** → Fixed with SetExecutableFlag
5. **Error 127 (current)** → Investigating shell script execution environment

### **Key Insights Discovered**
- AMP templates require specific configuration patterns
- Official templates provide best practices for complex applications
- Directory structure is critical for Node.js-based applications
- Shell scripts need complete dependency tree preservation
- Executable paths are relative to RootDir, not BaseDirectory

---

## 📁 **File Structure**

```
AMPTemplates/
├── code-server.kvp                    # Community template config
├── code-serverconfig.json             # Community UI configuration  
├── code-serverports.json              # Community port settings
├── code-serverupdates.json            # Community update automation
├── code-servermetaconfig.json         # Community meta settings
├── vscode-server.kvp                  # Microsoft template config
├── vscode-serverconfig.json           # Microsoft UI configuration
├── vscode-serverports.json            # Microsoft port settings  
├── vscode-serverupdates.json          # Microsoft update automation
├── vscode-servermetaconfig.json       # Microsoft meta settings
├── install-vscode-template.sh         # Community installer
├── install-vscode-server-template.sh  # Microsoft installer
├── VSCODE-TEMPLATES-README.md         # User documentation
└── CHANGELOG.md                       # This file
```

---

## 🚀 **Next Steps**

### **Immediate Actions**
1. Test latest SetExecutableFlag fix for error 127
2. If still failing, implement FetchURL-based update approach
3. Consider adding WorkingDir configuration
4. Test direct Node.js binary execution instead of shell script

### **Future Enhancements**
- Add extension marketplace integration
- Implement configuration file templates
- Add SSL/TLS support options  
- Create automated testing for both templates
- Add Docker container support detection

---

## 📞 **Support & Contribution**

This changelog tracks the iterative development and troubleshooting process. Each change represents learning from AMP's architecture and best practices from the official template repository.

**Key Learning**: Building AMP templates requires following established patterns rather than reinventing approaches. The official AMP Templates repository provides the definitive examples for proper implementation.