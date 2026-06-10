# Flutter AI Skills Framework

This repository provides reusable AI skills for Flutter development using Cursor and Claude.

The framework standardizes:

* Architecture
* API Development
* Authentication
* Storage
* Caching
* Testing
* PR Reviews

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
    ├── architecture/
    ├── api-standards/
    ├── auth-standards/
    ├── data-storage/
    ├── caching/
    ├── unit-testing/
    ├── bfsi-auth/
    └── flutter-pr-review/
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

Download script:

```bash
curl -O https://raw.githubusercontent.com/shaileshjosh/ai-assistant-skills/main/flutter/bootstrap/create_flutter_project.sh
```

Make executable:

```bash
chmod +x create_flutter_project.sh
```

---

## Create Cursor Project

```bash
./create_flutter_project.sh graphify_demo cursor
```

Open project:

```bash
cd graphify_demo
cursor .
```

Prompt:

```text
Use project-bootstrap skill.

Initialize this project.
```

---

## Create Claude Project

```bash
./create_flutter_project.sh graphify_demo claude
```

Open project:

```bash
cd graphify_demo
claude
```

Prompt:

```text
Use project-bootstrap skill.

Initialize this project.
```

---

# Available Skills

## project-bootstrap

Initialize a new Flutter project.

Responsibilities:

* Project structure
* Riverpod setup
* Dio setup
* GoRouter setup
* Hive setup
* Secure Storage setup
* Testing foundation

---

## architecture

Use for:

* Feature creation
* Boilerplate generation
* Refactoring

Responsibilities:

* Clean Architecture
* Feature-first structure
* Repository Pattern
* Dependency Injection

---

## api-standards

Use for:

* API integrations
* Repositories
* Interceptors
* Network layer

---

## auth-standards

Use for:

* Login
* Logout
* JWT
* Refresh tokens
* Biometrics
* Session management

---

## data-storage

Use for:

* Hive
* Secure Storage
* Local persistence

---

## caching

Use for:

* Offline support
* Cache invalidation
* Repository caching

---

## unit-testing

Use for:

* Unit Tests
* Widget Tests
* Mocking

---

## bfsi-auth

Use for BFSI authentication modules.

Example:

```text
Use bfsi-auth skill.

Create login module.
```

---

## flutter-pr-review

Use before creating a PR.

Example:

```text
Use flutter-pr-review skill.

Review current branch changes.
```

---

# Recommended Workflow

## 1. Create Project

```bash
./create_flutter_project.sh my_app cursor
```

or

```bash
./create_flutter_project.sh my_app claude
```

---

## 2. Initialize Project

```text
Use project-bootstrap skill.

Initialize this project.
```

---

## 3. Generate Features

```text
Use architecture skill.

Create Customer feature.
```

---

## 4. Generate APIs

```text
Use api-standards skill.

Create Customer API integration.
```

---

## 5. Generate Tests

```text
Use unit-testing skill.

Generate tests for Customer feature.
```

---

## 6. Review Before Merge

```text
Use flutter-pr-review skill.

Review current branch changes.
```

---

# Troubleshooting

Verify Flutter:

```bash
flutter --version
```

or

```bash
fvm flutter --version
```

Verify repository access:

```bash
git clone https://github.com/shaileshjosh/ai-assistant-skills.git /tmp/test-skills
```

Verify skills:

```bash
ls /tmp/test-skills/flutter/skills
```

Expected folders:

```text
api-standards
architecture
auth-standards
bfsi-auth
caching
data-storage
flutter-pr-review
project-bootstrap
unit-testing
```

---

# Contributing

To add a new skill:

```text
flutter/skills/payment-module/
└── SKILL.md
```

Commit and push.

All newly created projects will automatically receive the updated skills.
