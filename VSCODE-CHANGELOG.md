# VS Code Server Template Changelog

## 2024-10-01 - Version Restoration and Fixes

### Changes Made
- **Restored Working Template**: Reverted to the previously working VS Code Server template that was successfully starting the server
- **Fixed Port Configuration**: Updated default port from 8444 to 8443 to match AMP panel expectations
- **Fixed IP Binding**: 
  - Changed host binding from `{{$ApplicationIPBinding}}` to `0.0.0.0` to avoid IP binding restrictions
  - Set `App.ForceIPBinding=True` to ensure proper network configuration
- **Download and Setup Process**: Restored the working download process that properly extracts VS Code Server

### Key Template Features
- **Full VS Code Server**: Downloads and runs official Microsoft VS Code Server
- **Proper File Structure**: Correctly extracts and organizes VS Code Server files
- **Executable Permissions**: Automatically sets proper executable permissions on Linux
- **Network Configuration**: Configured to work with AMP panel proxy setup
- **Workspace Support**: Includes configurable workspace directory
- **Security Options**: Support for connection tokens and GitHub authentication

### Fixed Issues
- ✅ Server startup (no more exit code 127)
- ✅ File extraction and organization
- ✅ Network binding compatibility with AMP
- ✅ Port configuration for panel access
- ✅ Executable permissions on Linux

### Technical Details
- Uses official Microsoft VS Code Server from `https://update.code.visualstudio.com/`
- Supports both Linux (x86_64 and ARM64) and Windows platforms
- Implements proper cleanup of old files during updates
- Configurable workspace, extensions, and user data directories