# Password Manager

A secure offline password manager built with Flutter. The application allows users to safely store and access their credentials using multiple authentication methods.

## Features

-  Biometric Authentication
-  PIN Unlock
-  Password Unlock
-  Create, Reset, and Forgot Credentials Flow
-  Security Focused
  - Uses SQLCipher for encrypted password storage
  - Encryption keys injected at build time using `--dart-define`
  - Fully offline, no network dependency

## Architecture

- Riverpod for state management
- Clean and scalable feature-based structure
- Service abstraction for storage and biometric authentication

## Testing

### Unit Tests
- Business logic fully covered
- Edge cases tested and verified

### Widget Tests
- Most user flows covered
- Authentication screens tested
- Error and validation scenarios tested

## Tech Stack

- Flutter
- Riverpod
- SQLCipher
- Local Authentication
- Flutter Test
- Mocktail

## Screenshots

(screenshots)

## Getting Started

```bash
flutter pub get
flutter run
```

## Note 
you can download apk and run in your mobile.
