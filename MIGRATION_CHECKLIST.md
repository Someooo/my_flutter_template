# Flutter Template Modernization Checklist

A structured guide to modernize and optimize this Flutter template project. Execute items in order where dependencies exist.

---

## 1. Outdated Packages & Suggested Updates

| Package | Current | Suggested | Notes |
|---------|---------|-----------|-------|
| **cupertino_icons** | ^1.0.8 | ^1.0.8 | Already current |
| **get** | ^4.6.6 | ^4.7.3 | Patch update available |
| **get_storage** | ^2.1.1 | ^2.1.1 | Keep or remove (see §2) |
| **hive** | ^2.2.3 | ^2.2.3 | Keep or remove (see §2) |
| **hive_flutter** | ^1.1.0 | ^1.1.0 | Keep or remove (see §2) |
| **firebase_core** | ^2.25.4 | ^3.8.0 | Major update; verify compatibility |
| **firebase_analytics** | ^10.10.4 | ^11.3.5 | Align with firebase_core version |
| **firebase_crashlytics** | ^3.5.4 | ^4.1.5 | Align with firebase_core version |
| **dio** | ^5.4.3 | ^5.9.1 | Patch update available |
| **fpdart** | ^1.1.1 | ^1.1.1 | Keep or remove (see §2) |
| **flutter_screenutil** | ^5.9.0 | ^5.9.3 | Patch update available |
| **intl** | ^0.20.2 | ^0.20.2 | Already current |
| **equatable** | ^2.0.5 | ^2.0.5 | Already current |
| **cached_network_image_plus** | ^0.0.5 | ^0.0.5 | Check pub.dev for updates |
| **flutter_lints** | ^5.0.0 | ^5.0.0 | Already current |
| **build_runner** | ^2.4.14 | ^2.4.15 | Patch update available |
| **freezed** | ^2.5.6 | ^2.5.7 | Keep or remove (see §2) |
| **json_serializable** | ^6.7.1 | ^6.9.2 | Keep or remove (see §2) |
| **mocktail** | ^1.0.3 | ^1.0.4 | Patch update available |

**Recommended `pubspec.yaml` updates** (conservative, non-breaking):

```yaml
dependencies:
  get: ^4.7.3
  dio: ^5.9.1
  flutter_screenutil: ^5.9.3
  # ... other packages
```

---

## 2. Unused Packages – Safe to Remove

| Package | Status | Reason |
|---------|--------|--------|
| **get_storage** | UNUSED | No imports in lib; `StorageService` is a placeholder |
| **hive** | UNUSED | No imports in lib |
| **hive_flutter** | UNUSED | No imports in lib |
| **fpdart** | UNUSED | No imports; no `Option`/`Either`/`Task` usage |
| **freezed** | UNUSED | No `@freezed` classes or `.freezed.dart` files |
| **json_serializable** | UNUSED | No `@JsonSerializable` or `.g.dart` files |

**Caution – keep for now if you plan to use soon:**
- `firebase_core`, `firebase_analytics`, `firebase_crashlytics`: `FirebaseService` exists but is never instantiated or called. Either integrate Firebase initialization in `main.dart` or remove all three.
- `dio`: `ApiClient`/`ApiService` are placeholders. Remove if you won’t use Dio, or wire it up later.

**Steps to remove unused packages:**

1. Edit `pubspec.yaml` and remove the package lines.
2. Run `flutter pub get`.
3. Run `flutter analyze` and fix any new issues.

---

## 3. Unused Imports, Files, and Widgets

### Unused or Orphan Files

| File | Status |
|------|--------|
| `lib/app_router.dart` | UNUSED – app uses `AppRoutes`, not `AppRouter` |
| `lib/config/app_endpoints.dart` | UNUSED – no references |
| `lib/config/api_paths.dart` | UNUSED – no references |
| `lib/config/json_constants.dart` | UNUSED – no references |
| `lib/config/hive_box_constants.dart` | UNUSED – no references |
| `lib/core/controllers/localization_controller.dart` | UNUSED – `LanguageController` used instead |
| `lib/core/services/firebase_service.dart` | UNUSED – never instantiated |
| `lib/core/utils/force_update_state.dart` | UNUSED – only referenced in commented code |
| `lib/core/widgets/force_update_dialog.dart` | UNUSED – not imported anywhere |
| `lib/core/widgets/language_widget.dart` | UNUSED – not imported anywhere |

### Widgets exported but not used in app flow

- `GreyContainer`, `Loader1` – exported via `widgets.dart` but not referenced in routes or main screens
- `custom_drop_down`, `gallery_widget`, `map_screen`, `photos_gallery_screen` – template widgets for future use; safe to keep

### Typos to fix

| Current | Correct |
|---------|---------|
| `home_scrren.dart` | `home_screen.dart` |

After renaming, update `lib/config/app_routes.dart` import.

### Broken import

**File:** `lib/core/widgets/app_widgets/hcp_profile_container.dart`  
**Current:** `import '../../../../../core/utils/app_text_style.dart';`  
**Correct:** `import '../../utils/app_text_style.dart';`

---

## 4. Code Cleanup Suggestions

1. **Fix `hcp_profile_container.dart` import**
   - Change `'../../../../../core/utils/app_text_style.dart'` → `'../../utils/app_text_style.dart'`

2. **Fix typo**
   - Rename `home_scrren.dart` → `home_screen.dart`
   - Update import in `app_routes.dart`

3. **Consider adding `unused_import` lint**  
   In `analysis_options.yaml`:
   ```yaml
   linter:
     rules:
       unused_import: true
   ```

4. **Firebase integration**
   - Either call `Firebase.initializeApp()` and `FirebaseService().initialize()` in `main.dart`/`di.dart`, or remove Firebase packages if not needed.

5. **`localization_controller`**
   - Remove `lib/core/controllers/localization_controller.dart` if `LanguageController` fully replaces it.

6. **Remove or integrate `app_router.dart`**
   - If using only `AppRoutes`, delete `app_router.dart` to avoid confusion.

---

## 5. Flutter SDK & Platform Upgrade Steps

### 5.1 Flutter SDK

**Current:** `sdk: ^3.6.1`  
**Suggested:** `sdk: ^3.6.1` or `^3.7.0` (depending on your Flutter channel).

1. Update Flutter: `flutter upgrade`
2. Check version: `flutter --version`
3. Adjust `pubspec.yaml` if needed:
   ```yaml
   environment:
     sdk: ^3.6.1  # or ^3.7.0
   ```

### 5.2 Android

**Current:** Uses `flutter.compileSdkVersion`, `flutter.minSdkVersion`, `flutter.targetSdkVersion` from the Flutter SDK.

1. **Explicit values** – add to `android/app/build.gradle`:
   ```gradle
   android {
       compileSdk = 35  // or flutter.compileSdkVersion
       defaultConfig {
           minSdk = 24   // or flutter.minSdkVersion (21+ recommended)
           targetSdk = 35  // or flutter.targetSdkVersion
       }
   }
   ```

2. **Gradle / Kotlin** – in `android/settings.gradle`:
   - Android Gradle Plugin: `8.3.1` → `8.7.2` (or latest stable)
   - Kotlin: `1.9.22` → `2.0.0` (or latest compatible)

### 5.3 iOS

**Current:** `IPHONEOS_DEPLOYMENT_TARGET = 12.0`

1. Edit `ios/Runner.xcodeproj/project.pbxproj`
2. Replace `IPHONEOS_DEPLOYMENT_TARGET = 12.0` with `IPHONEOS_DEPLOYMENT_TARGET = 13.0` (or 14.0 for newer APIs) in all configurations.

Or use Xcode: Runner target → General → Deployment Info → iOS Deployment Target.

### 5.4 macOS (if used)

Update deployment target similarly in `macos/Runner.xcodeproj/project.pbxproj` if present.

---

## 6. Commands – Clean, Get, and Verify Build

Run in project root:

```powershell
# 1. Clean build artifacts
flutter clean

# 2. Get dependencies
flutter pub get

# 3. Verify analysis (no errors)
flutter analyze

# 4. Build Android
flutter build apk --debug

# 5. Build iOS (macOS only)
flutter build ios --debug --no-codesign

# 6. Run tests (if any)
flutter test
```

---

## 7. Execution Checklist

Use this as a step-by-step execution list.

### Phase 1: Dependencies

- [ ] Update `pubspec.yaml` with suggested versions (get, dio, flutter_screenutil, etc.)
- [ ] Remove unused packages: get_storage, hive, hive_flutter, fpdart, freezed, json_serializable (or keep if planned)
- [ ] Run `flutter pub get`
- [ ] Run `flutter analyze`

### Phase 2: Code Fixes

- [ ] Fix import in `hcp_profile_container.dart`
- [ ] Rename `home_scrren.dart` → `home_screen.dart` and update `app_routes.dart`
- [ ] Delete or archive unused files (app_router, app_endpoints, api_paths, json_constants, hive_box_constants, localization_controller, firebase_service, force_update_state, force_update_dialog, language_widget) – only if confirmed safe for your use case

### Phase 3: Platform Upgrades

- [ ] Run `flutter upgrade`
- [ ] Update `environment.sdk` in `pubspec.yaml` if needed
- [ ] Update Android `minSdk` / `compileSdk` / `targetSdk` in `build.gradle`
- [ ] Update iOS `IPHONEOS_DEPLOYMENT_TARGET` in `project.pbxproj`
- [ ] Update Gradle/Kotlin versions in `settings.gradle` if desired

### Phase 4: Verification

- [ ] `flutter clean`
- [ ] `flutter pub get`
- [ ] `flutter analyze` (no errors)
- [ ] `flutter build apk --debug` (or `flutter run` on a device/emulator)
- [ ] `flutter test` (if applicable)

---

## Quick Copy: Updated `pubspec.yaml` (Minimal Changes)

```yaml
name: my_template
description: Feature-based clean architecture Flutter template.
publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: ^3.6.1

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  cupertino_icons: ^1.0.8
  get: ^4.7.3
  # get_storage: ^2.1.1           # REMOVE if not using
  # hive: ^2.2.3                  # REMOVE if not using
  # hive_flutter: ^1.1.0          # REMOVE if not using
  firebase_core: ^2.25.4          # or ^3.8.0 for major update
  firebase_analytics: ^10.10.4
  firebase_crashlytics: ^3.5.4
  dio: ^5.9.1
  # fpdart: ^1.1.1                # REMOVE if not using
  flutter_screenutil: ^5.9.3
  intl: ^0.20.2
  equatable: ^2.0.5
  cached_network_image_plus: ^0.0.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  build_runner: ^2.4.15
  # freezed: ^2.5.7               # REMOVE if not using
  # json_serializable: ^6.9.2     # REMOVE if not using
  mocktail: ^1.0.4

flutter:
  uses-material-design: true
  assets:
    - assets/images/test_test.jpg
```

---

*Generated for my_flutter_template – execute items in order and verify builds after each phase.*
