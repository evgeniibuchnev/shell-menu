#!/usr/bin/env bash
# Download script from GitHub
GITHUB_URL="https://raw.githubusercontent.com/evgeniibuchnev/shell-menu/master/shell-menu"
# Default installation destination
INSTALL_DIR="${1:-/usr/local/bin}"
SCRIPT_NAME="shell-menu"


echo "=== $SCRIPT_NAME Installation Script ==="
echo ""
echo "Installation destination: $INSTALL_DIR"
echo ""

# Check download tools
if command -v curl >/dev/null 2>&1; then
    DOWNLOADER="curl"
elif command -v wget >/dev/null 2>&1; then
    DOWNLOADER="wget"
else
    >&2 echo "Error: neither curl nor wget is installed"
    exit 1
fi

# Check if we need sudo
if [ ! -w "$INSTALL_DIR" ]; then
    echo "Elevated permissions required for $INSTALL_DIR"
    SUDO="sudo"
else
    SUDO=""
fi

# Create directory if it doesn't exist
echo "Checking installation directory..."
$SUDO mkdir -p "$INSTALL_DIR"

# Download and install script
echo "Downloading $SCRIPT_NAME from GitHub..."
TMP_FILE="$(mktemp)"

if [ "$DOWNLOADER" = "curl" ]; then
    curl -fsSL "$GITHUB_URL" -o "$TMP_FILE"
else
    wget -qO "$TMP_FILE" "$GITHUB_URL"
fi

if [ $? -ne 0 ] || [ ! -s "$TMP_FILE" ]; then
    >&2 echo "Error: failed to download script from $GITHUB_URL"
    rm -f "$TMP_FILE"
    exit 1
fi

echo "Installing $SCRIPT_NAME to $INSTALL_DIR..."
$SUDO cp "$TMP_FILE" "$INSTALL_DIR/$SCRIPT_NAME"
rm -f "$TMP_FILE"

# Make executable
echo "Making script executable..."
$SUDO chmod 755 "$INSTALL_DIR/$SCRIPT_NAME"

# Verify installation
if [ -x "$INSTALL_DIR/$SCRIPT_NAME" ]; then
    echo ""
    echo "Installation successful!"
    echo "Script installed at: $INSTALL_DIR/$SCRIPT_NAME"
    echo "Run '$SCRIPT_NAME' to start"
else
    >&2 echo "Error: installation failed"
    exit 1
fi
