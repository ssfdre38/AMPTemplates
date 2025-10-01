# VS Code Server Template for AMP

This template allows you to run Visual Studio Code Server through AMP (Application Management Panel), providing a web-based VS Code environment accessible from anywhere.

## Files Created

- `code-server.kvp` - Main AMP configuration file
- `code-serverconfig.json` - Configuration options and settings
- `code-serverports.json` - Port configuration (default: 8443, avoiding AMP's 8080)
- `code-serverupdates.json` - Download and installation scripts
- `code-servermetaconfig.json` - Meta configuration (empty for now)

## AMP Integration Notes

### Automatic Git Operations
AMP automatically performs `git fetch` and `git pull` operations. This template is designed to work seamlessly with this:

- **VS Code Server Installation**: Uses pre-built binaries from GitHub releases (no git operations needed)
- **User Workspace**: Any git repositories you work on in VS Code will benefit from AMP's automatic git operations
- **Template Updates**: AMP will automatically update the template configuration when changes are pushed

### Port Configuration
- **Default Port**: 8443 (avoiding conflict with AMP's web interface on 8080)
- **Configurable**: Can be changed in the instance settings
- **Firewall**: Ensure port 8443 is accessible from your client machines

- **Cross-platform support**: Works on both Windows and Linux
- **Architecture support**: Supports both x86_64 and ARM64
- **Multiple authentication methods**: None, Password, or GitHub OAuth
- **Configurable workspace**: Set custom workspace directory
- **Extension support**: Configure custom extensions directory
- **Privacy controls**: Option to disable telemetry
- **Auto-updates**: Automatic download and installation of code-server

## Configuration Options

### Installation
- **VS Code Server Version**: Specify version or leave empty for latest

### Network
- **Server IP Address**: IP to bind to (default: 0.0.0.0 for all interfaces)
- **Server Port**: Port for web interface (default: 8443, avoiding conflict with AMP's 8080)

### Security
- **Authentication Type**: Choose between None, Password, or GitHub OAuth
- **Password**: Set password for password authentication
- **GitHub Client ID/Secret**: Required for GitHub OAuth

### Configuration
- **Workspace Directory**: Set the workspace folder (default: ./workspace)
- **Config Directory**: Custom config directory for settings
- **User Data Directory**: Custom user data directory
- **Extensions Directory**: Custom extensions directory

### Privacy
- **Disable Telemetry**: Option to disable telemetry collection (enabled by default)

### Advanced
- **Additional Arguments**: Pass extra command-line arguments

## Installation Instructions

1. Copy all 5 files to your AMP templates directory:
   - `code-server.kvp`
   - `code-serverconfig.json`
   - `code-serverports.json`
   - `code-serverupdates.json`
   - `code-servermetaconfig.json`

2. In AMP, create a new instance and select "Visual Studio Code Server" from the template list

3. Configure your desired settings:
   - Set a password if using password authentication
   - Configure GitHub OAuth if needed
   - Set workspace directory
   - Adjust other settings as needed

4. Start the instance and access via web browser at `http://your-server-ip:8443`

## Usage

Once running, you can:
- Access VS Code through your web browser
- Install extensions from the marketplace
- Open and edit files in your workspace
- Use the integrated terminal
- All standard VS Code features are available

## Security Notes

- **Password Authentication**: Recommended for most use cases
- **GitHub OAuth**: More secure, requires GitHub app setup
- **No Authentication**: Only use in trusted environments
- **Network Access**: Configure firewall rules appropriately

## Troubleshooting

- Check AMP logs for installation issues
- Ensure proper port accessibility
- Verify authentication settings
- Check workspace directory permissions

## Regarding GitHub Copilot CLI Integration

To answer your earlier questions:

1. **VSCode Login Issues**: The forbidden page after login is likely due to OAuth redirect URI configuration. Make sure your OAuth app's redirect URI matches your AMP instance URL.

2. **Syncing with GitHub Copilot**: This VS Code Server instance can use the GitHub Copilot extension, but it won't automatically sync with the GitHub Copilot CLI. They're separate tools that happen to share the GitHub Copilot backend.

3. **This AMP Template**: This creates a web-based VS Code environment that you can access from anywhere. You can install the GitHub Copilot extension within it to get AI assistance while coding.

## Next Steps

After setting up this VS Code Server template, you can:
- Install the GitHub Copilot extension for AI assistance
- Configure your workspace with your preferred project files
- Set up Git authentication for version control
- Install other useful extensions for your development workflow