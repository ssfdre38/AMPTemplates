# VS Code Server Template for AMP - Complete Package

## Overview

This package contains everything you need to run Visual Studio Code Server through AMP (Application Management Panel). VS Code Server provides a full VS Code experience in your web browser, accessible from anywhere.

## Package Contents

### Core Template Files (Required)
- `code-server.kvp` - Main AMP configuration file
- `code-serverconfig.json` - Configuration options and settings
- `code-serverports.json` - Port configuration (default: 8443, avoiding AMP's 8443)
- `code-serverupdates.json` - Download and installation scripts
- `code-servermetaconfig.json` - Meta configuration file

### Installation Scripts
- `install-vscode-template.sh` - Linux/macOS installer script
- `install-vscode-template.ps1` - Windows PowerShell installer script

### Documentation
- `CODE-SERVER-README.md` - Detailed usage instructions
- `INSTALLATION.md` - This file

## AMP Compatibility

### Git Operations
This template is fully compatible with AMP's automatic git operations:
- VS Code Server is installed from pre-built GitHub releases (no git conflicts)
- Your workspace repositories will benefit from AMP's automatic `git fetch` and `git pull`
- Template updates are handled automatically by AMP

### Port Configuration
- **Default Port**: 8443 (avoids conflict with AMP's 8080 web interface)
- **Access URL**: `http://your-server-ip:8443`
- **Firewall**: Ensure port 8443 is open for client access

## Quick Installation

### Option 1: Automatic Installation (Recommended)

**Linux/macOS:**
```bash
chmod +x install-vscode-template.sh
./install-vscode-template.sh
```

**Windows PowerShell (Run as Administrator):**
```powershell
.\install-vscode-template.ps1
```

### Option 2: Manual Installation

1. Copy these 5 files to your AMP templates directory:
   - `code-server.kvp`
   - `code-serverconfig.json`
   - `code-serverports.json`
   - `code-serverupdates.json`
   - `code-servermetaconfig.json`

2. Common AMP template directory locations:
   - **Linux**: `/opt/cubecoders/amp/AMPDatastore/Templates/`
   - **Windows**: `C:\AMP\AMPDatastore\Templates\`
   - **Docker**: `/opt/cubecoders/amp/AMPDatastore/Templates/`

3. Restart AMP if it's running

## Usage Instructions

1. **Create New Instance**
   - In AMP, click "Create Instance"
   - Select "Visual Studio Code Server" from the template list
   - Choose a name for your instance

2. **Configure Settings**
   - **Authentication**: Choose password, GitHub OAuth, or none
   - **Network**: Set IP address and port (default: 8443, avoiding AMP's 8443)
   - **Workspace**: Set your workspace directory
   - **Version**: Specify VS Code Server version or leave empty for latest

3. **Start Instance**
   - Click "Start" in your AMP instance
   - Wait for "HTTP server listening on" message in console

4. **Access VS Code**
   - Open browser to `http://your-server-ip:8443`
   - Enter password if authentication is enabled
   - Start coding!

## Security Recommendations

### For Internet Access
- **Always use password or GitHub OAuth authentication**
- Use a strong password (12+ characters)
- Consider using a reverse proxy with SSL
- Restrict access with firewall rules

### For Local Network Only
- Password authentication recommended
- No authentication acceptable if network is secure

## Common Configuration Examples

### Development Server (Password Protected)
- Authentication Type: Password
- Password: [Strong password]
- Server IP: 0.0.0.0
- Server Port: 8443
- Workspace: ./workspace

### Team Development (GitHub OAuth)
- Authentication Type: GitHub OAuth
- GitHub Client ID: [Your OAuth App Client ID]
- GitHub Client Secret: [Your OAuth App Secret]
- Server IP: 0.0.0.0
- Server Port: 8443

### Local Development (No Auth)
- Authentication Type: None
- Server IP: 127.0.0.1
- Server Port: 8443
- **Warning**: Only for local access!

## Troubleshooting

### Installation Issues
- Ensure all 5 template files are present
- Check JSON files are valid with `python3 -m json.tool filename.json`
- Verify AMP templates directory exists and is writable
- Restart AMP after copying files

### Runtime Issues
- Check AMP console for error messages
- Verify port is not in use by another service
- Check firewall allows access to the port
- Ensure workspace directory is readable/writable

### Authentication Issues
- For password auth: Check password is set correctly
- For GitHub OAuth: Verify Client ID/Secret are correct
- For GitHub OAuth: Ensure redirect URI is configured properly

### Network Issues
- Check IP binding (0.0.0.0 for all interfaces, 127.0.0.1 for local only)
- Verify port is accessible from client
- Check firewall rules
- Test with `curl http://server-ip:port`

## Advanced Usage

### Custom Extensions Directory
Set a custom extensions directory to persist extensions across updates:
- Extensions Directory: `./extensions`

### Custom Config Directory
Set a custom config directory to persist VS Code settings:
- Config Directory: `./config`

### Multiple Workspaces
Create multiple instances with different workspace directories for different projects.

### Integration with GitHub Copilot
1. Start your VS Code Server instance
2. Install the GitHub Copilot extension from the marketplace
3. Sign in with your GitHub account
4. Enjoy AI-powered coding assistance!

## Support

For issues with:
- **AMP Template**: Check this documentation and troubleshooting section
- **VS Code Server**: Visit https://github.com/coder/code-server
- **AMP Software**: Visit https://cubecoders.com/

## Version Information

- Template Version: 1.0
- Compatible AMP Version: 2.6.0.0+
- VS Code Server: Latest (auto-downloads)

## License

This template follows the same licensing as VS Code Server and AMP. Use responsibly and in accordance with all applicable licenses.

---

**Questions about your earlier issues:**

1. **VSCode Login Forbidden**: This was likely due to OAuth redirect URI configuration. With this template, you can avoid that by using password authentication instead.

2. **GitHub Copilot Sync**: This VS Code Server can use the GitHub Copilot extension, giving you AI assistance in the browser. While it won't sync directly with GitHub Copilot CLI, both use the same backend service.

3. **Running on AMP**: This template makes it easy to deploy VS Code Server through AMP's management interface, with automatic updates, configuration management, and monitoring.

Enjoy your web-based VS Code environment!