# Freezed Removal Plan

## Summary

**Finding:** Your project does **not** use `freezed` anywhere. There are no `@freezed` classes, no `freezed_annotation` imports, and no `.freezed.dart` generated files. All models are already plain Dart classes.

**Impact:** Removal is a single-step change: delete the `freezed` entry from `pubspec.yaml`.

---

## 1. Files and Classes Using `@freezed` or `freezed_annotation`

| Location | Status |
|----------|--------|
| `lib/` (all 98 Dart files) | **None** – no `@freezed` or `freezed_annotation` usage |
| Any `.freezed.dart` files | **None** – no generated files exist |

**Conclusion:** No Dart source files need modification.

---

## 2. Generated `.freezed.dart` Files to Delete

| File | Status |
|------|--------|
| Any `*.freezed.dart` | **None exist** in the project |

**Conclusion:** No generated files to delete.

---

## 3. Current Model Classes (Already Plain Dart)

These models are already standard Dart classes with constructors and `final` fields. **No conversion needed.**

| File | Class(es) | Notes |
|------|-----------|-------|
| `lib/core/models/medical_form_model.dart` | `Item` | Plain class with `name`, `price` |
| `lib/core/models/app_info_model.dart` | `AppInfoUIModel` | Plain class with multiple fields |
| `lib/core/models/base_model.dart` | `BaseModel` | Abstract placeholder |
| `lib/core/errors/failure.dart` | `Failure` | Abstract placeholder |
| `lib/core/errors/failures.dart` | `Failure`, `NetworkFailure`, etc. | Uses Equatable, not freezed |

---

## 4. References to `fromJson` / `toJson` / `copyWith`

| Usage | Location | Type |
|-------|----------|------|
| `copyWith` | Various widgets | Flutter API (`TextStyle.copyWith`, `MediaQuery.copyWith`, etc.) – **not freezed** |
| `fromJson` | **None** | Not used for model parsing |
| `toJson` | **None** | Not used for model serialization |

**Conclusion:** No freezed-related serialization or `copyWith` to update.

---

## 5. Files to Modify

| File | Action |
|------|--------|
| `pubspec.yaml` | Remove `freezed: ^2.5.6` from `dev_dependencies` |

---

## 6. Files to Delete

| File | Status |
|------|--------|
| `*.freezed.dart` | **None exist** – nothing to delete |

---

## 7. Updated `pubspec.yaml` – dev_dependencies Section

**Before:**
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  build_runner: ^2.4.14
  freezed: ^2.5.6          # ← REMOVE this line
  json_serializable: ^6.7.1
  mocktail: ^1.0.3
```

**After:**
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  build_runner: ^2.4.14
  json_serializable: ^6.7.1
  mocktail: ^1.0.3
```

---

## 8. Classes – No Changes Required

Because there are no freezed classes, no conversions are needed. Existing models already follow the desired pattern:

**Example – `Item` (medical_form_model.dart):**
```dart
class Item {
  final String? name;
  final String? price;

  const Item({
    this.name,
    this.price,
  });
}
```

**Example – `AppInfoUIModel` (app_info_model.dart):**
```dart
class AppInfoUIModel {
  final String? title;
  final TextStyle? titleStyle;
  // ... other fields

  const AppInfoUIModel({
    this.title,
    this.titleStyle,
    // ... other params
  });
}
```

---

## 9. Remaining Manual Steps

1. Remove the `freezed` line from `pubspec.yaml` (in `dev_dependencies`).
2. Run:
   ```powershell
   flutter pub get
   flutter clean
   flutter pub get
   flutter analyze
   ```
3. `pubspec.lock` will be updated automatically; `freezed` and `freezed_annotation` will disappear from it after `flutter pub get`.

---

## 10. Execution Checklist

- [ ] Edit `pubspec.yaml` – remove `freezed: ^2.5.6` from `dev_dependencies`
- [ ] Run `flutter pub get`
- [ ] Run `flutter clean` (optional, recommended)
- [ ] Run `flutter pub get` again
- [ ] Run `flutter analyze` – expect no new issues
- [ ] Run `flutter build apk` or `flutter run` to confirm build and runtime

---

## Note on `freezed_annotation`

`freezed_annotation` appears only in `pubspec.lock` as a transitive dependency of `freezed`. You do not need to add or remove it in `pubspec.yaml`; it will be removed from the dependency graph once `freezed` is removed.
