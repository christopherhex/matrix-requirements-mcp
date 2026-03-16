#!/usr/bin/env bash
set -euo pipefail

echo "==> Installing dependencies..."
npm install

echo "==> Building..."
npm run build

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "Build complete! To connect this to Claude Desktop:"
echo ""
echo "1. Open your Claude Desktop config file:"
echo "   macOS:   ~/Library/Application Support/Claude/claude_desktop_config.json"
echo "   Windows: %APPDATA%\\Claude\\claude_desktop_config.json"
echo ""
echo "2. Add (or merge) the following into the \"mcpServers\" section:"
echo ""
echo "   \"matrix-requirements\": {"
echo "     \"command\": \"node\","
echo "     \"args\": [\"${SCRIPT_DIR}/dist/index.js\"],"
echo "     \"env\": {"
echo "       \"MATRIX_URL\": \"https://your-instance.matrixreq.com\","
echo "       \"MATRIX_TOKEN\": \"your-api-token-here\""
echo "     }"
echo "   }"
echo ""
echo "3. Replace the URL and token with your own, then restart Claude Desktop."
echo ""
echo "See claude_desktop_config.example.json for the full file format."
