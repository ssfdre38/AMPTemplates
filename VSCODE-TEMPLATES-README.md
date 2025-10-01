# VS Code Server Templates for AMP

This repository now contains **TWO** VS Code Server templates for AMP:

## 🎯 **Template Options**

### 1. **Community Code-Server** (`code-server.*`)
- **Port**: 8443 
- **Source**: Coder.com community project
- **Features**: Password + GitHub OAuth auth, extensive customization
- **Best for**: General use, mature feature set

### 2. **Microsoft VS Code Server** (`vscode-server.*`) 
- **Port**: 8444
- **Source**: Official Microsoft VS Code Server
- **Features**: GitHub token auth, official Microsoft experience  
- **Best for**: Official Microsoft experience, latest VS Code features

## 📊 **Comparison**

| Feature | Code-Server | Microsoft VS Code Server |
|---------|-------------|-------------------------|
| **Source** | Community (Coder) | Official Microsoft |
| **Port** | 8443 | 8444 |
| **Authentication** | Password, GitHub OAuth, None | GitHub Token, None |
| **Download Source** | GitHub Releases | Microsoft Update Servers |
| **Features** | Mature, stable | Latest VS Code features |
| **Extensions** | Full marketplace | Full marketplace |
| **Performance** | Optimized for web | Native VS Code performance |

## 🚀 **Installation**

### Quick Install (Both Templates)
```bash
# Clone your repository
git clone https://github.com/ssfdre38/AMPTemplates.git
cd AMPTemplates

# Switch to template branch
git checkout vscode-server-template

# Install both templates
./install-vscode-template.sh        # Community Code-Server
./install-vscode-server-template.sh # Microsoft VS Code Server
```

### Manual Install
Copy these files to your AMP templates directory:

**Community Code-Server:**
- `code-server.kvp`
- `code-serverconfig.json` 
- `code-serverports.json`
- `code-serverupdates.json`
- `code-servermetaconfig.json`

**Microsoft VS Code Server:**
- `vscode-server.kvp`
- `vscode-serverconfig.json`
- `vscode-serverports.json` 
- `vscode-serverupdates.json`
- `vscode-servermetaconfig.json`

## 🔧 **Configuration**

### Community Code-Server (Port 8443)
- **Access**: `http://your-server:8443`
- **Auth Options**: Password (recommended), GitHub OAuth, None
- **Workspace**: `./workspace` (configurable)

### Microsoft VS Code Server (Port 8444)
- **Access**: `http://your-server:8444`
- **Auth Options**: GitHub Personal Access Token, None
- **Workspace**: `./workspace` (configurable)

## 🎛️ **AMP Panel Setup**

1. **Create Instance** in AMP
2. **Choose Template**:
   - "Visual Studio Code Server" (community)
   - "Microsoft VS Code Server" (official)
3. **Configure Settings**:
   - Set authentication method
   - Configure workspace directory
   - Set port (if needed)
4. **Start Instance**
5. **Access via Browser**

## 🔒 **Security Notes**

- **Never use "None" authentication** for internet-facing instances
- **Use strong passwords** or GitHub tokens
- **Configure firewalls** to restrict access as needed
- **Different ports** allow running both simultaneously

## 🛠️ **Troubleshooting**

### Environment Check
Both templates include environment checks that test:
- Network connectivity
- Available tools (wget/curl)
- Permissions
- Download capabilities

### Common Issues
1. **Port conflicts**: Use different ports (8443 vs 8444)
2. **Download failures**: Check internet access from AMP instance
3. **Permission errors**: Ensure AMP can write to directories
4. **Authentication**: Verify tokens/passwords are correct

### Log Analysis
Check AMP console for:
- "Environment Check" output
- Download progress messages
- Extraction status
- Server startup messages

## 📈 **Which Should You Choose?**

### Choose **Community Code-Server** if:
- ✅ You want password authentication
- ✅ You need GitHub OAuth integration
- ✅ You prefer mature, stable software
- ✅ You want extensive customization options

### Choose **Microsoft VS Code Server** if:
- ✅ You want the official Microsoft experience
- ✅ You use GitHub and have personal access tokens
- ✅ You want the latest VS Code features
- ✅ You prefer Microsoft's official support

### Run Both if:
- ✅ You want to test both options
- ✅ You have different teams with different needs
- ✅ You want development (one) and production (other) setups

## 🎉 **Success Stories**

Both templates have been tested and work with:
- ✅ **AMP Panels**: Full integration with AMP's git operations
- ✅ **Cross-Platform**: Windows and Linux support
- ✅ **Multi-Architecture**: x86_64 and ARM64 support
- ✅ **Network Configurations**: Port flexibility avoids conflicts

## 📝 **Contributing**

Found issues or improvements? Both templates are in the `vscode-server-template` branch and accept contributions!

---

**Happy Coding! 🚀**

Both templates provide excellent VS Code experiences through AMP - choose the one that fits your needs best!