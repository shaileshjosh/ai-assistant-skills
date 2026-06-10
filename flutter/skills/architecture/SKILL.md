# Flutter Architecture & Tech Stack Guide

**Audience:** Flutter engineers starting or standardizing a production-grade app (especially BFSI / enterprise).  
**Source:** Derived from [`skills-data/skills_boilerplate.md`](../skills-data/skills_boilerplate.md) and this repository’s implementation patterns.

---

## 1. Architecture

### 1.1 Principles

| Principle | What it means |
|-----------|----------------|
| **Clean Architecture** | Business rules live in **domain**; UI and frameworks stay at the edges. |
| **Feature-first structure** | Code is grouped by product capability (`auth`, `dashboard`, `transactions`), not by technical type alone. |
| **Layer separation** | **Presentation**, **Domain**, and **Data** are distinct folders with explicit boundaries. |
| **Dependency rule** | Dependencies point **inward only**: `presentation → domain ← data`. Domain never imports Flutter, Dio, or Hive. |
| **Testability** | Each layer can be tested in isolation (usecases, repositories, notifiers, widgets). |

### 1.2 Layer responsibilities

```
┌─────────────────────────────────────────────────────────────┐
│  PRESENTATION (UI)                                          │
│  Screens, widgets, Riverpod notifiers/providers             │
│  • Renders state, handles user input                        │
│  • No direct HTTP, no raw JSON parsing                      │
└───────────────────────────┬─────────────────────────────────┘
                            │ calls
                            ▼
┌─────────────────────────────────────────────────────────────┐
│  DOMAIN (business logic)                                    │
│  Entities, repository contracts, usecases                   │
│  • Pure Dart; framework-agnostic                            │
│  • Authorization and business rules enforced here           │
└───────────────────────────┬─────────────────────────────────┘
                            │ implemented by
                            ▼
┌─────────────────────────────────────────────────────────────┐
│  DATA (infrastructure)                                      │
│  Datasources, models, repository implementations            │
│  • ApiClient / Dio, Hive, secure storage                    │
│  • Maps exceptions → Failures; returns models/entities      │
└─────────────────────────────────────────────────────────────┘
```

| Layer | Contains | Must not contain |
|-------|----------|------------------|
| **Presentation** | `screens/`, `widgets/`, `providers/` (StateNotifier) | API URLs, `Dio` calls, storage keys, business rules |
| **Domain** | `entities/`, abstract `repositories/`, `usecases/` | `BuildContext`, widgets, `Response`, Hive boxes |
| **Data** | `datasources/`, `models/`, `repositories/*_impl` | UI state, navigation, theme |

### 1.3 Feature-first folder structure

Use one folder per feature under `lib/features/<feature_name>/`:

```
lib/
├── main.dart                    # App entry: bindings, Hive.init, ProviderScope
├── app/
│   ├── app.dart                 # MaterialApp.router, theme mode
│   └── router/
│       └── app_router.dart      # go_router routes + auth redirect
├── core/                        # Shared, non-feature-specific infrastructure
│   ├── constants/               # ApiConstants, AppConstants, CacheKeys
│   ├── error/                   # exceptions, Failure types
│   ├── network/                 # ApiClient, interceptors
│   ├── storage/                 # SecureStorageService
│   ├── theme/                   # AppTheme, colors, typography
│   └── widgets/                 # AppButton, AppTextField, LoadingOverlay, …
└── features/
    └── <feature>/
        ├── domain/
        │   ├── entities/
        │   ├── repositories/    # abstract contracts
        │   └── usecases/
        ├── data/
        │   ├── datasources/     # abstract + *_impl
        │   ├── models/          # JSON ↔ entity mapping
        │   └── repositories/    # *RepositoryImpl
        └── presentation/
            ├── providers/
            ├── screens/
            └── widgets/
```

**`test/` mirrors `lib/`** — same feature and layer paths for unit and widget tests.

### 1.4 Data flow (request path)

Typical read/write flow for a feature:

1. **Screen** triggers an action on a **Notifier** (e.g. login button).
2. **Notifier** calls a **Usecase** (domain).
3. **Usecase** calls the abstract **Repository**.
4. **RepositoryImpl** (data) calls **RemoteDataSource** / local cache.
5. **DataSource** uses **ApiClient** (never raw `Dio` in features).
6. Results return as **`Either<Failure, T>`** from the repository upward.
7. **Notifier** updates **state**; UI rebuilds via `ref.watch`.

```dart
// Domain: contract + usecase
abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginParams params);
}

// Data: implementation maps typed exceptions → Failure
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  // try/catch ServerException, NetworkException, …
}

// Presentation: notifier consumes usecase
class AuthNotifier extends StateNotifier<AuthState> {
  Future<bool> login({required String email, required String password}) async {
    final result = await _loginUsecase(LoginParams(email: email, password: password));
    return result.fold(/* failure */, /* success */);
  }
}
```

### 1.5 Dependency injection (Riverpod)

- Register **one `StateNotifierProvider` per feature** for UI state.
- Wire **repository inside a `Provider`** — instantiate datasource `Impl` there; do **not** expose datasource as its own top-level provider.
- Share app-wide services via providers: `apiClientProvider`, `secureStorageServiceProvider`, `appRouterProvider`.

```dart
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  final storage = ref.watch(secureStorageServiceProvider);
  return AuthRepositoryImpl(AuthRemoteDataSourceImpl(client, storage));
});

final loginUsecaseProvider = Provider<LoginUsecase>((ref) {
  return LoginUsecase(ref.watch(authRepositoryProvider));
});

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.watch(loginUsecaseProvider),
    ref.watch(authRepositoryProvider),
  );
});
```

### 1.6 Cross-cutting concerns (where they live)

| Concern | Layer / location |
|---------|------------------|
| Navigation & deep links | `lib/app/router/` (`go_router`, route guards) |
| Theming (Material 3, dark/light) | `lib/core/theme/` |
| HTTP + interceptors (auth, errors, logging) | `lib/core/network/` |
| Tokens & secrets | `SecureStorageService` — never Hive/SharedPreferences |
| Offline cache & preferences | Hive in data layer / cache service |
| Role / permission checks | **Usecase** layer (not UI-only) |
| Reusable UI | `lib/core/widgets/` |

### 1.7 Reference feature set (BFSI boilerplate)

Standard modules to plan for in a banking/fintech-style app:

| Feature | Typical scope |
|---------|----------------|
| **Login** | Credentials, token storage, session start |
| **Dashboard** | Accounts summary, quick actions |
| **Profile** | User details, settings |
| **Transaction history** | Paginated lists, filters |
| **Notifications** | In-app / push inbox (as product requires) |

Each follows the same `domain / data / presentation` layout.

### 1.8 Architecture anti-patterns (avoid)

- Business logic inside `build()` or widgets.
- Calling **`Dio` directly** from a feature (bypassing `ApiClient`).
- Storing **JWT, PIN, or passwords** in Hive or SharedPreferences.
- **UI-only** authorization (always enforce in usecases).
- **Hardcoded** URLs, route strings, storage keys, or cache TTLs.
- Skipping domain abstractions (no repository interface / no usecases).

---

## 2. Tech stack

Use this stack for any new Flutter project aligned with this boilerplate. Packages are the **approved defaults**; swap only with team approval.

### 2.1 Stack overview

| Category | Technology | Package(s) |
|----------|------------|------------|
| **Language / SDK** | Dart 3+, null safety | `sdk: '>=3.0.0 <4.0.0'` |
| **UI framework** | Flutter (Material 3) | `flutter` |
| **State management** | Riverpod | `flutter_riverpod`, `riverpod_annotation` (optional codegen) |
| **Navigation** | Declarative routing + guards | `go_router` |
| **Networking** | HTTP client + interceptors | `dio` |
| **Functional errors** | `Either` for repository results | `dartz` |
| **Value objects** | Equality for entities/state | `equatable` |
| **Local database** | Key-value / cache boxes | `hive`, `hive_flutter` |
| **Secure storage** | Keychain / Keystore | `flutter_secure_storage` |
| **Biometrics** | Device auth re-prompt | `local_auth` |
| **Testing** | Unit + widget tests | `flutter_test`, `mockito`, `build_runner` |
| **Linting** | Static analysis | `flutter_lints` |

### 2.2 State management — Riverpod

**Why:** Compile-safe providers, testable overrides, scales with feature modules.

**Conventions:**

- `ProviderScope` at app root (`main.dart`).
- `StateNotifierProvider` per feature for screen-level state (`isLoading`, `error`, domain models).
- Plain `Provider` for repositories, usecases, and singleton services.
- UI: `ConsumerWidget` / `ConsumerStatefulWidget` + `ref.watch` / `ref.read`.

### 2.3 Navigation — go_router

**Why:** URL-based routes, redirect guards, deep linking, nested navigation.

**Conventions:**

- Central `GoRouter` in `lib/app/router/app_router.dart`.
- Route paths as constants (`AppRoutes.login`, `AppRoutes.dashboard`).
- **Auth redirect** in `redirect:` — public routes vs protected routes.
- `MaterialApp.router` with `routerConfig`.

### 2.4 Networking — Dio + ApiClient

**Why:** Interceptors for JWT, centralized timeouts and base URL, typed error mapping.

**Conventions:**

- Single **`ApiClient`** wrapper — features never import `Dio` directly.
- **`ApiConstants`**: `baseUrl`, timeouts, endpoint paths only.
- Interceptor order: **Auth** → **Error** → **Log** (dev only).
- JWT: access + refresh tokens via **secure storage**; silent refresh at most **once** per request.
- Repository returns **`Either<Failure, T>`** — no swallowed exceptions.

### 2.5 Security

| Requirement | Implementation |
|-------------|----------------|
| Tokens, PIN, secrets | `flutter_secure_storage` via `SecureStorageService` |
| SSL pinning | Platform/channel or Dio adapter (per security spec) |
| Biometric re-auth | `local_auth` for sensitive actions (transfers, card details, settings) |
| Session timeout | App-wide timer + logout on inactivity (e.g. 30 minutes) |
| Logging | Never log tokens, passwords, MPINs, OTPs |

### 2.6 Local persistence — Hive

**Why:** Fast local boxes for cache metadata, preferences, offline read models.

**Use Hive for:**

- Cached API payloads (with TTL metadata).
- Non-sensitive user preferences.
- Offline-first read models.

**Do not use Hive for:**

- JWT, refresh tokens, PINs, or credentials.

### 2.7 UI & UX

| Topic | Standard |
|-------|----------|
| Design system | **Material 3** (`useMaterial3: true`) |
| Theming | Central `AppTheme` — light + dark, `ThemeMode.system` |
| Responsive layout | `LayoutBuilder` / `MediaQuery.sizeOf` — adapt to **window size**, not device type alone |
| Shared components | `lib/core/widgets/` — buttons, fields, loaders |
| Code standards | Reusable widgets, null safety, repository pattern, explicit error handling |

For responsive layouts in Cursor, use `@flutter-build-responsive-layout` (`.agents/skills/`).

### 2.8 Suggested `pubspec.yaml` dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  # State
  flutter_riverpod: ^2.4.9
  riverpod_annotation: ^2.3.3

  # Navigation
  go_router: ^13.2.0

  # Network
  dio: ^5.4.0

  # Storage
  flutter_secure_storage: ^9.0.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0

  # Security / device
  local_auth: ^2.1.8

  # Utilities
  equatable: ^2.0.5
  dartz: ^0.10.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  mockito: ^5.4.4
  build_runner: ^2.4.8
  riverpod_generator: ^2.3.9
  hive_generator: ^2.0.1
```

### 2.9 Related specifications

When implementing beyond boilerplate, read the matching spec in `skills-data/`:

| Topic | Spec file | Cursor skill |
|-------|-----------|----------------|
| API layer | `skills_api_standards.md` | `@bfsi-api` |
| Auth & session | `skills_auth.md` | `@bfsi-auth` |
| Storage | `skills_data_storage.md` | `@bfsi-storage` |
| Caching | `skills_caching.md` | `@bfsi-caching` |
| Testing | `skills_unit_testing.md` | `@bfsi-testing` |

---

## Quick start checklist (new project)

- [ ] Create `lib/app`, `lib/core`, `lib/features/<first_feature>` with three layers each.
- [ ] Add approved packages to `pubspec.yaml`.
- [ ] Implement `ApiClient`, `SecureStorageService`, `AppTheme`, `app_router`.
- [ ] Add first feature: entity → repo contract → usecase → datasource → repo impl → notifier → screen.
- [ ] Mirror structure under `test/`.
- [ ] Enforce `CLAUDE.md` priorities: security → scalability → clean architecture → compliance → testability.

---

*Canonical boilerplate spec:* [`skills-data/skills_boilerplate.md`](../skills-data/skills_boilerplate.md)
