
## 1. Create the New App
Use FVM to create the app with a stable Flutter version.

- **Command:**
  ```
  fvm spawn stable create swoony --org com.leonardo
  ```
- **Explanation:** This creates a new Flutter project named "swoony" using the stable channel of Flutter (via FVM's `spawn` to avoid switching globally). The `--org` flag sets the organization prefix for the package name (defaults to `com.leonardo.swoony`).
- **Next:** Navigate into the project directory:
  ```
  cd swoony
  ```

- **Switch to Stable Flutter Version:**
  ```
  fvm use stable
  ```
- **Explanation:** Pins the stable Flutter version for this project in `.fvm/fvm_config.json`. All subsequent `fvm flutter` commands will use this.

## 2. Change the Package Name
- **Command:**
  ```
  dart run change_app_package_name:main com.leonardo.swoony
  ```
- **Explanation:** Uses the `change_app_package_name` package (add it first via `fvm flutter pub add change_app_package_name` if not already in `pubspec.yaml`). This renames the app's bundle ID/package name across iOS/Android configs and code. Run `fvm flutter pub get` afterward if needed.
- **Tip:** If the package isn't installed, add it to `dev_dependencies` in `pubspec.yaml` and run pub get.

## 3. Git Setup
Initialize and configure Git for the project.

- **Commands:**
  ```
  git init  # If not already initialized
  git add .
  git commit -m "Initial commit"
  git remote add client https://githubAccessToken@github.com/gallorobbie7-cmd/The-Leaderboard-App.git
  git remote set-url client https://githubAccessToken@github.com/gallorobbie7-cmd/The-Leaderboard-App.git  # If updating
  git remote -v  # Verify remotes
  git push client main  # Push to 'client' remote
  git push origin main  # If using 'origin' remote instead
  ```
- **Explanation:** Adds a remote named "client" with a GitHub URL (replace `githubAccessToken` with your actual PAT for authentication). Verifies remotes and pushes the `main` branch. Note: Your URL points to "The-Leaderboard-App.git" – update if this is for "swoony".
- **Tip:** Use HTTPS with PAT for security. If it's a new repo, create it on GitHub first.

## 4. Build and Code Generation
- **One-Time Build:**
  ```
  fvm flutter pub run build_runner build --delete-conflicting-outputs
  ```
- **Explanation:** Runs `build_runner` to generate code (e.g., for json_serializable, freezed). The flag deletes conflicting files to force a clean build.

- **Watch Mode (for Development):**
  ```
  dart run build_runner watch
  ```
- **Explanation:** Watches for file changes and auto-rebuilds generated code. Use `fvm dart run` if needed for version consistency.
- **Tip:** Add packages like `build_runner`, `json_annotation`, etc., to `dev_dependencies` if using them.

## 5. Emulator Setup and Launch
- **List Available AVDs:**
  ```
  emulator -list-avds
  ```
- **Launch Emulator:**
  ```
  emulator -avd Pixel_9a
  ```
- **Explanation:** Lists Android Virtual Devices (AVDs) and launches one named "Pixel_9a". Create it first in Android Studio if it doesn't exist.
- **Tip:** For testing, run `fvm flutter run` to build and deploy to the emulator.

## 6. Generate Launcher Icons
- **Command:**
  ```
  flutter pub run flutter_launcher_icons
  ```
  (Your note had `dart run flutter_launcher_icons:generate -o` which seems incomplete; the above is standard.)
- **Explanation:** Generates app icons for iOS/Android from assets (place your icon in `assets/icon.png` or configure in `pubspec.yaml` under `flutter_launcher_icons`).
- **Prerequisite:** Add `flutter_launcher_icons` to `dev_dependencies` in `pubspec.yaml`, configure the YAML section, and run `fvm flutter pub get`.

## 7. Rename Imports (Batch Replace)
- **PowerShell Command (for Windows):**
  ```
  Get-ChildItem -Recurse -Filter "*.dart" | ForEach-Object { (Get-Content $_.FullName) -replace 'package:bai_serve_agent', 'package:bai_serve_agent' | Set-Content $_.FullName }
  ```
- **Explanation:** Recursively finds all `.dart` files and replaces the old package import (`package:bai_serve_agent`) with the new one. Your example replaces with the same string – update the second part if needed (e.g., to `package:com_leonardo_swoony`).
- **For macOS/Linux (using sed):**
  ```
  find . -type f -name "*.dart" -exec sed -i 's/package:bai_serve_agent/package:bai_serve_agent/g' {} +
  ```
- **Tip:** Commit changes to Git after this to track modifications.

## 8. Set Up Push Notifications (Firebase)
- **Install Firebase CLI:**
  ```
  npm install -g firebase-tools
  ```
- **Logout (if needed):**
  ```
  firebase logout
  ```
- **Login:**
  ```
  firebase login
  ```
- **Configure FlutterFire:**
  ```
  flutterfire configure
  ```
- **Explanation:** Installs the Firebase CLI globally via npm. Logs in to your Google account, then configures Firebase for your Flutter app (adds `firebase_core`, generates config files like `firebase_options.dart`).
- **Prerequisites:** Add `firebase_core`, `firebase_messaging`, etc., to `dependencies` in `pubspec.yaml` and run pub get. Set up a Firebase project in the console.
- **Tip:** After configuration, integrate push notifications in your code (e.g., request permissions, handle tokens).

## 9. Mason Setup for Code Generation
Mason is a Dart template engine for scaffolding features like BLoC or GetX.

- **Initialize Mason:**
  ```
  mason init
  ```
- **Add Bricks (Templates):**
  ```
  mason add bloc_feature
  ```
  (Assuming "bloc_feature" is a brick; replace with actual brick names from mason hub.)
- **Generate Features:**
  ```
  mason make getx_feature --name packageName
  mason make bloc_feature --name packageName
  ```
- **Explanation:** Initializes Mason in your project. Adds a brick (template), then generates a new feature (e.g., a BLoC or GetX module) with the given name (replace `packageName` with something like "auth").
- **Prerequisites:** Install Mason globally: `dart pub global activate mason_cli`. Search for bricks on brickhub.dev.
- **Tip:** Use for rapid feature creation – e.g., `mason make bloc_feature --name auth` scaffolds an "auth" folder with BLoC files.

## app release
- **Command:**
  ios
  ```
  pod deintegrate
  pod install
  fvm flutter build ios --release
  ```
  android
  ```
  fvm flutter build apk --release
  fvm flutter build appbundle --release
  ```
- **Explanation:** Builds a release APK for your app. The `--release` flag optimizes the build for production.
