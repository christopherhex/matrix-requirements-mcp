# Matrix Requirements MCP Server

An MCP (Model Context Protocol) server that connects Claude to your [Matrix Requirements](https://matrixreq.com/) ALM instance. Provides full CRUD access to projects, items, folders, links, labels, TODOs, and document generation.

## Prerequisites

- Node.js 18+
- A Matrix Requirements instance with API access
- An API token (create one in Matrix under User Menu → Access Tokens)

## Setup

### 1. Install dependencies and build

```bash
npm install
npm run build
```

### 2. Configure environment variables

The server needs two environment variables:

| Variable | Description | Example |
|---|---|---|
| `MATRIX_URL` | Your Matrix instance URL | `https://clouds5.matrixreq.com` |
| `MATRIX_TOKEN` | Your API token (without "Token " prefix) | `abc123def456...` |

### 3. Add to Claude Desktop

Add this to your `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "matrix-requirements": {
      "command": "node",
      "args": ["/absolute/path/to/matrix-req-mcp/dist/index.js"],
      "env": {
        "MATRIX_URL": "https://your-instance.matrixreq.com",
        "MATRIX_TOKEN": "your-api-token-here"
      }
    }
  }
}
```

### 4. Add to Claude Code

```bash
claude mcp add matrix-requirements \
  -e MATRIX_URL=https://your-instance.matrixreq.com \
  -e MATRIX_TOKEN=your-api-token-here \
  -- node /absolute/path/to/matrix-req-mcp/dist/index.js
```

## Available Tools

### Project & Navigation

| Tool | Description |
|---|---|
| `list_projects` | List all projects on the instance |
| `get_project_info` | Get categories and field definitions for a project |
| `get_folder_tree` | Get the root folder tree for a project |
| `get_folder_children` | Get children of a specific folder |

### Items (CRUD)

| Tool | Description |
|---|---|
| `get_item` | Get a single item with all fields, links, and labels |
| `search_items` | Search items by MRQL or free text (returns IDs) |
| `search_items_with_details` | Search items with full details returned |
| `create_item` | Create a new item in a folder |
| `update_item_title` | Update an item's title |
| `set_field` | Set a single field value |
| `set_fields` | Set multiple field values at once |
| `delete_item` | Delete an item or folder |
| `move_items` | Move items to a different folder |

### Folders

| Tool | Description |
|---|---|
| `create_folder` | Create a new folder in a project |

### Links (Traceability)

| Tool | Description |
|---|---|
| `get_links` | Get all uplinks and downlinks for an item |
| `add_downlink` | Add a trace link between items |
| `remove_downlink` | Remove a trace link between items |

### Labels

| Tool | Description |
|---|---|
| `set_labels` | Set labels on an item |

### TODOs & Audit

| Tool | Description |
|---|---|
| `get_todos` | Get TODOs for a project |
| `get_audit` | Get the change/audit log |

### Document Generation

| Tool | Description |
|---|---|
| `generate_document` | Export a DOC to PDF, HTML, DOCX, or ODT |

## MRQL Search Syntax

Matrix uses MRQL for structured queries. Examples:

- `mrql:category=REQ` — all requirements
- `mrql:category=REQ AND title~"safety"` — requirements with "safety" in title
- `mrql:category=TC AND label=approved` — approved test cases
- Free text searches also work (just pass a search string)

## Development

```bash
npm run dev    # Watch mode - recompiles on changes
npm run build  # One-time build
npm start      # Run the server
```
