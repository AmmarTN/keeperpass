# Assets

Keep application assets grouped by type and expose every referenced file through
`lib/presentation/common/constants/assets_constants.dart`.

- `animations/`: animation files added by product features.
- `env/`: `flutter_dotenv` configuration (`development.env`, `production.env`), loaded in
  `lib/main.dart`. Only public identifiers belong here (OAuth client IDs, the Dropbox app
  key) — never a secret.
- `fonts/`: local font files.
- `icons/png/` and `icons/svg/`: small UI and brand icons.
- `images/png/` and `images/svg/`: illustrations and larger images.

Add an animation runtime dependency only when the application actually uses that
animation format.
