# Native Splash Screen Setup

This project uses **flutter_native_splash** for the native splash screen. All settings live in **`flutter_native_splash.yaml`** (no hardcoded values in `main.dart` or UI code).

---

## 1. Pubspec (already updated)

Snippet from `pubspec.yaml`:

```yaml
dependencies:
  # ... other deps
  flutter_native_splash: ^2.4.7
```

Run **`flutter pub get`** after pulling changes.

---

## 2. Splash configuration file

Path: **`flutter_native_splash.yaml`** (project root).

It configures:

- **Fullscreen** – hides Android status/notification bar.
- **Background color** – `color` (and optional `color_dark`).
- **Logo** – `image` path (and optional `image_dark`).
- **Android 12+** – `android_12` block (color, image, `icon_background_color`).

---

## 3. Where to put the splash image

- Default path in this project: **`assets/images/splash_text.png`**. Put your logo there, or change the `image` path in `flutter_native_splash.yaml` to another asset (e.g. `assets/images/splash.png`).
- **General (Android <12, iOS, Web):** PNG, 4x density (e.g. 512×512 or larger).
- **Android 12+:** Same file is used; shown in a center circle. Prefer **960×960 px** when using `icon_background_color`, or **1152×1152 px** without. Keep important content inside the circle.

Ensure the path you use is listed under `flutter.assets` in `pubspec.yaml`.

---

## 4. Command to generate the splash

From the project root:

```bash
dart run flutter_native_splash:create
```

If the config file is not in the project root or has another name:

```bash
dart run flutter_native_splash:create --path=path/to/flutter_native_splash.yaml
```

Then run the app as usual; the native splash will show on cold start.

---

## 5. Field reference (short)

| Field | Scope | Description |
|-------|--------|-------------|
| **color** | All except Android 12+ | Background color (hex, e.g. `"#0D47A1"`). |
| **color_dark** | All except Android 12+ | Dark theme background. |
| **image** | All except Android 12+ | Path to center logo PNG (4x density). |
| **image_dark** | All except Android 12+ | Dark theme logo. |
| **fullscreen** | Android (iOS already fullscreen) | `true` = hide status/notification bar. |
| **android_12.color** | Android 12+ | Splash background color. |
| **android_12.image** | Android 12+ | Center logo (circle); omit to use launcher icon. |
| **android_12.icon_background_color** | Android 12+ | Background of the circular icon area. |

---

## Remove splash (restore default)

```bash
dart run flutter_native_splash:remove
```

(Add `--path=...` if using a custom config path.)
