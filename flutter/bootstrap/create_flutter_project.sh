#!/bin/bash

PROJECT_NAME=$1
AI_TOOL=$2

# ----------------------------------------------------

# Configuration

# ----------------------------------------------------

SKILLS_REPO="[git@github.com](mailto:git@github.com):shaileshjosh/ai-assistant-skills.git"
TEMP_DIR="/tmp/ai-assistant-skills"

# ----------------------------------------------------

# Validation

# ----------------------------------------------------

if [ -z "$PROJECT_NAME" ]; then
echo ""
echo "Usage:"
echo "./create_flutter_project.sh <project_name> <cursor|claude>"
echo ""
echo "Example:"
echo "./create_flutter_project.sh graphify_demo cursor"
echo ""
exit 1
fi

if [ -z "$AI_TOOL" ]; then
AI_TOOL="cursor"
fi

if [ "$AI_TOOL" != "cursor" ] && [ "$AI_TOOL" != "claude" ]; then
echo "Invalid AI tool."
echo "Supported values: cursor | claude"
exit 1
fi

# ----------------------------------------------------

# Detect Flutter

# ----------------------------------------------------

if command -v fvm >/dev/null 2>&1; then
echo "Using FVM Flutter"
FLUTTER_CMD="fvm flutter"
elif command -v flutter >/dev/null 2>&1; then
echo "Using System Flutter"
FLUTTER_CMD="flutter"
else
echo "Flutter not found."
echo "Please install Flutter or FVM."
exit 1
fi

# ----------------------------------------------------

# Create Flutter Project

# ----------------------------------------------------

echo ""
echo "Creating Flutter project: $PROJECT_NAME"
echo ""

$FLUTTER_CMD create "$PROJECT_NAME"

if [ $? -ne 0 ]; then
echo "Flutter project creation failed."
exit 1
fi

# ----------------------------------------------------

# Clone Skills Repository

# ----------------------------------------------------

echo ""
echo "Downloading AI skills..."
echo ""

rm -rf "$TEMP_DIR"

git clone "$SKILLS_REPO" "$TEMP_DIR"

if [ $? -ne 0 ]; then
echo "Failed to clone skills repository."
echo "Verify GitHub SSH access."
exit 1
fi

# ----------------------------------------------------

# Copy Skills

# ----------------------------------------------------

if [ "$AI_TOOL" = "cursor" ]; then

```
echo "Configuring Cursor..."

mkdir -p "$PROJECT_NAME/.cursor/skills"

cp -R \
"$TEMP_DIR/flutter/skills/"* \
"$PROJECT_NAME/.cursor/skills/"
```

fi

if [ "$AI_TOOL" = "claude" ]; then

```
echo "Configuring Claude..."

mkdir -p "$PROJECT_NAME/.claude/skills"

cp -R \
"$TEMP_DIR/flutter/skills/"* \
"$PROJECT_NAME/.claude/skills/"
```

fi

# ----------------------------------------------------

# Cleanup

# ----------------------------------------------------

rm -rf "$TEMP_DIR"

echo ""
echo "========================================"
echo "Project Created Successfully"
echo "========================================"
echo "Project : $PROJECT_NAME"
echo "AI Tool : $AI_TOOL"
echo ""
echo "Next Steps:"
echo ""
echo "cd $PROJECT_NAME"
echo ""

if [ "$AI_TOOL" = "cursor" ]; then
echo "Open project in Cursor and run:"
echo ""
echo "Use project-bootstrap skill."
echo ""
fi

if [ "$AI_TOOL" = "claude" ]; then
echo "Open project in Claude and run:"
echo ""
echo "Use project-bootstrap skill."
echo ""
fi

echo "========================================"
