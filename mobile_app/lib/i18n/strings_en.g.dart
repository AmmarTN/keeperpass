///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	dynamic operator[](String key) => _meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$app$en app = Translations$app$en.internal(_root);
	late final Translations$connectivity$en connectivity = Translations$connectivity$en.internal(_root);
	late final Translations$errors$en errors = Translations$errors$en.internal(_root);
	late final Translations$common$en common = Translations$common$en.internal(_root);
	late final Translations$strength$en strength = Translations$strength$en.internal(_root);
	late final Translations$totp$en totp = Translations$totp$en.internal(_root);
	late final Translations$settings$en settings = Translations$settings$en.internal(_root);
	late final Translations$auth$en auth = Translations$auth$en.internal(_root);
	late final Translations$vaults$en vaults = Translations$vaults$en.internal(_root);
	late final Translations$welcome$en welcome = Translations$welcome$en.internal(_root);
	late final Translations$connect$en connect = Translations$connect$en.internal(_root);
	late final Translations$howItWorks$en howItWorks = Translations$howItWorks$en.internal(_root);
	late final Translations$technicalDetails$en technicalDetails = Translations$technicalDetails$en.internal(_root);
	late final Translations$createVault$en createVault = Translations$createVault$en.internal(_root);
	late final Translations$unlock$en unlock = Translations$unlock$en.internal(_root);
	late final Translations$newVault$en newVault = Translations$newVault$en.internal(_root);
	late final Translations$tabs$en tabs = Translations$tabs$en.internal(_root);
	late final Translations$codes$en codes = Translations$codes$en.internal(_root);
	late final Translations$comingSoon$en comingSoon = Translations$comingSoon$en.internal(_root);
	late final Translations$vaultList$en vaultList = Translations$vaultList$en.internal(_root);
	late final Translations$itemDetail$en itemDetail = Translations$itemDetail$en.internal(_root);
	late final Translations$editItem$en editItem = Translations$editItem$en.internal(_root);
	late final Translations$generator$en generator = Translations$generator$en.internal(_root);
	late final Translations$report$en report = Translations$report$en.internal(_root);
	late final Translations$audit$en audit = Translations$audit$en.internal(_root);
	late final Translations$myVaults$en myVaults = Translations$myVaults$en.internal(_root);
	late final Translations$tags$en tags = Translations$tags$en.internal(_root);
	late final Translations$changeSecret$en changeSecret = Translations$changeSecret$en.internal(_root);
	late final Translations$storage$en storage = Translations$storage$en.internal(_root);
	late final Translations$moveVault$en moveVault = Translations$moveVault$en.internal(_root);
	late final Translations$dataIo$en dataIo = Translations$dataIo$en.internal(_root);
	late final Translations$archive$en archive = Translations$archive$en.internal(_root);
	late final Translations$help$en help = Translations$help$en.internal(_root);
	late final Translations$faq$en faq = Translations$faq$en.internal(_root);
	late final Translations$about$en about = Translations$about$en.internal(_root);
	late final Translations$clipboard$en clipboard = Translations$clipboard$en.internal(_root);
	late final Translations$sync$en sync = Translations$sync$en.internal(_root);
	late final Translations$scan$en scan = Translations$scan$en.internal(_root);
}

// Path: app
class Translations$app$en {
	Translations$app$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'KeeperPass'
	String get name => 'KeeperPass';
}

// Path: connectivity
class Translations$connectivity$en {
	Translations$connectivity$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No internet connection'
	String get offline => 'No internet connection';

	/// en: 'Back online'
	String get online => 'Back online';
}

// Path: errors
class Translations$errors$en {
	Translations$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$errors$failures$en failures = Translations$errors$failures$en.internal(_root);
	late final Translations$errors$drive$en drive = Translations$errors$drive$en.internal(_root);
	late final Translations$errors$dropbox$en dropbox = Translations$errors$dropbox$en.internal(_root);
	late final Translations$errors$auth$en auth = Translations$errors$auth$en.internal(_root);
	late final Translations$errors$masterPassword$en masterPassword = Translations$errors$masterPassword$en.internal(_root);
	late final Translations$errors$vault$en vault = Translations$errors$vault$en.internal(_root);
}

// Path: common
class Translations$common$en {
	Translations$common$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Copy'
	String get copy => 'Copy';

	/// en: 'Copied'
	String get copied => 'Copied';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Favorite'
	String get favorite => 'Favorite';

	/// en: 'Show secret'
	String get showSecret => 'Show secret';

	/// en: 'Hide secret'
	String get hideSecret => 'Hide secret';

	/// en: '[empty]'
	String get empty => '[empty]';

	/// en: 'Clear search'
	String get clearSearch => 'Clear search';

	/// en: 'Choose a date'
	String get chooseDate => 'Choose a date';

	/// en: 'Choose a month'
	String get chooseMonth => 'Choose a month';

	/// en: 'Country code'
	String get countryCode => 'Country code';

	/// en: 'Country code: $country, $code'
	String countryCodeValue({required Object country, required Object code}) => 'Country code: ${country}, ${code}';

	/// en: 'Remove tag $tag'
	String removeTag({required Object tag}) => 'Remove tag ${tag}';

	/// en: 'Secret'
	String get secretChip => 'Secret';

	/// en: 'Secret: $field'
	String secretToggle({required Object field}) => 'Secret: ${field}';

	/// en: 'Reorder $field'
	String reorderField({required Object field}) => 'Reorder ${field}';

	/// en: 'Remove $field'
	String removeField({required Object field}) => 'Remove ${field}';

	/// en: 'Change the $field icon'
	String changeFieldIcon({required Object field}) => 'Change the ${field} icon';

	/// en: 'Show all $count'
	String showAll({required Object count}) => 'Show all ${count}';

	/// en: 'Show in large type'
	String get showInLargeType => 'Show in large type';

	/// en: 'Step $current of $total'
	String stepOf({required Object current, required Object total}) => 'Step ${current} of ${total}';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Continue'
	String get continueAction => 'Continue';

	/// en: 'Try again'
	String get tryAgain => 'Try again';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Show'
	String get show => 'Show';

	/// en: 'Hide'
	String get hide => 'Hide';

	/// en: 'Got it'
	String get gotIt => 'Got it';

	/// en: 'Disconnect'
	String get disconnect => 'Disconnect';

	/// en: 'Generate a secret'
	String get generateSecret => 'Generate a secret';

	/// en: 'Use another account'
	String get useAnotherAccount => 'Use another account';

	/// en: 'You’re offline'
	String get offlineTitle => 'You’re offline';

	/// en: 'Saving to $provider…'
	String savingTo({required Object provider}) => 'Saving to ${provider}…';

	/// en: 'Keep KeeperPass open until this finishes.'
	String get keepOpen => 'Keep KeeperPass open until this finishes.';

	/// en: 'Type it again'
	String get typeItAgain => 'Type it again';

	/// en: 'Hidden'
	String get secretHiddenValue => 'Hidden';

	/// en: 'Rename'
	String get rename => 'Rename';

	/// en: 'Done'
	String get done => 'Done';
}

// Path: strength
class Translations$strength$en {
	Translations$strength$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Very weak'
	String get veryWeak => 'Very weak';

	/// en: 'Weak'
	String get weak => 'Weak';

	/// en: 'Fair'
	String get fair => 'Fair';

	/// en: 'Strong'
	String get strong => 'Strong';

	/// en: 'Very strong'
	String get veryStrong => 'Very strong';

	/// en: 'Strength: $level'
	String meter({required Object level}) => 'Strength: ${level}';
}

// Path: totp
class Translations$totp$en {
	Translations$totp$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Invalid code'
	String get invalidCode => 'Invalid code';

	/// en: 'The setup key isn’t valid, so no code can be made.'
	String get invalidKey => 'The setup key isn’t valid, so no code can be made.';

	/// en: 'Fix it in Edit'
	String get fixInEdit => 'Fix it in Edit';

	/// en: '$count s'
	String secondsShort({required Object count}) => '${count} s';

	/// en: '(one) {$count second left} (other) {$count seconds left}'
	String secondsLeft({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${count} second left',
		other: '${count} seconds left',
	);
}

// Path: settings
class Translations$settings$en {
	Translations$settings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$settings$migrate$en migrate = Translations$settings$migrate$en.internal(_root);

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'Account, language, security and data'
	String get subtitle => 'Account, language, security and data';

	/// en: 'Account'
	String get account => 'Account';

	/// en: '$email · $storage'
	String accountLine({required Object email, required Object storage}) => '${email} · ${storage}';

	/// en: 'Name and email are taken from the account you signed in with.'
	String get accountNote => 'Name and email are taken from the account you signed in with.';

	/// en: 'Log out'
	String get logOut => 'Log out';

	/// en: 'Log out?'
	String get logOutTitle => 'Log out?';

	/// en: 'Your vault stays in your $storage, encrypted. To open it again, sign in with $provider and enter your secret.'
	String logOutBody({required Object storage, required Object provider}) => 'Your vault stays in your ${storage}, encrypted. To open it again, sign in with ${provider} and enter your secret.';

	/// en: 'Security'
	String get security => 'Security';

	/// en: 'Lock now'
	String get lockNow => 'Lock now';

	/// en: 'Auto-lock'
	String get autoLock => 'Auto-lock';

	/// en: 'Clear clipboard'
	String get clearClipboard => 'Clear clipboard';

	/// en: 'Hide in app switcher'
	String get hideInSwitcher => 'Hide in app switcher';

	/// en: 'Shows a cover instead of your vault'
	String get hideInSwitcherNote => 'Shows a cover instead of your vault';

	/// en: 'Change secret'
	String get changeSecret => 'Change secret';

	/// en: 'Locking wipes the decrypted vault from this phone’s memory.'
	String get securityNote => 'Locking wipes the decrypted vault from this phone’s memory.';

	/// en: 'Appearance'
	String get appearance => 'Appearance';

	/// en: 'Theme'
	String get theme => 'Theme';

	/// en: 'Auto'
	String get themeAuto => 'Auto';

	/// en: 'Light'
	String get themeLight => 'Light';

	/// en: 'Dark'
	String get themeDark => 'Dark';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Storage'
	String get storage => 'Storage';

	/// en: 'Where your vault lives'
	String get whereItLives => 'Where your vault lives';

	/// en: 'Move vault to $storage'
	String moveTo({required Object storage}) => 'Move vault to ${storage}';

	/// en: 'Data'
	String get data => 'Data';

	/// en: 'Import CSV'
	String get importCsv => 'Import CSV';

	/// en: 'Export CSV'
	String get exportCsv => 'Export CSV';

	/// en: 'Recent exports'
	String get recentExports => 'Recent exports';

	/// en: 'Help'
	String get help => 'Help';

	/// en: 'How KeeperPass works'
	String get howItWorks => 'How KeeperPass works';

	/// en: 'Questions'
	String get questions => 'Questions';

	/// en: 'About KeeperPass'
	String get about => 'About KeeperPass';

	/// en: 'Danger zone'
	String get dangerZone => 'Danger zone';

	/// en: 'Archive vault and sign out'
	String get archive => 'Archive vault and sign out';

	/// en: 'Renames your vault file and signs you out. Nothing is erased.'
	String get archiveNote => 'Renames your vault file and signs you out. Nothing is erased.';

	/// en: 'KeeperPass $version · Free and open source under AGPL-3.0'
	String footer({required Object version}) => 'KeeperPass ${version} · Free and open source under AGPL-3.0';

	/// en: 'Auto-lock'
	String get autoLockTitle => 'Auto-lock';

	/// en: 'Immediately on leaving the app'
	String get autoLockImmediately => 'Immediately on leaving the app';

	/// en: 'Immediately'
	String get autoLockImmediatelyShort => 'Immediately';

	/// en: 'After 1 minute'
	String get after1Minute => 'After 1 minute';

	/// en: 'After 5 minutes'
	String get after5Minutes => 'After 5 minutes';

	/// en: 'After 10 minutes'
	String get after10Minutes => 'After 10 minutes';

	/// en: 'KeeperPass locks after this long without use. Unlocking again needs your secret.'
	String get autoLockNote => 'KeeperPass locks after this long without use. Unlocking again needs your secret.';

	/// en: 'Clear Clipboard'
	String get clearClipboardTitle => 'Clear Clipboard';

	/// en: 'After 30 seconds'
	String get after30Seconds => 'After 30 seconds';

	/// en: 'After 2 minutes'
	String get after2Minutes => 'After 2 minutes';

	/// en: 'Never'
	String get never => 'Never';

	/// en: 'After 30 s'
	String get after30s => 'After 30 s';

	/// en: 'After 1 min'
	String get after1Min => 'After 1 min';

	/// en: 'After 2 min'
	String get after2Min => 'After 2 min';

	/// en: 'Passwords and codes you copy are cleared from the clipboard after this long, if nothing else was copied since.'
	String get clipboardNote => 'Passwords and codes you copy are cleared from the clipboard after this long, if nothing else was copied since.';

	/// en: 'Preview'
	String get preview => 'Preview';

	/// en: 'From GitHub'
	String get previewFrom => 'From GitHub';

	/// en: 'From GitHub · Clears in $time'
	String previewClears({required Object time}) => 'From GitHub · Clears in ${time}';

	/// en: '$n s'
	String seconds({required Object n}) => '${n} s';

	/// en: '$n min'
	String minutes({required Object n}) => '${n} min';

	/// en: 'Language'
	String get languageTitle => 'Language';

	/// en: 'Saved on this phone only — it is not part of your vault.'
	String get languageNote => 'Saved on this phone only — it is not part of your vault.';

	/// en: 'Shows a cover instead of your vault, and blocks screenshots'
	String get hideInSwitcherBlocks => 'Shows a cover instead of your vault, and blocks screenshots';

	/// en: 'Block screenshots'
	String get blockScreenshots => 'Block screenshots';

	/// en: 'Android only · also blocks screen recording'
	String get blockScreenshotsNote => 'Android only · also blocks screen recording';

	/// en: 'On while “Hide in app switcher” is on'
	String get blockScreenshotsWhileHidden => 'On while “Hide in app switcher” is on';
}

// Path: auth
class Translations$auth$en {
	Translations$auth$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$auth$unlock$en unlock = Translations$auth$unlock$en.internal(_root);
}

// Path: vaults
class Translations$vaults$en {
	Translations$vaults$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My Vault'
	String get defaultName => 'My Vault';
}

// Path: welcome
class Translations$welcome$en {
	Translations$welcome$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'How it works'
	String get howItWorks => 'How it works';

	/// en: 'End-to-end encrypted'
	String get badge => 'End-to-end encrypted';

	/// en: 'Welcome to KeeperPass'
	String get title => 'Welcome to KeeperPass';

	/// en: 'Your vault is a single encrypted file in your own cloud storage. Sign in to open it.'
	String get description => 'Your vault is a single encrypted file in your own cloud storage. Sign in to open it.';

	/// en: 'What your storage sees'
	String get fileTag => 'What your storage sees';

	/// en: 'Argon2id · AES-256-GCM'
	String get fileMeta => 'Argon2id · AES-256-GCM';

	/// en: 'Continue with Google'
	String get continueWithGoogle => 'Continue with Google';

	/// en: 'Continue with Dropbox'
	String get continueWithDropbox => 'Continue with Dropbox';

	/// en: 'Connecting to $provider…'
	String connecting({required Object provider}) => 'Connecting to ${provider}…';

	/// en: 'Access only to the files KeeperPass creates'
	String get factAccess => 'Access only to the files KeeperPass creates';

	/// en: 'Encrypted on this phone, with your own secret'
	String get factEncrypted => 'Encrypted on this phone, with your own secret';

	/// en: 'No KeeperPass server. Nothing goes anywhere else.'
	String get factNoServer => 'No KeeperPass server. Nothing goes anywhere else.';

	/// en: 'No KeeperPass account — just the Google or Dropbox one you already have. Signing in creates the vault file if you don’t have one yet.'
	String get footer => 'No KeeperPass account — just the Google or Dropbox one you already have. Signing in creates the vault file if you don’t have one yet.';
}

// Path: connect
class Translations$connect$en {
	Translations$connect$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Looking in $storage…'
	String lookingIn({required Object storage}) => 'Looking in ${storage}…';

	/// en: 'Checking your vault…'
	String get checkingTitle => 'Checking your vault…';

	/// en: 'Looking for vault.json.enc in $storage.'
	String checkingDetail({required Object storage}) => 'Looking for vault.json.enc in ${storage}.';

	/// en: 'Found your vault'
	String get foundTitle => 'Found your vault';

	/// en: 'Opening Unlock…'
	String get foundDetail => 'Opening Unlock…';

	/// en: 'Found in $storage'
	String foundMeta({required Object storage}) => 'Found in ${storage}';

	/// en: 'Found in $storage · updated $time'
	String foundMetaUpdated({required Object storage, required Object time}) => 'Found in ${storage} · updated ${time}';

	/// en: 'Nothing was connected.'
	String get canceledDetail => 'Nothing was connected.';

	/// en: 'Sign-in failed'
	String get signInFailed => 'Sign-in failed';

	/// en: 'Signing in needs a connection to Google or Dropbox. This updates by itself when you’re back online.'
	String get offlineDetail => 'Signing in needs a connection to Google or Dropbox. This updates by itself when you’re back online.';

	/// en: 'Welcome Back,'
	String get welcomeBack => 'Welcome Back,';

	/// en: 'Your $provider session has expired. Sign in again to unlock your vault.'
	String expiredDetail({required Object provider}) => 'Your ${provider} session has expired. Sign in again to unlock your vault.';

	/// en: 'Last used'
	String get lastUsed => 'Last used';

	/// en: 'Couldn’t read it from $storage'
	String checkFailedMeta({required Object storage}) => 'Couldn’t read it from ${storage}';

	/// en: 'Could not read your vault'
	String get checkFailedTitle => 'Could not read your vault';

	/// en: '$storage didn’t respond. Nothing was changed.'
	String checkFailedDetail({required Object storage}) => '${storage} didn’t respond. Nothing was changed.';
}

// Path: howItWorks
class Translations$howItWorks$en {
	Translations$howItWorks$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your vault lives in your cloud'
	String get step1Title => 'Your vault lives\nin your cloud';

	/// en: 'KeeperPass saves one encrypted file to your Google Drive or Dropbox. There’s no KeeperPass server, so we never get a copy.'
	String get step1Body => 'KeeperPass saves one encrypted file to your Google Drive or Dropbox. There’s no KeeperPass server, so we never get a copy.';

	/// en: 'Encrypted'
	String get encrypted => 'Encrypted';

	/// en: 'Choose a secret'
	String get step2Title => 'Choose a secret';

	/// en: 'It becomes the key. Never sent, never stored.'
	String get step2Body => 'It becomes the key. Never sent, never stored.';

	/// en: 'It takes both'
	String get step3Title => 'It takes both';

	/// en: 'Someone with your storage account can’t read your vault. Someone with your secret can’t reach it.'
	String get step3Body => 'Someone with your storage account can’t read your vault. Someone with your secret can’t reach it.';

	/// en: 'Storage account'
	String get storageAccount => 'Storage account';

	/// en: 'Reaches the file'
	String get reachesFile => 'Reaches the file';

	/// en: 'Your secret'
	String get yourSecret => 'Your secret';

	/// en: 'Opens the file'
	String get opensFile => 'Opens the file';

	/// en: 'Technical details'
	String get technicalDetails => 'Technical details';

	/// en: 'Argon2id · AES-256'
	String get technicalSummary => 'Argon2id · AES-256';
}

// Path: technicalDetails
class Translations$technicalDetails$en {
	Translations$technicalDetails$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Technical Details'
	String get title => 'Technical Details';

	/// en: 'Key derivation'
	String get keyDerivation => 'Key derivation';

	/// en: '$algorithm · 64 MiB memory · 3 iterations · parallelism 4, making a 256-bit key'
	TextSpan keyDerivationValue({required InlineSpan algorithm}) => TextSpan(children: [
		algorithm,
		const TextSpan(text: ' · 64 MiB memory · 3 iterations · parallelism 4, making a 256-bit key'),
	]);

	/// en: 'Encryption'
	String get encryption => 'Encryption';

	/// en: '$algorithm, which also detects any change to the file'
	TextSpan encryptionValue({required InlineSpan algorithm}) => TextSpan(children: [
		algorithm,
		const TextSpan(text: ', which also detects any change to the file'),
	]);

	/// en: 'Google Drive'
	String get googleDrive => 'Google Drive';

	/// en: 'The $scope scope: only files KeeperPass created'
	TextSpan googleDriveValue({required InlineSpan scope}) => TextSpan(children: [
		const TextSpan(text: 'The '),
		scope,
		const TextSpan(text: ' scope: only files KeeperPass created'),
	]);

	/// en: 'Dropbox'
	String get dropbox => 'Dropbox';

	/// en: 'An app folder: $folder'
	TextSpan dropboxValue({required InlineSpan folder}) => TextSpan(children: [
		const TextSpan(text: 'An app folder: '),
		folder,
	]);

	/// en: 'Vault file'
	String get vaultFile => 'Vault file';

	/// en: '$file — one file, re-encrypted and rewritten on every save'
	TextSpan vaultFileValue({required InlineSpan file}) => TextSpan(children: [
		file,
		const TextSpan(text: ' — one file, re-encrypted and rewritten on every save'),
	]);

	/// en: 'View source on GitHub'
	String get viewSource => 'View source on GitHub';

	/// en: 'Free and open source under AGPL-3.0, so all of this can be checked.'
	String get license => 'Free and open source under AGPL-3.0, so all of this can be checked.';
}

// Path: createVault
class Translations$createVault$en {
	Translations$createVault$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Create your vault'
	String get eyebrow => 'Create your vault';

	/// en: 'Choose Your Secret'
	String get step1Title => 'Choose Your Secret';

	/// en: 'It encrypts your vault on this phone. Everything you save is locked with it.'
	String get step1Body => 'It encrypts your vault on this phone. Everything you save is locked with it.';

	/// en: 'Setting up for'
	String get settingUpFor => 'Setting up for';

	/// en: 'Secret'
	String get secret => 'Secret';

	/// en: 'Your secret'
	String get secretPlaceholder => 'Your secret';

	/// en: 'Generate another'
	String get generateAnother => 'Generate another';

	/// en: 'Generated secrets skip the retype step.'
	String get generatedNote => 'Generated secrets skip the retype step.';

	/// en: 'This secret is weak, which makes the encryption around your vault easier to break. You can continue, but a longer passphrase is strongly recommended.'
	String get weakWarning => 'This secret is weak, which makes the encryption around your vault easier to break. You can continue, but a longer passphrase is strongly recommended.';

	/// en: 'Choosing a good secret'
	String get tipsTitle => 'Choosing a good secret';

	/// en: 'Several random words beat one clever word: the longer it is, the harder it is to guess.'
	String get tip1 => 'Several random words beat one clever word: the longer it is, the harder it is to guess.';

	/// en: 'Don’t reuse a password you use anywhere else.'
	String get tip2 => 'Don’t reuse a password you use anywhere else.';

	/// en: 'Make it something you can type on this phone, then write it down and keep it somewhere safe.'
	String get tip3 => 'Make it something you can type on this phone, then write it down and keep it somewhere safe.';

	/// en: 'Type It Again'
	String get step2Title => 'Type It Again';

	/// en: 'Just to be sure there’s no typo. Nobody can reset your secret later.'
	String get step2Body => 'Just to be sure there’s no typo. Nobody can reset your secret later.';

	/// en: 'Repeat secret'
	String get repeat => 'Repeat secret';

	/// en: 'The two secrets do not match.'
	String get mismatch => 'The two secrets do not match.';

	/// en: 'Write It Down'
	String get step3Title => 'Write It Down';

	/// en: 'You’ll need it every time you unlock. Keep it somewhere safe, away from this phone.'
	String get step3Body => 'You’ll need it every time you unlock. Keep it somewhere safe, away from this phone.';

	/// en: 'Your secret · $count words'
	String secretWords({required Object count}) => 'Your secret · ${count} words';

	/// en: 'Your secret'
	String get secretWhole => 'Your secret';

	/// en: 'Your secret, hidden'
	String get secretHidden => 'Your secret, hidden';

	/// en: 'Your secret, shown'
	String get secretShown => 'Your secret, shown';

	/// en: 'Please read this before you continue'
	String get readBefore => 'Please read this before you continue';

	/// en: 'Your secret is never sent anywhere and never stored. Nobody — not KeeperPass, not your storage provider — can look it up or reset it.'
	String get bullet1 => 'Your secret is never sent anywhere and never stored. Nobody — not KeeperPass, not your storage provider — can look it up or reset it.';

	/// en: 'If you forget it, your vault can’t be recovered. No reset link or support request can open it.'
	String get bullet2 => 'If you forget it, your vault can’t be recovered. No reset link or support request can open it.';

	/// en: 'Write it down and keep it somewhere safe before you continue.'
	String get bullet3 => 'Write it down and keep it somewhere safe before you continue.';

	/// en: 'I’ve written my secret down'
	String get acknowledge => 'I’ve written my secret down';

	/// en: 'Create vault'
	String get create => 'Create vault';

	/// en: 'Creating your vault'
	String get progressTitle => 'Creating your vault';

	/// en: 'Encrypting your vault…'
	String get encrypting => 'Encrypting your vault…';

	/// en: 'On this phone. This takes a few seconds.'
	String get encryptingDetail => 'On this phone. This takes a few seconds.';

	/// en: 'Encrypting on this phone…'
	String get encryptingMeta => 'Encrypting on this phone…';

	/// en: 'One encrypted file, in the keeperpass folder.'
	String get savingDetail => 'One encrypted file, in the keeperpass folder.';

	/// en: 'Could not save your vault'
	String get failedTitle => 'Could not save your vault';

	/// en: 'Not saved'
	String get notSaved => 'Not saved';

	/// en: '$storage didn’t respond. Nothing was saved, and your secret is still here.'
	String failedDetail({required Object storage}) => '${storage} didn’t respond. Nothing was saved, and your secret is still here.';

	/// en: 'Back to your secret'
	String get backToSecret => 'Back to your secret';
}

// Path: unlock
class Translations$unlock$en {
	Translations$unlock$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Not you?'
	String get notYou => 'Not you?';

	/// en: 'Secret'
	String get secret => 'Secret';

	/// en: 'Enter your secret'
	String get placeholder => 'Enter your secret';

	/// en: 'Unlock'
	String get unlock => 'Unlock';

	/// en: 'Unlocking…'
	String get unlocking => 'Unlocking…';

	/// en: 'Unlocking on this phone…'
	String get unlockingStatus => 'Unlocking on this phone…';

	/// en: 'A few seconds, on purpose: it makes guessing your secret slow.'
	String get slowNote => 'A few seconds, on purpose: it makes guessing your secret slow.';

	/// en: 'Forgot your secret?'
	String get forgot => 'Forgot your secret?';

	/// en: 'Locked when you left KeeperPass'
	String get leftApp => 'Locked when you left KeeperPass';

	/// en: 'Could not reach $storage'
	String unreachableTitle({required Object storage}) => 'Could not reach ${storage}';

	/// en: 'Check your connection and try again. Your secret is still filled in.'
	String get unreachableDetail => 'Check your connection and try again. Your secret is still filled in.';

	/// en: 'Unlocking needs a connection to $storage. Unlock wakes up when you’re back online.'
	String offlineDetail({required Object storage}) => 'Unlocking needs a connection to ${storage}. Unlock wakes up when you’re back online.';

	/// en: '$email · $storage'
	String accountLine({required Object email, required Object storage}) => '${email} · ${storage}';

	/// en: '(one) {Locked after $n minute of inactivity} (other) {Locked after $n minutes of inactivity}'
	String lockedInactivity({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Locked after ${n} minute of inactivity',
		other: 'Locked after ${n} minutes of inactivity',
	);
}

// Path: newVault
class Translations$newVault$en {
	Translations$newVault$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Unlock'
	String get backLabel => 'Unlock';

	/// en: 'Back to unlock'
	String get backToUnlock => 'Back to unlock';

	/// en: 'Start a New Vault'
	String get title => 'Start a New Vault';

	/// en: 'Old vault · locked under the old secret'
	String get oldMeta => 'Old vault · locked under the old secret';

	/// en: 'New vault · empty'
	String get newMeta => 'New vault · empty';

	/// en: 'There’s no way to reset a forgotten secret — not by KeeperPass, and not by $provider. You can start again with a new, empty vault instead.'
	String body({required Object provider}) => 'There’s no way to reset a forgotten secret — not by KeeperPass, and not by ${provider}. You can start again with a new, empty vault instead.';

	/// en: 'Your current vault stays locked under the old secret.'
	String get pointLocked => 'Your current vault stays locked under the old secret.';

	/// en: 'Its file is kept as $file in your $storage. Nothing is deleted.'
	TextSpan pointKept({required InlineSpan file, required InlineSpan storage}) => TextSpan(children: [
		const TextSpan(text: 'Its file is kept as '),
		file,
		const TextSpan(text: ' in your '),
		storage,
		const TextSpan(text: '. Nothing is deleted.'),
	]);

	/// en: 'You start again with a brand-new, empty vault.'
	String get pointFresh => 'You start again with a brand-new, empty vault.';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'New secret'
	String get newSecret => 'New secret';

	/// en: 'Choose a new secret'
	String get newSecretPlaceholder => 'Choose a new secret';

	/// en: 'Repeat new secret'
	String get repeat => 'Repeat new secret';

	/// en: 'This secret is weak, which makes the encryption around your vaults easier to break. You can continue, but a longer passphrase is strongly recommended.'
	String get weakWarning => 'This secret is weak, which makes the encryption around your vaults easier to break. You can continue, but a longer passphrase is strongly recommended.';

	/// en: 'Like the old one, your new secret can’t be looked up or reset. Write it down before you continue.'
	String get warn => 'Like the old one, your new secret can’t be looked up or reset. Write it down before you continue.';

	/// en: 'Start a new vault'
	String get start => 'Start a new vault';

	/// en: 'Start a New Vault?'
	String get confirmTitle => 'Start a New Vault?';

	/// en: 'Its file is kept as a dated backup in your $storage.'
	String confirmKept({required Object storage}) => 'Its file is kept as a dated backup in your ${storage}.';

	/// en: 'You start again with an empty vault under your new secret.'
	String get confirmFresh => 'You start again with an empty vault under your new secret.';

	/// en: 'Starting a new vault'
	String get progressTitle => 'Starting a new vault';

	/// en: 'Encrypting your new vault…'
	String get encrypting => 'Encrypting your new vault…';

	/// en: 'Keeping your old vault as a backup…'
	String get backingUp => 'Keeping your old vault as a backup…';

	/// en: 'Renaming it in $storage.'
	String backingUpDetail({required Object storage}) => 'Renaming it in ${storage}.';

	/// en: 'Encrypted · ready to save'
	String get readyMeta => 'Encrypted · ready to save';

	/// en: 'Couldn’t rename it · nothing changed'
	String get backupFailedMeta => 'Couldn’t rename it · nothing changed';

	/// en: 'Nothing was changed'
	String get nothingChanged => 'Nothing was changed';

	/// en: 'Could not back up your existing vault in $storage. Nothing was changed.'
	String backupFailedDetail({required Object storage}) => 'Could not back up your existing vault in ${storage}. Nothing was changed.';

	/// en: 'New vault started'
	String get doneTitle => 'New vault started';

	/// en: 'Your old vault is kept as a backup in $storage.'
	String doneDetail({required Object storage}) => 'Your old vault is kept as a backup in ${storage}.';
}

// Path: tabs
class Translations$tabs$en {
	Translations$tabs$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Vault'
	String get vault => 'Vault';

	/// en: 'Codes'
	String get codes => 'Codes';

	/// en: 'Generator'
	String get generator => 'Generator';

	/// en: 'Security'
	String get security => 'Security';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: '(one) {Security, $n item flagged} (other) {Security, $n items flagged}'
	String securityFlagged({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Security, ${n} item flagged',
		other: 'Security, ${n} items flagged',
	);
}

// Path: codes
class Translations$codes$en {
	Translations$codes$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '2FA codes from your vault, made on this phone'
	String get subtitle => '2FA codes from your vault, made on this phone';

	/// en: '(one) {Search $n code} (other) {Search $n codes}'
	String searchPlaceholder({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Search ${n} code',
		other: 'Search ${n} codes',
	);

	/// en: '(one) {$n code} (other) {$n codes}'
	String codeCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} code',
		other: '${n} codes',
	);

	/// en: 'Code copied'
	String get copied => 'Code copied';

	/// en: 'Made on this phone from the setup keys in your vault. Nothing new is stored.'
	String get trust => 'Made on this phone from the setup keys in your vault. Nothing new is stored.';

	/// en: 'No 2FA codes yet'
	String get emptyTitle => 'No 2FA codes yet';

	/// en: 'When a site offers two-factor sign-in, scan its QR code here, or add an Authenticator item.'
	String get emptyBody => 'When a site offers two-factor sign-in, scan its QR code here, or add an Authenticator item.';

	/// en: 'Create an Authenticator item'
	String get createAuthenticator => 'Create an Authenticator item';
}

// Path: comingSoon
class Translations$comingSoon$en {
	Translations$comingSoon$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Coming in Part $part.'
	String body({required Object part}) => 'Coming in Part ${part}.';
}

// Path: vaultList
class Translations$vaultList$en {
	Translations$vaultList$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Lock'
	String get lock => 'Lock';

	/// en: 'New item'
	String get newItem => 'New item';

	/// en: 'All Vaults'
	String get allVaults => 'All Vaults';

	/// en: 'Favorites'
	String get favorites => 'Favorites';

	/// en: 'Recently Used'
	String get recentlyUsed => 'Recently Used';

	/// en: '$items · Saved to $storage'
	String statusSaved({required Object items, required Object storage}) => '${items} · Saved to ${storage}';

	/// en: '$items in $vault'
	String statusInVault({required Object items, required Object vault}) => '${items} in ${vault}';

	/// en: '$items tagged $tag'
	String statusTagged({required Object items, required Object tag}) => '${items} tagged ${tag}';

	/// en: '$items · $report'
	String statusReport({required Object items, required Object report}) => '${items} · ${report}';

	/// en: 'Not connected to $storage'
	String statusNotConnected({required Object storage}) => 'Not connected to ${storage}';

	/// en: 'Offline · $items'
	String statusOffline({required Object items}) => 'Offline · ${items}';

	/// en: 'Weak passwords'
	String get reportWeak => 'Weak passwords';

	/// en: 'Reused passwords'
	String get reportReused => 'Reused passwords';

	/// en: 'Compromised passwords'
	String get reportCompromised => 'Compromised passwords';

	/// en: 'Every word has to match, in any order: names, tags, field names and values.'
	String get searchHint => 'Every word has to match, in any order: names, tags, field names and values.';

	/// en: 'Filter by tag'
	String get filterByTag => 'Filter by tag';

	/// en: 'Manage tags'
	String get manageTags => 'Manage tags';

	/// en: 'Clear filter'
	String get clearFilter => 'Clear filter';

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'This week'
	String get thisWeek => 'This week';

	/// en: 'Earlier'
	String get earlier => 'Earlier';

	/// en: 'A to Z'
	String get aToZ => 'A to Z';

	/// en: 'Sort by last update'
	String get sortHeading => 'Sort by last update';

	/// en: 'Newest first'
	String get newestFirst => 'Newest first';

	/// en: 'Oldest first'
	String get oldestFirst => 'Oldest first';

	/// en: 'Reading your vault from $storage…'
	String refreshing({required Object storage}) => 'Reading your vault from ${storage}…';

	/// en: 'Copy password for $name'
	String copyPasswordFor({required Object name}) => 'Copy password for ${name}';

	/// en: 'Copy code for $name'
	String copyCodeFor({required Object name}) => 'Copy code for ${name}';

	/// en: 'Copy card number for $name'
	String copyCardNumberFor({required Object name}) => 'Copy card number for ${name}';

	/// en: 'Password'
	String get swipePassword => 'Password';

	/// en: 'Code'
	String get swipeCode => 'Code';

	/// en: 'Card number'
	String get swipeCardNumber => 'Card number';

	/// en: 'Username'
	String get swipeUsername => 'Username';

	/// en: 'More'
	String get swipeMore => 'More';

	/// en: 'Copy password'
	String get copyPassword => 'Copy password';

	/// en: 'Copy code'
	String get copyCode => 'Copy code';

	/// en: 'Copy card number'
	String get copyCardNumber => 'Copy card number';

	/// en: 'Copy username'
	String get copyUsername => 'Copy username';

	/// en: 'More actions'
	String get moreActions => 'More actions';

	/// en: 'Favorite'
	String get favorite => 'Favorite';

	/// en: 'Add to favorites'
	String get addToFavorites => 'Add to favorites';

	/// en: 'Remove from favorites'
	String get removeFromFavorites => 'Remove from favorites';

	/// en: 'Weak password'
	String get findingWeak => 'Weak password';

	/// en: 'Reused password'
	String get findingReused => 'Reused password';

	/// en: 'Compromised password'
	String get findingCompromised => 'Compromised password';

	/// en: 'Weak and reused password'
	String get findingWeakReused => 'Weak and reused password';

	/// en: 'Weak and compromised password'
	String get findingWeakCompromised => 'Weak and compromised password';

	/// en: 'Reused and compromised password'
	String get findingReusedCompromised => 'Reused and compromised password';

	/// en: 'Weak, reused and compromised password'
	String get findingAll => 'Weak, reused and compromised password';

	/// en: 'New Item'
	String get unnamed => 'New Item';

	/// en: 'Vaults'
	String get scopeTitle => 'Vaults';

	/// en: 'Manage vaults'
	String get manageVaults => 'Manage vaults';

	/// en: 'All your vaults live in one encrypted file, vault.json.enc, in your $storage.'
	String scopeNote({required Object storage}) => 'All your vaults live in one encrypted file, vault.json.enc, in your ${storage}.';

	/// en: '$name, quick actions'
	String quickActions({required Object name}) => '${name}, quick actions';

	/// en: 'Open website'
	String get openWebsite => 'Open website';

	/// en: 'Move to vault…'
	String get moveToVault => 'Move to vault…';

	/// en: 'Select'
	String get select => 'Select';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Select All'
	String get selectAll => 'Select All';

	/// en: 'Select or deselect all'
	String get selectOrDeselectAll => 'Select or deselect all';

	/// en: '$a and $b'
	String listTwo({required Object a, required Object b}) => '${a} and ${b}';

	/// en: '$a, $b and $c'
	String listThree({required Object a, required Object b, required Object c}) => '${a}, ${b} and ${c}';

	/// en: 'Delete Item'
	String get deleteItemTitle => 'Delete Item';

	/// en: 'Are you sure you want to delete ‘$name’? This cannot be undone.'
	String deleteItemConfirm({required Object name}) => 'Are you sure you want to delete ‘${name}’? This cannot be undone.';

	/// en: 'Delete item'
	String get deleteItemAction => 'Delete item';

	/// en: 'Move to Vault'
	String get moveToVaultTitle => 'Move to Vault';

	/// en: 'Pick the vault this item should live in.'
	String get moveDescription => 'Pick the vault this item should live in.';

	/// en: 'Current'
	String get current => 'Current';

	/// en: 'New vault…'
	String get newVaultOption => 'New vault…';

	/// en: 'There is no other vault to move this item to.'
	String get noOtherVaultOne => 'There is no other vault to move this item to.';

	/// en: 'There is no other vault to move these items to.'
	String get noOtherVaultMany => 'There is no other vault to move these items to.';

	/// en: 'A second vault keeps a set of items apart — work from personal, or shared from private.'
	String get noOtherVaultDetail => 'A second vault keeps a set of items apart — work from personal, or shared from private.';

	/// en: 'Create a vault'
	String get createAVault => 'Create a vault';

	/// en: 'New Vault'
	String get newVaultTitle => 'New Vault';

	/// en: 'A vault is a separate group of items. Unlike an item, there is nothing else to choose up front.'
	String get newVaultBody => 'A vault is a separate group of items. Unlike an item, there is nothing else to choose up front.';

	/// en: 'Vault name'
	String get vaultName => 'Vault name';

	/// en: 'A vault with this name already exists.'
	String get duplicateVault => 'A vault with this name already exists.';

	/// en: 'You don’t have any items yet.'
	String get noItemsTitle => 'You don’t have any items yet.';

	/// en: 'Add your first login, card or note. Each one is encrypted on this phone before it is saved.'
	String get noItemsBody => 'Add your first login, card or note. Each one is encrypted on this phone before it is saved.';

	/// en: 'Import from CSV'
	String get importCsv => 'Import from CSV';

	/// en: 'Your vault is ready. Nothing in it yet.'
	String get vaultReady => 'Your vault is ready. Nothing in it yet.';

	/// en: 'Saved to $storage · $items'
	String savedMeta({required Object storage, required Object items}) => 'Saved to ${storage} · ${items}';

	/// en: 'This vault does not have any items yet.'
	String get vaultEmptyTitle => 'This vault does not have any items yet.';

	/// en: 'Add one here, or move items in from $vault.'
	String vaultEmptyBody({required Object vault}) => 'Add one here, or move items in from ${vault}.';

	/// en: 'You don’t have any favorites yet.'
	String get noFavoritesTitle => 'You don’t have any favorites yet.';

	/// en: 'Tap the star on any item to keep it here.'
	String get noFavoritesBody => 'Tap the star on any item to keep it here.';

	/// en: 'Nothing used yet'
	String get nothingRecentTitle => 'Nothing used yet';

	/// en: 'Items you open or copy from show up here, most recent first.'
	String get nothingRecentBody => 'Items you open or copy from show up here, most recent first.';

	/// en: 'Your search did not match any items.'
	String get noResultsTitle => 'Your search did not match any items.';

	/// en: 'Every word has to match. Try fewer words, or check the spelling.'
	String get noResultsBody => 'Every word has to match. Try fewer words, or check the spelling.';

	/// en: 'Every password in your vault is strong enough.'
	String get allClearWeak => 'Every password in your vault is strong enough.';

	/// en: 'Every password in your vault is used exactly once.'
	String get allClearReused => 'Every password in your vault is used exactly once.';

	/// en: 'None of your passwords turned up in a known breach.'
	String get allClearCompromised => 'None of your passwords turned up in a known breach.';

	/// en: 'Nothing to fix here. KeeperPass checks again whenever a password changes.'
	String get allClearBody => 'Nothing to fix here. KeeperPass checks again whenever a password changes.';

	/// en: 'Back to Security'
	String get backToSecurity => 'Back to Security';

	/// en: '$field copied'
	String fieldCopied({required Object field}) => '${field} copied';

	/// en: 'From $item'
	String copiedFrom({required Object item}) => 'From ${item}';

	/// en: '(one) {$n item} (other) {$n items}'
	String itemCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} item',
		other: '${n} items',
	);

	/// en: '(one) {$n change not saved} (other) {$n changes not saved}'
	String statusNotSaved({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} change not saved',
		other: '${n} changes not saved',
	);

	/// en: '(one) {Search $n item} (other) {Search $n items}'
	String searchPlaceholder({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Search ${n} item',
		other: 'Search ${n} items',
	);

	/// en: '(one) {$n result} (other) {$n results}'
	String results({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} result',
		other: '${n} results',
	);

	/// en: '(one) {$n selected} (other) {$n selected}'
	String selectedCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} selected',
		other: '${n} selected',
	);

	/// en: '(one) {Move $n item} (other) {Move $n items}'
	String moveItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Move ${n} item',
		other: 'Move ${n} items',
	);

	/// en: '(one) {Move $n Item} (other) {Move $n Items}'
	String moveItemsTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Move ${n} Item',
		other: 'Move ${n} Items',
	);

	/// en: '(one) {Delete $n item} (other) {Delete $n items}'
	String deleteItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Delete ${n} item',
		other: 'Delete ${n} items',
	);

	/// en: '(one) {Delete $n item?} (other) {Delete $n items?}'
	String deleteTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Delete ${n} item?',
		other: 'Delete ${n} items?',
	);

	/// en: '(one) {$names will be deleted from $vault. This cannot be undone.} (other) {$names will be deleted from $vault. This cannot be undone.}'
	String deleteFromVault({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${names} will be deleted from ${vault}. This cannot be undone.',
		other: '${names} will be deleted from ${vault}. This cannot be undone.',
	);

	/// en: '(one) {$names will be deleted. This cannot be undone.} (other) {$names will be deleted. This cannot be undone.}'
	String deleteFromVaults({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${names} will be deleted. This cannot be undone.',
		other: '${names} will be deleted. This cannot be undone.',
	);

	/// en: '(one) {$names moves with its history and tags.} (other) {$names move with their history and tags.}'
	String moveLine({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${names} moves with its history and tags.',
		other: '${names} move with their history and tags.',
	);

	/// en: '(one) {Moved $names to $vault} (other) {Moved $names to $vault}'
	String movedTitle({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Moved ${names} to ${vault}',
		other: 'Moved ${names} to ${vault}',
	);

	/// en: '(one) {It keeps its history and tags.} (other) {They keep their history and tags.}'
	String movedDetail({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'It keeps its history and tags.',
		other: 'They keep their history and tags.',
	);

	/// en: '(one) {$count of $n item} (other) {$count of $n items}'
	String itemsOf({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${count} of ${n} item',
		other: '${count} of ${n} items',
	);
}

// Path: itemDetail
class Translations$itemDetail$en {
	Translations$itemDetail$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Edit item'
	String get editItem => 'Edit item';

	/// en: 'More options'
	String get moreOptions => 'More options';

	/// en: 'Updated $ago'
	String updatedAgo({required Object ago}) => 'Updated ${ago}';

	/// en: 'Show items tagged $tag'
	String showTagged({required Object tag}) => 'Show items tagged ${tag}';

	/// en: 'Fields'
	String get fields => 'Fields';

	/// en: 'This item has no fields.'
	String get noFields => 'This item has no fields.';

	/// en: 'History'
	String get history => 'History';

	/// en: 'Current Version'
	String get currentVersion => 'Current Version';

	/// en: 'Today, $time'
	String todayAt({required Object time}) => 'Today, ${time}';

	/// en: 'Unnamed'
	String get unnamedField => 'Unnamed';

	/// en: 'Copy $field'
	String copyField({required Object field}) => 'Copy ${field}';

	/// en: 'Reveal value'
	String get revealValue => 'Reveal value';

	/// en: 'Hide value'
	String get hideValue => 'Hide value';

	/// en: '$field, hidden'
	String hiddenValue({required Object field}) => '${field}, hidden';

	/// en: 'Open $site'
	String openSite({required Object site}) => 'Open ${site}';

	/// en: 'Call'
	String get call => 'Call';

	/// en: 'Message'
	String get message => 'Message';

	/// en: 'That number fails its checksum — one of the digits is probably wrong.'
	String get checksumFail => 'That number fails its checksum — one of the digits is probably wrong.';

	/// en: 'Tap to copy · also on the Codes tab'
	String get codeCardHint => 'Tap to copy · also on the Codes tab';

	/// en: 'Copy all codes'
	String get copyAllCodes => 'Copy all codes';

	/// en: 'Copy code $n'
	String copyCodeNumber({required Object n}) => 'Copy code ${n}';

	/// en: 'Card, number hidden'
	String get cardFace => 'Card, number hidden';

	/// en: '$brand card, number hidden'
	String cardFaceBrand({required Object brand}) => '${brand} card, number hidden';

	/// en: 'expires $date'
	String cardExpires({required Object date}) => 'expires ${date}';

	/// en: 'Turn your phone sideways to read it in one line.'
	String get largeTypeTurn => 'Turn your phone sideways to read it in one line.';

	/// en: 'It hides again when you leave this screen.'
	String get largeTypeHides => 'It hides again when you leave this screen.';

	/// en: 'Earlier Version'
	String get earlierVersion => 'Earlier Version';

	/// en: '$ago · read-only'
	String readOnly({required Object ago}) => '${ago} · read-only';

	/// en: 'Changed since'
	String get changedSince => 'Changed since';

	/// en: 'Restore this version'
	String get restoreThisVersion => 'Restore this version';

	/// en: 'Delete version'
	String get deleteVersion => 'Delete version';

	/// en: 'Restore this version?'
	String get restoreTitle => 'Restore this version?';

	/// en: '$name goes back to how it was on $date. The current version stays in its history.'
	String restoreBody({required Object name, required Object date}) => '${name} goes back to how it was on ${date}. The current version stays in its history.';

	/// en: 'Restore'
	String get restore => 'Restore';

	/// en: 'Delete This Version'
	String get deleteVersionTitle => 'Delete This Version';

	/// en: 'Are you sure you want to delete this version from the history? This cannot be undone.'
	String get deleteVersionConfirm => 'Are you sure you want to delete this version from the history? This cannot be undone.';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'This item no longer exists.'
	String get notFound => 'This item no longer exists.';

	/// en: 'It may have been deleted from another device.'
	String get notFoundHint => 'It may have been deleted from another device.';

	/// en: 'Back to vault'
	String get backToVault => 'Back to vault';

	/// en: '(one) {$field, hidden, $n line} (other) {$field, hidden, $n lines}'
	String hiddenLines({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${field}, hidden, ${n} line',
		other: '${field}, hidden, ${n} lines',
	);

	/// en: '(one) {$field shown in large type, $n character} (other) {$field shown in large type, $n characters}'
	String largeTypeLabel({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${field} shown in large type, ${n} character',
		other: '${field} shown in large type, ${n} characters',
	);
}

// Path: editItem
class Translations$editItem$en {
	Translations$editItem$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New Vault Item'
	String get newVaultItem => 'New Vault Item';

	/// en: 'Vault'
	String get vault => 'Vault';

	/// en: 'Template'
	String get template => 'Template';

	/// en: 'Templates are a head start: rename, remove or add fields at any time.'
	String get templateNote => 'Templates are a head start: rename, remove or add fields at any time.';

	late final Translations$editItem$templates$en templates = Translations$editItem$templates$en.internal(_root);
	late final Translations$editItem$templateHints$en templateHints = Translations$editItem$templateHints$en.internal(_root);
	late final Translations$editItem$templateFields$en templateFields = Translations$editItem$templateFields$en.internal(_root);
	late final Translations$editItem$types$en types = Translations$editItem$types$en.internal(_root);

	/// en: 'New Item'
	String get newItem => 'New Item';

	/// en: 'Edit Item'
	String get editItem => 'Edit Item';

	/// en: 'Change icon'
	String get changeIcon => 'Change icon';

	/// en: 'Name'
	String get name => 'Name';

	/// en: 'e.g. GitHub'
	String get namePlaceholder => 'e.g. GitHub';

	/// en: 'Tags'
	String get tags => 'Tags';

	/// en: 'Add field'
	String get addField => 'Add field';

	/// en: 'Add Field'
	String get addFieldTitle => 'Add Field';

	/// en: 'No fields yet'
	String get noFieldsTitle => 'No fields yet';

	/// en: 'Add any of the 16 field types — a policy number, a phone number, a PIN.'
	String get noFieldsBody => 'Add any of the 16 field types — a policy number, a phone number, a PIN.';

	/// en: 'Field name'
	String get fieldNamePlaceholder => 'Field name';

	/// en: 'Add a tag'
	String get addTag => 'Add a tag';

	/// en: 'Tag suggestions'
	String get tagSuggestions => 'Tag suggestions';

	/// en: 'Create ‘$name’'
	String createTag({required Object name}) => 'Create ‘${name}’';

	/// en: 'That name is too long.'
	String get tagTooLong => 'That name is too long.';

	/// en: 'Are you sure you want to remove this field?'
	String get removeFieldTitle => 'Are you sure you want to remove this field?';

	/// en: '“$field” and its value leave $item when you save.'
	String removeFieldBody({required Object field, required Object item}) => '“${field}” and its value leave ${item} when you save.';

	/// en: 'Remove'
	String get remove => 'Remove';

	/// en: 'Discard changes?'
	String get discardTitle => 'Discard changes?';

	/// en: 'Your edits to $name have not been saved. Discarding keeps the item as it was.'
	String discardBody({required Object name}) => 'Your edits to ${name} have not been saved. Discarding keeps the item as it was.';

	/// en: 'Discard this new item?'
	String get discardNewTitle => 'Discard this new item?';

	/// en: 'It has not been saved. Discarding throws it away.'
	String get discardNewBody => 'It has not been saved. Discarding throws it away.';

	/// en: 'Discard'
	String get discard => 'Discard';

	/// en: 'Username or email'
	String get usernamePlaceholder => 'Username or email';

	/// en: 'Password'
	String get passwordPlaceholder => 'Password';

	/// en: 'Enter value here'
	String get valuePlaceholder => 'Enter value here';

	/// en: 'e.g. 192.168.1.1, ::1, or db.example.com'
	String get ipHostPlaceholder => 'e.g. 192.168.1.1, ::1, or db.example.com';

	/// en: 'One per line — any format works'
	String get recoveryCodesPlaceholder => 'One per line — any format works';

	/// en: 'That does not look like an email address.'
	String get notEmail => 'That does not look like an email address.';

	/// en: 'Phone number'
	String get phoneNumber => 'Phone number';

	/// en: 'Search countries'
	String get searchCountries => 'Search countries';

	/// en: 'No country matches that.'
	String get noCountryMatch => 'No country matches that.';

	/// en: 'Generate'
	String get generate => 'Generate';

	/// en: 'Generate a password'
	String get generatePassword => 'Generate a password';

	/// en: 'Current code'
	String get currentCode => 'Current code';

	/// en: 'Scan QR code'
	String get scanQr => 'Scan QR code';

	/// en: 'Enter setup key'
	String get enterSetupKey => 'Enter setup key';

	/// en: 'Enter Setup Key'
	String get setupKeyTitle => 'Enter Setup Key';

	/// en: 'Sites show a setup key next to the QR code, often under “Can’t scan it?”.'
	String get setupKeyBody => 'Sites show a setup key next to the QR code, often under “Can’t scan it?”.';

	/// en: 'Setup key'
	String get setupKey => 'Setup key';

	/// en: 'Spaces and capitals don’t matter.'
	String get setupKeyHint => 'Spaces and capitals don’t matter.';

	/// en: 'Save code'
	String get saveCode => 'Save code';

	/// en: 'Choose Icon'
	String get chooseIcon => 'Choose Icon';

	/// en: 'Search icons — try ‘bank’ or ‘padlock’'
	String get searchIcons => 'Search icons — try ‘bank’ or ‘padlock’';

	/// en: 'Popular'
	String get popular => 'Popular';

	/// en: 'No icons match ‘$search’.'
	String noIcons({required Object search}) => 'No icons match ‘${search}’.';

	/// en: 'Use default icon'
	String get useDefaultIcon => 'Use default icon';

	/// en: '(one) {$n match} (other) {$n matches}'
	String iconMatches({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} match',
		other: '${n} matches',
	);
}

// Path: generator
class Translations$generator$en {
	Translations$generator$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Generate a password'
	String get title => 'Generate a password';

	/// en: 'Nothing is filled in until you accept it.'
	String get notFilledIn => 'Nothing is filled in until you accept it.';

	/// en: 'Generated password'
	String get generated => 'Generated password';

	/// en: 'Mode'
	String get mode => 'Mode';

	/// en: 'Passphrase'
	String get passphrase => 'Passphrase';

	/// en: 'Random string'
	String get randomString => 'Random string';

	/// en: 'Words'
	String get words => 'Words';

	/// en: 'Fewer words'
	String get fewerWords => 'Fewer words';

	/// en: 'More words'
	String get moreWords => 'More words';

	/// en: 'Length'
	String get length => 'Length';

	/// en: 'Shorter'
	String get shorter => 'Shorter';

	/// en: 'Longer'
	String get longer => 'Longer';

	/// en: 'Word separator'
	String get wordSeparator => 'Word separator';

	/// en: 'Dash'
	String get dash => 'Dash';

	/// en: 'Underscore'
	String get underscore => 'Underscore';

	/// en: 'Slash'
	String get slash => 'Slash';

	/// en: 'Space'
	String get space => 'Space';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Regenerate'
	String get regenerate => 'Regenerate';

	/// en: '$count characters'
	String charCount({required Object count}) => '${count} characters';

	/// en: 'Lowercase letters'
	String get lowercase => 'Lowercase letters';

	/// en: 'Uppercase letters'
	String get uppercase => 'Uppercase letters';

	/// en: 'Digits'
	String get digits => 'Digits';

	/// en: 'Symbols'
	String get symbols => 'Symbols';

	/// en: 'Pick at least one kind of character.'
	String get pickOne => 'Pick at least one kind of character.';

	/// en: 'Use this password'
	String get use => 'Use this password';

	/// en: '(one) {$n word} (other) {$n words}'
	String wordCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} word',
		other: '${n} words',
	);

	/// en: 'Password Generator'
	String get pageTitle => 'Password Generator';

	/// en: 'Random passwords and passphrases, made on this device'
	String get subtitle => 'Random passwords and passphrases, made on this device';

	/// en: 'Dash ( - )'
	String get separatorDash => 'Dash ( - )';

	/// en: 'Underscore ( _ )'
	String get separatorUnderscore => 'Underscore ( _ )';

	/// en: 'Slash ( / )'
	String get separatorSlash => 'Slash ( / )';

	/// en: 'Space'
	String get separatorSpace => 'Space';

	/// en: 'Nothing to generate.'
	String get nothingToGenerate => 'Nothing to generate.';

	/// en: 'Copy password'
	String get copyPassword => 'Copy password';

	/// en: 'Password copied'
	String get copied => 'Password copied';

	/// en: 'From the generator'
	String get fromGenerator => 'From the generator';
}

// Path: report
class Translations$report$en {
	Translations$report$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Security Report'
	String get title => 'Security Report';

	/// en: 'How well your saved passwords hold up'
	String get subtitle => 'How well your saved passwords hold up';

	/// en: 'Vault health'
	String get healthLabel => 'Vault health';

	/// en: 'Strong'
	String get healthGood => 'Strong';

	/// en: 'Needs work'
	String get healthFair => 'Needs work';

	/// en: 'At risk'
	String get healthPoor => 'At risk';

	/// en: 'No problems found'
	String get allClearTitle => 'No problems found';

	/// en: 'Every password in your vaults passed the last audit.'
	String get allClearDescription => 'Every password in your vaults passed the last audit.';

	/// en: 'About $title'
	String aboutSection({required Object title}) => 'About ${title}';

	/// en: 'Nothing found'
	String get nothingFound => 'Nothing found';

	/// en: 'Open $name'
	String openItem({required Object name}) => 'Open ${name}';

	/// en: 'Check again'
	String get checkAgain => 'Check again';

	/// en: 'Weak'
	String get statWeak => 'Weak';

	/// en: 'Reused'
	String get statReused => 'Reused';

	/// en: 'Compromised'
	String get statCompromised => 'Compromised';

	/// en: '$label: $count'
	String statValue({required Object label, required Object count}) => '${label}: ${count}';

	/// en: '$label: not checked yet'
	String statNotChecked({required Object label}) => '${label}: not checked yet';

	/// en: '$title $score percent'
	String healthPercent({required Object title, required Object score}) => '${title} ${score} percent';

	/// en: 'Same as $names'
	String sameAs({required Object names}) => 'Same as ${names}';

	/// en: 'Same as another password in this item'
	String get sameAsField => 'Same as another password in this item';

	/// en: 'Found in a known breach'
	String get foundInBreach => 'Found in a known breach';

	/// en: 'Breach checks use Have I Been Pwned with k-anonymity: only the first 5 characters of a SHA-1 hash ever leave this phone.'
	String get trust => 'Breach checks use Have I Been Pwned with k-anonymity: only the first 5 characters of a SHA-1 hash ever leave this phone.';

	/// en: 'Last checked just now'
	String get lastCheckedJustNow => 'Last checked just now';

	/// en: 'Last checked today at $time'
	String lastCheckedToday({required Object time}) => 'Last checked today at ${time}';

	/// en: 'Last checked $date'
	String lastCheckedOn({required Object date}) => 'Last checked ${date}';

	/// en: 'Checking…'
	String get checking => 'Checking…';

	/// en: 'Checking for breaches · $done of $total'
	String checkingBreaches({required Object done, required Object total}) => 'Checking for breaches · ${done} of ${total}';

	/// en: '$done of $total'
	String progress({required Object done, required Object total}) => '${done} of ${total}';

	/// en: '$done of $total · $time'
	String progressTime({required Object done, required Object total, required Object time}) => '${done} of ${total} · ${time}';

	/// en: 'Your passwords could not be checked. The check needs a connection.'
	String get offlineBody => 'Your passwords could not be checked. The check needs a connection.';

	/// en: 'The check could not finish'
	String get failedTitle => 'The check could not finish';

	/// en: 'Try again in a moment.'
	String get failedBody => 'Try again in a moment.';

	/// en: 'Nothing to check yet'
	String get nothingTitle => 'Nothing to check yet';

	/// en: 'Save an item with a password and it is checked here, on this phone, for weak, reused and breached passwords.'
	String get nothingBody => 'Save an item with a password and it is checked here, on this phone, for weak, reused and breached passwords.';

	/// en: 'How to fix it'
	String get howToFix => 'How to fix it';

	/// en: 'Open the item'
	String get stepOpen => 'Open the item';

	/// en: 'Tap Edit, then Generate on the password'
	String get stepGenerate => 'Tap Edit, then Generate on the password';

	/// en: 'Save — the finding clears by itself'
	String get stepSave => 'Save — the finding clears by itself';

	/// en: 'Save, then change it on the site too'
	String get stepSaveCompromised => 'Save, then change it on the site too';

	/// en: 'Change password'
	String get changePassword => 'Change password';

	/// en: 'Saved · $name is no longer flagged'
	String fixedClear({required Object name}) => 'Saved · ${name} is no longer flagged';

	/// en: 'Saved · $name is still flagged'
	String fixedFlagged({required Object name}) => 'Saved · ${name} is still flagged';

	/// en: 'Your vault was saved to $storage'
	String savedTo({required Object storage}) => 'Your vault was saved to ${storage}';

	/// en: 'No longer weak'
	String get noLongerWeak => 'No longer weak';

	/// en: 'No longer reused'
	String get noLongerReused => 'No longer reused';

	/// en: 'No longer weak or reused'
	String get noLongerWeakOrReused => 'No longer weak or reused';

	/// en: 'These $n share one password. Give each its own: open one, tap Edit, then Generate.'
	String hintReusedOne({required Object n}) => 'These ${n} share one password. Give each its own: open one, tap Edit, then Generate.';

	/// en: 'Some of these share a password. Give each its own: open one, tap Edit, then Generate.'
	String get hintReusedSome => 'Some of these share a password. Give each its own: open one, tap Edit, then Generate.';

	/// en: 'Give each a stronger one: open it, tap Edit, then Generate.'
	String get hintWeak => 'Give each a stronger one: open it, tap Edit, then Generate.';

	/// en: 'These are in known breaches. Change each one: open it, tap Edit, then Generate.'
	String get hintCompromised => 'These are in known breaches. Change each one: open it, tap Edit, then Generate.';

	/// en: '(one) {$n item with a password checked} (other) {$n items with a password checked}'
	String itemsChecked({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} item with a password checked',
		other: '${n} items with a password checked',
	);

	/// en: '(one) {$n item flagged} (other) {$n items flagged}'
	String flagged({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} item flagged',
		other: '${n} items flagged',
	);

	/// en: '(one) {Same as $n other item} (other) {Same as $n other items}'
	String sameAsOthers({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Same as ${n} other item',
		other: 'Same as ${n} other items',
	);

	/// en: '(one) {Checking $n password} (other) {Checking $n passwords}'
	String checkingPasswords({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Checking ${n} password',
		other: 'Checking ${n} passwords',
	);

	/// en: '(one) {about $n second} (other) {about $n seconds}'
	String aboutSeconds({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'about ${n} second',
		other: 'about ${n} seconds',
	);

	/// en: '(one) {about $n minute} (other) {about $n minutes}'
	String aboutMinutes({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'about ${n} minute',
		other: 'about ${n} minutes',
	);
}

// Path: audit
class Translations$audit$en {
	Translations$audit$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$audit$weakPassword$en weakPassword = Translations$audit$weakPassword$en.internal(_root);
	late final Translations$audit$reusedPassword$en reusedPassword = Translations$audit$reusedPassword$en.internal(_root);
	late final Translations$audit$compromisedPassword$en compromisedPassword = Translations$audit$compromisedPassword$en.internal(_root);
}

// Path: myVaults
class Translations$myVaults$en {
	Translations$myVaults$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My Vaults'
	String get title => 'My Vaults';

	/// en: 'Separate groups of items — work, family, personal'
	String get subtitle => 'Separate groups of items — work, family, personal';

	/// en: 'Default'
	String get defaultBadge => 'Default';

	/// en: 'New vault'
	String get newVault => 'New vault';

	/// en: 'You only have the default vault'
	String get emptyTitle => 'You only have the default vault';

	/// en: 'A second vault keeps a set of items apart — work from personal, or shared from private.'
	String get emptyBody => 'A second vault keeps a set of items apart — work from personal, or shared from private.';

	/// en: 'created $date'
	String createdOn({required Object date}) => 'created ${date}';

	/// en: 'Rename Vault'
	String get renameTitle => 'Rename Vault';

	/// en: 'The items in it are not affected.'
	String get renameBody => 'The items in it are not affected.';

	/// en: 'A vault named “$name” already exists.'
	String duplicateRename({required Object name}) => 'A vault named “${name}” already exists.';

	/// en: 'Delete “$name”?'
	String deleteTitle({required Object name}) => 'Delete “${name}”?';

	/// en: 'Delete vault'
	String get deleteAction => 'Delete vault';

	/// en: 'Rename $name'
	String renameAria({required Object name}) => 'Rename ${name}';

	/// en: 'Delete $name'
	String deleteAria({required Object name}) => 'Delete ${name}';

	/// en: '(one) {$n item} (other) {$n items}'
	String itemCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} item',
		other: '${n} items',
	);

	/// en: '(one) {Its $n item moves to $vault. This cannot be undone.} (other) {Its $n items move to $vault. This cannot be undone.}'
	String deleteBody({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Its ${n} item moves to ${vault}. This cannot be undone.',
		other: 'Its ${n} items move to ${vault}. This cannot be undone.',
	);

	/// en: '(one) {Delete $n vault?} (other) {Delete $n vaults?}'
	String deleteSelectedTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Delete ${n} vault?',
		other: 'Delete ${n} vaults?',
	);

	/// en: '(one) {Everything in them — $n item — moves to $vault. This cannot be undone.} (other) {Everything in them — $n items — moves to $vault. This cannot be undone.}'
	String deleteSelectedBody({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Everything in them — ${n} item — moves to ${vault}. This cannot be undone.',
		other: 'Everything in them — ${n} items — moves to ${vault}. This cannot be undone.',
	);

	/// en: '(one) {$name holds $n item and cannot be renamed or deleted.} (other) {$name holds $n items and cannot be renamed or deleted.}'
	String personalSummary({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${name} holds ${n} item and cannot be renamed or deleted.',
		other: '${name} holds ${n} items and cannot be renamed or deleted.',
	);

	/// en: '(one) {$n vault selected} (other) {$n vaults selected}'
	String selected({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} vault selected',
		other: '${n} vaults selected',
	);

	/// en: '(one) {Delete $n vault} (other) {Delete $n vaults}'
	String deleteVaults({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Delete ${n} vault',
		other: 'Delete ${n} vaults',
	);
}

// Path: tags
class Translations$tags$en {
	Translations$tags$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Tags'
	String get title => 'Tags';

	/// en: 'Labels that cut across vaults, for finding things fast'
	String get subtitle => 'Labels that cut across vaults, for finding things fast';

	/// en: 'since $date'
	String since({required Object date}) => 'since ${date}';

	/// en: 'Add tag'
	String get addTag => 'Add tag';

	/// en: 'Add Tag'
	String get addTitle => 'Add Tag';

	/// en: 'No tags yet'
	String get emptyTitle => 'No tags yet';

	/// en: 'Tags are created from an item, or here — either way they group items across vaults.'
	String get emptyBody => 'Tags are created from an item, or here — either way they group items across vaults.';

	/// en: 'A tag with no items yet. Put it on an item from that item’s own page.'
	String get addBody => 'A tag with no items yet. Put it on an item from that item’s own page.';

	/// en: 'Tag name'
	String get tagName => 'Tag name';

	/// en: 'A tag with this name already exists.'
	String get duplicate => 'A tag with this name already exists.';

	/// en: 'Its color comes from its name.'
	String get colorNote => 'Its color comes from its name.';

	/// en: 'Rename Tag'
	String get renameTitle => 'Rename Tag';

	/// en: 'Every item carrying it is updated.'
	String get renameBody => 'Every item carrying it is updated.';

	/// en: '‘$name’ already exists — renaming will merge them.'
	String mergeNotice({required Object name}) => '‘${name}’ already exists — renaming will merge them.';

	/// en: 'Delete “$name”?'
	String deleteTitle({required Object name}) => 'Delete “${name}”?';

	/// en: 'Delete tag'
	String get deleteAction => 'Delete tag';

	/// en: 'Each one is removed from every item that has it. The items themselves are kept. This cannot be undone.'
	String get deleteSelectedBody => 'Each one is removed from every item that has it. The items themselves are kept. This cannot be undone.';

	/// en: 'Tap a tag to see its items in the Vault tab.'
	String get footer => 'Tap a tag to see its items in the Vault tab.';

	/// en: 'Rename $name'
	String renameAria({required Object name}) => 'Rename ${name}';

	/// en: 'Delete $name'
	String deleteAria({required Object name}) => 'Delete ${name}';

	/// en: '(one) {$n item} (other) {$n items}'
	String itemCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} item',
		other: '${n} items',
	);

	/// en: '(one) {It will be removed from $n item. The items themselves are kept. This cannot be undone.} (other) {It will be removed from $n items. The items themselves are kept. This cannot be undone.}'
	String deleteBody({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'It will be removed from ${n} item. The items themselves are kept. This cannot be undone.',
		other: 'It will be removed from ${n} items. The items themselves are kept. This cannot be undone.',
	);

	/// en: '(one) {Delete $n tag?} (other) {Delete $n tags?}'
	String deleteSelectedTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Delete ${n} tag?',
		other: 'Delete ${n} tags?',
	);

	/// en: '(one) {$n tag selected} (other) {$n tags selected}'
	String selected({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} tag selected',
		other: '${n} tags selected',
	);

	/// en: '(one) {Delete $n tag} (other) {Delete $n tags}'
	String deleteTags({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Delete ${n} tag',
		other: 'Delete ${n} tags',
	);
}

// Path: changeSecret
class Translations$changeSecret$en {
	Translations$changeSecret$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Change Secret'
	String get title => 'Change Secret';

	/// en: 'Your vault is re-encrypted under the new secret and uploaded again. It cannot be recovered if you forget it.'
	String get intro => 'Your vault is re-encrypted under the new secret and uploaded again. It cannot be recovered if you forget it.';

	/// en: 'Current secret'
	String get current => 'Current secret';

	/// en: 'That is not your current secret.'
	String get wrong => 'That is not your current secret.';

	/// en: 'The two secrets match.'
	String get match => 'The two secrets match.';

	/// en: 'Other devices ask for the new secret the next time they open your vault.'
	String get otherDevices => 'Other devices ask for the new secret the next time they open your vault.';

	/// en: 'Change secret'
	String get submit => 'Change secret';

	/// en: 'Checking your current secret…'
	String get verifyingMeta => 'Checking your current secret…';

	/// en: 'Verifying your current secret…'
	String get verifyingTitle => 'Verifying your current secret…';

	/// en: 'Verifying your current secret'
	String get stepVerify => 'Verifying your current secret';

	/// en: 'Deliberately slow on a phone — that is what makes guessing it expensive'
	String get stepVerifyNote => 'Deliberately slow on a phone — that is what makes guessing it expensive';

	/// en: 'Encrypting with the new secret'
	String get stepEncrypt => 'Encrypting with the new secret';

	/// en: 'Saving your vault'
	String get stepSave => 'Saving your vault';

	/// en: 'Saving to $storage…'
	String savingMeta({required Object storage}) => 'Saving to ${storage}…';

	/// en: 'Saving your vault… $percent%'
	String savingTitle({required Object percent}) => 'Saving your vault… ${percent}%';

	/// en: 'Current secret verified'
	String get stepVerified => 'Current secret verified';

	/// en: 'Encrypted with the new secret'
	String get stepEncrypted => 'Encrypted with the new secret';

	/// en: 'Saving to $storage'
	String stepSaving({required Object storage}) => 'Saving to ${storage}';

	/// en: 'Keep KeeperPass open until it finishes.'
	String get keepOpen => 'Keep KeeperPass open until it finishes.';

	/// en: 'Saved to $storage'
	String doneMeta({required Object storage}) => 'Saved to ${storage}';

	/// en: 'Your secret was changed'
	String get doneTitle => 'Your secret was changed';

	/// en: 'Every item came with you. Other devices ask for the new secret the next time they open your vault.'
	String get doneBody => 'Every item came with you. Other devices ask for the new secret the next time they open your vault.';

	/// en: 'Secret changed'
	String get toast => 'Secret changed';

	/// en: 'Your vault was not saved'
	String get failTitle => 'Your vault was not saved';

	/// en: '$storage could not be reached. Your secret has not changed: the vault still opens with your current one.'
	String failBody({required Object storage}) => '${storage} could not be reached. Your secret has not changed: the vault still opens with your current one.';
}

// Path: storage
class Translations$storage$en {
	Translations$storage$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Storage'
	String get title => 'Storage';

	/// en: 'Where your vault lives, and what can reach it'
	String get subtitle => 'Where your vault lives, and what can reach it';

	/// en: 'Encrypted on this phone, stored in your $storage'
	String diagram({required Object storage}) => 'Encrypted on this phone, stored in your ${storage}';

	/// en: 'This phone'
	String get thisPhone => 'This phone';

	/// en: 'Encrypted file only'
	String get encryptedOnly => 'Encrypted file only';

	/// en: 'keeperpass folder'
	String get googleFolder => 'keeperpass folder';

	/// en: 'Apps/keeperpass folder'
	String get dropboxFolder => 'Apps/keeperpass folder';

	/// en: '$folder · saved today at $time'
	String savedToday({required Object folder, required Object time}) => '${folder} · saved today at ${time}';

	/// en: '$folder · saved $date'
	String savedOn({required Object folder, required Object date}) => '${folder} · saved ${date}';

	/// en: 'Access'
	String get access => 'Access';

	/// en: 'Google account permissions'
	String get googlePermissions => 'Google account permissions';

	/// en: 'Dropbox connected apps'
	String get dropboxApps => 'Dropbox connected apps';

	/// en: 'KeeperPass can reach only the files it creates. Revoke that here at any time; the vault file stays where it is.'
	String get accessNote => 'KeeperPass can reach only the files it creates. Revoke that here at any time; the vault file stays where it is.';
}

// Path: moveVault
class Translations$moveVault$en {
	Translations$moveVault$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Move Vault'
	String get title => 'Move Vault';

	/// en: 'Your vault moves from $from to $to'
	String diagram({required Object from, required Object to}) => 'Your vault moves from ${from} to ${to}';

	/// en: 'From'
	String get from => 'From';

	/// en: 'To'
	String get to => 'To';

	/// en: 'Your vault is copied and checked, and only then is the old file renamed. If anything fails, nothing is changed.'
	String get intro => 'Your vault is copied and checked, and only then is the old file renamed. If anything fails, nothing is changed.';

	/// en: 'Sign in to $storage to choose where the vault goes.'
	String step1({required Object storage}) => 'Sign in to ${storage} to choose where the vault goes.';

	/// en: 'Confirm. Nothing changes before this step.'
	String get step2 => 'Confirm. Nothing changes before this step.';

	/// en: 'The vault is copied and checked; then the old file is renamed, never deleted.'
	String get step3 => 'The vault is copied and checked; then the old file is renamed, never deleted.';

	/// en: 'Connect $storage'
	String connect({required Object storage}) => 'Connect ${storage}';

	/// en: 'Moving to this account'
	String get account => 'Moving to this account';

	/// en: 'This $storage account already has a KeeperPass vault'
	String existingTitle({required Object storage}) => 'This ${storage} account already has a KeeperPass vault';

	/// en: 'Continuing keeps it as a timestamped backup file in $storage and replaces it with the vault you are moving.'
	String existingBody({required Object storage}) => 'Continuing keeps it as a timestamped backup file in ${storage} and replaces it with the vault you are moving.';

	/// en: 'Replace it — the existing vault is kept as a backup'
	String get existingConfirm => 'Replace it — the existing vault is kept as a backup';

	/// en: 'Secret for the moved vault'
	String get secretSection => 'Secret for the moved vault';

	/// en: 'Keep my current secret'
	String get keepSecret => 'Keep my current secret';

	/// en: 'Choose a new secret'
	String get newSecret => 'Choose a new secret';

	/// en: 'Only the moved vault uses it'
	String get newSecretNote => 'Only the moved vault uses it';

	/// en: 'Move vault'
	String get submit => 'Move vault';

	/// en: 'Moving your vault'
	String get movingTitle => 'Moving your vault';

	/// en: 'Encrypting your vault'
	String get stageEncrypting => 'Encrypting your vault';

	/// en: 'Saving to $storage…'
	String stageSaving({required Object storage}) => 'Saving to ${storage}…';

	/// en: 'Checking the saved copy'
	String get stageChecking => 'Checking the saved copy';

	/// en: 'Renaming the old file'
	String get stageRenaming => 'Renaming the old file';

	/// en: 'Keep KeeperPass open until it finishes. If anything fails, nothing is changed.'
	String get movingNote => 'Keep KeeperPass open until it finishes. If anything fails, nothing is changed.';

	/// en: 'Saved to $storage'
	String savedTo({required Object storage}) => 'Saved to ${storage}';

	/// en: 'Your vault now lives in $storage'
	String doneTitle({required Object storage}) => 'Your vault now lives in ${storage}';

	/// en: 'Sign in with $provider to open it. The old file was kept and renamed in $from:'
	String doneBody({required Object provider, required Object from}) => 'Sign in with ${provider} to open it. The old file was kept and renamed in ${from}:';

	/// en: 'Copy file name'
	String get copyFileName => 'Copy file name';

	/// en: 'File name copied'
	String get fileNameCopied => 'File name copied';

	/// en: 'Your vault was copied to $storage'
	String partlyTitle({required Object storage}) => 'Your vault was copied to ${storage}';

	/// en: 'But the old file in $from could not be renamed. Rename or delete it yourself so the two copies do not drift apart.'
	String partlyBody({required Object from}) => 'But the old file in ${from} could not be renamed. Rename or delete it yourself so the two copies do not drift apart.';

	/// en: 'Open $storage'
	String open({required Object storage}) => 'Open ${storage}';

	/// en: 'Still in $from · unchanged'
	String unchanged({required Object from}) => 'Still in ${from} · unchanged';

	/// en: 'Your vault was not moved'
	String get notMovedTitle => 'Your vault was not moved';

	/// en: 'The saved copy did not match your vault, so the old file was left untouched. Nothing was lost — please try again.'
	String get notMovedBody => 'The saved copy did not match your vault, so the old file was left untouched. Nothing was lost — please try again.';
}

// Path: dataIo
class Translations$dataIo$en {
	Translations$dataIo$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Import'
	String get importTitle => 'Import';

	/// en: 'File'
	String get file => 'File';

	/// en: '$size · from Files'
	String fileMeta({required Object size}) => '${size} · from Files';

	/// en: '$n KB'
	String kilobytes({required Object n}) => '${n} KB';

	/// en: '$n MB'
	String megabytes({required Object n}) => '${n} MB';

	/// en: 'Change'
	String get change => 'Change';

	/// en: '(one) {Found $n item to import.} (other) {Found $n items to import.}'
	String found({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Found ${n} item to import.',
		other: 'Found ${n} items to import.',
	);

	/// en: 'Add them to'
	String get addTo => 'Add them to';

	/// en: 'Items are added to the vault you pick. Nothing is replaced.'
	String get importNote => 'Items are added to the vault you pick. Nothing is replaced.';

	/// en: '(one) {Import $n item} (other) {Import $n items}'
	String importButton({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Import ${n} item',
		other: 'Import ${n} items',
	);

	/// en: 'This file could not be read as CSV.'
	String get invalidCsv => 'This file could not be read as CSV.';

	/// en: 'No items found in this file.'
	String get noItems => 'No items found in this file.';

	/// en: 'Export a CSV from your other password manager, then choose that file here.'
	String get notCsvNote => 'Export a CSV from your other password manager, then choose that file here.';

	/// en: 'Choose another file'
	String get chooseAnother => 'Choose another file';

	/// en: 'Export'
	String get exportTitle => 'Export';

	/// en: 'Writes a CSV of the vault you choose. Exported items leave the vault’s encryption behind — what you do with the file is up to you.'
	String get exportIntro => 'Writes a CSV of the vault you choose. Exported items leave the vault’s encryption behind — what you do with the file is up to you.';

	/// en: 'Source vault'
	String get sourceVault => 'Source vault';

	/// en: 'A CSV file is not encrypted'
	String get notEncryptedTitle => 'A CSV file is not encrypted';

	/// en: 'Anyone who opens it can read every password in it. Keep it somewhere safe and delete it when you are done.'
	String get notEncryptedBody => 'Anyone who opens it can read every password in it. Keep it somewhere safe and delete it when you are done.';

	/// en: '(one) {Export $n item} (other) {Export $n items}'
	String exportButton({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Export ${n} item',
		other: 'Export ${n} items',
	);

	/// en: 'Opens the share sheet, so you choose where the file goes.'
	String get exportNote => 'Opens the share sheet, so you choose where the file goes.';

	/// en: 'Recent Exports'
	String get recentTitle => 'Recent Exports';

	/// en: '(one) {$scope · $n item} (other) {$scope · $n items}'
	String recentRow({required num n, required Object scope}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${scope} · ${n} item',
		other: '${scope} · ${n} items',
	);

	/// en: 'The last 10 exports are remembered, in your vault. KeeperPass keeps no copy of the files themselves.'
	String get recentNote => 'The last 10 exports are remembered, in your vault. KeeperPass keeps no copy of the files themselves.';

	/// en: 'No exports yet.'
	String get recentEmpty => 'No exports yet.';
}

// Path: archive
class Translations$archive$en {
	Translations$archive$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Archive Vault'
	String get title => 'Archive Vault';

	/// en: 'Archive vault and sign out'
	String get headline => 'Archive vault and sign out';

	/// en: 'Your vault is one encrypted file in your own $storage. Archiving renames it so this app no longer finds it, and signs you out. Nothing is erased.'
	String body({required Object storage}) => 'Your vault is one encrypted file in your own ${storage}. Archiving renames it so this app no longer finds it, and signs you out. Nothing is erased.';

	/// en: '$oldName is renamed to $newName, in the same $folder.'
	String step1({required Object oldName, required Object newName, required Object folder}) => '${oldName} is renamed to ${newName}, in the same ${folder}.';

	/// en: 'This phone signs out of $storage.'
	String step2({required Object storage}) => 'This phone signs out of ${storage}.';

	/// en: 'To delete the data itself, delete that file in $storage.'
	String step3({required Object storage}) => 'To delete the data itself, delete that file in ${storage}.';

	/// en: 'Type'
	String get typePrefix => 'Type';

	/// en: 'to confirm.'
	String get typeSuffix => 'to confirm.';

	/// en: 'Confirmation'
	String get confirmation => 'Confirmation';

	/// en: 'Archive and sign out'
	String get button => 'Archive and sign out';

	/// en: 'Renamed · this app no longer finds it'
	String get doneMeta => 'Renamed · this app no longer finds it';

	/// en: 'Your vault file has been renamed'
	String get doneTitle => 'Your vault file has been renamed';

	/// en: 'It is still in the $folder of your $storage. Delete it there whenever you want the data gone for good.'
	String doneBody({required Object folder, required Object storage}) => 'It is still in the ${folder} of your ${storage}. Delete it there whenever you want the data gone for good.';

	/// en: 'You are signed out on this phone.'
	String get signedOut => 'You are signed out on this phone.';

	/// en: 'Could not rename your vault file. Nothing was changed.'
	String get error => 'Could not rename your vault file. Nothing was changed.';
}

// Path: help
class Translations$help$en {
	Translations$help$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'How KeeperPass Works'
	String get howTitle => 'How KeeperPass Works';

	/// en: 'Where your data lives, and what keeps it private'
	String get howSubtitle => 'Where your data lives, and what keeps it private';

	/// en: 'Where your data lives'
	String get whereLives => 'Where your data lives';

	/// en: 'Your vault is encrypted on this phone and stored as one file in your $storage'
	String diagram({required Object storage}) => 'Your vault is encrypted on this phone and stored as one file in your ${storage}';

	/// en: 'Encrypts and decrypts everything. Your secret never leaves it.'
	String get thisPhoneNote => 'Encrypts and decrypts everything. Your secret never leaves it.';

	/// en: 'vault.json.enc · encrypted'
	String get fileEncrypted => 'vault.json.enc · encrypted';

	/// en: 'Your $storage'
	String yourStorage({required Object storage}) => 'Your ${storage}';

	/// en: 'Holds the file, which is unreadable without your secret.'
	String get storageNote => 'Holds the file, which is unreadable without your secret.';

	/// en: 'KeeperPass never receives your data. There is no account to breach and no operator who could read your vault.'
	String get noServer => 'KeeperPass never receives your data. There is no account to breach and no operator who could read your vault.';

	/// en: 'What protects it'
	String get protects => 'What protects it';

	/// en: 'Your secret'
	String get secretTerm => 'Your secret';

	/// en: 'Never sent, never stored. It exists only in memory while the app is unlocked.'
	String get secretNote => 'Never sent, never stored. It exists only in memory while the app is unlocked.';

	/// en: 'Key derivation'
	String get kdfTerm => 'Key derivation';

	/// en: 'Deliberately slow, so every guess at your secret is expensive.'
	String get kdfNote => 'Deliberately slow, so every guess at your secret is expensive.';

	/// en: 'Encryption'
	String get encryptionTerm => 'Encryption';

	/// en: 'Keeps the file unreadable, and shows if anyone changed it.'
	String get encryptionNote => 'Keeps the file unreadable, and shows if anyone changed it.';

	/// en: 'Storage access'
	String get accessTerm => 'Storage access';

	/// en: 'KeeperPass can reach only the files it creates.'
	String get accessNote => 'KeeperPass can reach only the files it creates.';

	/// en: 'Signing in'
	String get signingIn => 'Signing in';

	/// en: 'Connect your cloud storage'
	String get step1 => 'Connect your cloud storage';

	/// en: 'Proves who owns the file. It unlocks nothing.'
	String get step1Note => 'Proves who owns the file. It unlocks nothing.';

	/// en: 'Enter your secret'
	String get step2 => 'Enter your secret';

	/// en: 'Makes the key that opens the file, on this phone. Your storage provider never sees it.'
	String get step2Note => 'Makes the key that opens the file, on this phone. Your storage provider never sees it.';

	/// en: 'Someone with your storage account still can’t read your vault. Someone with your secret still can’t reach the file. Both are needed.'
	String get bothNeeded => 'Someone with your storage account still can’t read your vault. Someone with your secret still can’t reach the file. Both are needed.';

	/// en: 'Terms worth knowing'
	String get terms => 'Terms worth knowing';

	/// en: 'Secret'
	String get secretWord => 'Secret';

	/// en: 'The one phrase that unlocks your vault. It can’t be recovered.'
	String get secretDef => 'The one phrase that unlocks your vault. It can’t be recovered.';

	/// en: 'Vault'
	String get vaultWord => 'Vault';

	/// en: 'A group of items. Keep work and personal apart with several.'
	String get vaultDef => 'A group of items. Keep work and personal apart with several.';

	/// en: 'Tag'
	String get tagWord => 'Tag';

	/// en: 'A label for finding items across vaults, like work or banking.'
	String get tagDef => 'A label for finding items across vaults, like work or banking.';

	/// en: 'Security report'
	String get reportWord => 'Security report';

	/// en: 'Flags weak, reused and breached passwords, on this phone.'
	String get reportDef => 'Flags weak, reused and breached passwords, on this phone.';
}

// Path: faq
class Translations$faq$en {
	Translations$faq$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Questions'
	String get title => 'Questions';

	/// en: 'Answers to common questions'
	String get subtitle => 'Answers to common questions';

	/// en: 'What if I forget my secret?'
	String get forgetQ => 'What if I forget my secret?';

	/// en: 'Your vault cannot be recovered — not by you, not by us. The key is made from your secret alone, so without it the file stays unreadable. That is the cost of nobody else being able to read it either.'
	String get forgetA1 => 'Your vault cannot be recovered — not by you, not by us. The key is made from your secret alone, so without it the file stays unreadable. That is the cost of nobody else being able to read it either.';

	/// en: 'What you can do is start over: $forgot on the unlock screen sets up a new, empty vault. Your old file is not deleted — it is renamed to $file and kept in your keeperpass folder, so the data is still there if the secret comes back.'
	String forgetA2({required Object forgot, required Object file}) => 'What you can do is start over: ${forgot} on the unlock screen sets up a new, empty vault. Your old file is not deleted — it is renamed to ${file} and kept in your keeperpass folder, so the data is still there if the secret comes back.';

	/// en: 'Forgot your secret?'
	String get forgetA2Link => 'Forgot your secret?';

	/// en: 'Write your secret down and keep it somewhere safe. It is the one thing in KeeperPass that cannot be replaced.'
	String get forgetA3 => 'Write your secret down and keep it somewhere safe. It is the one thing in KeeperPass that cannot be replaced.';

	/// en: 'Can KeeperPass see my passwords?'
	String get seeQ => 'Can KeeperPass see my passwords?';

	/// en: 'No — and not as a promise, as a consequence of the design. Encryption happens on this phone and the ciphertext goes straight to your own storage. There is no KeeperPass server in the path to see anything.'
	String get seeA => 'No — and not as a promise, as a consequence of the design. Encryption happens on this phone and the ciphertext goes straight to your own storage. There is no KeeperPass server in the path to see anything.';

	/// en: 'Does it sync across devices?'
	String get syncQ => 'Does it sync across devices?';

	/// en: 'Yes. Every device reads the same file from your storage. Sign in with the same account, enter the same secret, and your vault is there.'
	String get syncA => 'Yes. Every device reads the same file from your storage. Sign in with the same account, enter the same secret, and your vault is there.';

	/// en: 'What if my storage provider reads the file?'
	String get providerQ => 'What if my storage provider reads the file?';

	/// en: 'They would see encrypted bytes. The key never leaves this phone, so Google, Dropbox or any other provider cannot read the contents.'
	String get providerA => 'They would see encrypted bytes. The key never leaves this phone, so Google, Dropbox or any other provider cannot read the contents.';

	/// en: 'Can I import from another password manager?'
	String get importQ => 'Can I import from another password manager?';

	/// en: 'Yes — export to CSV there, then use Import in Settings.'
	String get importA => 'Yes — export to CSV there, then use Import in Settings.';

	/// en: 'How do I change my secret?'
	String get changeSecretQ => 'How do I change my secret?';

	/// en: 'Open Settings and choose $action. You enter your current secret and the new one; your vault is decrypted, re-encrypted under the new secret, and saved back. Nothing is lost — every item comes with you, and the change applies on every device the next time it loads your vault.'
	String changeSecretA({required Object action}) => 'Open Settings and choose ${action}. You enter your current secret and the new one; your vault is decrypted, re-encrypted under the new secret, and saved back. Nothing is lost — every item comes with you, and the change applies on every device the next time it loads your vault.';

	/// en: 'What does it cost?'
	String get costQ => 'What does it cost?';

	/// en: 'Nothing. KeeperPass is free and open-source, and it stores data in cloud space you already have.'
	String get costA => 'Nothing. KeeperPass is free and open-source, and it stores data in cloud space you already have.';

	/// en: 'Still stuck?'
	String get stillStuck => 'Still stuck?';

	/// en: 'Questions, feedback or a problem to report? Send us an email.'
	String get contactBody => 'Questions, feedback or a problem to report? Send us an email.';
}

// Path: about
class Translations$about$en {
	Translations$about$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Version $version ($build)'
	String version({required Object version, required Object build}) => 'Version ${version} (${build})';

	/// en: 'Your cloud. Your keys. Your vault.'
	String get tagline => 'Your cloud. Your keys. Your vault.';

	/// en: 'Free and open source under AGPL-3.0'
	String get license => 'Free and open source under AGPL-3.0';

	/// en: 'Terms of Service'
	String get terms => 'Terms of Service';

	/// en: 'Privacy Policy'
	String get privacy => 'Privacy Policy';

	/// en: 'Free, with no catch: no plans, no premium tier, no upsells.'
	String get promise => 'Free, with no catch: no plans, no premium tier, no upsells.';
}

// Path: clipboard
class Translations$clipboard$en {
	Translations$clipboard$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Clears in $time'
	String clearsIn({required Object time}) => 'Clears in ${time}';

	/// en: 'Clipboard cleared'
	String get cleared => 'Clipboard cleared';
}

// Path: sync
class Translations$sync$en {
	Translations$sync$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Saved to $storage'
	String savedTo({required Object storage}) => 'Saved to ${storage}';

	/// en: 'Your vault was not saved'
	String get notSavedTitle => 'Your vault was not saved';

	/// en: '$storage could not be reached. Your change is still here — retry before you close KeeperPass.'
	String notSavedBody({required Object storage}) => '${storage} could not be reached. Your change is still here — retry before you close KeeperPass.';

	/// en: 'Dismiss'
	String get dismiss => 'Dismiss';

	/// en: 'Trying again…'
	String get retryingTitle => 'Trying again…';

	/// en: 'Saving to $storage.'
	String retryingBody({required Object storage}) => 'Saving to ${storage}.';

	/// en: 'Reconnect to $storage'
	String reconnectTitle({required Object storage}) => 'Reconnect to ${storage}';

	/// en: 'You can keep reading; changes are saved once you are back.'
	String get keepReading => 'You can keep reading; changes are saved once you are back.';

	/// en: 'Reconnect'
	String get reconnect => 'Reconnect';

	/// en: 'Later'
	String get later => 'Later';

	/// en: 'You can keep reading and copying. Saving needs a connection to $storage.'
	String offlineBody({required Object storage}) => 'You can keep reading and copying. Saving needs a connection to ${storage}.';

	/// en: 'Your Vault Changed'
	String get changedTitle => 'Your Vault Changed';

	/// en: 'A newer version of your vault was saved from another device. Load it before you edit, so nothing gets overwritten.'
	String get changedBody => 'A newer version of your vault was saved from another device. Load it before you edit, so nothing gets overwritten.';

	/// en: 'Two versions'
	String get twoVersions => 'Two versions';

	/// en: 'On this phone'
	String get onThisPhone => 'On this phone';

	/// en: 'In $storage'
	String inStorage({required Object storage}) => 'In ${storage}';

	/// en: 'loaded $time'
	String loadedAt({required Object time}) => 'loaded ${time}';

	/// en: 'saved $time · newer'
	String savedNewer({required Object time}) => 'saved ${time} · newer';

	/// en: 'Load the latest version'
	String get loadLatest => 'Load the latest version';

	/// en: 'Not now'
	String get notNow => 'Not now';

	/// en: 'Until then you can read and copy, but not edit.'
	String get pausedNote => 'Until then you can read and copy, but not edit.';

	/// en: 'Up to date'
	String get upToDate => 'Up to date';

	/// en: 'Loaded the version saved at $time'
	String loadedVersion({required Object time}) => 'Loaded the version saved at ${time}';
}

// Path: scan
class Translations$scan$en {
	Translations$scan$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Scan QR Code'
	String get title => 'Scan QR Code';

	/// en: 'Add a 2FA code by scanning'
	String get primerTitle => 'Add a 2FA code by scanning';

	/// en: 'When a site turns on two-factor sign-in, it shows a QR code. KeeperPass reads it with the camera and keeps the setup key in your vault, so its codes appear in Codes.'
	String get primerBody => 'When a site turns on two-factor sign-in, it shows a QR code. KeeperPass reads it with the camera and keeps the setup key in your vault, so its codes appear in Codes.';

	/// en: 'The camera only reads the code. Nothing is recorded, and no image is kept.'
	String get primerPrivacy => 'The camera only reads the code. Nothing is recorded, and no image is kept.';

	/// en: 'Your phone asks for camera access next.'
	String get primerNext => 'Your phone asks for camera access next.';

	/// en: 'Enter setup key instead'
	String get enterInstead => 'Enter setup key instead';

	/// en: 'Point at the QR code the website shows when you turn on two-factor sign-in.'
	String get hint => 'Point at the QR code the website shows\nwhen you turn on two-factor sign-in.';

	/// en: 'Turn on the light'
	String get torch => 'Turn on the light';

	/// en: 'Camera view'
	String get cameraView => 'Camera view';

	/// en: 'Code Found'
	String get codeFound => 'Code Found';

	/// en: 'Save it to'
	String get saveTo => 'Save it to';

	/// en: 'Existing item'
	String get existingItem => 'Existing item';

	/// en: 'Existing item · $summary'
	String existingItemWith({required Object summary}) => 'Existing item · ${summary}';

	/// en: 'New Authenticator item'
	String get newAuthenticator => 'New Authenticator item';

	/// en: 'Named $name'
	String named({required Object name}) => 'Named ${name}';

	/// en: 'Camera access is off'
	String get cameraOffTitle => 'Camera access is off';

	/// en: 'KeeperPass needs the camera only to read QR codes. Turn it on in Settings, or type the setup key instead.'
	String get cameraOffBody => 'KeeperPass needs the camera only to read QR codes. Turn it on in Settings, or type the setup key instead.';

	/// en: 'Open Settings'
	String get openSettings => 'Open Settings';

	/// en: 'This code uses settings KeeperPass doesn’t support yet'
	String get unsupported => 'This code uses settings KeeperPass doesn’t support yet';

	/// en: 'This isn’t a 2FA QR code'
	String get notACode => 'This isn’t a 2FA QR code';

	/// en: 'The camera couldn’t start'
	String get cameraFailed => 'The camera couldn’t start';

	/// en: 'Item'
	String get item => 'Item';

	/// en: '6 digits · every 30 seconds · SHA-1'
	String get codeSettings => '6 digits · every 30 seconds · SHA-1';

	/// en: 'Code added to $name'
	String codeAdded({required Object name}) => 'Code added to ${name}';

	/// en: 'Tap the card to copy it.'
	String get tapToCopy => 'Tap the card to copy it.';
}

// Path: errors.failures
class Translations$errors$failures$en {
	Translations$errors$failures$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Something went wrong. Please try again.'
	String get networkFailure => 'Something went wrong. Please try again.';

	/// en: 'Something went wrong. Please try again.'
	String get undocumentedError => 'Something went wrong. Please try again.';

	/// en: 'Something went wrong. Please try again.'
	String get platformError => 'Something went wrong. Please try again.';

	/// en: 'Something went wrong. Please try again.'
	String get notFound => 'Something went wrong. Please try again.';

	/// en: 'Something went wrong. Please try again.'
	String get formatException => 'Something went wrong. Please try again.';

	/// en: 'Something went wrong. Please try again.'
	String get unableToProcess => 'Something went wrong. Please try again.';

	/// en: 'Something went wrong. Please try again.'
	String get requestTimeout => 'Something went wrong. Please try again.';

	/// en: 'Something went wrong. Please try again.'
	String get connectionError => 'Something went wrong. Please try again.';

	/// en: 'Something went wrong. Please try again.'
	String get unexpectedError => 'Something went wrong. Please try again.';

	/// en: 'Something went wrong. Please try again.'
	String get accessTokenFailure => 'Something went wrong. Please try again.';

	/// en: 'Something went wrong. Please try again.'
	String get cacheReadFailure => 'Something went wrong. Please try again.';

	/// en: 'Something went wrong. Please try again.'
	String get cacheWriteFailure => 'Something went wrong. Please try again.';
}

// Path: errors.drive
class Translations$errors$drive$en {
	Translations$errors$drive$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your Google session has expired. Please reconnect.'
	String get authExpired => 'Your Google session has expired. Please reconnect.';

	/// en: 'Could not back up your existing vault in Google Drive. Please try again.'
	String get backupFailed => 'Could not back up your existing vault in Google Drive. Please try again.';

	/// en: 'Could not rename your vault file in Google Drive. Nothing was changed — please try again.'
	String get renameFailed => 'Could not rename your vault file in Google Drive. Nothing was changed — please try again.';

	/// en: 'Could not create the keeperpass folder in Google Drive. Please try again.'
	String get createFolderFailed => 'Could not create the keeperpass folder in Google Drive. Please try again.';

	/// en: 'Could not read your vault from Google Drive. Please try again.'
	String get readFailed => 'Could not read your vault from Google Drive. Please try again.';

	/// en: 'Could not save your vault to Google Drive. Please try again.'
	String get saveFailed => 'Could not save your vault to Google Drive. Please try again.';

	/// en: 'Could not reach Google Drive. Please try again.'
	String get unreachable => 'Could not reach Google Drive. Please try again.';
}

// Path: errors.dropbox
class Translations$errors$dropbox$en {
	Translations$errors$dropbox$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your Dropbox session has expired. Please reconnect.'
	String get authExpired => 'Your Dropbox session has expired. Please reconnect.';

	/// en: 'Could not read your Dropbox profile. Please try again.'
	String get profileFailed => 'Could not read your Dropbox profile. Please try again.';

	/// en: 'Something went wrong while contacting Dropbox. Please try again.'
	String get unknown => 'Something went wrong while contacting Dropbox. Please try again.';

	/// en: 'Could not reach Dropbox. Please try again.'
	String get unreachable => 'Could not reach Dropbox. Please try again.';

	/// en: 'Could not read your vault from Dropbox. Please try again.'
	String get readFailed => 'Could not read your vault from Dropbox. Please try again.';

	/// en: 'Could not save your vault to Dropbox. Please try again.'
	String get saveFailed => 'Could not save your vault to Dropbox. Please try again.';

	/// en: 'Could not back up your existing vault in Dropbox. Please try again.'
	String get backupFailed => 'Could not back up your existing vault in Dropbox. Please try again.';

	/// en: 'Could not rename your vault file in Dropbox. Nothing was changed — please try again.'
	String get renameFailed => 'Could not rename your vault file in Dropbox. Nothing was changed — please try again.';

	/// en: 'KeeperPass is missing a Dropbox permission. This is a configuration problem, not something signing in again will fix.'
	String get missingScope => 'KeeperPass is missing a Dropbox permission. This is a configuration problem, not something signing in again will fix.';

	/// en: 'Dropbox is asking us to slow down. Please wait a moment and try again.'
	String get rateLimited => 'Dropbox is asking us to slow down. Please wait a moment and try again.';
}

// Path: errors.auth
class Translations$errors$auth$en {
	Translations$errors$auth$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Could not read your Google profile. Please try again.'
	String get profileFailed => 'Could not read your Google profile. Please try again.';

	/// en: 'Something went wrong while contacting Google. Please try again.'
	String get unknown => 'Something went wrong while contacting Google. Please try again.';
}

// Path: errors.masterPassword
class Translations$errors$masterPassword$en {
	Translations$errors$masterPassword$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Could not find your vault.'
	String get vaultNotFound => 'Could not find your vault.';
}

// Path: errors.vault
class Translations$errors$vault$en {
	Translations$errors$vault$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sign in with $email to save your changes.'
	String accountMismatch({required Object email}) => 'Sign in with ${email} to save your changes.';

	/// en: 'Google didn’t give KeeperPass access to the files it creates in your Drive. Try again, and allow that access on Google’s page.'
	String get driveAccessNotGranted => 'Google didn’t give KeeperPass access to the files it creates in your Drive. Try again, and allow that access on Google’s page.';

	/// en: 'A newer version of your vault was saved from another device. Load it before you edit, so nothing gets overwritten.'
	String get conflict => 'A newer version of your vault was saved from another device. Load it before you edit, so nothing gets overwritten.';

	/// en: 'Sign-in canceled'
	String get signInCanceled => 'Sign-in canceled';

	/// en: 'This vault file can’t be opened by this version of KeeperPass.'
	String get unsupported => 'This vault file can’t be opened by this version of KeeperPass.';

	/// en: 'Your vault file is damaged and can’t be opened.'
	String get corrupt => 'Your vault file is damaged and can’t be opened.';
}

// Path: settings.migrate
class Translations$settings$migrate$en {
	Translations$settings$migrate$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$settings$migrate$error$en error = Translations$settings$migrate$error$en.internal(_root);
}

// Path: auth.unlock
class Translations$auth$unlock$en {
	Translations$auth$unlock$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Incorrect secret. Please try again.'
	String get incorrectSecret => 'Incorrect secret. Please try again.';
}

// Path: editItem.templates
class Translations$editItem$templates$en {
	Translations$editItem$templates$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Website or App'
	String get website => 'Website or App';

	/// en: 'Computer'
	String get computer => 'Computer';

	/// en: 'Credit Card'
	String get creditCard => 'Credit Card';

	/// en: 'Bank Account'
	String get bankAccount => 'Bank Account';

	/// en: 'Wi-Fi Network'
	String get wifi => 'Wi-Fi Network';

	/// en: 'Passport'
	String get passport => 'Passport';

	/// en: 'Note'
	String get note => 'Note';

	/// en: 'Authenticator'
	String get authenticator => 'Authenticator';

	/// en: 'Custom'
	String get custom => 'Custom';
}

// Path: editItem.templateHints
class Translations$editItem$templateHints$en {
	Translations$editItem$templateHints$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Username, password, URL'
	String get website => 'Username, password, URL';

	/// en: 'Username, password'
	String get computer => 'Username, password';

	/// en: 'Number, holder, expiry, CVC, PIN'
	String get creditCard => 'Number, holder, expiry, CVC, PIN';

	/// en: 'Holder, IBAN, BIC, PIN'
	String get bankAccount => 'Holder, IBAN, BIC, PIN';

	/// en: 'Network name, password'
	String get wifi => 'Network name, password';

	/// en: 'Number, name, dates'
	String get passport => 'Number, name, dates';

	/// en: 'A formatted note'
	String get note => 'A formatted note';

	/// en: 'A 2FA code'
	String get authenticator => 'A 2FA code';

	/// en: 'No fields yet'
	String get custom => 'No fields yet';
}

// Path: editItem.templateFields
class Translations$editItem$templateFields$en {
	Translations$editItem$templateFields$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cardholder'
	String get cardholder => 'Cardholder';

	/// en: 'Expires On'
	String get expiresOn => 'Expires On';

	/// en: 'CVC'
	String get cvc => 'CVC';

	/// en: 'Account Holder'
	String get accountHolder => 'Account Holder';

	/// en: 'IBAN'
	String get iban => 'IBAN';

	/// en: 'BIC'
	String get bic => 'BIC';

	/// en: 'Card PIN'
	String get cardPin => 'Card PIN';

	/// en: 'Network Name'
	String get networkName => 'Network Name';

	/// en: 'Full Name'
	String get fullName => 'Full Name';

	/// en: 'Passport Number'
	String get passportNumber => 'Passport Number';

	/// en: 'Issuing Country'
	String get issuingCountry => 'Issuing Country';

	/// en: 'Date of Birth'
	String get dateOfBirth => 'Date of Birth';

	/// en: 'Place of Birth'
	String get placeOfBirth => 'Place of Birth';

	/// en: 'Issued On'
	String get issuedOn => 'Issued On';
}

// Path: editItem.types
class Translations$editItem$types$en {
	Translations$editItem$types$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Username'
	String get username => 'Username';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'URL'
	String get url => 'URL';

	/// en: 'IP / Host'
	String get ipHost => 'IP / Host';

	/// en: 'Date'
	String get date => 'Date';

	/// en: 'Month'
	String get month => 'Month';

	/// en: 'Card Number'
	String get credit => 'Card Number';

	/// en: 'Phone'
	String get phone => 'Phone';

	/// en: 'PIN'
	String get pin => 'PIN';

	/// en: 'Authenticator Code'
	String get totp => 'Authenticator Code';

	/// en: 'Certificate'
	String get certificate => 'Certificate';

	/// en: 'SSH / Private Key'
	String get sshKey => 'SSH / Private Key';

	/// en: 'Recovery Codes'
	String get recoveryCodes => 'Recovery Codes';

	/// en: 'Formatted Note'
	String get note => 'Formatted Note';

	/// en: 'Text'
	String get text => 'Text';
}

// Path: audit.weakPassword
class Translations$audit$weakPassword$en {
	Translations$audit$weakPassword$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Weak Passwords'
	String get label => 'Weak Passwords';

	/// en: 'A password is weak when the space an attacker has to search is small: it is short, it draws on a narrow set of characters, or it is built from a word, name or keyboard run that sits in every cracking dictionary. Offline guessing runs at billions of attempts per second, so anything in that class falls quickly. Replace it with a long, randomly generated one.'
	String get description => 'A password is weak when the space an attacker has to search is small: it is short, it draws on a narrow set of characters, or it is built from a word, name or keyboard run that sits in every cracking dictionary. Offline guessing runs at billions of attempts per second, so anything in that class falls quickly. Replace it with a long, randomly generated one.';
}

// Path: audit.reusedPassword
class Translations$audit$reusedPassword$en {
	Translations$audit$reusedPassword$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reused Passwords'
	String get label => 'Reused Passwords';

	/// en: 'One password used in several places means a single breach anywhere unlocks all of them — and you have no say in which of those services will be the one to leak. Give every item its own generated password so a leak stays contained to the account it came from.'
	String get description => 'One password used in several places means a single breach anywhere unlocks all of them — and you have no say in which of those services will be the one to leak. Give every item its own generated password so a leak stays contained to the account it came from.';
}

// Path: audit.compromisedPassword
class Translations$audit$compromisedPassword$en {
	Translations$audit$compromisedPassword$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Compromised Passwords'
	String get label => 'Compromised Passwords';

	/// en: 'This password appears in a public record of breached credentials, which puts it on the lists attackers try first no matter how strong it looks. Change it everywhere it is used: a password only has to leak once to stay leaked.'
	String get description => 'This password appears in a public record of breached credentials, which puts it on the lists attackers try first no matter how strong it looks. Change it everywhere it is used: a password only has to leak once to stay leaked.';
}

// Path: settings.migrate.error
class Translations$settings$migrate$error$en {
	Translations$settings$migrate$error$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'The vault is already in that storage.'
	String get sameProvider => 'The vault is already in that storage.';

	/// en: 'A save is still in progress. Wait for it to finish and try again.'
	String get busy => 'A save is still in progress. Wait for it to finish and try again.';

	/// en: 'Your current session expired. Please sign in again before moving the vault.'
	String get sourceExpired => 'Your current session expired. Please sign in again before moving the vault.';

	/// en: 'Your $provider sign-in expired. Nothing was changed — please start again.'
	String targetExpired({required Object provider}) => 'Your ${provider} sign-in expired. Nothing was changed — please start again.';

	/// en: 'The saved copy did not match your vault, so the old file was left untouched. Nothing was lost — please try again.'
	String get verifyFailed => 'The saved copy did not match your vault, so the old file was left untouched. Nothing was lost — please try again.';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'KeeperPass',
			'connectivity.offline' => 'No internet connection',
			'connectivity.online' => 'Back online',
			'errors.failures.networkFailure' => 'Something went wrong. Please try again.',
			'errors.failures.undocumentedError' => 'Something went wrong. Please try again.',
			'errors.failures.platformError' => 'Something went wrong. Please try again.',
			'errors.failures.notFound' => 'Something went wrong. Please try again.',
			'errors.failures.formatException' => 'Something went wrong. Please try again.',
			'errors.failures.unableToProcess' => 'Something went wrong. Please try again.',
			'errors.failures.requestTimeout' => 'Something went wrong. Please try again.',
			'errors.failures.connectionError' => 'Something went wrong. Please try again.',
			'errors.failures.unexpectedError' => 'Something went wrong. Please try again.',
			'errors.failures.accessTokenFailure' => 'Something went wrong. Please try again.',
			'errors.failures.cacheReadFailure' => 'Something went wrong. Please try again.',
			'errors.failures.cacheWriteFailure' => 'Something went wrong. Please try again.',
			'errors.drive.authExpired' => 'Your Google session has expired. Please reconnect.',
			'errors.drive.backupFailed' => 'Could not back up your existing vault in Google Drive. Please try again.',
			'errors.drive.renameFailed' => 'Could not rename your vault file in Google Drive. Nothing was changed — please try again.',
			'errors.drive.createFolderFailed' => 'Could not create the keeperpass folder in Google Drive. Please try again.',
			'errors.drive.readFailed' => 'Could not read your vault from Google Drive. Please try again.',
			'errors.drive.saveFailed' => 'Could not save your vault to Google Drive. Please try again.',
			'errors.drive.unreachable' => 'Could not reach Google Drive. Please try again.',
			'errors.dropbox.authExpired' => 'Your Dropbox session has expired. Please reconnect.',
			'errors.dropbox.profileFailed' => 'Could not read your Dropbox profile. Please try again.',
			'errors.dropbox.unknown' => 'Something went wrong while contacting Dropbox. Please try again.',
			'errors.dropbox.unreachable' => 'Could not reach Dropbox. Please try again.',
			'errors.dropbox.readFailed' => 'Could not read your vault from Dropbox. Please try again.',
			'errors.dropbox.saveFailed' => 'Could not save your vault to Dropbox. Please try again.',
			'errors.dropbox.backupFailed' => 'Could not back up your existing vault in Dropbox. Please try again.',
			'errors.dropbox.renameFailed' => 'Could not rename your vault file in Dropbox. Nothing was changed — please try again.',
			'errors.dropbox.missingScope' => 'KeeperPass is missing a Dropbox permission. This is a configuration problem, not something signing in again will fix.',
			'errors.dropbox.rateLimited' => 'Dropbox is asking us to slow down. Please wait a moment and try again.',
			'errors.auth.profileFailed' => 'Could not read your Google profile. Please try again.',
			'errors.auth.unknown' => 'Something went wrong while contacting Google. Please try again.',
			'errors.masterPassword.vaultNotFound' => 'Could not find your vault.',
			'errors.vault.accountMismatch' => ({required Object email}) => 'Sign in with ${email} to save your changes.',
			'errors.vault.driveAccessNotGranted' => 'Google didn’t give KeeperPass access to the files it creates in your Drive. Try again, and allow that access on Google’s page.',
			'errors.vault.conflict' => 'A newer version of your vault was saved from another device. Load it before you edit, so nothing gets overwritten.',
			'errors.vault.signInCanceled' => 'Sign-in canceled',
			'errors.vault.unsupported' => 'This vault file can’t be opened by this version of KeeperPass.',
			'errors.vault.corrupt' => 'Your vault file is damaged and can’t be opened.',
			'common.close' => 'Close',
			'common.copy' => 'Copy',
			'common.copied' => 'Copied',
			'common.cancel' => 'Cancel',
			'common.save' => 'Save',
			'common.back' => 'Back',
			'common.favorite' => 'Favorite',
			'common.showSecret' => 'Show secret',
			'common.hideSecret' => 'Hide secret',
			'common.empty' => '[empty]',
			'common.clearSearch' => 'Clear search',
			'common.chooseDate' => 'Choose a date',
			'common.chooseMonth' => 'Choose a month',
			'common.countryCode' => 'Country code',
			'common.countryCodeValue' => ({required Object country, required Object code}) => 'Country code: ${country}, ${code}',
			'common.removeTag' => ({required Object tag}) => 'Remove tag ${tag}',
			'common.secretChip' => 'Secret',
			'common.secretToggle' => ({required Object field}) => 'Secret: ${field}',
			'common.reorderField' => ({required Object field}) => 'Reorder ${field}',
			'common.removeField' => ({required Object field}) => 'Remove ${field}',
			'common.changeFieldIcon' => ({required Object field}) => 'Change the ${field} icon',
			'common.showAll' => ({required Object count}) => 'Show all ${count}',
			'common.showInLargeType' => 'Show in large type',
			'common.stepOf' => ({required Object current, required Object total}) => 'Step ${current} of ${total}',
			'common.next' => 'Next',
			'common.continueAction' => 'Continue',
			'common.tryAgain' => 'Try again',
			'common.retry' => 'Retry',
			'common.show' => 'Show',
			'common.hide' => 'Hide',
			'common.gotIt' => 'Got it',
			'common.disconnect' => 'Disconnect',
			'common.generateSecret' => 'Generate a secret',
			'common.useAnotherAccount' => 'Use another account',
			'common.offlineTitle' => 'You’re offline',
			'common.savingTo' => ({required Object provider}) => 'Saving to ${provider}…',
			'common.keepOpen' => 'Keep KeeperPass open until this finishes.',
			'common.typeItAgain' => 'Type it again',
			'common.secretHiddenValue' => 'Hidden',
			'common.rename' => 'Rename',
			'common.done' => 'Done',
			'strength.veryWeak' => 'Very weak',
			'strength.weak' => 'Weak',
			'strength.fair' => 'Fair',
			'strength.strong' => 'Strong',
			'strength.veryStrong' => 'Very strong',
			'strength.meter' => ({required Object level}) => 'Strength: ${level}',
			'totp.invalidCode' => 'Invalid code',
			'totp.invalidKey' => 'The setup key isn’t valid, so no code can be made.',
			'totp.fixInEdit' => 'Fix it in Edit',
			'totp.secondsShort' => ({required Object count}) => '${count} s',
			'totp.secondsLeft' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: '${count} second left', other: '${count} seconds left', ), 
			'settings.migrate.error.sameProvider' => 'The vault is already in that storage.',
			'settings.migrate.error.busy' => 'A save is still in progress. Wait for it to finish and try again.',
			'settings.migrate.error.sourceExpired' => 'Your current session expired. Please sign in again before moving the vault.',
			'settings.migrate.error.targetExpired' => ({required Object provider}) => 'Your ${provider} sign-in expired. Nothing was changed — please start again.',
			'settings.migrate.error.verifyFailed' => 'The saved copy did not match your vault, so the old file was left untouched. Nothing was lost — please try again.',
			'settings.title' => 'Settings',
			'settings.subtitle' => 'Account, language, security and data',
			'settings.account' => 'Account',
			'settings.accountLine' => ({required Object email, required Object storage}) => '${email} · ${storage}',
			'settings.accountNote' => 'Name and email are taken from the account you signed in with.',
			'settings.logOut' => 'Log out',
			'settings.logOutTitle' => 'Log out?',
			'settings.logOutBody' => ({required Object storage, required Object provider}) => 'Your vault stays in your ${storage}, encrypted. To open it again, sign in with ${provider} and enter your secret.',
			'settings.security' => 'Security',
			'settings.lockNow' => 'Lock now',
			'settings.autoLock' => 'Auto-lock',
			'settings.clearClipboard' => 'Clear clipboard',
			'settings.hideInSwitcher' => 'Hide in app switcher',
			'settings.hideInSwitcherNote' => 'Shows a cover instead of your vault',
			'settings.changeSecret' => 'Change secret',
			'settings.securityNote' => 'Locking wipes the decrypted vault from this phone’s memory.',
			'settings.appearance' => 'Appearance',
			'settings.theme' => 'Theme',
			'settings.themeAuto' => 'Auto',
			'settings.themeLight' => 'Light',
			'settings.themeDark' => 'Dark',
			'settings.language' => 'Language',
			'settings.storage' => 'Storage',
			'settings.whereItLives' => 'Where your vault lives',
			'settings.moveTo' => ({required Object storage}) => 'Move vault to ${storage}',
			'settings.data' => 'Data',
			'settings.importCsv' => 'Import CSV',
			'settings.exportCsv' => 'Export CSV',
			'settings.recentExports' => 'Recent exports',
			'settings.help' => 'Help',
			'settings.howItWorks' => 'How KeeperPass works',
			'settings.questions' => 'Questions',
			'settings.about' => 'About KeeperPass',
			'settings.dangerZone' => 'Danger zone',
			'settings.archive' => 'Archive vault and sign out',
			'settings.archiveNote' => 'Renames your vault file and signs you out. Nothing is erased.',
			'settings.footer' => ({required Object version}) => 'KeeperPass ${version} · Free and open source under AGPL-3.0',
			'settings.autoLockTitle' => 'Auto-lock',
			'settings.autoLockImmediately' => 'Immediately on leaving the app',
			'settings.autoLockImmediatelyShort' => 'Immediately',
			'settings.after1Minute' => 'After 1 minute',
			'settings.after5Minutes' => 'After 5 minutes',
			'settings.after10Minutes' => 'After 10 minutes',
			'settings.autoLockNote' => 'KeeperPass locks after this long without use. Unlocking again needs your secret.',
			'settings.clearClipboardTitle' => 'Clear Clipboard',
			'settings.after30Seconds' => 'After 30 seconds',
			'settings.after2Minutes' => 'After 2 minutes',
			'settings.never' => 'Never',
			'settings.after30s' => 'After 30 s',
			'settings.after1Min' => 'After 1 min',
			'settings.after2Min' => 'After 2 min',
			'settings.clipboardNote' => 'Passwords and codes you copy are cleared from the clipboard after this long, if nothing else was copied since.',
			'settings.preview' => 'Preview',
			'settings.previewFrom' => 'From GitHub',
			'settings.previewClears' => ({required Object time}) => 'From GitHub · Clears in ${time}',
			'settings.seconds' => ({required Object n}) => '${n} s',
			'settings.minutes' => ({required Object n}) => '${n} min',
			'settings.languageTitle' => 'Language',
			'settings.languageNote' => 'Saved on this phone only — it is not part of your vault.',
			'settings.hideInSwitcherBlocks' => 'Shows a cover instead of your vault, and blocks screenshots',
			'settings.blockScreenshots' => 'Block screenshots',
			'settings.blockScreenshotsNote' => 'Android only · also blocks screen recording',
			'settings.blockScreenshotsWhileHidden' => 'On while “Hide in app switcher” is on',
			'auth.unlock.incorrectSecret' => 'Incorrect secret. Please try again.',
			'vaults.defaultName' => 'My Vault',
			'welcome.howItWorks' => 'How it works',
			'welcome.badge' => 'End-to-end encrypted',
			'welcome.title' => 'Welcome to KeeperPass',
			'welcome.description' => 'Your vault is a single encrypted file in your own cloud storage. Sign in to open it.',
			'welcome.fileTag' => 'What your storage sees',
			'welcome.fileMeta' => 'Argon2id · AES-256-GCM',
			'welcome.continueWithGoogle' => 'Continue with Google',
			'welcome.continueWithDropbox' => 'Continue with Dropbox',
			'welcome.connecting' => ({required Object provider}) => 'Connecting to ${provider}…',
			'welcome.factAccess' => 'Access only to the files KeeperPass creates',
			'welcome.factEncrypted' => 'Encrypted on this phone, with your own secret',
			'welcome.factNoServer' => 'No KeeperPass server. Nothing goes anywhere else.',
			'welcome.footer' => 'No KeeperPass account — just the Google or Dropbox one you already have. Signing in creates the vault file if you don’t have one yet.',
			'connect.lookingIn' => ({required Object storage}) => 'Looking in ${storage}…',
			'connect.checkingTitle' => 'Checking your vault…',
			'connect.checkingDetail' => ({required Object storage}) => 'Looking for vault.json.enc in ${storage}.',
			'connect.foundTitle' => 'Found your vault',
			'connect.foundDetail' => 'Opening Unlock…',
			'connect.foundMeta' => ({required Object storage}) => 'Found in ${storage}',
			'connect.foundMetaUpdated' => ({required Object storage, required Object time}) => 'Found in ${storage} · updated ${time}',
			'connect.canceledDetail' => 'Nothing was connected.',
			'connect.signInFailed' => 'Sign-in failed',
			'connect.offlineDetail' => 'Signing in needs a connection to Google or Dropbox. This updates by itself when you’re back online.',
			'connect.welcomeBack' => 'Welcome Back,',
			'connect.expiredDetail' => ({required Object provider}) => 'Your ${provider} session has expired. Sign in again to unlock your vault.',
			'connect.lastUsed' => 'Last used',
			'connect.checkFailedMeta' => ({required Object storage}) => 'Couldn’t read it from ${storage}',
			'connect.checkFailedTitle' => 'Could not read your vault',
			'connect.checkFailedDetail' => ({required Object storage}) => '${storage} didn’t respond. Nothing was changed.',
			'howItWorks.step1Title' => 'Your vault lives\nin your cloud',
			'howItWorks.step1Body' => 'KeeperPass saves one encrypted file to your Google Drive or Dropbox. There’s no KeeperPass server, so we never get a copy.',
			'howItWorks.encrypted' => 'Encrypted',
			'howItWorks.step2Title' => 'Choose a secret',
			'howItWorks.step2Body' => 'It becomes the key. Never sent, never stored.',
			'howItWorks.step3Title' => 'It takes both',
			'howItWorks.step3Body' => 'Someone with your storage account can’t read your vault. Someone with your secret can’t reach it.',
			'howItWorks.storageAccount' => 'Storage account',
			'howItWorks.reachesFile' => 'Reaches the file',
			'howItWorks.yourSecret' => 'Your secret',
			'howItWorks.opensFile' => 'Opens the file',
			'howItWorks.technicalDetails' => 'Technical details',
			'howItWorks.technicalSummary' => 'Argon2id · AES-256',
			'technicalDetails.title' => 'Technical Details',
			'technicalDetails.keyDerivation' => 'Key derivation',
			'technicalDetails.keyDerivationValue' => ({required InlineSpan algorithm}) => TextSpan(children: [ algorithm, const TextSpan(text: ' · 64 MiB memory · 3 iterations · parallelism 4, making a 256-bit key'), ]), 
			'technicalDetails.encryption' => 'Encryption',
			'technicalDetails.encryptionValue' => ({required InlineSpan algorithm}) => TextSpan(children: [ algorithm, const TextSpan(text: ', which also detects any change to the file'), ]), 
			'technicalDetails.googleDrive' => 'Google Drive',
			'technicalDetails.googleDriveValue' => ({required InlineSpan scope}) => TextSpan(children: [ const TextSpan(text: 'The '), scope, const TextSpan(text: ' scope: only files KeeperPass created'), ]), 
			'technicalDetails.dropbox' => 'Dropbox',
			'technicalDetails.dropboxValue' => ({required InlineSpan folder}) => TextSpan(children: [ const TextSpan(text: 'An app folder: '), folder, ]), 
			'technicalDetails.vaultFile' => 'Vault file',
			'technicalDetails.vaultFileValue' => ({required InlineSpan file}) => TextSpan(children: [ file, const TextSpan(text: ' — one file, re-encrypted and rewritten on every save'), ]), 
			'technicalDetails.viewSource' => 'View source on GitHub',
			'technicalDetails.license' => 'Free and open source under AGPL-3.0, so all of this can be checked.',
			'createVault.eyebrow' => 'Create your vault',
			'createVault.step1Title' => 'Choose Your Secret',
			'createVault.step1Body' => 'It encrypts your vault on this phone. Everything you save is locked with it.',
			'createVault.settingUpFor' => 'Setting up for',
			'createVault.secret' => 'Secret',
			'createVault.secretPlaceholder' => 'Your secret',
			'createVault.generateAnother' => 'Generate another',
			'createVault.generatedNote' => 'Generated secrets skip the retype step.',
			'createVault.weakWarning' => 'This secret is weak, which makes the encryption around your vault easier to break. You can continue, but a longer passphrase is strongly recommended.',
			'createVault.tipsTitle' => 'Choosing a good secret',
			'createVault.tip1' => 'Several random words beat one clever word: the longer it is, the harder it is to guess.',
			'createVault.tip2' => 'Don’t reuse a password you use anywhere else.',
			'createVault.tip3' => 'Make it something you can type on this phone, then write it down and keep it somewhere safe.',
			'createVault.step2Title' => 'Type It Again',
			'createVault.step2Body' => 'Just to be sure there’s no typo. Nobody can reset your secret later.',
			'createVault.repeat' => 'Repeat secret',
			'createVault.mismatch' => 'The two secrets do not match.',
			'createVault.step3Title' => 'Write It Down',
			'createVault.step3Body' => 'You’ll need it every time you unlock. Keep it somewhere safe, away from this phone.',
			'createVault.secretWords' => ({required Object count}) => 'Your secret · ${count} words',
			'createVault.secretWhole' => 'Your secret',
			'createVault.secretHidden' => 'Your secret, hidden',
			'createVault.secretShown' => 'Your secret, shown',
			'createVault.readBefore' => 'Please read this before you continue',
			'createVault.bullet1' => 'Your secret is never sent anywhere and never stored. Nobody — not KeeperPass, not your storage provider — can look it up or reset it.',
			'createVault.bullet2' => 'If you forget it, your vault can’t be recovered. No reset link or support request can open it.',
			'createVault.bullet3' => 'Write it down and keep it somewhere safe before you continue.',
			'createVault.acknowledge' => 'I’ve written my secret down',
			'createVault.create' => 'Create vault',
			'createVault.progressTitle' => 'Creating your vault',
			'createVault.encrypting' => 'Encrypting your vault…',
			'createVault.encryptingDetail' => 'On this phone. This takes a few seconds.',
			'createVault.encryptingMeta' => 'Encrypting on this phone…',
			'createVault.savingDetail' => 'One encrypted file, in the keeperpass folder.',
			'createVault.failedTitle' => 'Could not save your vault',
			'createVault.notSaved' => 'Not saved',
			'createVault.failedDetail' => ({required Object storage}) => '${storage} didn’t respond. Nothing was saved, and your secret is still here.',
			'createVault.backToSecret' => 'Back to your secret',
			'unlock.notYou' => 'Not you?',
			'unlock.secret' => 'Secret',
			'unlock.placeholder' => 'Enter your secret',
			'unlock.unlock' => 'Unlock',
			'unlock.unlocking' => 'Unlocking…',
			'unlock.unlockingStatus' => 'Unlocking on this phone…',
			'unlock.slowNote' => 'A few seconds, on purpose: it makes guessing your secret slow.',
			'unlock.forgot' => 'Forgot your secret?',
			'unlock.leftApp' => 'Locked when you left KeeperPass',
			'unlock.unreachableTitle' => ({required Object storage}) => 'Could not reach ${storage}',
			'unlock.unreachableDetail' => 'Check your connection and try again. Your secret is still filled in.',
			'unlock.offlineDetail' => ({required Object storage}) => 'Unlocking needs a connection to ${storage}. Unlock wakes up when you’re back online.',
			'unlock.accountLine' => ({required Object email, required Object storage}) => '${email} · ${storage}',
			'unlock.lockedInactivity' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Locked after ${n} minute of inactivity', other: 'Locked after ${n} minutes of inactivity', ), 
			'newVault.backLabel' => 'Unlock',
			'newVault.backToUnlock' => 'Back to unlock',
			'newVault.title' => 'Start a New Vault',
			'newVault.oldMeta' => 'Old vault · locked under the old secret',
			'newVault.newMeta' => 'New vault · empty',
			'newVault.body' => ({required Object provider}) => 'There’s no way to reset a forgotten secret — not by KeeperPass, and not by ${provider}. You can start again with a new, empty vault instead.',
			'newVault.pointLocked' => 'Your current vault stays locked under the old secret.',
			'newVault.pointKept' => ({required InlineSpan file, required InlineSpan storage}) => TextSpan(children: [ const TextSpan(text: 'Its file is kept as '), file, const TextSpan(text: ' in your '), storage, const TextSpan(text: '. Nothing is deleted.'), ]), 
			'newVault.pointFresh' => 'You start again with a brand-new, empty vault.',
			'newVault.account' => 'Account',
			'newVault.newSecret' => 'New secret',
			'newVault.newSecretPlaceholder' => 'Choose a new secret',
			'newVault.repeat' => 'Repeat new secret',
			'newVault.weakWarning' => 'This secret is weak, which makes the encryption around your vaults easier to break. You can continue, but a longer passphrase is strongly recommended.',
			'newVault.warn' => 'Like the old one, your new secret can’t be looked up or reset. Write it down before you continue.',
			'newVault.start' => 'Start a new vault',
			'newVault.confirmTitle' => 'Start a New Vault?',
			'newVault.confirmKept' => ({required Object storage}) => 'Its file is kept as a dated backup in your ${storage}.',
			'newVault.confirmFresh' => 'You start again with an empty vault under your new secret.',
			'newVault.progressTitle' => 'Starting a new vault',
			'newVault.encrypting' => 'Encrypting your new vault…',
			'newVault.backingUp' => 'Keeping your old vault as a backup…',
			'newVault.backingUpDetail' => ({required Object storage}) => 'Renaming it in ${storage}.',
			'newVault.readyMeta' => 'Encrypted · ready to save',
			'newVault.backupFailedMeta' => 'Couldn’t rename it · nothing changed',
			'newVault.nothingChanged' => 'Nothing was changed',
			'newVault.backupFailedDetail' => ({required Object storage}) => 'Could not back up your existing vault in ${storage}. Nothing was changed.',
			'newVault.doneTitle' => 'New vault started',
			'newVault.doneDetail' => ({required Object storage}) => 'Your old vault is kept as a backup in ${storage}.',
			'tabs.vault' => 'Vault',
			'tabs.codes' => 'Codes',
			'tabs.generator' => 'Generator',
			'tabs.security' => 'Security',
			'tabs.settings' => 'Settings',
			'tabs.securityFlagged' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Security, ${n} item flagged', other: 'Security, ${n} items flagged', ), 
			'codes.subtitle' => '2FA codes from your vault, made on this phone',
			'codes.searchPlaceholder' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Search ${n} code', other: 'Search ${n} codes', ), 
			'codes.codeCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} code', other: '${n} codes', ), 
			'codes.copied' => 'Code copied',
			'codes.trust' => 'Made on this phone from the setup keys in your vault. Nothing new is stored.',
			'codes.emptyTitle' => 'No 2FA codes yet',
			'codes.emptyBody' => 'When a site offers two-factor sign-in, scan its QR code here, or add an Authenticator item.',
			'codes.createAuthenticator' => 'Create an Authenticator item',
			'comingSoon.body' => ({required Object part}) => 'Coming in Part ${part}.',
			'vaultList.lock' => 'Lock',
			'vaultList.newItem' => 'New item',
			'vaultList.allVaults' => 'All Vaults',
			'vaultList.favorites' => 'Favorites',
			'vaultList.recentlyUsed' => 'Recently Used',
			'vaultList.statusSaved' => ({required Object items, required Object storage}) => '${items} · Saved to ${storage}',
			'vaultList.statusInVault' => ({required Object items, required Object vault}) => '${items} in ${vault}',
			'vaultList.statusTagged' => ({required Object items, required Object tag}) => '${items} tagged ${tag}',
			'vaultList.statusReport' => ({required Object items, required Object report}) => '${items} · ${report}',
			'vaultList.statusNotConnected' => ({required Object storage}) => 'Not connected to ${storage}',
			'vaultList.statusOffline' => ({required Object items}) => 'Offline · ${items}',
			'vaultList.reportWeak' => 'Weak passwords',
			'vaultList.reportReused' => 'Reused passwords',
			'vaultList.reportCompromised' => 'Compromised passwords',
			'vaultList.searchHint' => 'Every word has to match, in any order: names, tags, field names and values.',
			'vaultList.filterByTag' => 'Filter by tag',
			'vaultList.manageTags' => 'Manage tags',
			'vaultList.clearFilter' => 'Clear filter',
			'vaultList.today' => 'Today',
			'vaultList.thisWeek' => 'This week',
			'vaultList.earlier' => 'Earlier',
			'vaultList.aToZ' => 'A to Z',
			'vaultList.sortHeading' => 'Sort by last update',
			'vaultList.newestFirst' => 'Newest first',
			'vaultList.oldestFirst' => 'Oldest first',
			'vaultList.refreshing' => ({required Object storage}) => 'Reading your vault from ${storage}…',
			'vaultList.copyPasswordFor' => ({required Object name}) => 'Copy password for ${name}',
			'vaultList.copyCodeFor' => ({required Object name}) => 'Copy code for ${name}',
			'vaultList.copyCardNumberFor' => ({required Object name}) => 'Copy card number for ${name}',
			'vaultList.swipePassword' => 'Password',
			'vaultList.swipeCode' => 'Code',
			'vaultList.swipeCardNumber' => 'Card number',
			'vaultList.swipeUsername' => 'Username',
			'vaultList.swipeMore' => 'More',
			'vaultList.copyPassword' => 'Copy password',
			'vaultList.copyCode' => 'Copy code',
			'vaultList.copyCardNumber' => 'Copy card number',
			'vaultList.copyUsername' => 'Copy username',
			'vaultList.moreActions' => 'More actions',
			'vaultList.favorite' => 'Favorite',
			'vaultList.addToFavorites' => 'Add to favorites',
			'vaultList.removeFromFavorites' => 'Remove from favorites',
			'vaultList.findingWeak' => 'Weak password',
			'vaultList.findingReused' => 'Reused password',
			'vaultList.findingCompromised' => 'Compromised password',
			'vaultList.findingWeakReused' => 'Weak and reused password',
			'vaultList.findingWeakCompromised' => 'Weak and compromised password',
			'vaultList.findingReusedCompromised' => 'Reused and compromised password',
			'vaultList.findingAll' => 'Weak, reused and compromised password',
			'vaultList.unnamed' => 'New Item',
			'vaultList.scopeTitle' => 'Vaults',
			'vaultList.manageVaults' => 'Manage vaults',
			'vaultList.scopeNote' => ({required Object storage}) => 'All your vaults live in one encrypted file, vault.json.enc, in your ${storage}.',
			'vaultList.quickActions' => ({required Object name}) => '${name}, quick actions',
			'vaultList.openWebsite' => 'Open website',
			'vaultList.moveToVault' => 'Move to vault…',
			'vaultList.select' => 'Select',
			'vaultList.delete' => 'Delete',
			'vaultList.selectAll' => 'Select All',
			'vaultList.selectOrDeselectAll' => 'Select or deselect all',
			'vaultList.listTwo' => ({required Object a, required Object b}) => '${a} and ${b}',
			'vaultList.listThree' => ({required Object a, required Object b, required Object c}) => '${a}, ${b} and ${c}',
			'vaultList.deleteItemTitle' => 'Delete Item',
			'vaultList.deleteItemConfirm' => ({required Object name}) => 'Are you sure you want to delete ‘${name}’? This cannot be undone.',
			'vaultList.deleteItemAction' => 'Delete item',
			'vaultList.moveToVaultTitle' => 'Move to Vault',
			'vaultList.moveDescription' => 'Pick the vault this item should live in.',
			'vaultList.current' => 'Current',
			'vaultList.newVaultOption' => 'New vault…',
			'vaultList.noOtherVaultOne' => 'There is no other vault to move this item to.',
			'vaultList.noOtherVaultMany' => 'There is no other vault to move these items to.',
			'vaultList.noOtherVaultDetail' => 'A second vault keeps a set of items apart — work from personal, or shared from private.',
			'vaultList.createAVault' => 'Create a vault',
			'vaultList.newVaultTitle' => 'New Vault',
			'vaultList.newVaultBody' => 'A vault is a separate group of items. Unlike an item, there is nothing else to choose up front.',
			'vaultList.vaultName' => 'Vault name',
			'vaultList.duplicateVault' => 'A vault with this name already exists.',
			'vaultList.noItemsTitle' => 'You don’t have any items yet.',
			'vaultList.noItemsBody' => 'Add your first login, card or note. Each one is encrypted on this phone before it is saved.',
			'vaultList.importCsv' => 'Import from CSV',
			'vaultList.vaultReady' => 'Your vault is ready. Nothing in it yet.',
			'vaultList.savedMeta' => ({required Object storage, required Object items}) => 'Saved to ${storage} · ${items}',
			'vaultList.vaultEmptyTitle' => 'This vault does not have any items yet.',
			'vaultList.vaultEmptyBody' => ({required Object vault}) => 'Add one here, or move items in from ${vault}.',
			'vaultList.noFavoritesTitle' => 'You don’t have any favorites yet.',
			'vaultList.noFavoritesBody' => 'Tap the star on any item to keep it here.',
			'vaultList.nothingRecentTitle' => 'Nothing used yet',
			'vaultList.nothingRecentBody' => 'Items you open or copy from show up here, most recent first.',
			'vaultList.noResultsTitle' => 'Your search did not match any items.',
			'vaultList.noResultsBody' => 'Every word has to match. Try fewer words, or check the spelling.',
			'vaultList.allClearWeak' => 'Every password in your vault is strong enough.',
			'vaultList.allClearReused' => 'Every password in your vault is used exactly once.',
			'vaultList.allClearCompromised' => 'None of your passwords turned up in a known breach.',
			'vaultList.allClearBody' => 'Nothing to fix here. KeeperPass checks again whenever a password changes.',
			'vaultList.backToSecurity' => 'Back to Security',
			'vaultList.fieldCopied' => ({required Object field}) => '${field} copied',
			'vaultList.copiedFrom' => ({required Object item}) => 'From ${item}',
			'vaultList.itemCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} item', other: '${n} items', ), 
			'vaultList.statusNotSaved' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} change not saved', other: '${n} changes not saved', ), 
			'vaultList.searchPlaceholder' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Search ${n} item', other: 'Search ${n} items', ), 
			'vaultList.results' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} result', other: '${n} results', ), 
			'vaultList.selectedCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} selected', other: '${n} selected', ), 
			'vaultList.moveItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Move ${n} item', other: 'Move ${n} items', ), 
			'vaultList.moveItemsTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Move ${n} Item', other: 'Move ${n} Items', ), 
			'vaultList.deleteItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Delete ${n} item', other: 'Delete ${n} items', ), 
			'vaultList.deleteTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Delete ${n} item?', other: 'Delete ${n} items?', ), 
			'vaultList.deleteFromVault' => ({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${names} will be deleted from ${vault}. This cannot be undone.', other: '${names} will be deleted from ${vault}. This cannot be undone.', ), 
			'vaultList.deleteFromVaults' => ({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${names} will be deleted. This cannot be undone.', other: '${names} will be deleted. This cannot be undone.', ), 
			'vaultList.moveLine' => ({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${names} moves with its history and tags.', other: '${names} move with their history and tags.', ), 
			'vaultList.movedTitle' => ({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Moved ${names} to ${vault}', other: 'Moved ${names} to ${vault}', ), 
			'vaultList.movedDetail' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'It keeps its history and tags.', other: 'They keep their history and tags.', ), 
			'vaultList.itemsOf' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${count} of ${n} item', other: '${count} of ${n} items', ), 
			'itemDetail.edit' => 'Edit',
			'itemDetail.editItem' => 'Edit item',
			'itemDetail.moreOptions' => 'More options',
			'itemDetail.updatedAgo' => ({required Object ago}) => 'Updated ${ago}',
			'itemDetail.showTagged' => ({required Object tag}) => 'Show items tagged ${tag}',
			'itemDetail.fields' => 'Fields',
			'itemDetail.noFields' => 'This item has no fields.',
			'itemDetail.history' => 'History',
			'itemDetail.currentVersion' => 'Current Version',
			'itemDetail.todayAt' => ({required Object time}) => 'Today, ${time}',
			'itemDetail.unnamedField' => 'Unnamed',
			'itemDetail.copyField' => ({required Object field}) => 'Copy ${field}',
			'itemDetail.revealValue' => 'Reveal value',
			'itemDetail.hideValue' => 'Hide value',
			'itemDetail.hiddenValue' => ({required Object field}) => '${field}, hidden',
			'itemDetail.openSite' => ({required Object site}) => 'Open ${site}',
			'itemDetail.call' => 'Call',
			'itemDetail.message' => 'Message',
			'itemDetail.checksumFail' => 'That number fails its checksum — one of the digits is probably wrong.',
			'itemDetail.codeCardHint' => 'Tap to copy · also on the Codes tab',
			'itemDetail.copyAllCodes' => 'Copy all codes',
			'itemDetail.copyCodeNumber' => ({required Object n}) => 'Copy code ${n}',
			'itemDetail.cardFace' => 'Card, number hidden',
			'itemDetail.cardFaceBrand' => ({required Object brand}) => '${brand} card, number hidden',
			'itemDetail.cardExpires' => ({required Object date}) => 'expires ${date}',
			'itemDetail.largeTypeTurn' => 'Turn your phone sideways to read it in one line.',
			'itemDetail.largeTypeHides' => 'It hides again when you leave this screen.',
			'itemDetail.earlierVersion' => 'Earlier Version',
			'itemDetail.readOnly' => ({required Object ago}) => '${ago} · read-only',
			'itemDetail.changedSince' => 'Changed since',
			'itemDetail.restoreThisVersion' => 'Restore this version',
			'itemDetail.deleteVersion' => 'Delete version',
			'itemDetail.restoreTitle' => 'Restore this version?',
			'itemDetail.restoreBody' => ({required Object name, required Object date}) => '${name} goes back to how it was on ${date}. The current version stays in its history.',
			'itemDetail.restore' => 'Restore',
			'itemDetail.deleteVersionTitle' => 'Delete This Version',
			'itemDetail.deleteVersionConfirm' => 'Are you sure you want to delete this version from the history? This cannot be undone.',
			'itemDetail.delete' => 'Delete',
			'itemDetail.notFound' => 'This item no longer exists.',
			'itemDetail.notFoundHint' => 'It may have been deleted from another device.',
			'itemDetail.backToVault' => 'Back to vault',
			'itemDetail.hiddenLines' => ({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${field}, hidden, ${n} line', other: '${field}, hidden, ${n} lines', ), 
			'itemDetail.largeTypeLabel' => ({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${field} shown in large type, ${n} character', other: '${field} shown in large type, ${n} characters', ), 
			'editItem.newVaultItem' => 'New Vault Item',
			'editItem.vault' => 'Vault',
			'editItem.template' => 'Template',
			'editItem.templateNote' => 'Templates are a head start: rename, remove or add fields at any time.',
			'editItem.templates.website' => 'Website or App',
			'editItem.templates.computer' => 'Computer',
			'editItem.templates.creditCard' => 'Credit Card',
			'editItem.templates.bankAccount' => 'Bank Account',
			'editItem.templates.wifi' => 'Wi-Fi Network',
			'editItem.templates.passport' => 'Passport',
			'editItem.templates.note' => 'Note',
			'editItem.templates.authenticator' => 'Authenticator',
			'editItem.templates.custom' => 'Custom',
			'editItem.templateHints.website' => 'Username, password, URL',
			'editItem.templateHints.computer' => 'Username, password',
			'editItem.templateHints.creditCard' => 'Number, holder, expiry, CVC, PIN',
			'editItem.templateHints.bankAccount' => 'Holder, IBAN, BIC, PIN',
			'editItem.templateHints.wifi' => 'Network name, password',
			'editItem.templateHints.passport' => 'Number, name, dates',
			'editItem.templateHints.note' => 'A formatted note',
			'editItem.templateHints.authenticator' => 'A 2FA code',
			'editItem.templateHints.custom' => 'No fields yet',
			'editItem.templateFields.cardholder' => 'Cardholder',
			'editItem.templateFields.expiresOn' => 'Expires On',
			'editItem.templateFields.cvc' => 'CVC',
			'editItem.templateFields.accountHolder' => 'Account Holder',
			'editItem.templateFields.iban' => 'IBAN',
			'editItem.templateFields.bic' => 'BIC',
			'editItem.templateFields.cardPin' => 'Card PIN',
			'editItem.templateFields.networkName' => 'Network Name',
			'editItem.templateFields.fullName' => 'Full Name',
			'editItem.templateFields.passportNumber' => 'Passport Number',
			'editItem.templateFields.issuingCountry' => 'Issuing Country',
			'editItem.templateFields.dateOfBirth' => 'Date of Birth',
			'editItem.templateFields.placeOfBirth' => 'Place of Birth',
			'editItem.templateFields.issuedOn' => 'Issued On',
			'editItem.types.username' => 'Username',
			'editItem.types.password' => 'Password',
			'editItem.types.email' => 'Email',
			'editItem.types.url' => 'URL',
			'editItem.types.ipHost' => 'IP / Host',
			'editItem.types.date' => 'Date',
			'editItem.types.month' => 'Month',
			_ => null,
		} ?? switch (path) {
			'editItem.types.credit' => 'Card Number',
			'editItem.types.phone' => 'Phone',
			'editItem.types.pin' => 'PIN',
			'editItem.types.totp' => 'Authenticator Code',
			'editItem.types.certificate' => 'Certificate',
			'editItem.types.sshKey' => 'SSH / Private Key',
			'editItem.types.recoveryCodes' => 'Recovery Codes',
			'editItem.types.note' => 'Formatted Note',
			'editItem.types.text' => 'Text',
			'editItem.newItem' => 'New Item',
			'editItem.editItem' => 'Edit Item',
			'editItem.changeIcon' => 'Change icon',
			'editItem.name' => 'Name',
			'editItem.namePlaceholder' => 'e.g. GitHub',
			'editItem.tags' => 'Tags',
			'editItem.addField' => 'Add field',
			'editItem.addFieldTitle' => 'Add Field',
			'editItem.noFieldsTitle' => 'No fields yet',
			'editItem.noFieldsBody' => 'Add any of the 16 field types — a policy number, a phone number, a PIN.',
			'editItem.fieldNamePlaceholder' => 'Field name',
			'editItem.addTag' => 'Add a tag',
			'editItem.tagSuggestions' => 'Tag suggestions',
			'editItem.createTag' => ({required Object name}) => 'Create ‘${name}’',
			'editItem.tagTooLong' => 'That name is too long.',
			'editItem.removeFieldTitle' => 'Are you sure you want to remove this field?',
			'editItem.removeFieldBody' => ({required Object field, required Object item}) => '“${field}” and its value leave ${item} when you save.',
			'editItem.remove' => 'Remove',
			'editItem.discardTitle' => 'Discard changes?',
			'editItem.discardBody' => ({required Object name}) => 'Your edits to ${name} have not been saved. Discarding keeps the item as it was.',
			'editItem.discardNewTitle' => 'Discard this new item?',
			'editItem.discardNewBody' => 'It has not been saved. Discarding throws it away.',
			'editItem.discard' => 'Discard',
			'editItem.usernamePlaceholder' => 'Username or email',
			'editItem.passwordPlaceholder' => 'Password',
			'editItem.valuePlaceholder' => 'Enter value here',
			'editItem.ipHostPlaceholder' => 'e.g. 192.168.1.1, ::1, or db.example.com',
			'editItem.recoveryCodesPlaceholder' => 'One per line — any format works',
			'editItem.notEmail' => 'That does not look like an email address.',
			'editItem.phoneNumber' => 'Phone number',
			'editItem.searchCountries' => 'Search countries',
			'editItem.noCountryMatch' => 'No country matches that.',
			'editItem.generate' => 'Generate',
			'editItem.generatePassword' => 'Generate a password',
			'editItem.currentCode' => 'Current code',
			'editItem.scanQr' => 'Scan QR code',
			'editItem.enterSetupKey' => 'Enter setup key',
			'editItem.setupKeyTitle' => 'Enter Setup Key',
			'editItem.setupKeyBody' => 'Sites show a setup key next to the QR code, often under “Can’t scan it?”.',
			'editItem.setupKey' => 'Setup key',
			'editItem.setupKeyHint' => 'Spaces and capitals don’t matter.',
			'editItem.saveCode' => 'Save code',
			'editItem.chooseIcon' => 'Choose Icon',
			'editItem.searchIcons' => 'Search icons — try ‘bank’ or ‘padlock’',
			'editItem.popular' => 'Popular',
			'editItem.noIcons' => ({required Object search}) => 'No icons match ‘${search}’.',
			'editItem.useDefaultIcon' => 'Use default icon',
			'editItem.iconMatches' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} match', other: '${n} matches', ), 
			'generator.title' => 'Generate a password',
			'generator.notFilledIn' => 'Nothing is filled in until you accept it.',
			'generator.generated' => 'Generated password',
			'generator.mode' => 'Mode',
			'generator.passphrase' => 'Passphrase',
			'generator.randomString' => 'Random string',
			'generator.words' => 'Words',
			'generator.fewerWords' => 'Fewer words',
			'generator.moreWords' => 'More words',
			'generator.length' => 'Length',
			'generator.shorter' => 'Shorter',
			'generator.longer' => 'Longer',
			'generator.wordSeparator' => 'Word separator',
			'generator.dash' => 'Dash',
			'generator.underscore' => 'Underscore',
			'generator.slash' => 'Slash',
			'generator.space' => 'Space',
			'generator.language' => 'Language',
			'generator.regenerate' => 'Regenerate',
			'generator.charCount' => ({required Object count}) => '${count} characters',
			'generator.lowercase' => 'Lowercase letters',
			'generator.uppercase' => 'Uppercase letters',
			'generator.digits' => 'Digits',
			'generator.symbols' => 'Symbols',
			'generator.pickOne' => 'Pick at least one kind of character.',
			'generator.use' => 'Use this password',
			'generator.wordCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} word', other: '${n} words', ), 
			'generator.pageTitle' => 'Password Generator',
			'generator.subtitle' => 'Random passwords and passphrases, made on this device',
			'generator.separatorDash' => 'Dash ( - )',
			'generator.separatorUnderscore' => 'Underscore ( _ )',
			'generator.separatorSlash' => 'Slash ( / )',
			'generator.separatorSpace' => 'Space',
			'generator.nothingToGenerate' => 'Nothing to generate.',
			'generator.copyPassword' => 'Copy password',
			'generator.copied' => 'Password copied',
			'generator.fromGenerator' => 'From the generator',
			'report.title' => 'Security Report',
			'report.subtitle' => 'How well your saved passwords hold up',
			'report.healthLabel' => 'Vault health',
			'report.healthGood' => 'Strong',
			'report.healthFair' => 'Needs work',
			'report.healthPoor' => 'At risk',
			'report.allClearTitle' => 'No problems found',
			'report.allClearDescription' => 'Every password in your vaults passed the last audit.',
			'report.aboutSection' => ({required Object title}) => 'About ${title}',
			'report.nothingFound' => 'Nothing found',
			'report.openItem' => ({required Object name}) => 'Open ${name}',
			'report.checkAgain' => 'Check again',
			'report.statWeak' => 'Weak',
			'report.statReused' => 'Reused',
			'report.statCompromised' => 'Compromised',
			'report.statValue' => ({required Object label, required Object count}) => '${label}: ${count}',
			'report.statNotChecked' => ({required Object label}) => '${label}: not checked yet',
			'report.healthPercent' => ({required Object title, required Object score}) => '${title} ${score} percent',
			'report.sameAs' => ({required Object names}) => 'Same as ${names}',
			'report.sameAsField' => 'Same as another password in this item',
			'report.foundInBreach' => 'Found in a known breach',
			'report.trust' => 'Breach checks use Have I Been Pwned with k-anonymity: only the first 5 characters of a SHA-1 hash ever leave this phone.',
			'report.lastCheckedJustNow' => 'Last checked just now',
			'report.lastCheckedToday' => ({required Object time}) => 'Last checked today at ${time}',
			'report.lastCheckedOn' => ({required Object date}) => 'Last checked ${date}',
			'report.checking' => 'Checking…',
			'report.checkingBreaches' => ({required Object done, required Object total}) => 'Checking for breaches · ${done} of ${total}',
			'report.progress' => ({required Object done, required Object total}) => '${done} of ${total}',
			'report.progressTime' => ({required Object done, required Object total, required Object time}) => '${done} of ${total} · ${time}',
			'report.offlineBody' => 'Your passwords could not be checked. The check needs a connection.',
			'report.failedTitle' => 'The check could not finish',
			'report.failedBody' => 'Try again in a moment.',
			'report.nothingTitle' => 'Nothing to check yet',
			'report.nothingBody' => 'Save an item with a password and it is checked here, on this phone, for weak, reused and breached passwords.',
			'report.howToFix' => 'How to fix it',
			'report.stepOpen' => 'Open the item',
			'report.stepGenerate' => 'Tap Edit, then Generate on the password',
			'report.stepSave' => 'Save — the finding clears by itself',
			'report.stepSaveCompromised' => 'Save, then change it on the site too',
			'report.changePassword' => 'Change password',
			'report.fixedClear' => ({required Object name}) => 'Saved · ${name} is no longer flagged',
			'report.fixedFlagged' => ({required Object name}) => 'Saved · ${name} is still flagged',
			'report.savedTo' => ({required Object storage}) => 'Your vault was saved to ${storage}',
			'report.noLongerWeak' => 'No longer weak',
			'report.noLongerReused' => 'No longer reused',
			'report.noLongerWeakOrReused' => 'No longer weak or reused',
			'report.hintReusedOne' => ({required Object n}) => 'These ${n} share one password. Give each its own: open one, tap Edit, then Generate.',
			'report.hintReusedSome' => 'Some of these share a password. Give each its own: open one, tap Edit, then Generate.',
			'report.hintWeak' => 'Give each a stronger one: open it, tap Edit, then Generate.',
			'report.hintCompromised' => 'These are in known breaches. Change each one: open it, tap Edit, then Generate.',
			'report.itemsChecked' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} item with a password checked', other: '${n} items with a password checked', ), 
			'report.flagged' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} item flagged', other: '${n} items flagged', ), 
			'report.sameAsOthers' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Same as ${n} other item', other: 'Same as ${n} other items', ), 
			'report.checkingPasswords' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Checking ${n} password', other: 'Checking ${n} passwords', ), 
			'report.aboutSeconds' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'about ${n} second', other: 'about ${n} seconds', ), 
			'report.aboutMinutes' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'about ${n} minute', other: 'about ${n} minutes', ), 
			'audit.weakPassword.label' => 'Weak Passwords',
			'audit.weakPassword.description' => 'A password is weak when the space an attacker has to search is small: it is short, it draws on a narrow set of characters, or it is built from a word, name or keyboard run that sits in every cracking dictionary. Offline guessing runs at billions of attempts per second, so anything in that class falls quickly. Replace it with a long, randomly generated one.',
			'audit.reusedPassword.label' => 'Reused Passwords',
			'audit.reusedPassword.description' => 'One password used in several places means a single breach anywhere unlocks all of them — and you have no say in which of those services will be the one to leak. Give every item its own generated password so a leak stays contained to the account it came from.',
			'audit.compromisedPassword.label' => 'Compromised Passwords',
			'audit.compromisedPassword.description' => 'This password appears in a public record of breached credentials, which puts it on the lists attackers try first no matter how strong it looks. Change it everywhere it is used: a password only has to leak once to stay leaked.',
			'myVaults.title' => 'My Vaults',
			'myVaults.subtitle' => 'Separate groups of items — work, family, personal',
			'myVaults.defaultBadge' => 'Default',
			'myVaults.newVault' => 'New vault',
			'myVaults.emptyTitle' => 'You only have the default vault',
			'myVaults.emptyBody' => 'A second vault keeps a set of items apart — work from personal, or shared from private.',
			'myVaults.createdOn' => ({required Object date}) => 'created ${date}',
			'myVaults.renameTitle' => 'Rename Vault',
			'myVaults.renameBody' => 'The items in it are not affected.',
			'myVaults.duplicateRename' => ({required Object name}) => 'A vault named “${name}” already exists.',
			'myVaults.deleteTitle' => ({required Object name}) => 'Delete “${name}”?',
			'myVaults.deleteAction' => 'Delete vault',
			'myVaults.renameAria' => ({required Object name}) => 'Rename ${name}',
			'myVaults.deleteAria' => ({required Object name}) => 'Delete ${name}',
			'myVaults.itemCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} item', other: '${n} items', ), 
			'myVaults.deleteBody' => ({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Its ${n} item moves to ${vault}. This cannot be undone.', other: 'Its ${n} items move to ${vault}. This cannot be undone.', ), 
			'myVaults.deleteSelectedTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Delete ${n} vault?', other: 'Delete ${n} vaults?', ), 
			'myVaults.deleteSelectedBody' => ({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Everything in them — ${n} item — moves to ${vault}. This cannot be undone.', other: 'Everything in them — ${n} items — moves to ${vault}. This cannot be undone.', ), 
			'myVaults.personalSummary' => ({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${name} holds ${n} item and cannot be renamed or deleted.', other: '${name} holds ${n} items and cannot be renamed or deleted.', ), 
			'myVaults.selected' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} vault selected', other: '${n} vaults selected', ), 
			'myVaults.deleteVaults' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Delete ${n} vault', other: 'Delete ${n} vaults', ), 
			'tags.title' => 'Tags',
			'tags.subtitle' => 'Labels that cut across vaults, for finding things fast',
			'tags.since' => ({required Object date}) => 'since ${date}',
			'tags.addTag' => 'Add tag',
			'tags.addTitle' => 'Add Tag',
			'tags.emptyTitle' => 'No tags yet',
			'tags.emptyBody' => 'Tags are created from an item, or here — either way they group items across vaults.',
			'tags.addBody' => 'A tag with no items yet. Put it on an item from that item’s own page.',
			'tags.tagName' => 'Tag name',
			'tags.duplicate' => 'A tag with this name already exists.',
			'tags.colorNote' => 'Its color comes from its name.',
			'tags.renameTitle' => 'Rename Tag',
			'tags.renameBody' => 'Every item carrying it is updated.',
			'tags.mergeNotice' => ({required Object name}) => '‘${name}’ already exists — renaming will merge them.',
			'tags.deleteTitle' => ({required Object name}) => 'Delete “${name}”?',
			'tags.deleteAction' => 'Delete tag',
			'tags.deleteSelectedBody' => 'Each one is removed from every item that has it. The items themselves are kept. This cannot be undone.',
			'tags.footer' => 'Tap a tag to see its items in the Vault tab.',
			'tags.renameAria' => ({required Object name}) => 'Rename ${name}',
			'tags.deleteAria' => ({required Object name}) => 'Delete ${name}',
			'tags.itemCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} item', other: '${n} items', ), 
			'tags.deleteBody' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'It will be removed from ${n} item. The items themselves are kept. This cannot be undone.', other: 'It will be removed from ${n} items. The items themselves are kept. This cannot be undone.', ), 
			'tags.deleteSelectedTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Delete ${n} tag?', other: 'Delete ${n} tags?', ), 
			'tags.selected' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} tag selected', other: '${n} tags selected', ), 
			'tags.deleteTags' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Delete ${n} tag', other: 'Delete ${n} tags', ), 
			'changeSecret.title' => 'Change Secret',
			'changeSecret.intro' => 'Your vault is re-encrypted under the new secret and uploaded again. It cannot be recovered if you forget it.',
			'changeSecret.current' => 'Current secret',
			'changeSecret.wrong' => 'That is not your current secret.',
			'changeSecret.match' => 'The two secrets match.',
			'changeSecret.otherDevices' => 'Other devices ask for the new secret the next time they open your vault.',
			'changeSecret.submit' => 'Change secret',
			'changeSecret.verifyingMeta' => 'Checking your current secret…',
			'changeSecret.verifyingTitle' => 'Verifying your current secret…',
			'changeSecret.stepVerify' => 'Verifying your current secret',
			'changeSecret.stepVerifyNote' => 'Deliberately slow on a phone — that is what makes guessing it expensive',
			'changeSecret.stepEncrypt' => 'Encrypting with the new secret',
			'changeSecret.stepSave' => 'Saving your vault',
			'changeSecret.savingMeta' => ({required Object storage}) => 'Saving to ${storage}…',
			'changeSecret.savingTitle' => ({required Object percent}) => 'Saving your vault… ${percent}%',
			'changeSecret.stepVerified' => 'Current secret verified',
			'changeSecret.stepEncrypted' => 'Encrypted with the new secret',
			'changeSecret.stepSaving' => ({required Object storage}) => 'Saving to ${storage}',
			'changeSecret.keepOpen' => 'Keep KeeperPass open until it finishes.',
			'changeSecret.doneMeta' => ({required Object storage}) => 'Saved to ${storage}',
			'changeSecret.doneTitle' => 'Your secret was changed',
			'changeSecret.doneBody' => 'Every item came with you. Other devices ask for the new secret the next time they open your vault.',
			'changeSecret.toast' => 'Secret changed',
			'changeSecret.failTitle' => 'Your vault was not saved',
			'changeSecret.failBody' => ({required Object storage}) => '${storage} could not be reached. Your secret has not changed: the vault still opens with your current one.',
			'storage.title' => 'Storage',
			'storage.subtitle' => 'Where your vault lives, and what can reach it',
			'storage.diagram' => ({required Object storage}) => 'Encrypted on this phone, stored in your ${storage}',
			'storage.thisPhone' => 'This phone',
			'storage.encryptedOnly' => 'Encrypted file only',
			'storage.googleFolder' => 'keeperpass folder',
			'storage.dropboxFolder' => 'Apps/keeperpass folder',
			'storage.savedToday' => ({required Object folder, required Object time}) => '${folder} · saved today at ${time}',
			'storage.savedOn' => ({required Object folder, required Object date}) => '${folder} · saved ${date}',
			'storage.access' => 'Access',
			'storage.googlePermissions' => 'Google account permissions',
			'storage.dropboxApps' => 'Dropbox connected apps',
			'storage.accessNote' => 'KeeperPass can reach only the files it creates. Revoke that here at any time; the vault file stays where it is.',
			'moveVault.title' => 'Move Vault',
			'moveVault.diagram' => ({required Object from, required Object to}) => 'Your vault moves from ${from} to ${to}',
			'moveVault.from' => 'From',
			'moveVault.to' => 'To',
			'moveVault.intro' => 'Your vault is copied and checked, and only then is the old file renamed. If anything fails, nothing is changed.',
			'moveVault.step1' => ({required Object storage}) => 'Sign in to ${storage} to choose where the vault goes.',
			'moveVault.step2' => 'Confirm. Nothing changes before this step.',
			'moveVault.step3' => 'The vault is copied and checked; then the old file is renamed, never deleted.',
			'moveVault.connect' => ({required Object storage}) => 'Connect ${storage}',
			'moveVault.account' => 'Moving to this account',
			'moveVault.existingTitle' => ({required Object storage}) => 'This ${storage} account already has a KeeperPass vault',
			'moveVault.existingBody' => ({required Object storage}) => 'Continuing keeps it as a timestamped backup file in ${storage} and replaces it with the vault you are moving.',
			'moveVault.existingConfirm' => 'Replace it — the existing vault is kept as a backup',
			'moveVault.secretSection' => 'Secret for the moved vault',
			'moveVault.keepSecret' => 'Keep my current secret',
			'moveVault.newSecret' => 'Choose a new secret',
			'moveVault.newSecretNote' => 'Only the moved vault uses it',
			'moveVault.submit' => 'Move vault',
			'moveVault.movingTitle' => 'Moving your vault',
			'moveVault.stageEncrypting' => 'Encrypting your vault',
			'moveVault.stageSaving' => ({required Object storage}) => 'Saving to ${storage}…',
			'moveVault.stageChecking' => 'Checking the saved copy',
			'moveVault.stageRenaming' => 'Renaming the old file',
			'moveVault.movingNote' => 'Keep KeeperPass open until it finishes. If anything fails, nothing is changed.',
			'moveVault.savedTo' => ({required Object storage}) => 'Saved to ${storage}',
			'moveVault.doneTitle' => ({required Object storage}) => 'Your vault now lives in ${storage}',
			'moveVault.doneBody' => ({required Object provider, required Object from}) => 'Sign in with ${provider} to open it. The old file was kept and renamed in ${from}:',
			'moveVault.copyFileName' => 'Copy file name',
			'moveVault.fileNameCopied' => 'File name copied',
			'moveVault.partlyTitle' => ({required Object storage}) => 'Your vault was copied to ${storage}',
			'moveVault.partlyBody' => ({required Object from}) => 'But the old file in ${from} could not be renamed. Rename or delete it yourself so the two copies do not drift apart.',
			'moveVault.open' => ({required Object storage}) => 'Open ${storage}',
			'moveVault.unchanged' => ({required Object from}) => 'Still in ${from} · unchanged',
			'moveVault.notMovedTitle' => 'Your vault was not moved',
			'moveVault.notMovedBody' => 'The saved copy did not match your vault, so the old file was left untouched. Nothing was lost — please try again.',
			'dataIo.importTitle' => 'Import',
			'dataIo.file' => 'File',
			'dataIo.fileMeta' => ({required Object size}) => '${size} · from Files',
			'dataIo.kilobytes' => ({required Object n}) => '${n} KB',
			'dataIo.megabytes' => ({required Object n}) => '${n} MB',
			'dataIo.change' => 'Change',
			'dataIo.found' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Found ${n} item to import.', other: 'Found ${n} items to import.', ), 
			'dataIo.addTo' => 'Add them to',
			'dataIo.importNote' => 'Items are added to the vault you pick. Nothing is replaced.',
			'dataIo.importButton' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Import ${n} item', other: 'Import ${n} items', ), 
			'dataIo.invalidCsv' => 'This file could not be read as CSV.',
			'dataIo.noItems' => 'No items found in this file.',
			'dataIo.notCsvNote' => 'Export a CSV from your other password manager, then choose that file here.',
			'dataIo.chooseAnother' => 'Choose another file',
			'dataIo.exportTitle' => 'Export',
			'dataIo.exportIntro' => 'Writes a CSV of the vault you choose. Exported items leave the vault’s encryption behind — what you do with the file is up to you.',
			'dataIo.sourceVault' => 'Source vault',
			'dataIo.notEncryptedTitle' => 'A CSV file is not encrypted',
			'dataIo.notEncryptedBody' => 'Anyone who opens it can read every password in it. Keep it somewhere safe and delete it when you are done.',
			'dataIo.exportButton' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Export ${n} item', other: 'Export ${n} items', ), 
			'dataIo.exportNote' => 'Opens the share sheet, so you choose where the file goes.',
			'dataIo.recentTitle' => 'Recent Exports',
			'dataIo.recentRow' => ({required num n, required Object scope}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${scope} · ${n} item', other: '${scope} · ${n} items', ), 
			'dataIo.recentNote' => 'The last 10 exports are remembered, in your vault. KeeperPass keeps no copy of the files themselves.',
			'dataIo.recentEmpty' => 'No exports yet.',
			'archive.title' => 'Archive Vault',
			'archive.headline' => 'Archive vault and sign out',
			'archive.body' => ({required Object storage}) => 'Your vault is one encrypted file in your own ${storage}. Archiving renames it so this app no longer finds it, and signs you out. Nothing is erased.',
			'archive.step1' => ({required Object oldName, required Object newName, required Object folder}) => '${oldName} is renamed to ${newName}, in the same ${folder}.',
			'archive.step2' => ({required Object storage}) => 'This phone signs out of ${storage}.',
			'archive.step3' => ({required Object storage}) => 'To delete the data itself, delete that file in ${storage}.',
			'archive.typePrefix' => 'Type',
			'archive.typeSuffix' => 'to confirm.',
			'archive.confirmation' => 'Confirmation',
			'archive.button' => 'Archive and sign out',
			'archive.doneMeta' => 'Renamed · this app no longer finds it',
			'archive.doneTitle' => 'Your vault file has been renamed',
			'archive.doneBody' => ({required Object folder, required Object storage}) => 'It is still in the ${folder} of your ${storage}. Delete it there whenever you want the data gone for good.',
			'archive.signedOut' => 'You are signed out on this phone.',
			'archive.error' => 'Could not rename your vault file. Nothing was changed.',
			'help.howTitle' => 'How KeeperPass Works',
			'help.howSubtitle' => 'Where your data lives, and what keeps it private',
			'help.whereLives' => 'Where your data lives',
			'help.diagram' => ({required Object storage}) => 'Your vault is encrypted on this phone and stored as one file in your ${storage}',
			'help.thisPhoneNote' => 'Encrypts and decrypts everything. Your secret never leaves it.',
			'help.fileEncrypted' => 'vault.json.enc · encrypted',
			'help.yourStorage' => ({required Object storage}) => 'Your ${storage}',
			'help.storageNote' => 'Holds the file, which is unreadable without your secret.',
			'help.noServer' => 'KeeperPass never receives your data. There is no account to breach and no operator who could read your vault.',
			'help.protects' => 'What protects it',
			'help.secretTerm' => 'Your secret',
			'help.secretNote' => 'Never sent, never stored. It exists only in memory while the app is unlocked.',
			'help.kdfTerm' => 'Key derivation',
			'help.kdfNote' => 'Deliberately slow, so every guess at your secret is expensive.',
			'help.encryptionTerm' => 'Encryption',
			'help.encryptionNote' => 'Keeps the file unreadable, and shows if anyone changed it.',
			'help.accessTerm' => 'Storage access',
			'help.accessNote' => 'KeeperPass can reach only the files it creates.',
			'help.signingIn' => 'Signing in',
			'help.step1' => 'Connect your cloud storage',
			'help.step1Note' => 'Proves who owns the file. It unlocks nothing.',
			'help.step2' => 'Enter your secret',
			'help.step2Note' => 'Makes the key that opens the file, on this phone. Your storage provider never sees it.',
			'help.bothNeeded' => 'Someone with your storage account still can’t read your vault. Someone with your secret still can’t reach the file. Both are needed.',
			'help.terms' => 'Terms worth knowing',
			'help.secretWord' => 'Secret',
			'help.secretDef' => 'The one phrase that unlocks your vault. It can’t be recovered.',
			'help.vaultWord' => 'Vault',
			'help.vaultDef' => 'A group of items. Keep work and personal apart with several.',
			'help.tagWord' => 'Tag',
			'help.tagDef' => 'A label for finding items across vaults, like work or banking.',
			'help.reportWord' => 'Security report',
			'help.reportDef' => 'Flags weak, reused and breached passwords, on this phone.',
			'faq.title' => 'Questions',
			'faq.subtitle' => 'Answers to common questions',
			'faq.forgetQ' => 'What if I forget my secret?',
			'faq.forgetA1' => 'Your vault cannot be recovered — not by you, not by us. The key is made from your secret alone, so without it the file stays unreadable. That is the cost of nobody else being able to read it either.',
			'faq.forgetA2' => ({required Object forgot, required Object file}) => 'What you can do is start over: ${forgot} on the unlock screen sets up a new, empty vault. Your old file is not deleted — it is renamed to ${file} and kept in your keeperpass folder, so the data is still there if the secret comes back.',
			'faq.forgetA2Link' => 'Forgot your secret?',
			'faq.forgetA3' => 'Write your secret down and keep it somewhere safe. It is the one thing in KeeperPass that cannot be replaced.',
			'faq.seeQ' => 'Can KeeperPass see my passwords?',
			'faq.seeA' => 'No — and not as a promise, as a consequence of the design. Encryption happens on this phone and the ciphertext goes straight to your own storage. There is no KeeperPass server in the path to see anything.',
			'faq.syncQ' => 'Does it sync across devices?',
			'faq.syncA' => 'Yes. Every device reads the same file from your storage. Sign in with the same account, enter the same secret, and your vault is there.',
			'faq.providerQ' => 'What if my storage provider reads the file?',
			'faq.providerA' => 'They would see encrypted bytes. The key never leaves this phone, so Google, Dropbox or any other provider cannot read the contents.',
			'faq.importQ' => 'Can I import from another password manager?',
			'faq.importA' => 'Yes — export to CSV there, then use Import in Settings.',
			'faq.changeSecretQ' => 'How do I change my secret?',
			'faq.changeSecretA' => ({required Object action}) => 'Open Settings and choose ${action}. You enter your current secret and the new one; your vault is decrypted, re-encrypted under the new secret, and saved back. Nothing is lost — every item comes with you, and the change applies on every device the next time it loads your vault.',
			'faq.costQ' => 'What does it cost?',
			'faq.costA' => 'Nothing. KeeperPass is free and open-source, and it stores data in cloud space you already have.',
			'faq.stillStuck' => 'Still stuck?',
			'faq.contactBody' => 'Questions, feedback or a problem to report? Send us an email.',
			'about.version' => ({required Object version, required Object build}) => 'Version ${version} (${build})',
			'about.tagline' => 'Your cloud. Your keys. Your vault.',
			'about.license' => 'Free and open source under AGPL-3.0',
			'about.terms' => 'Terms of Service',
			'about.privacy' => 'Privacy Policy',
			'about.promise' => 'Free, with no catch: no plans, no premium tier, no upsells.',
			'clipboard.clearsIn' => ({required Object time}) => 'Clears in ${time}',
			'clipboard.cleared' => 'Clipboard cleared',
			'sync.savedTo' => ({required Object storage}) => 'Saved to ${storage}',
			'sync.notSavedTitle' => 'Your vault was not saved',
			'sync.notSavedBody' => ({required Object storage}) => '${storage} could not be reached. Your change is still here — retry before you close KeeperPass.',
			'sync.dismiss' => 'Dismiss',
			'sync.retryingTitle' => 'Trying again…',
			'sync.retryingBody' => ({required Object storage}) => 'Saving to ${storage}.',
			'sync.reconnectTitle' => ({required Object storage}) => 'Reconnect to ${storage}',
			'sync.keepReading' => 'You can keep reading; changes are saved once you are back.',
			'sync.reconnect' => 'Reconnect',
			'sync.later' => 'Later',
			'sync.offlineBody' => ({required Object storage}) => 'You can keep reading and copying. Saving needs a connection to ${storage}.',
			'sync.changedTitle' => 'Your Vault Changed',
			'sync.changedBody' => 'A newer version of your vault was saved from another device. Load it before you edit, so nothing gets overwritten.',
			'sync.twoVersions' => 'Two versions',
			'sync.onThisPhone' => 'On this phone',
			'sync.inStorage' => ({required Object storage}) => 'In ${storage}',
			'sync.loadedAt' => ({required Object time}) => 'loaded ${time}',
			'sync.savedNewer' => ({required Object time}) => 'saved ${time} · newer',
			'sync.loadLatest' => 'Load the latest version',
			'sync.notNow' => 'Not now',
			'sync.pausedNote' => 'Until then you can read and copy, but not edit.',
			'sync.upToDate' => 'Up to date',
			'sync.loadedVersion' => ({required Object time}) => 'Loaded the version saved at ${time}',
			'scan.title' => 'Scan QR Code',
			'scan.primerTitle' => 'Add a 2FA code by scanning',
			'scan.primerBody' => 'When a site turns on two-factor sign-in, it shows a QR code. KeeperPass reads it with the camera and keeps the setup key in your vault, so its codes appear in Codes.',
			'scan.primerPrivacy' => 'The camera only reads the code. Nothing is recorded, and no image is kept.',
			'scan.primerNext' => 'Your phone asks for camera access next.',
			'scan.enterInstead' => 'Enter setup key instead',
			'scan.hint' => 'Point at the QR code the website shows\nwhen you turn on two-factor sign-in.',
			'scan.torch' => 'Turn on the light',
			'scan.cameraView' => 'Camera view',
			'scan.codeFound' => 'Code Found',
			'scan.saveTo' => 'Save it to',
			'scan.existingItem' => 'Existing item',
			'scan.existingItemWith' => ({required Object summary}) => 'Existing item · ${summary}',
			'scan.newAuthenticator' => 'New Authenticator item',
			'scan.named' => ({required Object name}) => 'Named ${name}',
			'scan.cameraOffTitle' => 'Camera access is off',
			'scan.cameraOffBody' => 'KeeperPass needs the camera only to read QR codes. Turn it on in Settings, or type the setup key instead.',
			'scan.openSettings' => 'Open Settings',
			'scan.unsupported' => 'This code uses settings KeeperPass doesn’t support yet',
			'scan.notACode' => 'This isn’t a 2FA QR code',
			'scan.cameraFailed' => 'The camera couldn’t start',
			'scan.item' => 'Item',
			'scan.codeSettings' => '6 digits · every 30 seconds · SHA-1',
			'scan.codeAdded' => ({required Object name}) => 'Code added to ${name}',
			'scan.tapToCopy' => 'Tap the card to copy it.',
			_ => null,
		};
	}
}
