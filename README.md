# Sharly

Listas de la compra compartidas.

## Getting Started

### Run Dev
- Install firebase tools `npm install -g firebase-tools`
- Under root folder run `firebase emulators:start`
- Run your app in dev mode using `main_dev.dart` as target

### Run integration tests
- Install firebase tools `npm install -g firebase-tools`
- Under root folder run `firebase emulators:start`
- Run `flutter test integration_test/app_test.dart`

## Trouble shooting

### iOS not working
- Update your cocoapods to  to 1.9.1 or higher with `gem install cocoapods`
- Delete `Podfile.lock`
- Run `flutter pub get` in your terminal
- Under ios folder run `Pod install`
- Run the app in iOS

### Unit tests
Before running unit test run `dart run build_runner build` to autogenerate mocks