#!/bin/bash

# VS Code Server AMP Template Installer
# This script copies the necessary files to create a VS Code Server template in AMP

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}===============================================${NC}"
echo -e "${BLUE}    VS Code Server AMP Template Installer    ${NC}"
echo -e "${BLUE}===============================================${NC}"
echo

# Files to copy
FILES=(
    "code-server.kvp"
    "code-serverconfig.json"
    "code-serverports.json"
    "code-serverupdates.json"
    "code-servermetaconfig.json"
)

# Check if files exist
echo -e "${YELLOW}Checking for required files...${NC}"
MISSING_FILES=()
for file in "${FILES[@]}"; do
    if [ ! -f "$file" ]; then
        MISSING_FILES+=("$file")
    else
        echo -e "${GREEN}✓${NC} Found $file"
    fi
done

if [ ${#MISSING_FILES[@]} -ne 0 ]; then
    echo -e "${RED}✗ Missing files:${NC}"
    for file in "${MISSING_FILES[@]}"; do
        echo -e "  ${RED}✗${NC} $file"
    done
    echo -e "${RED}Please ensure all template files are in the current directory.${NC}"
    exit 1
fi

echo

# Validate JSON files
echo -e "${YELLOW}Validating JSON files...${NC}"
JSON_FILES=(
    "code-serverconfig.json"
    "code-serverports.json"
    "code-serverupdates.json"
    "code-servermetaconfig.json"
)

for file in "${JSON_FILES[@]}"; do
    if python3 -m json.tool "$file" >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $file is valid JSON"
    else
        echo -e "${RED}✗${NC} $file has JSON syntax errors"
        exit 1
    fi
done

echo

# Get AMP templates directory
echo -e "${YELLOW}Please enter your AMP templates directory path:${NC}"
echo -e "${BLUE}Common locations:${NC}"
echo -e "  Linux: /opt/cubecoders/amp/AMPDatastore/Templates/"
echo -e "  Windows: C:\\AMP\\AMPDatastore\\Templates\\"
echo -e "  Docker: /opt/cubecoders/amp/AMPDatastore/Templates/"
echo
read -p "Templates directory path: " AMP_TEMPLATES_DIR

# Validate directory
if [ ! -d "$AMP_TEMPLATES_DIR" ]; then
    echo -e "${RED}✗ Directory not found: $AMP_TEMPLATES_DIR${NC}"
    echo -e "${YELLOW}Would you like to create it? (y/n):${NC}"
    read -p "" CREATE_DIR
    if [ "$CREATE_DIR" = "y" ] || [ "$CREATE_DIR" = "Y" ]; then
        mkdir -p "$AMP_TEMPLATES_DIR"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓${NC} Created directory: $AMP_TEMPLATES_DIR"
        else
            echo -e "${RED}✗ Failed to create directory. Check permissions.${NC}"
            exit 1
        fi
    else
        echo -e "${RED}Installation cancelled.${NC}"
        exit 1
    fi
fi

echo

# Copy files
echo -e "${YELLOW}Copying template files...${NC}"
for file in "${FILES[@]}"; do
    cp "$file" "$AMP_TEMPLATES_DIR/"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓${NC} Copied $file"
    else
        echo -e "${RED}✗${NC} Failed to copy $file"
        exit 1
    fi
done

echo
echo -e "${GREEN}===============================================${NC}"
echo -e "${GREEN}       Installation completed successfully!   ${NC}"
echo -e "${GREEN}===============================================${NC}"
echo
echo -e "${BLUE}Next steps:${NC}"
echo -e "1. Restart your AMP panel if it's running"
echo -e "2. Create a new instance in AMP"
echo -e "3. Select 'Visual Studio Code Server' from the template list"
echo -e "4. Configure your settings (authentication, workspace, etc.)"
echo -e "5. Start the instance and access via web browser"
echo
echo -e "${BLUE}Default access:${NC} http://your-server-ip:8443"
echo -e "${YELLOW}Remember to configure authentication before exposing to the internet!${NC}"
echo