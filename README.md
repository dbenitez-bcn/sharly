# Sharly

Listas de la compra compartidas.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Trouble shooting

### iOS not working
- Update your cocoapods to  to 1.9.1 or higher with `gem install cocoapods`
- Delete `Podfile.lock`
- Run `flutter pub get` in your terminal
- Under ios folder run `Pod install`
- Run the app in iOS

### Unit tests
Before running unit test run `dart run build_runner` build to autogenerate mocks