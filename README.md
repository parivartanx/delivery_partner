# delivery_partner

A cross-platform Flutter application for delivery partners to manage orders, track earnings, and update their profiles.

## Features
- User authentication (login, logout)
- View and manage delivery orders
- Track daily/weekly/monthly earnings
- Profile management
- Localization support
- Responsive UI for mobile and web

## Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.x recommended)
- Dart SDK (comes with Flutter)
- Android Studio/Xcode/VS Code (for emulators and development)
- A device or emulator (Android/iOS/Web)

### Installation
1. Clone the repository:
   ```bash
   git clone <repo-url>
   cd delivery_partner
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```
   For web:
   ```bash
   flutter run -d chrome
   ```

## Project Structure
- `lib/`
  - `main.dart` – App entry point
  - `core/` – Constants, themes, utilities, shared widgets
  - `data/` – Models, repositories, services
  - `features/` – Feature modules (auth, earnings, home, orders, profile)
  - `localization/` – Localization files
  - `routing/` – App routing
  - `shared/` – Shared providers and utilities
- `test/` – Widget and unit tests

## Configuration
- Update `pubspec.yaml` for dependencies
- Platform-specific settings:
  - Android: `android/app/build.gradle.kts`, `android/app/src/`
  - iOS: `ios/Runner/Info.plist`
  - Web: `web/`

## Running Tests
```bash
flutter test
```

## Troubleshooting
- Run `flutter doctor` to check for environment issues
- Clean build: `flutter clean && flutter pub get`
- For platform-specific issues, check the respective platform folders

## Contributing
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes
4. Push to the branch
5. Open a pull request

## License
This project is licensed under the MIT License.

---
Feel free to update this README with more details as the project evolves.
