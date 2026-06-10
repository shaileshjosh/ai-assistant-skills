#!/bin/bash

PROJECT_NAME=$1
AI_TOOL=$2

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

# Create Project

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

# Download Skills Repository

# ----------------------------------------------------

echo ""
echo "Downloading AI skills..."
echo ""

rm -rf /tmp/ai-assistant-skills

git clone 
https://github.com/joshsoftware/ai-assistant-skills.git 
/tmp/ai-assistant-skills

if [ $? -ne 0 ]; then
echo "Failed to download skills repository."
exit 1
fi

# ----------------------------------------------------

# Copy Skills

# ----------------------------------------------------

mkdir -p "$PROJECT_NAME/Skills"

cp -R 
/tmp/ai-assistant-skills/flutter/skills/* 
"$PROJECT_NAME/Skills/"

# ----------------------------------------------------

# Cursor Setup

# ----------------------------------------------------

if [ "$AI_TOOL" = "cursor" ]; then

```
echo "Configuring Cursor..."

mkdir -p "$PROJECT_NAME/.cursor"

cat > "$PROJECT_NAME/.cursor/rules.md" << EOF
```

Read all files inside Skills/.

Use project-bootstrap skill first.

Follow all standards while generating code.
EOF

fi

# ----------------------------------------------------

# Claude Setup

# ----------------------------------------------------

if [ "$AI_TOOL" = "claude" ]; then

```
echo "Configuring Claude..."

cat > "$PROJECT_NAME/CLAUDE.md" << EOF
```

Read all files inside Skills/.

Use project-bootstrap skill first.

Follow all standards while generating code.
EOF

fi

# ----------------------------------------------------

# Cleanup

# ----------------------------------------------------

rm -rf /tmp/ai-assistant-skills

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
echo "Open Cursor and run:"
echo ""
echo "Use project-bootstrap skill."
echo ""
fi

if [ "$AI_TOOL" = "claude" ]; then
echo "Open Claude and run:"
echo ""
echo "Use project-bootstrap skill."
echo ""
fi

echo "========================================"
