#!/bin/bash

PROJECT_NAME=$1
AI_TOOL=$2

# ----------------------------------------------------

# Configuration

# ----------------------------------------------------

SKILLS_REPO="https://github.com/shaileshjosh/ai-assistant-skills.git"
TEMP_DIR="/tmp/ai-assistant-skills"

# ----------------------------------------------------

# Validation

# ----------------------------------------------------

if [ -z "$PROJECT_NAME" ]; then
echo ""
echo "Usage:"
echo "./create_flutter_project.sh <project_name> <cursor|claude>"
echo ""
echo "Examples:"
echo "./create_flutter_project.sh graphify_demo cursor"
echo "./create_flutter_project.sh graphify_demo claude"
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

if [ -d "$PROJECT_NAME" ]; then
echo "Directory '$PROJECT_NAME' already exists."
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

# Download Skills

# ----------------------------------------------------

echo ""
echo "Downloading AI skills..."
echo ""

rm -rf "$TEMP_DIR"

git clone "$SKILLS_REPO" "$TEMP_DIR"

if [ $? -ne 0 ]; then
echo "Failed to clone skills repository."
exit 1
fi

if [ ! -d "$TEMP_DIR/flutter/skills" ]; then
echo "Skills folder not found."
echo "Expected path: flutter/skills"
exit 1
fi

# ----------------------------------------------------

# Setup AI Tool

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

if [ "$AI_TOOL" = "cursor" ]; then
echo "cd $PROJECT_NAME"
echo "cursor ."
echo ""
echo "Prompt:"
echo "Use project-bootstrap skill."
fi

if [ "$AI_TOOL" = "claude" ]; then
echo "cd $PROJECT_NAME"
echo "claude"
echo ""
echo "Prompt:"
echo "Use project-bootstrap skill."
fi

echo ""
echo "========================================"
