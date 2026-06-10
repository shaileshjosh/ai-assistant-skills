# Flutter AI Skills Framework

This repository provides reusable AI skills for Flutter development using Cursor and Claude.

The framework standardizes:

* Clean Architecture
* Feature-first development
* API integrations
* Authentication
* Data storage
* Caching
* Testing
* Code reviews

The goal is to ensure all Flutter projects follow the same architecture, security standards, and development practices.

---

# Repository Structure

```text
flutter/
├── README.md
├── AGENTS.md
├── CLAUDE.md
│
├── bootstrap/
│   └── create_flutter_project.sh
│
└── skills/
    ├── project-bootstrap/
    │   └── SKILL.md
    ├── architecture/
    │   └── SKILL.md
    ├── api-standards/
    │   └── SKILL.md
    ├── auth-standards/
    │   └── SKILL.md
    ├── data-storage/
    │   └── SKILL.md
    ├── caching/
    │   └── SKILL.md
    ├── unit-testing/
    │   └── SKILL.md
    └── flutter-pr-review/
        └── SKILL.md
```

---

# Prerequisites

Install one of:

## Flutter

```bash
flutter --version
```

## FVM

```bash
fvm --version
```

The bootstrap script automatically prefers FVM and falls back to Flutter.

---

# Creating A New Project

Download the bootstrap script:

```bash
curl -O https://raw.githubusercontent.com/shaileshjosh/ai-assistant-skills/main/flutter/bootstrap/create_flutter_project.sh
```

Make it executable:

```bash
chmod +x create_flutter_project.sh
```

---

# Create Cursor Project

```bash
./create_flutter_project.sh banking_app cursor
```

Open project:

```bash
cd banking_app
cursor .
```

Generated structure:

```text
banking_app/
├── AGENTS.md
├── .cursor/
│   └── skills/
└── lib/
```

---

# Create Claude Project

```bash
./create_flutter_project.sh banking_app claude
```

Open project:

```bash
cd banking_app
claude
```

Generated structure:

```text
banking_app/
├── CLAUDE.md
├── .claude/
│   └── skills/
└── lib/
```

---

# Available Skills

| Skill             | Purpose                                            |
| ----------------- | -------------------------------------------------- |
| project-bootstrap | Project initialization                             |
| architecture      | Architecture, folder structure, feature generation |
| api-standards     | APIs, repositories, models, datasources            |
| auth-standards    | Authentication and authorization                   |
| data-storage      | Hive and Secure Storage                            |
| caching           | Cache implementation and invalidation              |
| unit-testing      | Unit, widget and integration testing               |
| flutter-pr-review | Pull request review                                |

---

# Developer Workflow

## Step 1

Create a project:

```bash
./create_flutter_project.sh my_app cursor
```

or

```bash
./create_flutter_project.sh my_app claude
```

---

## Step 2

Initialize the project:

```text
Initialize this project
```

The AI automatically:

* Loads project-bootstrap
* Loads architecture
* Creates the project foundation

---

## Step 3

Create a feature:

```text
Create Customer feature
```

The AI automatically applies:

* architecture

---

## Step 4

Create API integration:

```text
Create Customer API integration
```

The AI automatically applies:

* architecture
* api-standards

---

## Step 5

Create authentication:

```text
Create Login feature
```

The AI automatically applies:

* architecture
* auth-standards
* data-storage
* unit-testing

---

## Step 6

Add local storage:

```text
Store customer profile locally
```

The AI automatically applies:

* data-storage

---

## Step 7

Add caching:

```text
Add caching to customer list API
```

The AI automatically applies:

* caching

---

## Step 8

Generate tests:

```text
Generate tests for Customer feature
```

The AI automatically applies:

* unit-testing

---

## Step 9

Review PR:

```text
Review current branch changes
```

The AI automatically applies:

* flutter-pr-review

---

# Architecture

The repository architecture standard is defined in:

```text
skills/architecture/SKILL.md
```

This is the canonical source for:

* Clean Architecture
* Layer responsibilities
* Feature-first structure
* Dependency injection
* Riverpod
* GoRouter
* Dio
* Hive
* Secure Storage
* Testing standards
* Approved package versions

All generated code must follow this specification.

---

# Adding New Skills

Create a new folder:

```text
flutter/skills/payment-module/
└── SKILL.md
```

Example:

```markdown
---
name: payment-module
description: Payment feature standards.
---

# Payment Module

## When to use

Use this skill when implementing payments.

## Standards

...
```

Commit and push.

All newly created projects will automatically receive the new skill.

---

# Project Priorities

1. Security
2. Scalability
3. Clean Architecture
4. Testability

All skills and generated code must follow these priorities.
