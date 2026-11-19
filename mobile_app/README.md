# KeeperPass — Mobile App

The KeeperPass app for iOS and Android, built with **Flutter**. It opens the
same encrypted vault file as the web app, in your own Google Drive or
Dropbox, and behaves the same way. Like every other part of KeeperPass, it's
client-side only: the vault is decrypted and encrypted on the phone and saved
straight to your storage, with no KeeperPass server involved.

See the [root README](../README.md) for how KeeperPass works as a whole.

## Getting started

You need Flutter 3.44 or later (stable channel), plus Android Studio for
Android or Xcode for iOS.

Install dependencies:

```bash
flutter pub get
```

Run the app on a connected phone, emulator or simulator:

```bash
flutter run
```

Generated code (`*.g.dart`, `*.freezed.dart`, the router and the translations)
is committed, so a fresh clone runs without a generation step. After you
change them, regenerate:

```bash
dart run slang                  # after editing lib/i18n/*.i18n.json
dart run build_runner build     # after changing @freezed, @injectable, @RoutePage or JSON classes
```

## Configuration

Settings come from `assets/env/development.env` in debug and profile builds
(these show a "DEVELOPMENT" ribbon) and from `assets/env/production.env` in
release builds. The values are public identifiers: the Google client IDs and
the Dropbox app key of the official KeeperPass apps, the same ones the web app
uses. To sign in with your own Google Cloud project or Dropbox app, put your
own values there. A provider whose value is empty is not offered.

After editing a `.env` file, stop the app and run it again; a hot reload
doesn't read it.

## Google and Dropbox setup

**Dropbox:** in the [Dropbox App Console](https://www.dropbox.com/developers/apps),
add `com.keeperpass.mobile:/oauth/dropbox` to the app's OAuth 2 redirect URIs
and allow public clients (PKCE). The app needs the `account_info.read`,
`files.metadata.read`, `files.metadata.write`, `files.content.read` and
`files.content.write` permissions.

**Google:** create OAuth 2.0 Client IDs in the
[Google Cloud Console](https://console.cloud.google.com/), in the same project
as the web app's client. The `drive.file` scope only shows a project the files
it created itself, so a client in another project can't see a vault the web
app made.

1. Enable the **Google Drive API** and configure the OAuth consent screen
   with the `https://www.googleapis.com/auth/drive.file` scope.
2. **Android:** create a client of type **Android** with the package name
   `com.keeperpass.mobile` and the SHA-1 fingerprint of the key that signs your
   builds (see [Signing on Android](#signing-on-android)). Put its ID in
   `GOOGLE_ANDROID_CLIENT_ID`; the web client's ID goes in
   `GOOGLE_WEB_CLIENT_ID`.
3. **iOS:** create a client of type **iOS** with the bundle ID
   `com.keeperpass.mobile`. Put its ID in `GOOGLE_IOS_CLIENT_ID`, and add the
   reversed ID Google shows (`com.googleusercontent.apps.…`) to
   `CFBundleURLSchemes` in `ios/Runner/Info.plist`.

`drive.file` is the only Drive scope KeeperPass ever asks for. It only grants
access to files the app itself creates — nothing else already in your Drive.

## Signing on Android

Android builds are signed with the key named in `android/key.properties`. That
file holds passwords, so it's git-ignored and never committed. Keep the key
file outside the project:

```properties
storeFile=/absolute/path/to/upload-key.jks
storePassword=…
keyAlias=upload
keyPassword=…
```

Without `key.properties`, builds fall back to your computer's debug key. The
app still builds and runs, but Google sign-in only works if the Android client
has that key's SHA-1:

```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android
```

## Build & install

The app isn't on the App Store or Play Store yet, so getting it onto a phone
means building it yourself.

**Android:**

```bash
flutter build apk --release
```

Then install `build/app/outputs/flutter-apk/app-release.apk` with
`adb install -r`, or copy it to the phone and open it (you'll need to allow
"install unknown apps" for whichever app opens it). For Google Play, build an
app bundle with `flutter build appbundle --release`.

**iOS:** open `ios/Runner.xcworkspace` in Xcode and choose your team under
**Runner → Signing & Capabilities** (this needs an Apple Developer account),
then run `flutter run --release` with the iPhone connected.

## Running tests

```bash
flutter test
```

The vault logic (encryption, TOTP, CSV import, the security report, dates) is
a Dart port of the web app's code. It's tested against answers produced by the
web app's own TypeScript, in `test/fixtures/`.

## Project structure

- `lib/core/` — the vault logic ported from the web (Argon2id + AES-256-GCM
  encryption, TOTP, CSV, the security report), the failures and the use cases.
- `lib/infrastructure/` — Google Drive and Dropbox, sign-in, the phone's secure
  storage, and the data models.
- `lib/presentation/` — the screens, one folder per feature with its cubits,
  plus the design system and shared widgets in `common/`.
- `lib/i18n/` — the texts in English, German, Spanish, French and Portuguese.

Your secret and the decrypted vault exist only in memory, never in the
phone's storage. To keep you signed in, the phone remembers only which storage
you use, your account's name and address, and the Dropbox refresh token, kept
in the system's secure storage.

## Contributing

Pull requests are welcome. The app must behave like the web app, so a change
to the vault logic belongs together with the same change in the web. Every
text needs all five languages (a test checks). Before submitting one, run:

```bash
dart format lib test
flutter analyze
flutter test
```

## License

See the [root LICENSE](../LICENSE).
