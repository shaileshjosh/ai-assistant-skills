# AI Assistant Skills for Flutter

This repository contains reusable AI skills and standards used to bootstrap and develop Flutter applications using AI tools such as Cursor and Claude.

The goal is to provide a consistent architecture, coding standards, security practices, testing standards, and feature generation guidelines across all Flutter projects.

---

# Repository Structure

```text
flutter/
├── bootstrap/
│   └── create_flutter_project.sh
│
└── skills/
    ├── project-bootstrap/
    │   └── SKILL.md
    │
    ├── architecture/
    │   └── SKILL.md
    │
    ├── api-standards/
    │   └── SKILL.md
    │
    ├── auth-standards/
    │   └── SKILL.md
    │
    ├── data-storage/
    │   └── SKILL.md
    │
    ├── caching/
    │   └── SKILL.md
    │
    ├── unit-testing/
    │   └── SKILL.md
    │
    ├── bfsi-auth/
    │   └── SKILL.md
    │
    └── flutter-pr-review/
        └── SKILL.md
```

---

# Prerequisites

Install either:

### Option 1: Flutter

```bash
flutter --version
```

### Option 2: FVM

```bash
fvm --version
```

The bootstrap script automatically uses FVM if available, otherwise it falls back to the installed Flutter SDK.

---

# Creating a New Flutter Project

Download the bootstrap script:

```bash
curl -O https://raw.githubusercontent.com/joshsoftware/ai-assistant-skills/main/flutter/bootstrap/create_flutter_project.sh
```

Make it executable:

```bash
chmod +x create_flutter_project.sh
```

---

## Using Cursor

Create a project:

```bash
./create_flutter_project.sh graphify_demo cursor
```

This creates:

```text
graphify_demo/
├── android/
├── ios/
├── lib/
├── pubspec.yaml
└── .cursor/
    └── skills/
```

Open project:

```bash
cd graphify_demo
cursor .
```

---

## Using Claude

Create a project:

```bash
./create_flutter_project.sh graphify_demo claude
```

This creates:

```text
graphify_demo/
├── android/
├── ios/
├── lib/
├── pubspec.yaml
└── .claude/
    └── skills/
```

Open project:

```bash
cd graphify_demo
claude
```

---

# Available Skills

## project-bootstrap

Use this skill to initialize a newly created Flutter project.

Example:

```text
Use project-bootstrap skill.

Initialize this project.
```

Responsibilities:

* Setup project architecture
* Configure dependencies
* Configure networking
* Configure storage
* Configure routing
* Configure testing setup

---

## architecture

Use this skill when:

* Creating features
* Creating screens
* Refactoring code
* Generating boilerplate

Responsibilities:

* Clean Architecture
* Feature-first structure
* Repository Pattern
* Dependency Injection
* Riverpod setup

---

## api-standards

Use this skill when:

* Creating APIs
* Creating repositories
* Creating network layers
* Creating interceptors

Responsibilities:

* Dio setup
* API client
* Error handling
* Response parsing
* JWT integration

---

## auth-standards

Use this skill when:

* Login
* Logout
* Session management
* JWT handling
* Biometric authentication

Responsibilities:

* Authentication flow
* Token management
* Secure storage
* Route protection

---

## data-storage

Use this skill when:

* Hive
* Secure Storage
* Local persistence

Responsibilities:

* Data storage patterns
* Secure data handling
* Repository integration

---

## caching

Use this skill when:

* Offline support
* API caching
* Cache invalidation

Responsibilities:

* Cache strategy
* Cache lifecycle
* Cache management

---

## unit-testing

Use this skill when:

* Unit testing
* Widget testing
* Mocking

Responsibilities:

* Test coverage
* Mock implementations
* Repository testing
* Provider testing

---

## bfsi-auth

Use this skill when implementing BFSI authentication modules.

Responsibilities:

* Login
* Logout
* MPIN
* Biometric Login
* Session Timeout
* JWT Authentication

---

## flutter-pr-review

Use this skill before raising a Pull Request.

Example:

```text
Use flutter-pr-review skill.

Review current branch changes.
```

Responsibilities:

* Architecture review
* Security review
* Testing review
* Performance review
* Best practices review

---

# Recommended Workflow

## Step 1

Create project:

```bash
./create_flutter_project.sh my_app cursor
```

or

```bash
./create_flutter_project.sh my_app claude
```

---

## Step 2

Initialize project:

```text
Use project-bootstrap skill.

Initialize this project.
```

---

## Step 3

Generate features:

```text
Use architecture skill.

Create Customer feature.
```

or

```text
Use bfsi-auth skill.

Create Login module.
```

---

## Step 4

Implement APIs:

```text
Use api-standards skill.

Create Customer API integration.
```

---

## Step 5

Write tests:

```text
Use unit-testing skill.

Generate tests for Customer feature.
```

---

## Step 6

Review before PR:

```text
Use flutter-pr-review skill.

Review current branch changes.
```

---

# Standards

All generated code must follow:

* Clean Architecture
* Feature-first folder structure
* Riverpod State Management
* Dio Networking
* Hive Local Storage
* Secure Storage
* JWT Authentication
* Material 3
* Null Safety
* Proper Error Handling
* Unit Testing

---

# Contributing

When adding a new skill:

1. Create a new folder under `flutter/skills`
2. Add a `SKILL.md`
3. Document when the skill should be used
4. Provide implementation standards
5. Commit and push changes

Example:

```text
flutter/skills/payment-module/
└── SKILL.md
```

The skill will automatically become available to all newly created projects.
