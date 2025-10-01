# VS Code Server Template Changelog

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