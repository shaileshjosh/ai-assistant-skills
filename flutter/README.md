# Flutter AI Skills Framework

This repository provides reusable AI skills for Flutter development using tools such as Cursor and Claude.

The objective is to standardize:

* Project Architecture
* API Development
* Authentication
* Data Storage
* Caching
* Testing
* Code Reviews

across all Flutter projects.

---

# Repository Structure

```text
flutter/
├── README.md
│
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

Install one of the following:

## Flutter

```bash
flutter --version
```

or

## FVM

```bash
fvm --version
```

The bootstrap script automatically uses FVM if available and falls back to Flutter otherwise.

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

## Create Cursor Project

```bash
./create_flutter_project.sh graphify_demo cursor
```

Project structure:

```text
graphify_demo/
├── android/
├── ios/
├── lib/
├── pubspec.yaml
└── .cursor/
    └── skills/
```

---

## Create Claude Project

```bash
./create_flutter_project.sh graphify_demo claude
```

Project structure:

```text
graphify_demo/
├── android/
├── ios/
├── lib/
├── pubspec.yaml
└── .claude/
    └── skills/
```

---

# Available Skills

## project-bootstrap

Use when creating a new Flutter project.

Example:

```text
Use project-bootstrap skill.

Initialize this project.
```

Responsibilities:

* Setup project architecture
* Configure dependencies
* Setup Riverpod
* Setup Dio
* Setup GoRouter
* Setup Hive
* Setup Secure Storage
* Configure testing foundation

---

## architecture

Use when:

* Creating new features
* Creating screens
* Refactoring modules
* Generating boilerplate code

Responsibilities:

* Clean Architecture
* Feature-first structure
* Repository Pattern
* Dependency Injection
* Riverpod setup

---

## api-standards

Use when:

* Creating APIs
* Creating repositories
* Creating interceptors
* Creating network layers

Responsibilities:

* Dio configuration
* Error handling
* Response mapping
* Request interceptors
* Token management

---

## auth-standards

Use when:

* Login
* Logout
* JWT Authentication
* Refresh Tokens
* Session Management
* Route Protection
* Biometric Authentication

Responsibilities:

* Authentication architecture
* Token storage
* Session handling
* Security best practices

---

## data-storage

Use when:

* Hive
* Secure Storage
* Local Data Persistence

Responsibilities:

* Storage architecture
* Secure storage implementation
* Data lifecycle management

---

## caching

Use when:

* Offline support
* API response caching
* Cache invalidation

Responsibilities:

* Cache strategy
* TTL handling
* Cache refresh mechanism

---

## unit-testing

Use when:

* Writing unit tests
* Widget testing
* Mock generation

Responsibilities:

* Test coverage
* Mock setup
* Repository testing
* Provider testing

---

## bfsi-auth

Use when implementing BFSI authentication.

Responsibilities:

* Login
* Logout
* MPIN
* Biometric Login
* Session Timeout
* JWT Authentication

Example:

```text
Use bfsi-auth skill.

Create authentication module.
```

---

## flutter-pr-review

Use before creating a Pull Request.

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
* Best practice validation

---

# Recommended Workflow

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

Create Login feature.
```

---

## Step 4

Create APIs:

```text
Use api-standards skill.

Create Customer API integration.
```

---

## Step 5

Generate tests:

```text
Use unit-testing skill.

Generate tests for Customer feature.
```

---

## Step 6

Review before merge:

```text
Use flutter-pr-review skill.

Review current branch changes.
```

---

# Adding New Skills

Create a new folder under:

```text
flutter/skills/
```

Example:

```text
flutter/skills/payment-module/
└── SKILL.md
```

Recommended structure:

```markdown
# Skill Name

## When To Use

Describe usage.

## Responsibilities

Describe expected behaviour.

## Standards

Describe implementation guidelines.
```

After committing and pushing, the skill will automatically be available in newly created projects.

---

# Coding Standards

All generated code should follow:

* Clean Architecture
* Feature-first structure
* Riverpod
* Dio
* Hive
* Flutter Secure Storage
* Material 3
* Null Safety
* Proper Error Handling
* Unit Testing
* Repository Pattern
* Dependency Injection

---

# Support

If a skill requires updates:

1. Modify the relevant `SKILL.md`
2. Commit changes
3. Push to repository

All future projects created using the bootstrap script will automatically use the updated skill definitions.
