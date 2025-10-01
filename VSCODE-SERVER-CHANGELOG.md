# VS Code Server Template Changelog

## Version 4.0 - Major Security and Compliance Fixes - 2024-12-26

### Breaking Changes
- **🔒 Fixed Host Binding**: Changed from `--host=0.0.0.0` to `--host={{$ApplicationIPBinding}}` to comply with AMP security requirements
- **📁 Executable Path**: Changed from `bin/code-server` to `code-server` (executable now placed in root directory)
- **🔌 Default Port**: Changed from 8444 to 8443 to avoid conflict with AMP's default port configuration

### Critical Security Fix
- **❌ Resolved "You must select a specific IP address" Error**: The template was incorrectly trying to bind to `0.0.0.0` which AMP security policies prohibit. Now properly uses AMP's managed IP binding.

### Major Improvements
- **🌐 IP Binding Configuration**: 
  - Set `App.ForceIPBinding=False` to allow AMP to manage IP binding
  - Set `App.ApplicationIPBinding={{$PrimaryIPAddress}}` to use the server's primary IP
  - This resolves the "forbidden page" issue and security compliance problems

- **📦 Update Mechanism**: 
  - Completely rewrote the update process to be more reliable
  - Simplified file extraction by placing executable directly in root directory
  - Added better error handling and validation
  - Removed complex file moving operations that were causing update failures

- **⚙️ Server Support**:
  - Added `App.SupportsUpdate=True` to enable proper update functionality
  - Enhanced Smart Exclude to protect workspace files during updates
  - Template now properly reports its update capabilities

- **🛡️ Error Recovery**: 
  - Improved download and extraction error handling
  - Better cleanup of temporary files
  - More descriptive error messages for troubleshooting

### Bug Fixes
- **🚫 Exit Code 127**: Fixed by placing executable in correct location and fixing paths
- **🔐 Permission Issues**: Fixed chmod operations and executable permissions
- **🌐 IP Binding Errors**: Resolved "You must select a specific IP address" error
- **🔄 Update Failures**: Fixed file moving and extraction issues that caused update loops
- **⚡ Port Conflicts**: Changed default port to avoid AMP conflicts

### Technical Details
- Template now properly extracts only the necessary `code-server` executable
- Simplified directory structure eliminates file conflicts during updates
- Better compliance with AMP's security and networking requirements
- Improved workspace protection during updates with better exclusion patterns
- Executable placement follows AMP conventions for better reliability

### Migration Notes
⚠️ **Important for Existing Instances**:
- You may need to update the "Application IP Binding" setting in AMP's Network settings
- Default port changed from 8444 to 8443
- Update the instance to get the new executable placement
- The server will now properly respect AMP's IP binding requirements

---

## Version 3.0 - 2024-12-19

### Major Fixes & Improvements
- ✅ **Authentication Issues**: Fixed connection token handling that was causing "forbidden" errors
- ✅ **Port Binding**: Fixed port configuration to properly bind to the configured port
- ✅ **Update Mechanism**: Improved file extraction and handling during updates to prevent conflicts
- ✅ **Command Line Arguments**: Complete rewrite of argument structure for better compatibility
- ✅ **File Permissions**: Fixed executable permissions for the code-server binary on Linux

### Technical Improvements
1. **Smart Authentication**: Conditional connection token support (can be enabled or disabled)
2. **Better Configuration**: Proper handling of optional directories (extensions, user data)
3. **Cleaner Updates**: Improved file cleanup and extraction process
4. **Template Compliance**: Aligned with AMP template best practices from working templates

### Key Configuration Changes
- **Connection Tokens**: Now properly handled with conditional logic
- **Argument Building**: Uses Handlebars templating for dynamic argument construction
- **Port Handling**: Consistent use of {{$ServerPort}} throughout template
- **Directory Management**: Better handling of workspace, extensions, and user data directories

### Issues Resolved
- ❌ "Forbidden" errors when accessing web interface
- ❌ Server binding to wrong ports or failing to bind
- ❌ Update failures due to file extraction conflicts
- ❌ Error code 127 startup failures
- ❌ License acceptance prompts blocking startup

### Breaking Changes
⚠️ **Important**: Existing instances may need to be updated/recreated due to:
- Changed command line argument structure
- Updated authentication method
- Modified configuration field names

## Version 2.0 - Fixed Release

### Fixed Issues:
1. **Authentication/Access Issues**:
   - Fixed "forbidden page" error by removing complex authentication and using `--without-connection-token`
   - Added proper host binding to `0.0.0.0` instead of using `{{$ApplicationIPBinding}}`
   - Added `--accept-server-license-terms` flag to automatically accept VS Code license
   - Set `ForceIPBinding=True` to ensure proper network binding

2. **Port Configuration**:
   - Changed default port from 8443 to 8444 to avoid conflicts with AMP panel (port 8080)
   - Port 8444 should work fine with your panel setup

3. **Update/Installation Issues**:
   - Fixed file extraction conflicts during updates by adding cleanup stage
   - Improved file moving logic to prevent "Directory not empty" errors
   - Added separate cleanup stages before download for both Linux and Windows
   - Used `mv` instead of `cp` to prevent file conflicts during extraction

4. **Error Code 127 Issues**:
   - Fixed executable path references in the .kvp file
   - Ensured proper executable permissions are set on Linux
   - Corrected the executable names for Windows and Linux

5. **Startup and Runtime Issues**:
   - Improved console output detection with better regex patterns
   - Added `DISABLE_OPENCOLLECTIVE=1` environment variable to reduce noise
   - Set `SupportsLiveSettingsChanges=False` for stability
   - Simplified configuration to reduce complexity

### Key Configuration Changes:
- **Command Line**: Now uses `--accept-server-license-terms --host=0.0.0.0 --port={{$ServerPort}} --without-connection-token`
- **Port**: Default port is now 8444
- **Network**: Forced IP binding enabled for proper external access
- **Updates**: Improved extraction process with cleanup stages
- **Authentication**: Simplified to no authentication by default (can be secured by AMP panel access controls)

### Testing:
After applying these fixes, the VS Code Server should:
1. Start without license acceptance prompts
2. Be accessible at `http://your-panel-domain:8444`
3. Update properly without file conflicts
4. Not show "forbidden" pages

### Notes for AMP Panel Integration:
- The panel will handle git fetch/pull automatically as mentioned
- Port 8444 avoids conflict with panel's port 8080
- No authentication required at VS Code level since access is controlled by AMP
- The server will bind to all interfaces (0.0.0.0) for proper external access