///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsDe extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsDe _root = this; // ignore: unused_field

	@override 
	TranslationsDe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsDe(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$de app = _Translations$app$de._(_root);
	@override late final _Translations$connectivity$de connectivity = _Translations$connectivity$de._(_root);
	@override late final _Translations$errors$de errors = _Translations$errors$de._(_root);
	@override late final _Translations$common$de common = _Translations$common$de._(_root);
	@override late final _Translations$strength$de strength = _Translations$strength$de._(_root);
	@override late final _Translations$totp$de totp = _Translations$totp$de._(_root);
	@override late final _Translations$settings$de settings = _Translations$settings$de._(_root);
	@override late final _Translations$auth$de auth = _Translations$auth$de._(_root);
	@override late final _Translations$vaults$de vaults = _Translations$vaults$de._(_root);
	@override late final _Translations$welcome$de welcome = _Translations$welcome$de._(_root);
	@override late final _Translations$connect$de connect = _Translations$connect$de._(_root);
	@override late final _Translations$howItWorks$de howItWorks = _Translations$howItWorks$de._(_root);
	@override late final _Translations$technicalDetails$de technicalDetails = _Translations$technicalDetails$de._(_root);
	@override late final _Translations$createVault$de createVault = _Translations$createVault$de._(_root);
	@override late final _Translations$unlock$de unlock = _Translations$unlock$de._(_root);
	@override late final _Translations$newVault$de newVault = _Translations$newVault$de._(_root);
	@override late final _Translations$tabs$de tabs = _Translations$tabs$de._(_root);
	@override late final _Translations$codes$de codes = _Translations$codes$de._(_root);
	@override late final _Translations$comingSoon$de comingSoon = _Translations$comingSoon$de._(_root);
	@override late final _Translations$vaultList$de vaultList = _Translations$vaultList$de._(_root);
	@override late final _Translations$itemDetail$de itemDetail = _Translations$itemDetail$de._(_root);
	@override late final _Translations$editItem$de editItem = _Translations$editItem$de._(_root);
	@override late final _Translations$generator$de generator = _Translations$generator$de._(_root);
	@override late final _Translations$report$de report = _Translations$report$de._(_root);
	@override late final _Translations$audit$de audit = _Translations$audit$de._(_root);
	@override late final _Translations$myVaults$de myVaults = _Translations$myVaults$de._(_root);
	@override late final _Translations$tags$de tags = _Translations$tags$de._(_root);
	@override late final _Translations$changeSecret$de changeSecret = _Translations$changeSecret$de._(_root);
	@override late final _Translations$storage$de storage = _Translations$storage$de._(_root);
	@override late final _Translations$moveVault$de moveVault = _Translations$moveVault$de._(_root);
	@override late final _Translations$dataIo$de dataIo = _Translations$dataIo$de._(_root);
	@override late final _Translations$archive$de archive = _Translations$archive$de._(_root);
	@override late final _Translations$help$de help = _Translations$help$de._(_root);
	@override late final _Translations$faq$de faq = _Translations$faq$de._(_root);
	@override late final _Translations$about$de about = _Translations$about$de._(_root);
	@override late final _Translations$clipboard$de clipboard = _Translations$clipboard$de._(_root);
	@override late final _Translations$sync$de sync = _Translations$sync$de._(_root);
	@override late final _Translations$scan$de scan = _Translations$scan$de._(_root);
}

// Path: app
class _Translations$app$de extends Translations$app$en {
	_Translations$app$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'KeeperPass';
}

// Path: connectivity
class _Translations$connectivity$de extends Translations$connectivity$en {
	_Translations$connectivity$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get offline => 'Keine Internetverbindung';
	@override String get online => 'Wieder online';
}

// Path: errors
class _Translations$errors$de extends Translations$errors$en {
	_Translations$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$errors$failures$de failures = _Translations$errors$failures$de._(_root);
	@override late final _Translations$errors$drive$de drive = _Translations$errors$drive$de._(_root);
	@override late final _Translations$errors$dropbox$de dropbox = _Translations$errors$dropbox$de._(_root);
	@override late final _Translations$errors$auth$de auth = _Translations$errors$auth$de._(_root);
	@override late final _Translations$errors$masterPassword$de masterPassword = _Translations$errors$masterPassword$de._(_root);
	@override late final _Translations$errors$vault$de vault = _Translations$errors$vault$de._(_root);
}

// Path: common
class _Translations$common$de extends Translations$common$en {
	_Translations$common$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get close => 'Schließen';
	@override String get copy => 'Kopieren';
	@override String get copied => 'Kopiert';
	@override String get cancel => 'Abbrechen';
	@override String get save => 'Speichern';
	@override String get back => 'Zurück';
	@override String get favorite => 'Favorit';
	@override String get showSecret => 'Geheimnis anzeigen';
	@override String get hideSecret => 'Geheimnis verbergen';
	@override String get empty => '[leer]';
	@override String get clearSearch => 'Suche löschen';
	@override String get chooseDate => 'Datum auswählen';
	@override String get chooseMonth => 'Monat auswählen';
	@override String get countryCode => 'Ländervorwahl';
	@override String countryCodeValue({required Object country, required Object code}) => 'Ländervorwahl: ${country}, ${code}';
	@override String removeTag({required Object tag}) => 'Tag ${tag} entfernen';
	@override String get secretChip => 'Geheim';
	@override String secretToggle({required Object field}) => 'Geheim: ${field}';
	@override String reorderField({required Object field}) => '${field} verschieben';
	@override String removeField({required Object field}) => '${field} entfernen';
	@override String changeFieldIcon({required Object field}) => 'Symbol für ${field} ändern';
	@override String showAll({required Object count}) => 'Alle ${count} anzeigen';
	@override String get showInLargeType => 'In großer Schrift anzeigen';
	@override String stepOf({required Object current, required Object total}) => 'Schritt ${current} von ${total}';
	@override String get next => 'Weiter';
	@override String get continueAction => 'Weiter';
	@override String get tryAgain => 'Erneut versuchen';
	@override String get retry => 'Wiederholen';
	@override String get show => 'Anzeigen';
	@override String get hide => 'Ausblenden';
	@override String get gotIt => 'Verstanden';
	@override String get disconnect => 'Trennen';
	@override String get generateSecret => 'Geheimnis generieren';
	@override String get useAnotherAccount => 'Anderes Konto verwenden';
	@override String get offlineTitle => 'Sie sind offline';
	@override String savingTo({required Object provider}) => 'Wird in ${provider} gespeichert…';
	@override String get keepOpen => 'Lassen Sie KeeperPass geöffnet, bis dies abgeschlossen ist.';
	@override String get typeItAgain => 'Erneut eingeben';
	@override String get secretHiddenValue => 'Verborgen';
	@override String get rename => 'Umbenennen';
	@override String get done => 'Fertig';
}

// Path: strength
class _Translations$strength$de extends Translations$strength$en {
	_Translations$strength$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get veryWeak => 'Sehr schwach';
	@override String get weak => 'Schwach';
	@override String get fair => 'Mittel';
	@override String get strong => 'Stark';
	@override String get veryStrong => 'Sehr stark';
	@override String meter({required Object level}) => 'Stärke: ${level}';
}

// Path: totp
class _Translations$totp$de extends Translations$totp$en {
	_Translations$totp$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get invalidCode => 'Ungültiger Code';
	@override String get invalidKey => 'Der Einrichtungsschlüssel ist ungültig, daher kann kein Code erzeugt werden.';
	@override String get fixInEdit => 'In „Bearbeiten“ beheben';
	@override String secondsShort({required Object count}) => '${count} s';
	@override String secondsLeft({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(count,
		one: 'Noch ${count} Sekunde',
		other: 'Noch ${count} Sekunden',
	);
}

// Path: settings
class _Translations$settings$de extends Translations$settings$en {
	_Translations$settings$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$settings$migrate$de migrate = _Translations$settings$migrate$de._(_root);
	@override String get title => 'Einstellungen';
	@override String get subtitle => 'Konto, Sprache, Sicherheit und Daten';
	@override String get account => 'Konto';
	@override String accountLine({required Object email, required Object storage}) => '${email} · ${storage}';
	@override String get accountNote => 'Name und E-Mail-Adresse stammen aus dem Konto, mit dem Sie sich angemeldet haben.';
	@override String get logOut => 'Abmelden';
	@override String get logOutTitle => 'Abmelden?';
	@override String logOutBody({required Object storage, required Object provider}) => 'Ihr Tresor bleibt verschlüsselt in Ihrem ${storage}. Um ihn wieder zu öffnen, melden Sie sich mit ${provider} an und geben Sie Ihr Geheimnis ein.';
	@override String get security => 'Sicherheit';
	@override String get lockNow => 'Jetzt sperren';
	@override String get autoLock => 'Automatische Sperre';
	@override String get clearClipboard => 'Zwischenablage leeren';
	@override String get hideInSwitcher => 'Im App-Umschalter ausblenden';
	@override String get hideInSwitcherNote => 'Zeigt einen Sichtschutz statt Ihres Tresors';
	@override String get changeSecret => 'Geheimnis ändern';
	@override String get securityNote => 'Beim Sperren wird der entschlüsselte Tresor aus dem Speicher dieses Telefons gelöscht.';
	@override String get appearance => 'Darstellung';
	@override String get theme => 'Design';
	@override String get themeAuto => 'Auto';
	@override String get themeLight => 'Hell';
	@override String get themeDark => 'Dunkel';
	@override String get language => 'Sprache';
	@override String get storage => 'Speicher';
	@override String get whereItLives => 'Wo Ihr Tresor liegt';
	@override String moveTo({required Object storage}) => 'Tresor nach ${storage} verschieben';
	@override String get data => 'Daten';
	@override String get importCsv => 'CSV importieren';
	@override String get exportCsv => 'CSV exportieren';
	@override String get recentExports => 'Letzte Exporte';
	@override String get help => 'Hilfe';
	@override String get howItWorks => 'So funktioniert KeeperPass';
	@override String get questions => 'Fragen';
	@override String get about => 'Über KeeperPass';
	@override String get dangerZone => 'Gefahrenbereich';
	@override String get archive => 'Tresor archivieren und abmelden';
	@override String get archiveNote => 'Benennt Ihre Tresordatei um und meldet Sie ab. Es wird nichts gelöscht.';
	@override String footer({required Object version}) => 'KeeperPass ${version} · Kostenlos und quelloffen unter AGPL-3.0';
	@override String get autoLockTitle => 'Automatische Sperre';
	@override String get autoLockImmediately => 'Sofort beim Verlassen der App';
	@override String get autoLockImmediatelyShort => 'Sofort';
	@override String get after1Minute => 'Nach 1 Minute';
	@override String get after5Minutes => 'Nach 5 Minuten';
	@override String get after10Minutes => 'Nach 10 Minuten';
	@override String get autoLockNote => 'KeeperPass sperrt sich, wenn es so lange nicht verwendet wird. Zum Entsperren brauchen Sie dann wieder Ihr Geheimnis.';
	@override String get clearClipboardTitle => 'Zwischenablage leeren';
	@override String get after30Seconds => 'Nach 30 Sekunden';
	@override String get after2Minutes => 'Nach 2 Minuten';
	@override String get never => 'Nie';
	@override String get after30s => 'Nach 30 s';
	@override String get after1Min => 'Nach 1 min';
	@override String get after2Min => 'Nach 2 min';
	@override String get clipboardNote => 'Kopierte Passwörter und Codes werden nach dieser Zeit aus der Zwischenablage gelöscht, sofern seitdem nichts anderes kopiert wurde.';
	@override String get preview => 'Vorschau';
	@override String get previewFrom => 'Von GitHub';
	@override String previewClears({required Object time}) => 'Von GitHub · Wird in ${time} gelöscht';
	@override String seconds({required Object n}) => '${n} s';
	@override String minutes({required Object n}) => '${n} min';
	@override String get languageTitle => 'Sprache';
	@override String get languageNote => 'Wird nur auf diesem Telefon gespeichert — sie gehört nicht zu Ihrem Tresor.';
	@override String get hideInSwitcherBlocks => 'Zeigt einen Sichtschutz statt Ihres Tresors und blockiert Screenshots';
	@override String get blockScreenshots => 'Screenshots blockieren';
	@override String get blockScreenshotsNote => 'Nur Android · blockiert auch Bildschirmaufnahmen';
	@override String get blockScreenshotsWhileHidden => 'Aktiv, solange „Im App-Umschalter ausblenden“ aktiv ist';
}

// Path: auth
class _Translations$auth$de extends Translations$auth$en {
	_Translations$auth$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$auth$unlock$de unlock = _Translations$auth$unlock$de._(_root);
}

// Path: vaults
class _Translations$vaults$de extends Translations$vaults$en {
	_Translations$vaults$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get defaultName => 'Mein Tresor';
}

// Path: welcome
class _Translations$welcome$de extends Translations$welcome$en {
	_Translations$welcome$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get howItWorks => 'So funktioniert’s';
	@override String get badge => 'Ende-zu-Ende-verschlüsselt';
	@override String get title => 'Willkommen bei KeeperPass';
	@override String get description => 'Ihr Tresor ist eine einzelne verschlüsselte Datei in Ihrem eigenen Cloud-Speicher. Melden Sie sich an, um ihn zu öffnen.';
	@override String get fileTag => 'Was Ihr Speicher sieht';
	@override String get fileMeta => 'Argon2id · AES-256-GCM';
	@override String get continueWithGoogle => 'Mit Google fortfahren';
	@override String get continueWithDropbox => 'Mit Dropbox fortfahren';
	@override String connecting({required Object provider}) => 'Verbindung mit ${provider} wird hergestellt …';
	@override String get factAccess => 'Zugriff nur auf die Dateien, die KeeperPass erstellt';
	@override String get factEncrypted => 'Auf diesem Telefon verschlüsselt, mit Ihrem eigenen Geheimnis';
	@override String get factNoServer => 'Kein KeeperPass-Server. Nichts geht sonst irgendwohin.';
	@override String get footer => 'Kein KeeperPass-Konto — nur das Google- oder Dropbox-Konto, das Sie bereits haben. Bei der Anmeldung wird die Tresordatei erstellt, falls Sie noch keine haben.';
}

// Path: connect
class _Translations$connect$de extends Translations$connect$en {
	_Translations$connect$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String lookingIn({required Object storage}) => 'Suche in ${storage} …';
	@override String get checkingTitle => 'Ihr Tresor wird geprüft …';
	@override String checkingDetail({required Object storage}) => 'Suche nach vault.json.enc in ${storage}.';
	@override String get foundTitle => 'Ihr Tresor wurde gefunden';
	@override String get foundDetail => 'Entsperren wird geöffnet …';
	@override String foundMeta({required Object storage}) => 'In ${storage} gefunden';
	@override String foundMetaUpdated({required Object storage, required Object time}) => 'In ${storage} gefunden · aktualisiert ${time}';
	@override String get canceledDetail => 'Es wurde nichts verbunden.';
	@override String get signInFailed => 'Anmeldung fehlgeschlagen';
	@override String get offlineDetail => 'Für die Anmeldung ist eine Verbindung zu Google oder Dropbox nötig. Dies aktualisiert sich von selbst, sobald Sie wieder online sind.';
	@override String get welcomeBack => 'Willkommen zurück,';
	@override String expiredDetail({required Object provider}) => 'Ihre ${provider}-Sitzung ist abgelaufen. Melden Sie sich erneut an, um Ihren Tresor zu entsperren.';
	@override String get lastUsed => 'Zuletzt verwendet';
	@override String checkFailedMeta({required Object storage}) => 'Konnte nicht aus ${storage} gelesen werden';
	@override String get checkFailedTitle => 'Ihr Tresor konnte nicht gelesen werden';
	@override String checkFailedDetail({required Object storage}) => '${storage} hat nicht geantwortet. Es wurde nichts verändert.';
}

// Path: howItWorks
class _Translations$howItWorks$de extends Translations$howItWorks$en {
	_Translations$howItWorks$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get step1Title => 'Ihr Tresor wohnt\nin Ihrer Cloud';
	@override String get step1Body => 'KeeperPass speichert eine verschlüsselte Datei in Ihrem Google Drive oder Dropbox. Es gibt keinen KeeperPass-Server, also erhalten wir nie eine Kopie.';
	@override String get encrypted => 'Verschlüsselt';
	@override String get step2Title => 'Wählen Sie ein Geheimnis';
	@override String get step2Body => 'Es wird zum Schlüssel. Nie gesendet, nie gespeichert.';
	@override String get step3Title => 'Es braucht beides';
	@override String get step3Body => 'Wer Ihr Speicherkonto hat, kann Ihren Tresor nicht lesen. Wer Ihr Geheimnis hat, kommt nicht an ihn heran.';
	@override String get storageAccount => 'Speicherkonto';
	@override String get reachesFile => 'Erreicht die Datei';
	@override String get yourSecret => 'Ihr Geheimnis';
	@override String get opensFile => 'Öffnet die Datei';
	@override String get technicalDetails => 'Technische Details';
	@override String get technicalSummary => 'Argon2id · AES-256';
}

// Path: technicalDetails
class _Translations$technicalDetails$de extends Translations$technicalDetails$en {
	_Translations$technicalDetails$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Technische Details';
	@override String get keyDerivation => 'Schlüsselableitung';
	@override TextSpan keyDerivationValue({required InlineSpan algorithm}) => TextSpan(children: [
		algorithm,
		const TextSpan(text: ' · 64 MiB Speicher · 3 Durchläufe · Parallelität 4, ergibt einen 256-Bit-Schlüssel'),
	]);
	@override String get encryption => 'Verschlüsselung';
	@override TextSpan encryptionValue({required InlineSpan algorithm}) => TextSpan(children: [
		algorithm,
		const TextSpan(text: ', das auch jede Änderung an der Datei erkennt'),
	]);
	@override String get googleDrive => 'Google Drive';
	@override TextSpan googleDriveValue({required InlineSpan scope}) => TextSpan(children: [
		const TextSpan(text: 'Der Bereich '),
		scope,
		const TextSpan(text: ': nur von KeeperPass erstellte Dateien'),
	]);
	@override String get dropbox => 'Dropbox';
	@override TextSpan dropboxValue({required InlineSpan folder}) => TextSpan(children: [
		const TextSpan(text: 'Ein App-Ordner: '),
		folder,
	]);
	@override String get vaultFile => 'Tresordatei';
	@override TextSpan vaultFileValue({required InlineSpan file}) => TextSpan(children: [
		file,
		const TextSpan(text: ' — eine Datei, bei jedem Speichern neu verschlüsselt und geschrieben'),
	]);
	@override String get viewSource => 'Quellcode auf GitHub ansehen';
	@override String get license => 'Kostenlos und quelloffen unter AGPL-3.0, sodass all dies überprüft werden kann.';
}

// Path: createVault
class _Translations$createVault$de extends Translations$createVault$en {
	_Translations$createVault$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'Tresor erstellen';
	@override String get step1Title => 'Wählen Sie Ihr Geheimnis';
	@override String get step1Body => 'Es verschlüsselt Ihren Tresor auf diesem Telefon. Alles, was Sie speichern, wird damit gesichert.';
	@override String get settingUpFor => 'Einrichtung für';
	@override String get secret => 'Geheimnis';
	@override String get secretPlaceholder => 'Ihr Geheimnis';
	@override String get generateAnother => 'Neues generieren';
	@override String get generatedNote => 'Generierte Geheimnisse überspringen das erneute Eingeben.';
	@override String get weakWarning => 'Dieses Geheimnis ist schwach, wodurch die Verschlüsselung Ihres Tresors leichter zu knacken ist. Sie können fortfahren, aber eine längere Passphrase wird dringend empfohlen.';
	@override String get tipsTitle => 'Ein gutes Geheimnis wählen';
	@override String get tip1 => 'Mehrere zufällige Wörter sind besser als ein cleveres Wort: Je länger, desto schwerer zu erraten.';
	@override String get tip2 => 'Verwenden Sie kein Passwort, das Sie schon anderswo nutzen.';
	@override String get tip3 => 'Wählen Sie etwas, das Sie auf diesem Telefon tippen können, schreiben Sie es auf und bewahren Sie es sicher auf.';
	@override String get step2Title => 'Noch einmal eingeben';
	@override String get step2Body => 'Nur um sicherzugehen, dass kein Tippfehler drin ist. Niemand kann Ihr Geheimnis später zurücksetzen.';
	@override String get repeat => 'Geheimnis wiederholen';
	@override String get mismatch => 'Die beiden Geheimnisse stimmen nicht überein.';
	@override String get step3Title => 'Schreiben Sie es auf';
	@override String get step3Body => 'Sie brauchen es bei jedem Entsperren. Bewahren Sie es sicher auf, getrennt von diesem Telefon.';
	@override String secretWords({required Object count}) => 'Ihr Geheimnis · ${count} Wörter';
	@override String get secretWhole => 'Ihr Geheimnis';
	@override String get secretHidden => 'Ihr Geheimnis, verborgen';
	@override String get secretShown => 'Ihr Geheimnis, angezeigt';
	@override String get readBefore => 'Bitte lesen Sie dies, bevor Sie fortfahren';
	@override String get bullet1 => 'Ihr Geheimnis wird nirgendwohin gesendet und nie gespeichert. Niemand — weder KeeperPass noch Ihr Speicheranbieter — kann es nachschlagen oder zurücksetzen.';
	@override String get bullet2 => 'Wenn Sie es vergessen, kann Ihr Tresor nicht wiederhergestellt werden. Kein Reset-Link und keine Support-Anfrage kann ihn öffnen.';
	@override String get bullet3 => 'Notieren Sie es sich und bewahren Sie es sicher auf, bevor Sie fortfahren.';
	@override String get acknowledge => 'Ich habe mein Geheimnis aufgeschrieben';
	@override String get create => 'Tresor erstellen';
	@override String get progressTitle => 'Ihr Tresor wird erstellt';
	@override String get encrypting => 'Ihr Tresor wird verschlüsselt …';
	@override String get encryptingDetail => 'Auf diesem Telefon. Das dauert ein paar Sekunden.';
	@override String get encryptingMeta => 'Wird auf diesem Telefon verschlüsselt …';
	@override String get savingDetail => 'Eine verschlüsselte Datei im Ordner keeperpass.';
	@override String get failedTitle => 'Ihr Tresor konnte nicht gespeichert werden';
	@override String get notSaved => 'Nicht gespeichert';
	@override String failedDetail({required Object storage}) => '${storage} hat nicht geantwortet. Es wurde nichts gespeichert, und Ihr Geheimnis ist noch da.';
	@override String get backToSecret => 'Zurück zu Ihrem Geheimnis';
}

// Path: unlock
class _Translations$unlock$de extends Translations$unlock$en {
	_Translations$unlock$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get notYou => 'Nicht Sie?';
	@override String get secret => 'Geheimnis';
	@override String get placeholder => 'Geben Sie Ihr Geheimnis ein';
	@override String get unlock => 'Entsperren';
	@override String get unlocking => 'Wird entsperrt …';
	@override String get unlockingStatus => 'Wird auf diesem Telefon entsperrt …';
	@override String get slowNote => 'Ein paar Sekunden, mit Absicht: So wird das Erraten Ihres Geheimnisses langsam.';
	@override String get forgot => 'Geheimnis vergessen?';
	@override String get leftApp => 'Gesperrt, als Sie KeeperPass verlassen haben';
	@override String unreachableTitle({required Object storage}) => '${storage} nicht erreichbar';
	@override String get unreachableDetail => 'Prüfen Sie Ihre Verbindung und versuchen Sie es erneut. Ihr Geheimnis ist noch eingetragen.';
	@override String offlineDetail({required Object storage}) => 'Zum Entsperren ist eine Verbindung zu ${storage} nötig. „Entsperren“ wird aktiv, sobald Sie wieder online sind.';
	@override String accountLine({required Object email, required Object storage}) => '${email} · ${storage}';
	@override String lockedInactivity({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Nach ${n} Minute Inaktivität gesperrt',
		other: 'Nach ${n} Minuten Inaktivität gesperrt',
	);
}

// Path: newVault
class _Translations$newVault$de extends Translations$newVault$en {
	_Translations$newVault$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get backLabel => 'Entsperren';
	@override String get backToUnlock => 'Zurück zum Entsperren';
	@override String get title => 'Einen neuen Tresor beginnen';
	@override String get oldMeta => 'Alter Tresor · mit dem alten Geheimnis gesperrt';
	@override String get newMeta => 'Neuer Tresor · leer';
	@override String body({required Object provider}) => 'Ein vergessenes Geheimnis lässt sich nicht zurücksetzen — weder durch KeeperPass noch durch ${provider}. Sie können stattdessen mit einem neuen, leeren Tresor neu beginnen.';
	@override String get pointLocked => 'Ihr aktueller Tresor bleibt mit dem alten Geheimnis gesperrt.';
	@override TextSpan pointKept({required InlineSpan file, required InlineSpan storage}) => TextSpan(children: [
		const TextSpan(text: 'Seine Datei bleibt als '),
		file,
		const TextSpan(text: ' in Ihrem '),
		storage,
		const TextSpan(text: ' erhalten. Nichts wird gelöscht.'),
	]);
	@override String get pointFresh => 'Sie beginnen neu mit einem brandneuen, leeren Tresor.';
	@override String get account => 'Konto';
	@override String get newSecret => 'Neues Geheimnis';
	@override String get newSecretPlaceholder => 'Wählen Sie ein neues Geheimnis';
	@override String get repeat => 'Neues Geheimnis wiederholen';
	@override String get weakWarning => 'Dieses Geheimnis ist schwach, wodurch die Verschlüsselung Ihrer Tresore leichter zu knacken ist. Sie können fortfahren, aber eine längere Passphrase wird dringend empfohlen.';
	@override String get warn => 'Wie das alte kann auch Ihr neues Geheimnis weder nachgeschlagen noch zurückgesetzt werden. Schreiben Sie es auf, bevor Sie fortfahren.';
	@override String get start => 'Neuen Tresor beginnen';
	@override String get confirmTitle => 'Einen neuen Tresor beginnen?';
	@override String confirmKept({required Object storage}) => 'Seine Datei bleibt als datierte Sicherung in Ihrem ${storage} erhalten.';
	@override String get confirmFresh => 'Sie beginnen neu mit einem leeren Tresor unter Ihrem neuen Geheimnis.';
	@override String get progressTitle => 'Neuer Tresor wird begonnen';
	@override String get encrypting => 'Ihr neuer Tresor wird verschlüsselt …';
	@override String get backingUp => 'Ihr alter Tresor wird als Sicherung aufbewahrt …';
	@override String backingUpDetail({required Object storage}) => 'Sie wird in ${storage} umbenannt.';
	@override String get readyMeta => 'Verschlüsselt · bereit zum Speichern';
	@override String get backupFailedMeta => 'Konnte nicht umbenannt werden · nichts geändert';
	@override String get nothingChanged => 'Es wurde nichts verändert';
	@override String backupFailedDetail({required Object storage}) => 'Ihr bestehender Tresor konnte in ${storage} nicht gesichert werden. Es wurde nichts verändert.';
	@override String get doneTitle => 'Neuer Tresor begonnen';
	@override String doneDetail({required Object storage}) => 'Ihr alter Tresor bleibt als Sicherung in ${storage} erhalten.';
}

// Path: tabs
class _Translations$tabs$de extends Translations$tabs$en {
	_Translations$tabs$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get vault => 'Tresor';
	@override String get codes => 'Codes';
	@override String get generator => 'Generator';
	@override String get security => 'Sicherheit';
	@override String get settings => 'Einstellungen';
	@override String securityFlagged({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Sicherheit, ${n} Eintrag markiert',
		other: 'Sicherheit, ${n} Einträge markiert',
	);
}

// Path: codes
class _Translations$codes$de extends Translations$codes$en {
	_Translations$codes$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get subtitle => '2FA-Codes aus Ihrem Tresor, auf diesem Telefon erzeugt';
	@override String searchPlaceholder({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Code durchsuchen',
		other: '${n} Codes durchsuchen',
	);
	@override String codeCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Code',
		other: '${n} Codes',
	);
	@override String get copied => 'Code kopiert';
	@override String get trust => 'Auf diesem Telefon aus den Einrichtungsschlüsseln in Ihrem Tresor erzeugt. Es wird nichts Neues gespeichert.';
	@override String get emptyTitle => 'Noch keine 2FA-Codes';
	@override String get emptyBody => 'Wenn eine Website eine Zwei-Faktor-Anmeldung anbietet, scannen Sie hier ihren QR-Code oder fügen Sie einen Eintrag „Authentifizierung“ hinzu.';
	@override String get createAuthenticator => 'Eintrag „Authentifizierung“ erstellen';
}

// Path: comingSoon
class _Translations$comingSoon$de extends Translations$comingSoon$en {
	_Translations$comingSoon$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String body({required Object part}) => 'Kommt in Teil ${part}.';
}

// Path: vaultList
class _Translations$vaultList$de extends Translations$vaultList$en {
	_Translations$vaultList$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get lock => 'Sperren';
	@override String get newItem => 'Neuer Eintrag';
	@override String get allVaults => 'Alle Tresore';
	@override String get favorites => 'Favoriten';
	@override String get recentlyUsed => 'Kürzlich verwendet';
	@override String statusSaved({required Object items, required Object storage}) => '${items} · In ${storage} gespeichert';
	@override String statusInVault({required Object items, required Object vault}) => '${items} in ${vault}';
	@override String statusTagged({required Object items, required Object tag}) => '${items} mit Tag ${tag}';
	@override String statusReport({required Object items, required Object report}) => '${items} · ${report}';
	@override String statusNotConnected({required Object storage}) => 'Nicht mit ${storage} verbunden';
	@override String statusOffline({required Object items}) => 'Offline · ${items}';
	@override String get reportWeak => 'Schwache Passwörter';
	@override String get reportReused => 'Wiederverwendete Passwörter';
	@override String get reportCompromised => 'Kompromittierte Passwörter';
	@override String get searchHint => 'Jedes Wort muss passen, in beliebiger Reihenfolge: Namen, Tags, Feldnamen und Werte.';
	@override String get filterByTag => 'Nach Tag filtern';
	@override String get manageTags => 'Tags verwalten';
	@override String get clearFilter => 'Filter entfernen';
	@override String get today => 'Heute';
	@override String get thisWeek => 'Diese Woche';
	@override String get earlier => 'Früher';
	@override String get aToZ => 'A bis Z';
	@override String get sortHeading => 'Nach letzter Änderung sortieren';
	@override String get newestFirst => 'Neueste zuerst';
	@override String get oldestFirst => 'Älteste zuerst';
	@override String refreshing({required Object storage}) => 'Ihr Tresor wird aus ${storage} gelesen …';
	@override String copyPasswordFor({required Object name}) => 'Passwort für ${name} kopieren';
	@override String copyCodeFor({required Object name}) => 'Code für ${name} kopieren';
	@override String copyCardNumberFor({required Object name}) => 'Kartennummer für ${name} kopieren';
	@override String get swipePassword => 'Passwort';
	@override String get swipeCode => 'Code';
	@override String get swipeCardNumber => 'Kartennummer';
	@override String get swipeUsername => 'Benutzername';
	@override String get swipeMore => 'Mehr';
	@override String get copyPassword => 'Passwort kopieren';
	@override String get copyCode => 'Code kopieren';
	@override String get copyCardNumber => 'Kartennummer kopieren';
	@override String get copyUsername => 'Benutzernamen kopieren';
	@override String get moreActions => 'Weitere Aktionen';
	@override String get favorite => 'Favorit';
	@override String get addToFavorites => 'Zu Favoriten hinzufügen';
	@override String get removeFromFavorites => 'Aus Favoriten entfernen';
	@override String get findingWeak => 'Schwaches Passwort';
	@override String get findingReused => 'Wiederverwendetes Passwort';
	@override String get findingCompromised => 'Kompromittiertes Passwort';
	@override String get findingWeakReused => 'Schwaches und wiederverwendetes Passwort';
	@override String get findingWeakCompromised => 'Schwaches und kompromittiertes Passwort';
	@override String get findingReusedCompromised => 'Wiederverwendetes und kompromittiertes Passwort';
	@override String get findingAll => 'Schwaches, wiederverwendetes und kompromittiertes Passwort';
	@override String get unnamed => 'Neuer Eintrag';
	@override String get scopeTitle => 'Tresore';
	@override String get manageVaults => 'Tresore verwalten';
	@override String scopeNote({required Object storage}) => 'Alle Ihre Tresore liegen in einer verschlüsselten Datei, vault.json.enc, in Ihrem ${storage}.';
	@override String quickActions({required Object name}) => '${name}, Schnellaktionen';
	@override String get openWebsite => 'Website öffnen';
	@override String get moveToVault => 'In Tresor verschieben …';
	@override String get select => 'Auswählen';
	@override String get delete => 'Löschen';
	@override String get selectAll => 'Alle auswählen';
	@override String get selectOrDeselectAll => 'Alle auswählen oder abwählen';
	@override String listTwo({required Object a, required Object b}) => '${a} und ${b}';
	@override String listThree({required Object a, required Object b, required Object c}) => '${a}, ${b} und ${c}';
	@override String get deleteItemTitle => 'Eintrag löschen';
	@override String deleteItemConfirm({required Object name}) => 'Möchten Sie „${name}“ wirklich löschen? Dies kann nicht rückgängig gemacht werden.';
	@override String get deleteItemAction => 'Eintrag löschen';
	@override String get moveToVaultTitle => 'In Tresor verschieben';
	@override String get moveDescription => 'Wählen Sie den Tresor, in dem dieser Eintrag liegen soll.';
	@override String get current => 'Aktuell';
	@override String get newVaultOption => 'Neuer Tresor …';
	@override String get noOtherVaultOne => 'Es gibt keinen anderen Tresor, in den dieser Eintrag verschoben werden kann.';
	@override String get noOtherVaultMany => 'Es gibt keinen anderen Tresor, in den diese Einträge verschoben werden können.';
	@override String get noOtherVaultDetail => 'Ein zweiter Tresor hält eine Gruppe von Einträgen getrennt — Arbeit von Privatem, oder Geteiltes von Privatem.';
	@override String get createAVault => 'Einen Tresor erstellen';
	@override String get newVaultTitle => 'Neuer Tresor';
	@override String get newVaultBody => 'Ein Tresor ist eine eigene Gruppe von Einträgen. Anders als bei einem Eintrag gibt es vorab nichts weiter zu wählen.';
	@override String get vaultName => 'Tresorname';
	@override String get duplicateVault => 'Ein Tresor mit diesem Namen existiert bereits.';
	@override String get noItemsTitle => 'Sie haben noch keine Einträge.';
	@override String get noItemsBody => 'Fügen Sie Ihr erstes Login, Ihre erste Karte oder Notiz hinzu. Jeder Eintrag wird auf diesem Telefon verschlüsselt, bevor er gespeichert wird.';
	@override String get importCsv => 'Aus CSV importieren';
	@override String get vaultReady => 'Ihr Tresor ist bereit. Noch ist nichts darin.';
	@override String savedMeta({required Object storage, required Object items}) => 'In ${storage} gespeichert · ${items}';
	@override String get vaultEmptyTitle => 'Dieser Tresor enthält noch keine Einträge.';
	@override String vaultEmptyBody({required Object vault}) => 'Fügen Sie hier einen hinzu oder verschieben Sie Einträge aus ${vault} hierher.';
	@override String get noFavoritesTitle => 'Sie haben noch keine Favoriten.';
	@override String get noFavoritesBody => 'Tippen Sie bei einem Eintrag auf den Stern, um ihn hier zu behalten.';
	@override String get nothingRecentTitle => 'Noch nichts verwendet';
	@override String get nothingRecentBody => 'Einträge, die Sie öffnen oder aus denen Sie kopieren, erscheinen hier — die neuesten zuerst.';
	@override String get noResultsTitle => 'Ihre Suche ergab keine Treffer.';
	@override String get noResultsBody => 'Jedes Wort muss passen. Versuchen Sie es mit weniger Wörtern oder prüfen Sie die Schreibweise.';
	@override String get allClearWeak => 'Alle Passwörter in Ihrem Tresor sind stark genug.';
	@override String get allClearReused => 'Jedes Passwort in Ihrem Tresor wird genau einmal verwendet.';
	@override String get allClearCompromised => 'Keines Ihrer Passwörter wurde in einem bekannten Datenleck gefunden.';
	@override String get allClearBody => 'Hier gibt es nichts zu beheben. KeeperPass prüft erneut, sobald sich ein Passwort ändert.';
	@override String get backToSecurity => 'Zurück zu Sicherheit';
	@override String fieldCopied({required Object field}) => '${field} kopiert';
	@override String copiedFrom({required Object item}) => 'Von ${item}';
	@override String itemCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Eintrag',
		other: '${n} Einträge',
	);
	@override String statusNotSaved({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Änderung nicht gespeichert',
		other: '${n} Änderungen nicht gespeichert',
	);
	@override String searchPlaceholder({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Eintrag durchsuchen',
		other: '${n} Einträge durchsuchen',
	);
	@override String results({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Treffer',
		other: '${n} Treffer',
	);
	@override String selectedCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} ausgewählt',
		other: '${n} ausgewählt',
	);
	@override String moveItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Eintrag verschieben',
		other: '${n} Einträge verschieben',
	);
	@override String moveItemsTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Eintrag verschieben',
		other: '${n} Einträge verschieben',
	);
	@override String deleteItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Eintrag löschen',
		other: '${n} Einträge löschen',
	);
	@override String deleteTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Eintrag löschen?',
		other: '${n} Einträge löschen?',
	);
	@override String deleteFromVault({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${names} wird aus ${vault} gelöscht. Dies kann nicht rückgängig gemacht werden.',
		other: '${names} werden aus ${vault} gelöscht. Dies kann nicht rückgängig gemacht werden.',
	);
	@override String deleteFromVaults({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${names} wird gelöscht. Dies kann nicht rückgängig gemacht werden.',
		other: '${names} werden gelöscht. Dies kann nicht rückgängig gemacht werden.',
	);
	@override String moveLine({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${names} wird mit Verlauf und Tags verschoben.',
		other: '${names} werden mit Verlauf und Tags verschoben.',
	);
	@override String movedTitle({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${names} nach ${vault} verschoben',
		other: '${names} nach ${vault} verschoben',
	);
	@override String movedDetail({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Verlauf und Tags bleiben erhalten.',
		other: 'Verlauf und Tags bleiben erhalten.',
	);
	@override String itemsOf({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${count} von ${n} Eintrag',
		other: '${count} von ${n} Einträgen',
	);
}

// Path: itemDetail
class _Translations$itemDetail$de extends Translations$itemDetail$en {
	_Translations$itemDetail$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get edit => 'Bearbeiten';
	@override String get editItem => 'Eintrag bearbeiten';
	@override String get moreOptions => 'Weitere Optionen';
	@override String updatedAgo({required Object ago}) => 'Aktualisiert ${ago}';
	@override String showTagged({required Object tag}) => 'Einträge mit Tag ${tag} anzeigen';
	@override String get fields => 'Felder';
	@override String get noFields => 'Dieser Eintrag hat keine Felder.';
	@override String get history => 'Verlauf';
	@override String get currentVersion => 'Aktuelle Version';
	@override String todayAt({required Object time}) => 'Heute, ${time}';
	@override String get unnamedField => 'Unbenannt';
	@override String copyField({required Object field}) => '${field} kopieren';
	@override String get revealValue => 'Wert anzeigen';
	@override String get hideValue => 'Wert verbergen';
	@override String hiddenValue({required Object field}) => '${field}, verborgen';
	@override String openSite({required Object site}) => '${site} öffnen';
	@override String get call => 'Anrufen';
	@override String get message => 'Nachricht';
	@override String get checksumFail => 'Diese Nummer besteht ihre Prüfsumme nicht — vermutlich ist eine der Ziffern falsch.';
	@override String get codeCardHint => 'Zum Kopieren tippen · auch im Tab „Codes“';
	@override String get copyAllCodes => 'Alle Codes kopieren';
	@override String copyCodeNumber({required Object n}) => 'Code ${n} kopieren';
	@override String get cardFace => 'Karte, Nummer verborgen';
	@override String cardFaceBrand({required Object brand}) => '${brand}-Karte, Nummer verborgen';
	@override String cardExpires({required Object date}) => 'gültig bis ${date}';
	@override String get largeTypeTurn => 'Drehen Sie Ihr Telefon quer, um alles in einer Zeile zu lesen.';
	@override String get largeTypeHides => 'Beim Verlassen dieses Bildschirms wird es wieder verborgen.';
	@override String get earlierVersion => 'Frühere Version';
	@override String readOnly({required Object ago}) => '${ago} · nur lesbar';
	@override String get changedSince => 'Seitdem geändert';
	@override String get restoreThisVersion => 'Diese Version wiederherstellen';
	@override String get deleteVersion => 'Version löschen';
	@override String get restoreTitle => 'Diese Version wiederherstellen?';
	@override String restoreBody({required Object name, required Object date}) => '${name} wird auf den Stand vom ${date} zurückgesetzt. Die aktuelle Version bleibt im Verlauf.';
	@override String get restore => 'Wiederherstellen';
	@override String get deleteVersionTitle => 'Diese Version löschen';
	@override String get deleteVersionConfirm => 'Möchten Sie diese Version wirklich aus dem Verlauf löschen? Dies kann nicht rückgängig gemacht werden.';
	@override String get delete => 'Löschen';
	@override String get notFound => 'Dieser Eintrag existiert nicht mehr.';
	@override String get notFoundHint => 'Er wurde möglicherweise von einem anderen Gerät gelöscht.';
	@override String get backToVault => 'Zurück zum Tresor';
	@override String hiddenLines({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${field}, verborgen, ${n} Zeile',
		other: '${field}, verborgen, ${n} Zeilen',
	);
	@override String largeTypeLabel({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${field} in großer Schrift, ${n} Zeichen',
		other: '${field} in großer Schrift, ${n} Zeichen',
	);
}

// Path: editItem
class _Translations$editItem$de extends Translations$editItem$en {
	_Translations$editItem$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get newVaultItem => 'Neuer Tresoreintrag';
	@override String get vault => 'Tresor';
	@override String get template => 'Vorlage';
	@override String get templateNote => 'Vorlagen sind nur ein Anfang: Felder lassen sich jederzeit umbenennen, entfernen oder hinzufügen.';
	@override late final _Translations$editItem$templates$de templates = _Translations$editItem$templates$de._(_root);
	@override late final _Translations$editItem$templateHints$de templateHints = _Translations$editItem$templateHints$de._(_root);
	@override late final _Translations$editItem$templateFields$de templateFields = _Translations$editItem$templateFields$de._(_root);
	@override late final _Translations$editItem$types$de types = _Translations$editItem$types$de._(_root);
	@override String get newItem => 'Neuer Eintrag';
	@override String get editItem => 'Eintrag bearbeiten';
	@override String get changeIcon => 'Symbol ändern';
	@override String get name => 'Name';
	@override String get namePlaceholder => 'z. B. GitHub';
	@override String get tags => 'Tags';
	@override String get addField => 'Feld hinzufügen';
	@override String get addFieldTitle => 'Feld hinzufügen';
	@override String get noFieldsTitle => 'Noch keine Felder';
	@override String get noFieldsBody => 'Fügen Sie einen der 16 Feldtypen hinzu — eine Policennummer, eine Telefonnummer, eine PIN.';
	@override String get fieldNamePlaceholder => 'Feldname';
	@override String get addTag => 'Tag hinzufügen';
	@override String get tagSuggestions => 'Tag-Vorschläge';
	@override String createTag({required Object name}) => '„${name}“ erstellen';
	@override String get tagTooLong => 'Dieser Name ist zu lang.';
	@override String get removeFieldTitle => 'Möchten Sie dieses Feld wirklich entfernen?';
	@override String removeFieldBody({required Object field, required Object item}) => '„${field}“ und sein Wert verschwinden beim Speichern aus ${item}.';
	@override String get remove => 'Entfernen';
	@override String get discardTitle => 'Änderungen verwerfen?';
	@override String discardBody({required Object name}) => 'Ihre Änderungen an ${name} wurden nicht gespeichert. Beim Verwerfen bleibt der Eintrag, wie er war.';
	@override String get discardNewTitle => 'Diesen neuen Eintrag verwerfen?';
	@override String get discardNewBody => 'Er wurde nicht gespeichert. Beim Verwerfen geht er verloren.';
	@override String get discard => 'Verwerfen';
	@override String get usernamePlaceholder => 'Benutzername oder E-Mail';
	@override String get passwordPlaceholder => 'Passwort';
	@override String get valuePlaceholder => 'Wert hier eingeben';
	@override String get ipHostPlaceholder => 'z. B. 192.168.1.1, ::1 oder db.beispiel.de';
	@override String get recoveryCodesPlaceholder => 'Einer pro Zeile — jedes Format funktioniert';
	@override String get notEmail => 'Das sieht nicht wie eine E-Mail-Adresse aus.';
	@override String get phoneNumber => 'Telefonnummer';
	@override String get searchCountries => 'Länder suchen';
	@override String get noCountryMatch => 'Kein Land stimmt überein.';
	@override String get generate => 'Generieren';
	@override String get generatePassword => 'Passwort generieren';
	@override String get currentCode => 'Aktueller Code';
	@override String get scanQr => 'QR-Code scannen';
	@override String get enterSetupKey => 'Einrichtungsschlüssel eingeben';
	@override String get setupKeyTitle => 'Einrichtungsschlüssel eingeben';
	@override String get setupKeyBody => 'Websites zeigen neben dem QR-Code einen Einrichtungsschlüssel, oft unter „Scannen nicht möglich?“.';
	@override String get setupKey => 'Einrichtungsschlüssel';
	@override String get setupKeyHint => 'Leerzeichen und Großschreibung spielen keine Rolle.';
	@override String get saveCode => 'Code speichern';
	@override String get chooseIcon => 'Symbol wählen';
	@override String get searchIcons => 'Symbole suchen — z. B. „Bank“ oder „Schloss“';
	@override String get popular => 'Beliebt';
	@override String noIcons({required Object search}) => 'Keine Symbole für „${search}“ gefunden.';
	@override String get useDefaultIcon => 'Standardsymbol verwenden';
	@override String iconMatches({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Treffer',
		other: '${n} Treffer',
	);
}

// Path: generator
class _Translations$generator$de extends Translations$generator$en {
	_Translations$generator$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Passwort generieren';
	@override String get notFilledIn => 'Nichts wird eingefügt, bevor Sie es übernehmen.';
	@override String get generated => 'Generiertes Passwort';
	@override String get mode => 'Art';
	@override String get passphrase => 'Passphrase';
	@override String get randomString => 'Zufällige Zeichenfolge';
	@override String get words => 'Wörter';
	@override String get fewerWords => 'Weniger Wörter';
	@override String get moreWords => 'Mehr Wörter';
	@override String get length => 'Länge';
	@override String get shorter => 'Kürzer';
	@override String get longer => 'Länger';
	@override String get wordSeparator => 'Worttrennzeichen';
	@override String get dash => 'Bindestrich';
	@override String get underscore => 'Unterstrich';
	@override String get slash => 'Schrägstrich';
	@override String get space => 'Leerzeichen';
	@override String get language => 'Sprache';
	@override String get regenerate => 'Neu generieren';
	@override String charCount({required Object count}) => '${count} Zeichen';
	@override String get lowercase => 'Kleinbuchstaben';
	@override String get uppercase => 'Großbuchstaben';
	@override String get digits => 'Ziffern';
	@override String get symbols => 'Symbole';
	@override String get pickOne => 'Wählen Sie mindestens eine Zeichenart.';
	@override String get use => 'Dieses Passwort verwenden';
	@override String wordCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Wort',
		other: '${n} Wörter',
	);
	@override String get pageTitle => 'Passwortgenerator';
	@override String get subtitle => 'Zufällige Passwörter und Passphrasen, auf diesem Gerät erzeugt';
	@override String get separatorDash => 'Bindestrich ( - )';
	@override String get separatorUnderscore => 'Unterstrich ( _ )';
	@override String get separatorSlash => 'Schrägstrich ( / )';
	@override String get separatorSpace => 'Leerzeichen';
	@override String get nothingToGenerate => 'Nichts zu generieren.';
	@override String get copyPassword => 'Passwort kopieren';
	@override String get copied => 'Passwort kopiert';
	@override String get fromGenerator => 'Aus dem Generator';
}

// Path: report
class _Translations$report$de extends Translations$report$en {
	_Translations$report$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sicherheitsbericht';
	@override String get subtitle => 'Wie gut Ihre gespeicherten Passwörter standhalten';
	@override String get healthLabel => 'Tresor-Zustand';
	@override String get healthGood => 'Stark';
	@override String get healthFair => 'Verbesserungsbedarf';
	@override String get healthPoor => 'Gefährdet';
	@override String get allClearTitle => 'Keine Probleme gefunden';
	@override String get allClearDescription => 'Jedes Passwort in Ihren Tresoren hat den letzten Audit bestanden.';
	@override String aboutSection({required Object title}) => 'Über ${title}';
	@override String get nothingFound => 'Nichts gefunden';
	@override String openItem({required Object name}) => '${name} öffnen';
	@override String get checkAgain => 'Erneut prüfen';
	@override String get statWeak => 'Schwach';
	@override String get statReused => 'Wiederverwendet';
	@override String get statCompromised => 'Kompromittiert';
	@override String statValue({required Object label, required Object count}) => '${label}: ${count}';
	@override String statNotChecked({required Object label}) => '${label}: noch nicht geprüft';
	@override String healthPercent({required Object title, required Object score}) => '${title} ${score} Prozent';
	@override String sameAs({required Object names}) => 'Wie bei ${names}';
	@override String get sameAsField => 'Wie ein anderes Passwort in diesem Eintrag';
	@override String get foundInBreach => 'In einem bekannten Datenleck gefunden';
	@override String get trust => 'Die Prüfung auf Datenlecks nutzt Have I Been Pwned mit k-Anonymität: Nur die ersten 5 Zeichen eines SHA-1-Hashes verlassen dieses Telefon.';
	@override String get lastCheckedJustNow => 'Zuletzt geprüft: gerade eben';
	@override String lastCheckedToday({required Object time}) => 'Zuletzt geprüft: heute um ${time}';
	@override String lastCheckedOn({required Object date}) => 'Zuletzt geprüft: ${date}';
	@override String get checking => 'Wird geprüft …';
	@override String checkingBreaches({required Object done, required Object total}) => 'Suche nach Datenlecks · ${done} von ${total}';
	@override String progress({required Object done, required Object total}) => '${done} von ${total}';
	@override String progressTime({required Object done, required Object total, required Object time}) => '${done} von ${total} · ${time}';
	@override String get offlineBody => 'Ihre Passwörter konnten nicht geprüft werden. Die Prüfung braucht eine Verbindung.';
	@override String get failedTitle => 'Die Prüfung konnte nicht abgeschlossen werden';
	@override String get failedBody => 'Versuchen Sie es gleich noch einmal.';
	@override String get nothingTitle => 'Noch nichts zu prüfen';
	@override String get nothingBody => 'Speichern Sie einen Eintrag mit Passwort, und er wird hier auf diesem Telefon auf schwache, wiederverwendete und geleakte Passwörter geprüft.';
	@override String get howToFix => 'So beheben Sie es';
	@override String get stepOpen => 'Öffnen Sie den Eintrag';
	@override String get stepGenerate => 'Tippen Sie auf Bearbeiten, dann beim Passwort auf Generieren';
	@override String get stepSave => 'Speichern – die Markierung verschwindet von selbst';
	@override String get stepSaveCompromised => 'Speichern Sie, und ändern Sie es auch auf der Website';
	@override String get changePassword => 'Passwort ändern';
	@override String fixedClear({required Object name}) => 'Gespeichert · ${name} ist nicht mehr markiert';
	@override String fixedFlagged({required Object name}) => 'Gespeichert · ${name} ist weiterhin markiert';
	@override String savedTo({required Object storage}) => 'Ihr Tresor wurde in ${storage} gespeichert';
	@override String get noLongerWeak => 'Nicht mehr schwach';
	@override String get noLongerReused => 'Nicht mehr wiederverwendet';
	@override String get noLongerWeakOrReused => 'Nicht mehr schwach oder wiederverwendet';
	@override String hintReusedOne({required Object n}) => 'Diese ${n} nutzen dasselbe Passwort. Geben Sie jedem ein eigenes: einen öffnen, auf Bearbeiten tippen, dann auf Generieren.';
	@override String get hintReusedSome => 'Einige davon nutzen dasselbe Passwort. Geben Sie jedem ein eigenes: einen öffnen, auf Bearbeiten tippen, dann auf Generieren.';
	@override String get hintWeak => 'Geben Sie jedem ein stärkeres: öffnen, auf Bearbeiten tippen, dann auf Generieren.';
	@override String get hintCompromised => 'Diese stehen in bekannten Datenlecks. Ändern Sie jedes: öffnen, auf Bearbeiten tippen, dann auf Generieren.';
	@override String itemsChecked({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Eintrag mit Passwort geprüft',
		other: '${n} Einträge mit Passwort geprüft',
	);
	@override String flagged({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Eintrag markiert',
		other: '${n} Einträge markiert',
	);
	@override String sameAsOthers({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Wie bei ${n} anderen Eintrag',
		other: 'Wie bei ${n} anderen Einträgen',
	);
	@override String checkingPasswords({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Passwort wird geprüft',
		other: '${n} Passwörter werden geprüft',
	);
	@override String aboutSeconds({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'etwa ${n} Sekunde',
		other: 'etwa ${n} Sekunden',
	);
	@override String aboutMinutes({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'etwa ${n} Minute',
		other: 'etwa ${n} Minuten',
	);
}

// Path: audit
class _Translations$audit$de extends Translations$audit$en {
	_Translations$audit$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$audit$weakPassword$de weakPassword = _Translations$audit$weakPassword$de._(_root);
	@override late final _Translations$audit$reusedPassword$de reusedPassword = _Translations$audit$reusedPassword$de._(_root);
	@override late final _Translations$audit$compromisedPassword$de compromisedPassword = _Translations$audit$compromisedPassword$de._(_root);
}

// Path: myVaults
class _Translations$myVaults$de extends Translations$myVaults$en {
	_Translations$myVaults$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Meine Tresore';
	@override String get subtitle => 'Getrennte Gruppen von Einträgen — Arbeit, Familie, Privat';
	@override String get defaultBadge => 'Standard';
	@override String get newVault => 'Neuer Tresor';
	@override String get emptyTitle => 'Sie haben nur den Standardtresor';
	@override String get emptyBody => 'Ein zweiter Tresor hält eine Gruppe von Einträgen getrennt — Arbeit von Privatem, oder Geteiltes von Privatem.';
	@override String createdOn({required Object date}) => 'erstellt ${date}';
	@override String get renameTitle => 'Tresor umbenennen';
	@override String get renameBody => 'Die enthaltenen Einträge sind davon nicht betroffen.';
	@override String duplicateRename({required Object name}) => 'Ein Tresor namens „${name}“ existiert bereits.';
	@override String deleteTitle({required Object name}) => '„${name}“ löschen?';
	@override String get deleteAction => 'Tresor löschen';
	@override String renameAria({required Object name}) => '${name} umbenennen';
	@override String deleteAria({required Object name}) => '${name} löschen';
	@override String itemCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Eintrag',
		other: '${n} Einträge',
	);
	@override String deleteBody({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Sein ${n} Eintrag wird in ${vault} verschoben. Dies kann nicht rückgängig gemacht werden.',
		other: 'Seine ${n} Einträge werden in ${vault} verschoben. Dies kann nicht rückgängig gemacht werden.',
	);
	@override String deleteSelectedTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tresor löschen?',
		other: '${n} Tresore löschen?',
	);
	@override String deleteSelectedBody({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Alles darin — ${n} Eintrag — wird in ${vault} verschoben. Dies kann nicht rückgängig gemacht werden.',
		other: 'Alles darin — ${n} Einträge — wird in ${vault} verschoben. Dies kann nicht rückgängig gemacht werden.',
	);
	@override String personalSummary({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${name} enthält ${n} Eintrag und kann nicht umbenannt oder gelöscht werden.',
		other: '${name} enthält ${n} Einträge und kann nicht umbenannt oder gelöscht werden.',
	);
	@override String selected({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tresor ausgewählt',
		other: '${n} Tresore ausgewählt',
	);
	@override String deleteVaults({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tresor löschen',
		other: '${n} Tresore löschen',
	);
}

// Path: tags
class _Translations$tags$de extends Translations$tags$en {
	_Translations$tags$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tags';
	@override String get subtitle => 'Markierungen über alle Tresore hinweg, um Dinge schnell zu finden';
	@override String since({required Object date}) => 'seit ${date}';
	@override String get addTag => 'Tag hinzufügen';
	@override String get addTitle => 'Tag hinzufügen';
	@override String get emptyTitle => 'Noch keine Tags';
	@override String get emptyBody => 'Tags werden von einem Eintrag aus oder hier erstellt — so oder so gruppieren sie Einträge über Tresore hinweg.';
	@override String get addBody => 'Ein Tag ohne Einträge. Weisen Sie es einem Eintrag von dessen eigener Seite aus zu.';
	@override String get tagName => 'Tag-Name';
	@override String get duplicate => 'Ein Tag mit diesem Namen existiert bereits.';
	@override String get colorNote => 'Seine Farbe ergibt sich aus dem Namen.';
	@override String get renameTitle => 'Tag umbenennen';
	@override String get renameBody => 'Jeder Eintrag, der es trägt, wird aktualisiert.';
	@override String mergeNotice({required Object name}) => '„${name}“ existiert bereits — das Umbenennen führt sie zusammen.';
	@override String deleteTitle({required Object name}) => '„${name}“ löschen?';
	@override String get deleteAction => 'Tag löschen';
	@override String get deleteSelectedBody => 'Jedes wird von jedem Eintrag entfernt, der es trägt. Die Einträge selbst bleiben erhalten. Dies kann nicht rückgängig gemacht werden.';
	@override String get footer => 'Tippen Sie auf einen Tag, um seine Einträge im Tab „Tresor“ zu sehen.';
	@override String renameAria({required Object name}) => '${name} umbenennen';
	@override String deleteAria({required Object name}) => '${name} löschen';
	@override String itemCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Eintrag',
		other: '${n} Einträge',
	);
	@override String deleteBody({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Es wird von ${n} Eintrag entfernt. Die Einträge selbst bleiben erhalten. Dies kann nicht rückgängig gemacht werden.',
		other: 'Es wird von ${n} Einträgen entfernt. Die Einträge selbst bleiben erhalten. Dies kann nicht rückgängig gemacht werden.',
	);
	@override String deleteSelectedTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tag löschen?',
		other: '${n} Tags löschen?',
	);
	@override String selected({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tag ausgewählt',
		other: '${n} Tags ausgewählt',
	);
	@override String deleteTags({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tag löschen',
		other: '${n} Tags löschen',
	);
}

// Path: changeSecret
class _Translations$changeSecret$de extends Translations$changeSecret$en {
	_Translations$changeSecret$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Geheimnis ändern';
	@override String get intro => 'Ihr Tresor wird mit dem neuen Geheimnis neu verschlüsselt und erneut hochgeladen. Er kann nicht wiederhergestellt werden, wenn Sie es vergessen.';
	@override String get current => 'Aktuelles Geheimnis';
	@override String get wrong => 'Das ist nicht Ihr aktuelles Geheimnis.';
	@override String get match => 'Die beiden Geheimnisse stimmen überein.';
	@override String get otherDevices => 'Andere Geräte fragen beim nächsten Öffnen Ihres Tresors nach dem neuen Geheimnis.';
	@override String get submit => 'Geheimnis ändern';
	@override String get verifyingMeta => 'Ihr aktuelles Geheimnis wird geprüft …';
	@override String get verifyingTitle => 'Ihr aktuelles Geheimnis wird überprüft …';
	@override String get stepVerify => 'Aktuelles Geheimnis wird überprüft';
	@override String get stepVerifyNote => 'Auf einem Telefon bewusst langsam — genau das macht das Erraten teuer';
	@override String get stepEncrypt => 'Wird mit dem neuen Geheimnis verschlüsselt';
	@override String get stepSave => 'Tresor wird gespeichert';
	@override String savingMeta({required Object storage}) => 'Wird in ${storage} gespeichert…';
	@override String savingTitle({required Object percent}) => 'Ihr Tresor wird gespeichert… ${percent}%';
	@override String get stepVerified => 'Aktuelles Geheimnis überprüft';
	@override String get stepEncrypted => 'Mit dem neuen Geheimnis verschlüsselt';
	@override String stepSaving({required Object storage}) => 'Wird in ${storage} gespeichert';
	@override String get keepOpen => 'Lassen Sie KeeperPass geöffnet, bis der Vorgang abgeschlossen ist.';
	@override String doneMeta({required Object storage}) => 'In ${storage} gespeichert';
	@override String get doneTitle => 'Ihr Geheimnis wurde geändert';
	@override String get doneBody => 'Alle Einträge sind erhalten geblieben. Andere Geräte fragen beim nächsten Öffnen Ihres Tresors nach dem neuen Geheimnis.';
	@override String get toast => 'Geheimnis geändert';
	@override String get failTitle => 'Ihr Tresor wurde nicht gespeichert';
	@override String failBody({required Object storage}) => '${storage} war nicht erreichbar. Ihr Geheimnis wurde nicht geändert: Der Tresor lässt sich weiterhin mit dem aktuellen öffnen.';
}

// Path: storage
class _Translations$storage$de extends Translations$storage$en {
	_Translations$storage$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Speicher';
	@override String get subtitle => 'Wo Ihr Tresor liegt und was darauf zugreifen kann';
	@override String diagram({required Object storage}) => 'Auf diesem Telefon verschlüsselt, in Ihrem ${storage} gespeichert';
	@override String get thisPhone => 'Dieses Telefon';
	@override String get encryptedOnly => 'Nur verschlüsselte Datei';
	@override String get googleFolder => 'Ordner keeperpass';
	@override String get dropboxFolder => 'Ordner Apps/keeperpass';
	@override String savedToday({required Object folder, required Object time}) => '${folder} · heute um ${time} gespeichert';
	@override String savedOn({required Object folder, required Object date}) => '${folder} · gespeichert am ${date}';
	@override String get access => 'Zugriff';
	@override String get googlePermissions => 'Berechtigungen des Google-Kontos';
	@override String get dropboxApps => 'Verbundene Dropbox-Apps';
	@override String get accessNote => 'KeeperPass kann nur auf die Dateien zugreifen, die es selbst erstellt. Sie können diesen Zugriff hier jederzeit widerrufen; die Tresordatei bleibt, wo sie ist.';
}

// Path: moveVault
class _Translations$moveVault$de extends Translations$moveVault$en {
	_Translations$moveVault$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tresor verschieben';
	@override String diagram({required Object from, required Object to}) => 'Ihr Tresor wird von ${from} nach ${to} verschoben';
	@override String get from => 'Quelle';
	@override String get to => 'Ziel';
	@override String get intro => 'Ihr Tresor wird kopiert und geprüft, und erst danach wird die alte Datei umbenannt. Schlägt etwas fehl, bleibt alles unverändert.';
	@override String step1({required Object storage}) => 'Melden Sie sich bei ${storage} an, um das Ziel für den Tresor zu wählen.';
	@override String get step2 => 'Bestätigen Sie. Vor diesem Schritt ändert sich nichts.';
	@override String get step3 => 'Der Tresor wird kopiert und geprüft; danach wird die alte Datei umbenannt, nie gelöscht.';
	@override String connect({required Object storage}) => '${storage} verbinden';
	@override String get account => 'Verschieben in dieses Konto';
	@override String existingTitle({required Object storage}) => 'In diesem ${storage}-Konto gibt es bereits einen KeeperPass-Tresor';
	@override String existingBody({required Object storage}) => 'Wenn Sie fortfahren, wird er als Sicherungsdatei mit Zeitstempel in ${storage} aufbewahrt und durch den Tresor ersetzt, den Sie verschieben.';
	@override String get existingConfirm => 'Ersetzen — der vorhandene Tresor bleibt als Sicherung erhalten';
	@override String get secretSection => 'Geheimnis für den verschobenen Tresor';
	@override String get keepSecret => 'Mein aktuelles Geheimnis behalten';
	@override String get newSecret => 'Neues Geheimnis wählen';
	@override String get newSecretNote => 'Nur der verschobene Tresor verwendet es';
	@override String get submit => 'Tresor verschieben';
	@override String get movingTitle => 'Ihr Tresor wird verschoben';
	@override String get stageEncrypting => 'Ihr Tresor wird verschlüsselt';
	@override String stageSaving({required Object storage}) => 'Wird in ${storage} gespeichert…';
	@override String get stageChecking => 'Die gespeicherte Kopie wird geprüft';
	@override String get stageRenaming => 'Die alte Datei wird umbenannt';
	@override String get movingNote => 'Lassen Sie KeeperPass geöffnet, bis der Vorgang abgeschlossen ist. Schlägt etwas fehl, bleibt alles unverändert.';
	@override String savedTo({required Object storage}) => 'In ${storage} gespeichert';
	@override String doneTitle({required Object storage}) => 'Ihr Tresor liegt jetzt in ${storage}';
	@override String doneBody({required Object provider, required Object from}) => 'Melden Sie sich mit ${provider} an, um ihn zu öffnen. Die alte Datei wurde in ${from} behalten und umbenannt:';
	@override String get copyFileName => 'Dateinamen kopieren';
	@override String get fileNameCopied => 'Dateiname kopiert';
	@override String partlyTitle({required Object storage}) => 'Ihr Tresor wurde nach ${storage} kopiert';
	@override String partlyBody({required Object from}) => 'Die alte Datei in ${from} konnte aber nicht umbenannt werden. Benennen Sie sie selbst um oder löschen Sie sie, damit die beiden Kopien nicht auseinanderlaufen.';
	@override String open({required Object storage}) => '${storage} öffnen';
	@override String unchanged({required Object from}) => 'Weiterhin in ${from} · unverändert';
	@override String get notMovedTitle => 'Ihr Tresor wurde nicht verschoben';
	@override String get notMovedBody => 'Die gespeicherte Kopie stimmte nicht mit Ihrem Tresor überein, daher blieb die alte Datei unberührt. Es ging nichts verloren — bitte versuchen Sie es erneut.';
}

// Path: dataIo
class _Translations$dataIo$de extends Translations$dataIo$en {
	_Translations$dataIo$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get importTitle => 'Importieren';
	@override String get file => 'Datei';
	@override String fileMeta({required Object size}) => '${size} · aus Dateien';
	@override String kilobytes({required Object n}) => '${n} KB';
	@override String megabytes({required Object n}) => '${n} MB';
	@override String get change => 'Ändern';
	@override String found({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Eintrag zum Importieren gefunden.',
		other: '${n} Einträge zum Importieren gefunden.',
	);
	@override String get addTo => 'Hinzufügen zu';
	@override String get importNote => 'Einträge werden dem gewählten Tresor hinzugefügt. Nichts wird ersetzt.';
	@override String importButton({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Eintrag importieren',
		other: '${n} Einträge importieren',
	);
	@override String get invalidCsv => 'Diese Datei konnte nicht als CSV gelesen werden.';
	@override String get noItems => 'In dieser Datei wurden keine Einträge gefunden.';
	@override String get notCsvNote => 'Exportieren Sie eine CSV-Datei aus Ihrem anderen Passwortmanager und wählen Sie diese Datei dann hier aus.';
	@override String get chooseAnother => 'Andere Datei wählen';
	@override String get exportTitle => 'Exportieren';
	@override String get exportIntro => 'Schreibt eine CSV-Datei des gewählten Tresors. Exportierte Einträge verlassen die Verschlüsselung des Tresors — was Sie mit der Datei tun, liegt bei Ihnen.';
	@override String get sourceVault => 'Quelltresor';
	@override String get notEncryptedTitle => 'Eine CSV-Datei ist nicht verschlüsselt';
	@override String get notEncryptedBody => 'Wer sie öffnet, kann jedes Passwort darin lesen. Bewahren Sie sie sicher auf und löschen Sie sie, wenn Sie fertig sind.';
	@override String exportButton({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Eintrag exportieren',
		other: '${n} Einträge exportieren',
	);
	@override String get exportNote => 'Öffnet das Teilen-Menü, damit Sie selbst wählen, wohin die Datei geht.';
	@override String get recentTitle => 'Letzte Exporte';
	@override String recentRow({required num n, required Object scope}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${scope} · ${n} Eintrag',
		other: '${scope} · ${n} Einträge',
	);
	@override String get recentNote => 'Die letzten 10 Exporte werden in Ihrem Tresor vermerkt. KeeperPass bewahrt keine Kopie der Dateien selbst auf.';
	@override String get recentEmpty => 'Noch keine Exporte.';
}

// Path: archive
class _Translations$archive$de extends Translations$archive$en {
	_Translations$archive$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tresor archivieren';
	@override String get headline => 'Tresor archivieren und abmelden';
	@override String body({required Object storage}) => 'Ihr Tresor ist eine einzelne verschlüsselte Datei in Ihrem eigenen ${storage}. Beim Archivieren wird sie umbenannt, sodass diese App sie nicht mehr findet, und Sie werden abgemeldet. Es wird nichts gelöscht.';
	@override String step1({required Object oldName, required Object folder, required Object newName}) => '${oldName} wird im selben ${folder} in ${newName} umbenannt.';
	@override String step2({required Object storage}) => 'Dieses Telefon meldet sich von ${storage} ab.';
	@override String step3({required Object storage}) => 'Um die Daten selbst zu löschen, löschen Sie diese Datei in ${storage}.';
	@override String get typePrefix => 'Geben Sie zur Bestätigung';
	@override String get typeSuffix => 'ein.';
	@override String get confirmation => 'Bestätigung';
	@override String get button => 'Archivieren und abmelden';
	@override String get doneMeta => 'Umbenannt · diese App findet sie nicht mehr';
	@override String get doneTitle => 'Ihre Tresordatei wurde umbenannt';
	@override String doneBody({required Object folder, required Object storage}) => 'Sie liegt weiterhin im ${folder} in Ihrem ${storage}. Löschen Sie sie dort, wenn die Daten endgültig verschwinden sollen.';
	@override String get signedOut => 'Sie sind auf diesem Telefon abgemeldet.';
	@override String get error => 'Die Tresordatei konnte nicht umbenannt werden. Es wurde nichts geändert.';
}

// Path: help
class _Translations$help$de extends Translations$help$en {
	_Translations$help$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get howTitle => 'So funktioniert KeeperPass';
	@override String get howSubtitle => 'Wo Ihre Daten liegen und was sie privat hält';
	@override String get whereLives => 'Wo Ihre Daten liegen';
	@override String diagram({required Object storage}) => 'Ihr Tresor wird auf diesem Telefon verschlüsselt und als eine Datei in Ihrem ${storage} gespeichert';
	@override String get thisPhoneNote => 'Verschlüsselt und entschlüsselt alles. Ihr Geheimnis verlässt es nie.';
	@override String get fileEncrypted => 'vault.json.enc · verschlüsselt';
	@override String yourStorage({required Object storage}) => 'Ihr ${storage}';
	@override String get storageNote => 'Enthält die Datei, die ohne Ihr Geheimnis unlesbar ist.';
	@override String get noServer => 'KeeperPass erhält Ihre Daten nie. Es gibt kein Konto, in das eingebrochen werden könnte, und keinen Betreiber, der Ihren Tresor lesen könnte.';
	@override String get protects => 'Was ihn schützt';
	@override String get secretTerm => 'Ihr Geheimnis';
	@override String get secretNote => 'Nie gesendet, nie gespeichert. Es existiert nur im Arbeitsspeicher, solange die App entsperrt ist.';
	@override String get kdfTerm => 'Schlüsselableitung';
	@override String get kdfNote => 'Bewusst langsam, damit jeder Versuch, Ihr Geheimnis zu erraten, teuer ist.';
	@override String get encryptionTerm => 'Verschlüsselung';
	@override String get encryptionNote => 'Hält die Datei unlesbar und zeigt, ob jemand sie verändert hat.';
	@override String get accessTerm => 'Speicherzugriff';
	@override String get accessNote => 'KeeperPass kann nur auf die Dateien zugreifen, die es selbst erstellt.';
	@override String get signingIn => 'Anmelden';
	@override String get step1 => 'Cloud-Speicher verbinden';
	@override String get step1Note => 'Belegt, wem die Datei gehört. Entsperrt wird dadurch nichts.';
	@override String get step2 => 'Geheimnis eingeben';
	@override String get step2Note => 'Erzeugt auf diesem Telefon den Schlüssel, der die Datei öffnet. Ihr Speicheranbieter sieht ihn nie.';
	@override String get bothNeeded => 'Wer Ihr Speicherkonto hat, kann Ihren Tresor trotzdem nicht lesen. Wer Ihr Geheimnis kennt, erreicht die Datei trotzdem nicht. Es braucht beides.';
	@override String get terms => 'Begriffe, die Sie kennen sollten';
	@override String get secretWord => 'Geheimnis';
	@override String get secretDef => 'Die eine Phrase, die Ihren Tresor entsperrt. Sie kann nicht wiederhergestellt werden.';
	@override String get vaultWord => 'Tresor';
	@override String get vaultDef => 'Eine Gruppe von Einträgen. Mit mehreren halten Sie Arbeit und Privates getrennt.';
	@override String get tagWord => 'Tag';
	@override String get tagDef => 'Eine Markierung, um Einträge über Tresore hinweg zu finden, etwa Arbeit oder Bank.';
	@override String get reportWord => 'Sicherheitsbericht';
	@override String get reportDef => 'Markiert auf diesem Telefon schwache, wiederverwendete und geleakte Passwörter.';
}

// Path: faq
class _Translations$faq$de extends Translations$faq$en {
	_Translations$faq$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Fragen';
	@override String get subtitle => 'Antworten auf häufige Fragen';
	@override String get forgetQ => 'Was, wenn ich mein Geheimnis vergesse?';
	@override String get forgetA1 => 'Ihr Tresor kann nicht wiederhergestellt werden — weder von Ihnen noch von uns. Der Schlüssel wird allein aus Ihrem Geheimnis erzeugt, ohne es bleibt die Datei also unlesbar. Das ist der Preis dafür, dass auch sonst niemand sie lesen kann.';
	@override String forgetA2({required Object forgot, required Object file}) => 'Sie können aber neu beginnen: ${forgot} auf dem Entsperrbildschirm richtet einen neuen, leeren Tresor ein. Ihre alte Datei wird nicht gelöscht — sie wird in ${file} umbenannt und in Ihrem Ordner keeperpass aufbewahrt, sodass die Daten noch da sind, falls Ihnen das Geheimnis wieder einfällt.';
	@override String get forgetA2Link => 'Geheimnis vergessen?';
	@override String get forgetA3 => 'Notieren Sie sich Ihr Geheimnis und bewahren Sie es sicher auf. Es ist das Einzige bei KeeperPass, das nicht ersetzt werden kann.';
	@override String get seeQ => 'Kann KeeperPass meine Passwörter sehen?';
	@override String get seeA => 'Nein — und das ist kein Versprechen, sondern eine Folge des Designs. Verschlüsselt wird auf diesem Telefon, und der Geheimtext geht direkt in Ihren eigenen Speicher. Es gibt keinen KeeperPass-Server dazwischen, der etwas sehen könnte.';
	@override String get syncQ => 'Synchronisiert es geräteübergreifend?';
	@override String get syncA => 'Ja. Jedes Gerät liest dieselbe Datei aus Ihrem Speicher. Melden Sie sich mit demselben Konto an, geben Sie dasselbe Geheimnis ein, und Ihr Tresor ist da.';
	@override String get providerQ => 'Was, wenn mein Speicheranbieter die Datei liest?';
	@override String get providerA => 'Er sähe nur verschlüsselte Bytes. Der Schlüssel verlässt dieses Telefon nie, daher können weder Google noch Dropbox noch ein anderer Anbieter den Inhalt lesen.';
	@override String get importQ => 'Kann ich aus einem anderen Passwortmanager importieren?';
	@override String get importA => 'Ja — exportieren Sie dort als CSV und verwenden Sie dann Importieren in den Einstellungen.';
	@override String get changeSecretQ => 'Wie ändere ich mein Geheimnis?';
	@override String changeSecretA({required Object action}) => 'Öffnen Sie die Einstellungen und wählen Sie ${action}. Sie geben Ihr aktuelles Geheimnis und das neue ein; Ihr Tresor wird entschlüsselt, mit dem neuen Geheimnis neu verschlüsselt und zurückgespeichert. Nichts geht verloren — jeder Eintrag bleibt erhalten, und die Änderung gilt auf jedem Gerät, sobald es Ihren Tresor das nächste Mal lädt.';
	@override String get costQ => 'Was kostet es?';
	@override String get costA => 'Nichts. KeeperPass ist kostenlos und quelloffen und speichert die Daten in Cloud-Speicher, den Sie bereits haben.';
	@override String get stillStuck => 'Immer noch nicht weiter?';
	@override String get contactBody => 'Fragen, Feedback oder ein Problem? Schreiben Sie uns eine E-Mail.';
}

// Path: about
class _Translations$about$de extends Translations$about$en {
	_Translations$about$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String version({required Object version, required Object build}) => 'Version ${version} (${build})';
	@override String get tagline => 'Ihre Cloud. Ihre Schlüssel. Ihr Tresor.';
	@override String get license => 'Kostenlos und quelloffen unter AGPL-3.0';
	@override String get terms => 'Nutzungsbedingungen';
	@override String get privacy => 'Datenschutzerklärung';
	@override String get promise => 'Kostenlos, ohne Haken: keine Tarife, keine Premium-Stufe, keine Zusatzverkäufe.';
}

// Path: clipboard
class _Translations$clipboard$de extends Translations$clipboard$en {
	_Translations$clipboard$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String clearsIn({required Object time}) => 'Wird in ${time} geleert';
	@override String get cleared => 'Zwischenablage geleert';
}

// Path: sync
class _Translations$sync$de extends Translations$sync$en {
	_Translations$sync$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String savedTo({required Object storage}) => 'In ${storage} gespeichert';
	@override String get notSavedTitle => 'Ihr Tresor wurde nicht gespeichert';
	@override String notSavedBody({required Object storage}) => '${storage} war nicht erreichbar. Ihre Änderung ist noch da – wiederholen Sie den Vorgang, bevor Sie KeeperPass schließen.';
	@override String get dismiss => 'Verwerfen';
	@override String get retryingTitle => 'Neuer Versuch …';
	@override String retryingBody({required Object storage}) => 'Wird in ${storage} gespeichert.';
	@override String reconnectTitle({required Object storage}) => 'Erneut mit ${storage} verbinden';
	@override String get keepReading => 'Sie können weiterlesen; Änderungen werden gespeichert, sobald Sie wieder verbunden sind.';
	@override String get reconnect => 'Erneut verbinden';
	@override String get later => 'Später';
	@override String offlineBody({required Object storage}) => 'Sie können weiter lesen und kopieren. Zum Speichern ist eine Verbindung zu ${storage} nötig.';
	@override String get changedTitle => 'Ihr Tresor wurde geändert';
	@override String get changedBody => 'Auf einem anderen Gerät wurde eine neuere Version Ihres Tresors gespeichert. Laden Sie sie, bevor Sie bearbeiten, damit nichts überschrieben wird.';
	@override String get twoVersions => 'Zwei Versionen';
	@override String get onThisPhone => 'Auf diesem Telefon';
	@override String inStorage({required Object storage}) => 'In ${storage}';
	@override String loadedAt({required Object time}) => 'geladen: ${time}';
	@override String savedNewer({required Object time}) => 'gespeichert: ${time} · neuer';
	@override String get loadLatest => 'Neueste Version laden';
	@override String get notNow => 'Nicht jetzt';
	@override String get pausedNote => 'Bis dahin können Sie lesen und kopieren, aber nicht bearbeiten.';
	@override String get upToDate => 'Auf dem neuesten Stand';
	@override String loadedVersion({required Object time}) => 'Die um ${time} gespeicherte Version wurde geladen';
}

// Path: scan
class _Translations$scan$de extends Translations$scan$en {
	_Translations$scan$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'QR-Code scannen';
	@override String get primerTitle => '2FA-Code per Scan hinzufügen';
	@override String get primerBody => 'Wenn eine Website die Zwei-Faktor-Anmeldung einschaltet, zeigt sie einen QR-Code. KeeperPass liest ihn mit der Kamera und bewahrt den Einrichtungsschlüssel in Ihrem Tresor auf, damit seine Codes unter „Codes“ erscheinen.';
	@override String get primerPrivacy => 'Die Kamera liest nur den Code. Es wird nichts aufgezeichnet und kein Bild gespeichert.';
	@override String get primerNext => 'Als Nächstes fragt Ihr Telefon nach dem Kamerazugriff.';
	@override String get enterInstead => 'Stattdessen Einrichtungsschlüssel eingeben';
	@override String get hint => 'Richten Sie die Kamera auf den QR-Code, den die Website\nbeim Einschalten der Zwei-Faktor-Anmeldung zeigt.';
	@override String get torch => 'Licht einschalten';
	@override String get cameraView => 'Kameraansicht';
	@override String get codeFound => 'Code gefunden';
	@override String get saveTo => 'Speichern in';
	@override String get existingItem => 'Vorhandener Eintrag';
	@override String existingItemWith({required Object summary}) => 'Vorhandener Eintrag · ${summary}';
	@override String get newAuthenticator => 'Neuer Eintrag „Authentifizierung“';
	@override String named({required Object name}) => 'Mit dem Namen ${name}';
	@override String get cameraOffTitle => 'Kamerazugriff ist aus';
	@override String get cameraOffBody => 'KeeperPass braucht die Kamera nur, um QR-Codes zu lesen. Schalten Sie sie in den Einstellungen ein oder geben Sie stattdessen den Einrichtungsschlüssel ein.';
	@override String get openSettings => 'Einstellungen öffnen';
	@override String get unsupported => 'Dieser Code nutzt Einstellungen, die KeeperPass noch nicht unterstützt';
	@override String get notACode => 'Das ist kein 2FA-QR-Code';
	@override String get cameraFailed => 'Die Kamera konnte nicht starten';
	@override String get item => 'Eintrag';
	@override String get codeSettings => '6 Ziffern · alle 30 Sekunden · SHA-1';
	@override String codeAdded({required Object name}) => 'Code zu ${name} hinzugefügt';
	@override String get tapToCopy => 'Tippen Sie auf die Karte, um ihn zu kopieren.';
}

// Path: errors.failures
class _Translations$errors$failures$de extends Translations$errors$failures$en {
	_Translations$errors$failures$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get networkFailure => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.';
	@override String get undocumentedError => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.';
	@override String get platformError => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.';
	@override String get notFound => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.';
	@override String get formatException => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.';
	@override String get unableToProcess => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.';
	@override String get requestTimeout => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.';
	@override String get connectionError => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.';
	@override String get unexpectedError => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.';
	@override String get accessTokenFailure => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.';
	@override String get cacheReadFailure => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.';
	@override String get cacheWriteFailure => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.';
}

// Path: errors.drive
class _Translations$errors$drive$de extends Translations$errors$drive$en {
	_Translations$errors$drive$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get authExpired => 'Ihre Google-Sitzung ist abgelaufen. Bitte verbinden Sie sich erneut.';
	@override String get backupFailed => 'Ihr bestehender Tresor konnte nicht in Google Drive gesichert werden. Bitte versuchen Sie es erneut.';
	@override String get renameFailed => 'Ihre Tresordatei konnte in Google Drive nicht umbenannt werden. Es wurde nichts geändert – bitte versuchen Sie es erneut.';
	@override String get createFolderFailed => 'Der keeperpass-Ordner konnte in Google Drive nicht erstellt werden. Bitte versuchen Sie es erneut.';
	@override String get readFailed => 'Ihr Tresor konnte nicht aus Google Drive gelesen werden. Bitte versuchen Sie es erneut.';
	@override String get saveFailed => 'Ihr Tresor konnte nicht in Google Drive gespeichert werden. Bitte versuchen Sie es erneut.';
	@override String get unreachable => 'Google Drive konnte nicht erreicht werden. Bitte versuchen Sie es erneut.';
}

// Path: errors.dropbox
class _Translations$errors$dropbox$de extends Translations$errors$dropbox$en {
	_Translations$errors$dropbox$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get authExpired => 'Ihre Dropbox-Sitzung ist abgelaufen. Bitte verbinden Sie sich erneut.';
	@override String get profileFailed => 'Ihr Dropbox-Profil konnte nicht gelesen werden. Bitte versuchen Sie es erneut.';
	@override String get unknown => 'Bei der Verbindung mit Dropbox ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut.';
	@override String get unreachable => 'Dropbox konnte nicht erreicht werden. Bitte versuchen Sie es erneut.';
	@override String get readFailed => 'Ihr Tresor konnte nicht aus Dropbox gelesen werden. Bitte versuchen Sie es erneut.';
	@override String get saveFailed => 'Ihr Tresor konnte nicht in Dropbox gespeichert werden. Bitte versuchen Sie es erneut.';
	@override String get backupFailed => 'Ihr bestehender Tresor konnte nicht in Dropbox gesichert werden. Bitte versuchen Sie es erneut.';
	@override String get renameFailed => 'Ihre Tresordatei konnte in Dropbox nicht umbenannt werden. Es wurde nichts geändert – bitte versuchen Sie es erneut.';
	@override String get missingScope => 'KeeperPass fehlt eine Dropbox-Berechtigung. Das ist ein Konfigurationsproblem, das sich durch erneutes Anmelden nicht beheben lässt.';
	@override String get rateLimited => 'Dropbox bittet darum, langsamer vorzugehen. Bitte warten Sie einen Moment und versuchen Sie es erneut.';
}

// Path: errors.auth
class _Translations$errors$auth$de extends Translations$errors$auth$en {
	_Translations$errors$auth$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get profileFailed => 'Ihr Google-Profil konnte nicht gelesen werden. Bitte versuchen Sie es erneut.';
	@override String get unknown => 'Bei der Verbindung mit Google ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut.';
}

// Path: errors.masterPassword
class _Translations$errors$masterPassword$de extends Translations$errors$masterPassword$en {
	_Translations$errors$masterPassword$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get vaultNotFound => 'Ihr Tresor wurde nicht gefunden.';
}

// Path: errors.vault
class _Translations$errors$vault$de extends Translations$errors$vault$en {
	_Translations$errors$vault$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String accountMismatch({required Object email}) => 'Melden Sie sich mit ${email} an, um Ihre Änderungen zu speichern.';
	@override String get driveAccessNotGranted => 'Google hat KeeperPass keinen Zugriff auf die Dateien gewährt, die es in Ihrem Drive erstellt. Versuchen Sie es erneut und erlauben Sie diesen Zugriff auf der Seite von Google.';
	@override String get conflict => 'Eine neuere Version Ihres Tresors wurde auf einem anderen Gerät gespeichert. Laden Sie sie, bevor Sie etwas bearbeiten, damit nichts überschrieben wird.';
	@override String get signInCanceled => 'Anmeldung abgebrochen';
	@override String get unsupported => 'Diese Tresordatei kann mit dieser Version von KeeperPass nicht geöffnet werden.';
	@override String get corrupt => 'Ihre Tresordatei ist beschädigt und kann nicht geöffnet werden.';
}

// Path: settings.migrate
class _Translations$settings$migrate$de extends Translations$settings$migrate$en {
	_Translations$settings$migrate$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$settings$migrate$error$de error = _Translations$settings$migrate$error$de._(_root);
}

// Path: auth.unlock
class _Translations$auth$unlock$de extends Translations$auth$unlock$en {
	_Translations$auth$unlock$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get incorrectSecret => 'Falsches Geheimnis. Bitte versuchen Sie es erneut.';
}

// Path: editItem.templates
class _Translations$editItem$templates$de extends Translations$editItem$templates$en {
	_Translations$editItem$templates$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get website => 'Website oder App';
	@override String get computer => 'Computer';
	@override String get creditCard => 'Kreditkarte';
	@override String get bankAccount => 'Bankkonto';
	@override String get wifi => 'WLAN-Netzwerk';
	@override String get passport => 'Reisepass';
	@override String get note => 'Notiz';
	@override String get authenticator => 'Authentifizierung';
	@override String get custom => 'Benutzerdefiniert';
}

// Path: editItem.templateHints
class _Translations$editItem$templateHints$de extends Translations$editItem$templateHints$en {
	_Translations$editItem$templateHints$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get website => 'Benutzername, Passwort, URL';
	@override String get computer => 'Benutzername, Passwort';
	@override String get creditCard => 'Nummer, Inhaber, Ablauf, CVC, PIN';
	@override String get bankAccount => 'Inhaber, IBAN, BIC, PIN';
	@override String get wifi => 'Netzwerkname, Passwort';
	@override String get passport => 'Nummer, Name, Daten';
	@override String get note => 'Eine formatierte Notiz';
	@override String get authenticator => 'Ein 2FA-Code';
	@override String get custom => 'Noch keine Felder';
}

// Path: editItem.templateFields
class _Translations$editItem$templateFields$de extends Translations$editItem$templateFields$en {
	_Translations$editItem$templateFields$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get cardholder => 'Karteninhaber';
	@override String get expiresOn => 'Gültig bis';
	@override String get cvc => 'CVC';
	@override String get accountHolder => 'Kontoinhaber';
	@override String get iban => 'IBAN';
	@override String get bic => 'BIC';
	@override String get cardPin => 'Karten-PIN';
	@override String get networkName => 'Netzwerkname';
	@override String get fullName => 'Vollständiger Name';
	@override String get passportNumber => 'Passnummer';
	@override String get issuingCountry => 'Ausstellendes Land';
	@override String get dateOfBirth => 'Geburtsdatum';
	@override String get placeOfBirth => 'Geburtsort';
	@override String get issuedOn => 'Ausgestellt am';
}

// Path: editItem.types
class _Translations$editItem$types$de extends Translations$editItem$types$en {
	_Translations$editItem$types$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get username => 'Benutzername';
	@override String get password => 'Passwort';
	@override String get email => 'E-Mail';
	@override String get url => 'URL';
	@override String get ipHost => 'IP / Host';
	@override String get date => 'Datum';
	@override String get month => 'Monat';
	@override String get credit => 'Kartennummer';
	@override String get phone => 'Telefon';
	@override String get pin => 'PIN';
	@override String get totp => 'Authentifizierungscode';
	@override String get certificate => 'Zertifikat';
	@override String get sshKey => 'SSH-/Privatschlüssel';
	@override String get recoveryCodes => 'Wiederherstellungscodes';
	@override String get note => 'Formatierte Notiz';
	@override String get text => 'Text';
}

// Path: audit.weakPassword
class _Translations$audit$weakPassword$de extends Translations$audit$weakPassword$en {
	_Translations$audit$weakPassword$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Schwache Passwörter';
	@override String get description => 'Ein Passwort ist schwach, wenn der Suchraum für einen Angreifer klein ist: Es ist kurz, nutzt nur wenige verschiedene Zeichen oder basiert auf einem Wort, Namen oder einer Tastaturfolge, die in jedem Cracking-Wörterbuch steht. Offline-Angriffe schaffen Milliarden Versuche pro Sekunde, sodass alles in dieser Kategorie schnell fällt. Ersetzen Sie es durch ein langes, zufällig generiertes Passwort.';
}

// Path: audit.reusedPassword
class _Translations$audit$reusedPassword$de extends Translations$audit$reusedPassword$en {
	_Translations$audit$reusedPassword$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Wiederverwendete Passwörter';
	@override String get description => 'Ein Passwort, das an mehreren Stellen verwendet wird, bedeutet, dass ein einziges Datenleck alle diese Konten öffnet – und Sie haben keinen Einfluss darauf, welcher dieser Dienste als Nächstes betroffen ist. Geben Sie jedem Eintrag ein eigenes generiertes Passwort, damit ein Leck auf das Konto beschränkt bleibt, aus dem es stammt.';
}

// Path: audit.compromisedPassword
class _Translations$audit$compromisedPassword$de extends Translations$audit$compromisedPassword$en {
	_Translations$audit$compromisedPassword$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Kompromittierte Passwörter';
	@override String get description => 'Dieses Passwort erscheint in einer öffentlichen Liste geleakter Zugangsdaten, wodurch es zu den ersten gehört, die Angreifer ausprobieren – egal wie stark es wirkt. Ändern Sie es überall, wo es verwendet wird: Ein Passwort muss nur einmal geleakt werden, um dauerhaft kompromittiert zu bleiben.';
}

// Path: settings.migrate.error
class _Translations$settings$migrate$error$de extends Translations$settings$migrate$error$en {
	_Translations$settings$migrate$error$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get sameProvider => 'Der Tresor liegt bereits in diesem Speicher.';
	@override String get busy => 'Ein Speichervorgang läuft noch. Warten Sie, bis er abgeschlossen ist, und versuchen Sie es erneut.';
	@override String get sourceExpired => 'Ihre aktuelle Sitzung ist abgelaufen. Bitte melden Sie sich erneut an, bevor Sie den Tresor verschieben.';
	@override String targetExpired({required Object provider}) => 'Ihre ${provider}-Anmeldung ist abgelaufen. Es wurde nichts verändert — bitte beginnen Sie von vorn.';
	@override String get verifyFailed => 'Die gespeicherte Kopie stimmte nicht mit Ihrem Tresor überein, daher blieb die alte Datei unberührt. Es ging nichts verloren — bitte versuchen Sie es erneut.';
}

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'KeeperPass',
			'connectivity.offline' => 'Keine Internetverbindung',
			'connectivity.online' => 'Wieder online',
			'errors.failures.networkFailure' => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.',
			'errors.failures.undocumentedError' => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.',
			'errors.failures.platformError' => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.',
			'errors.failures.notFound' => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.',
			'errors.failures.formatException' => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.',
			'errors.failures.unableToProcess' => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.',
			'errors.failures.requestTimeout' => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.',
			'errors.failures.connectionError' => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.',
			'errors.failures.unexpectedError' => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.',
			'errors.failures.accessTokenFailure' => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.',
			'errors.failures.cacheReadFailure' => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.',
			'errors.failures.cacheWriteFailure' => 'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.',
			'errors.drive.authExpired' => 'Ihre Google-Sitzung ist abgelaufen. Bitte verbinden Sie sich erneut.',
			'errors.drive.backupFailed' => 'Ihr bestehender Tresor konnte nicht in Google Drive gesichert werden. Bitte versuchen Sie es erneut.',
			'errors.drive.renameFailed' => 'Ihre Tresordatei konnte in Google Drive nicht umbenannt werden. Es wurde nichts geändert – bitte versuchen Sie es erneut.',
			'errors.drive.createFolderFailed' => 'Der keeperpass-Ordner konnte in Google Drive nicht erstellt werden. Bitte versuchen Sie es erneut.',
			'errors.drive.readFailed' => 'Ihr Tresor konnte nicht aus Google Drive gelesen werden. Bitte versuchen Sie es erneut.',
			'errors.drive.saveFailed' => 'Ihr Tresor konnte nicht in Google Drive gespeichert werden. Bitte versuchen Sie es erneut.',
			'errors.drive.unreachable' => 'Google Drive konnte nicht erreicht werden. Bitte versuchen Sie es erneut.',
			'errors.dropbox.authExpired' => 'Ihre Dropbox-Sitzung ist abgelaufen. Bitte verbinden Sie sich erneut.',
			'errors.dropbox.profileFailed' => 'Ihr Dropbox-Profil konnte nicht gelesen werden. Bitte versuchen Sie es erneut.',
			'errors.dropbox.unknown' => 'Bei der Verbindung mit Dropbox ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut.',
			'errors.dropbox.unreachable' => 'Dropbox konnte nicht erreicht werden. Bitte versuchen Sie es erneut.',
			'errors.dropbox.readFailed' => 'Ihr Tresor konnte nicht aus Dropbox gelesen werden. Bitte versuchen Sie es erneut.',
			'errors.dropbox.saveFailed' => 'Ihr Tresor konnte nicht in Dropbox gespeichert werden. Bitte versuchen Sie es erneut.',
			'errors.dropbox.backupFailed' => 'Ihr bestehender Tresor konnte nicht in Dropbox gesichert werden. Bitte versuchen Sie es erneut.',
			'errors.dropbox.renameFailed' => 'Ihre Tresordatei konnte in Dropbox nicht umbenannt werden. Es wurde nichts geändert – bitte versuchen Sie es erneut.',
			'errors.dropbox.missingScope' => 'KeeperPass fehlt eine Dropbox-Berechtigung. Das ist ein Konfigurationsproblem, das sich durch erneutes Anmelden nicht beheben lässt.',
			'errors.dropbox.rateLimited' => 'Dropbox bittet darum, langsamer vorzugehen. Bitte warten Sie einen Moment und versuchen Sie es erneut.',
			'errors.auth.profileFailed' => 'Ihr Google-Profil konnte nicht gelesen werden. Bitte versuchen Sie es erneut.',
			'errors.auth.unknown' => 'Bei der Verbindung mit Google ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut.',
			'errors.masterPassword.vaultNotFound' => 'Ihr Tresor wurde nicht gefunden.',
			'errors.vault.accountMismatch' => ({required Object email}) => 'Melden Sie sich mit ${email} an, um Ihre Änderungen zu speichern.',
			'errors.vault.driveAccessNotGranted' => 'Google hat KeeperPass keinen Zugriff auf die Dateien gewährt, die es in Ihrem Drive erstellt. Versuchen Sie es erneut und erlauben Sie diesen Zugriff auf der Seite von Google.',
			'errors.vault.conflict' => 'Eine neuere Version Ihres Tresors wurde auf einem anderen Gerät gespeichert. Laden Sie sie, bevor Sie etwas bearbeiten, damit nichts überschrieben wird.',
			'errors.vault.signInCanceled' => 'Anmeldung abgebrochen',
			'errors.vault.unsupported' => 'Diese Tresordatei kann mit dieser Version von KeeperPass nicht geöffnet werden.',
			'errors.vault.corrupt' => 'Ihre Tresordatei ist beschädigt und kann nicht geöffnet werden.',
			'common.close' => 'Schließen',
			'common.copy' => 'Kopieren',
			'common.copied' => 'Kopiert',
			'common.cancel' => 'Abbrechen',
			'common.save' => 'Speichern',
			'common.back' => 'Zurück',
			'common.favorite' => 'Favorit',
			'common.showSecret' => 'Geheimnis anzeigen',
			'common.hideSecret' => 'Geheimnis verbergen',
			'common.empty' => '[leer]',
			'common.clearSearch' => 'Suche löschen',
			'common.chooseDate' => 'Datum auswählen',
			'common.chooseMonth' => 'Monat auswählen',
			'common.countryCode' => 'Ländervorwahl',
			'common.countryCodeValue' => ({required Object country, required Object code}) => 'Ländervorwahl: ${country}, ${code}',
			'common.removeTag' => ({required Object tag}) => 'Tag ${tag} entfernen',
			'common.secretChip' => 'Geheim',
			'common.secretToggle' => ({required Object field}) => 'Geheim: ${field}',
			'common.reorderField' => ({required Object field}) => '${field} verschieben',
			'common.removeField' => ({required Object field}) => '${field} entfernen',
			'common.changeFieldIcon' => ({required Object field}) => 'Symbol für ${field} ändern',
			'common.showAll' => ({required Object count}) => 'Alle ${count} anzeigen',
			'common.showInLargeType' => 'In großer Schrift anzeigen',
			'common.stepOf' => ({required Object current, required Object total}) => 'Schritt ${current} von ${total}',
			'common.next' => 'Weiter',
			'common.continueAction' => 'Weiter',
			'common.tryAgain' => 'Erneut versuchen',
			'common.retry' => 'Wiederholen',
			'common.show' => 'Anzeigen',
			'common.hide' => 'Ausblenden',
			'common.gotIt' => 'Verstanden',
			'common.disconnect' => 'Trennen',
			'common.generateSecret' => 'Geheimnis generieren',
			'common.useAnotherAccount' => 'Anderes Konto verwenden',
			'common.offlineTitle' => 'Sie sind offline',
			'common.savingTo' => ({required Object provider}) => 'Wird in ${provider} gespeichert…',
			'common.keepOpen' => 'Lassen Sie KeeperPass geöffnet, bis dies abgeschlossen ist.',
			'common.typeItAgain' => 'Erneut eingeben',
			'common.secretHiddenValue' => 'Verborgen',
			'common.rename' => 'Umbenennen',
			'common.done' => 'Fertig',
			'strength.veryWeak' => 'Sehr schwach',
			'strength.weak' => 'Schwach',
			'strength.fair' => 'Mittel',
			'strength.strong' => 'Stark',
			'strength.veryStrong' => 'Sehr stark',
			'strength.meter' => ({required Object level}) => 'Stärke: ${level}',
			'totp.invalidCode' => 'Ungültiger Code',
			'totp.invalidKey' => 'Der Einrichtungsschlüssel ist ungültig, daher kann kein Code erzeugt werden.',
			'totp.fixInEdit' => 'In „Bearbeiten“ beheben',
			'totp.secondsShort' => ({required Object count}) => '${count} s',
			'totp.secondsLeft' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(count, one: 'Noch ${count} Sekunde', other: 'Noch ${count} Sekunden', ), 
			'settings.migrate.error.sameProvider' => 'Der Tresor liegt bereits in diesem Speicher.',
			'settings.migrate.error.busy' => 'Ein Speichervorgang läuft noch. Warten Sie, bis er abgeschlossen ist, und versuchen Sie es erneut.',
			'settings.migrate.error.sourceExpired' => 'Ihre aktuelle Sitzung ist abgelaufen. Bitte melden Sie sich erneut an, bevor Sie den Tresor verschieben.',
			'settings.migrate.error.targetExpired' => ({required Object provider}) => 'Ihre ${provider}-Anmeldung ist abgelaufen. Es wurde nichts verändert — bitte beginnen Sie von vorn.',
			'settings.migrate.error.verifyFailed' => 'Die gespeicherte Kopie stimmte nicht mit Ihrem Tresor überein, daher blieb die alte Datei unberührt. Es ging nichts verloren — bitte versuchen Sie es erneut.',
			'settings.title' => 'Einstellungen',
			'settings.subtitle' => 'Konto, Sprache, Sicherheit und Daten',
			'settings.account' => 'Konto',
			'settings.accountLine' => ({required Object email, required Object storage}) => '${email} · ${storage}',
			'settings.accountNote' => 'Name und E-Mail-Adresse stammen aus dem Konto, mit dem Sie sich angemeldet haben.',
			'settings.logOut' => 'Abmelden',
			'settings.logOutTitle' => 'Abmelden?',
			'settings.logOutBody' => ({required Object storage, required Object provider}) => 'Ihr Tresor bleibt verschlüsselt in Ihrem ${storage}. Um ihn wieder zu öffnen, melden Sie sich mit ${provider} an und geben Sie Ihr Geheimnis ein.',
			'settings.security' => 'Sicherheit',
			'settings.lockNow' => 'Jetzt sperren',
			'settings.autoLock' => 'Automatische Sperre',
			'settings.clearClipboard' => 'Zwischenablage leeren',
			'settings.hideInSwitcher' => 'Im App-Umschalter ausblenden',
			'settings.hideInSwitcherNote' => 'Zeigt einen Sichtschutz statt Ihres Tresors',
			'settings.changeSecret' => 'Geheimnis ändern',
			'settings.securityNote' => 'Beim Sperren wird der entschlüsselte Tresor aus dem Speicher dieses Telefons gelöscht.',
			'settings.appearance' => 'Darstellung',
			'settings.theme' => 'Design',
			'settings.themeAuto' => 'Auto',
			'settings.themeLight' => 'Hell',
			'settings.themeDark' => 'Dunkel',
			'settings.language' => 'Sprache',
			'settings.storage' => 'Speicher',
			'settings.whereItLives' => 'Wo Ihr Tresor liegt',
			'settings.moveTo' => ({required Object storage}) => 'Tresor nach ${storage} verschieben',
			'settings.data' => 'Daten',
			'settings.importCsv' => 'CSV importieren',
			'settings.exportCsv' => 'CSV exportieren',
			'settings.recentExports' => 'Letzte Exporte',
			'settings.help' => 'Hilfe',
			'settings.howItWorks' => 'So funktioniert KeeperPass',
			'settings.questions' => 'Fragen',
			'settings.about' => 'Über KeeperPass',
			'settings.dangerZone' => 'Gefahrenbereich',
			'settings.archive' => 'Tresor archivieren und abmelden',
			'settings.archiveNote' => 'Benennt Ihre Tresordatei um und meldet Sie ab. Es wird nichts gelöscht.',
			'settings.footer' => ({required Object version}) => 'KeeperPass ${version} · Kostenlos und quelloffen unter AGPL-3.0',
			'settings.autoLockTitle' => 'Automatische Sperre',
			'settings.autoLockImmediately' => 'Sofort beim Verlassen der App',
			'settings.autoLockImmediatelyShort' => 'Sofort',
			'settings.after1Minute' => 'Nach 1 Minute',
			'settings.after5Minutes' => 'Nach 5 Minuten',
			'settings.after10Minutes' => 'Nach 10 Minuten',
			'settings.autoLockNote' => 'KeeperPass sperrt sich, wenn es so lange nicht verwendet wird. Zum Entsperren brauchen Sie dann wieder Ihr Geheimnis.',
			'settings.clearClipboardTitle' => 'Zwischenablage leeren',
			'settings.after30Seconds' => 'Nach 30 Sekunden',
			'settings.after2Minutes' => 'Nach 2 Minuten',
			'settings.never' => 'Nie',
			'settings.after30s' => 'Nach 30 s',
			'settings.after1Min' => 'Nach 1 min',
			'settings.after2Min' => 'Nach 2 min',
			'settings.clipboardNote' => 'Kopierte Passwörter und Codes werden nach dieser Zeit aus der Zwischenablage gelöscht, sofern seitdem nichts anderes kopiert wurde.',
			'settings.preview' => 'Vorschau',
			'settings.previewFrom' => 'Von GitHub',
			'settings.previewClears' => ({required Object time}) => 'Von GitHub · Wird in ${time} gelöscht',
			'settings.seconds' => ({required Object n}) => '${n} s',
			'settings.minutes' => ({required Object n}) => '${n} min',
			'settings.languageTitle' => 'Sprache',
			'settings.languageNote' => 'Wird nur auf diesem Telefon gespeichert — sie gehört nicht zu Ihrem Tresor.',
			'settings.hideInSwitcherBlocks' => 'Zeigt einen Sichtschutz statt Ihres Tresors und blockiert Screenshots',
			'settings.blockScreenshots' => 'Screenshots blockieren',
			'settings.blockScreenshotsNote' => 'Nur Android · blockiert auch Bildschirmaufnahmen',
			'settings.blockScreenshotsWhileHidden' => 'Aktiv, solange „Im App-Umschalter ausblenden“ aktiv ist',
			'auth.unlock.incorrectSecret' => 'Falsches Geheimnis. Bitte versuchen Sie es erneut.',
			'vaults.defaultName' => 'Mein Tresor',
			'welcome.howItWorks' => 'So funktioniert’s',
			'welcome.badge' => 'Ende-zu-Ende-verschlüsselt',
			'welcome.title' => 'Willkommen bei KeeperPass',
			'welcome.description' => 'Ihr Tresor ist eine einzelne verschlüsselte Datei in Ihrem eigenen Cloud-Speicher. Melden Sie sich an, um ihn zu öffnen.',
			'welcome.fileTag' => 'Was Ihr Speicher sieht',
			'welcome.fileMeta' => 'Argon2id · AES-256-GCM',
			'welcome.continueWithGoogle' => 'Mit Google fortfahren',
			'welcome.continueWithDropbox' => 'Mit Dropbox fortfahren',
			'welcome.connecting' => ({required Object provider}) => 'Verbindung mit ${provider} wird hergestellt …',
			'welcome.factAccess' => 'Zugriff nur auf die Dateien, die KeeperPass erstellt',
			'welcome.factEncrypted' => 'Auf diesem Telefon verschlüsselt, mit Ihrem eigenen Geheimnis',
			'welcome.factNoServer' => 'Kein KeeperPass-Server. Nichts geht sonst irgendwohin.',
			'welcome.footer' => 'Kein KeeperPass-Konto — nur das Google- oder Dropbox-Konto, das Sie bereits haben. Bei der Anmeldung wird die Tresordatei erstellt, falls Sie noch keine haben.',
			'connect.lookingIn' => ({required Object storage}) => 'Suche in ${storage} …',
			'connect.checkingTitle' => 'Ihr Tresor wird geprüft …',
			'connect.checkingDetail' => ({required Object storage}) => 'Suche nach vault.json.enc in ${storage}.',
			'connect.foundTitle' => 'Ihr Tresor wurde gefunden',
			'connect.foundDetail' => 'Entsperren wird geöffnet …',
			'connect.foundMeta' => ({required Object storage}) => 'In ${storage} gefunden',
			'connect.foundMetaUpdated' => ({required Object storage, required Object time}) => 'In ${storage} gefunden · aktualisiert ${time}',
			'connect.canceledDetail' => 'Es wurde nichts verbunden.',
			'connect.signInFailed' => 'Anmeldung fehlgeschlagen',
			'connect.offlineDetail' => 'Für die Anmeldung ist eine Verbindung zu Google oder Dropbox nötig. Dies aktualisiert sich von selbst, sobald Sie wieder online sind.',
			'connect.welcomeBack' => 'Willkommen zurück,',
			'connect.expiredDetail' => ({required Object provider}) => 'Ihre ${provider}-Sitzung ist abgelaufen. Melden Sie sich erneut an, um Ihren Tresor zu entsperren.',
			'connect.lastUsed' => 'Zuletzt verwendet',
			'connect.checkFailedMeta' => ({required Object storage}) => 'Konnte nicht aus ${storage} gelesen werden',
			'connect.checkFailedTitle' => 'Ihr Tresor konnte nicht gelesen werden',
			'connect.checkFailedDetail' => ({required Object storage}) => '${storage} hat nicht geantwortet. Es wurde nichts verändert.',
			'howItWorks.step1Title' => 'Ihr Tresor wohnt\nin Ihrer Cloud',
			'howItWorks.step1Body' => 'KeeperPass speichert eine verschlüsselte Datei in Ihrem Google Drive oder Dropbox. Es gibt keinen KeeperPass-Server, also erhalten wir nie eine Kopie.',
			'howItWorks.encrypted' => 'Verschlüsselt',
			'howItWorks.step2Title' => 'Wählen Sie ein Geheimnis',
			'howItWorks.step2Body' => 'Es wird zum Schlüssel. Nie gesendet, nie gespeichert.',
			'howItWorks.step3Title' => 'Es braucht beides',
			'howItWorks.step3Body' => 'Wer Ihr Speicherkonto hat, kann Ihren Tresor nicht lesen. Wer Ihr Geheimnis hat, kommt nicht an ihn heran.',
			'howItWorks.storageAccount' => 'Speicherkonto',
			'howItWorks.reachesFile' => 'Erreicht die Datei',
			'howItWorks.yourSecret' => 'Ihr Geheimnis',
			'howItWorks.opensFile' => 'Öffnet die Datei',
			'howItWorks.technicalDetails' => 'Technische Details',
			'howItWorks.technicalSummary' => 'Argon2id · AES-256',
			'technicalDetails.title' => 'Technische Details',
			'technicalDetails.keyDerivation' => 'Schlüsselableitung',
			'technicalDetails.keyDerivationValue' => ({required InlineSpan algorithm}) => TextSpan(children: [ algorithm, const TextSpan(text: ' · 64 MiB Speicher · 3 Durchläufe · Parallelität 4, ergibt einen 256-Bit-Schlüssel'), ]), 
			'technicalDetails.encryption' => 'Verschlüsselung',
			'technicalDetails.encryptionValue' => ({required InlineSpan algorithm}) => TextSpan(children: [ algorithm, const TextSpan(text: ', das auch jede Änderung an der Datei erkennt'), ]), 
			'technicalDetails.googleDrive' => 'Google Drive',
			'technicalDetails.googleDriveValue' => ({required InlineSpan scope}) => TextSpan(children: [ const TextSpan(text: 'Der Bereich '), scope, const TextSpan(text: ': nur von KeeperPass erstellte Dateien'), ]), 
			'technicalDetails.dropbox' => 'Dropbox',
			'technicalDetails.dropboxValue' => ({required InlineSpan folder}) => TextSpan(children: [ const TextSpan(text: 'Ein App-Ordner: '), folder, ]), 
			'technicalDetails.vaultFile' => 'Tresordatei',
			'technicalDetails.vaultFileValue' => ({required InlineSpan file}) => TextSpan(children: [ file, const TextSpan(text: ' — eine Datei, bei jedem Speichern neu verschlüsselt und geschrieben'), ]), 
			'technicalDetails.viewSource' => 'Quellcode auf GitHub ansehen',
			'technicalDetails.license' => 'Kostenlos und quelloffen unter AGPL-3.0, sodass all dies überprüft werden kann.',
			'createVault.eyebrow' => 'Tresor erstellen',
			'createVault.step1Title' => 'Wählen Sie Ihr Geheimnis',
			'createVault.step1Body' => 'Es verschlüsselt Ihren Tresor auf diesem Telefon. Alles, was Sie speichern, wird damit gesichert.',
			'createVault.settingUpFor' => 'Einrichtung für',
			'createVault.secret' => 'Geheimnis',
			'createVault.secretPlaceholder' => 'Ihr Geheimnis',
			'createVault.generateAnother' => 'Neues generieren',
			'createVault.generatedNote' => 'Generierte Geheimnisse überspringen das erneute Eingeben.',
			'createVault.weakWarning' => 'Dieses Geheimnis ist schwach, wodurch die Verschlüsselung Ihres Tresors leichter zu knacken ist. Sie können fortfahren, aber eine längere Passphrase wird dringend empfohlen.',
			'createVault.tipsTitle' => 'Ein gutes Geheimnis wählen',
			'createVault.tip1' => 'Mehrere zufällige Wörter sind besser als ein cleveres Wort: Je länger, desto schwerer zu erraten.',
			'createVault.tip2' => 'Verwenden Sie kein Passwort, das Sie schon anderswo nutzen.',
			'createVault.tip3' => 'Wählen Sie etwas, das Sie auf diesem Telefon tippen können, schreiben Sie es auf und bewahren Sie es sicher auf.',
			'createVault.step2Title' => 'Noch einmal eingeben',
			'createVault.step2Body' => 'Nur um sicherzugehen, dass kein Tippfehler drin ist. Niemand kann Ihr Geheimnis später zurücksetzen.',
			'createVault.repeat' => 'Geheimnis wiederholen',
			'createVault.mismatch' => 'Die beiden Geheimnisse stimmen nicht überein.',
			'createVault.step3Title' => 'Schreiben Sie es auf',
			'createVault.step3Body' => 'Sie brauchen es bei jedem Entsperren. Bewahren Sie es sicher auf, getrennt von diesem Telefon.',
			'createVault.secretWords' => ({required Object count}) => 'Ihr Geheimnis · ${count} Wörter',
			'createVault.secretWhole' => 'Ihr Geheimnis',
			'createVault.secretHidden' => 'Ihr Geheimnis, verborgen',
			'createVault.secretShown' => 'Ihr Geheimnis, angezeigt',
			'createVault.readBefore' => 'Bitte lesen Sie dies, bevor Sie fortfahren',
			'createVault.bullet1' => 'Ihr Geheimnis wird nirgendwohin gesendet und nie gespeichert. Niemand — weder KeeperPass noch Ihr Speicheranbieter — kann es nachschlagen oder zurücksetzen.',
			'createVault.bullet2' => 'Wenn Sie es vergessen, kann Ihr Tresor nicht wiederhergestellt werden. Kein Reset-Link und keine Support-Anfrage kann ihn öffnen.',
			'createVault.bullet3' => 'Notieren Sie es sich und bewahren Sie es sicher auf, bevor Sie fortfahren.',
			'createVault.acknowledge' => 'Ich habe mein Geheimnis aufgeschrieben',
			'createVault.create' => 'Tresor erstellen',
			'createVault.progressTitle' => 'Ihr Tresor wird erstellt',
			'createVault.encrypting' => 'Ihr Tresor wird verschlüsselt …',
			'createVault.encryptingDetail' => 'Auf diesem Telefon. Das dauert ein paar Sekunden.',
			'createVault.encryptingMeta' => 'Wird auf diesem Telefon verschlüsselt …',
			'createVault.savingDetail' => 'Eine verschlüsselte Datei im Ordner keeperpass.',
			'createVault.failedTitle' => 'Ihr Tresor konnte nicht gespeichert werden',
			'createVault.notSaved' => 'Nicht gespeichert',
			'createVault.failedDetail' => ({required Object storage}) => '${storage} hat nicht geantwortet. Es wurde nichts gespeichert, und Ihr Geheimnis ist noch da.',
			'createVault.backToSecret' => 'Zurück zu Ihrem Geheimnis',
			'unlock.notYou' => 'Nicht Sie?',
			'unlock.secret' => 'Geheimnis',
			'unlock.placeholder' => 'Geben Sie Ihr Geheimnis ein',
			'unlock.unlock' => 'Entsperren',
			'unlock.unlocking' => 'Wird entsperrt …',
			'unlock.unlockingStatus' => 'Wird auf diesem Telefon entsperrt …',
			'unlock.slowNote' => 'Ein paar Sekunden, mit Absicht: So wird das Erraten Ihres Geheimnisses langsam.',
			'unlock.forgot' => 'Geheimnis vergessen?',
			'unlock.leftApp' => 'Gesperrt, als Sie KeeperPass verlassen haben',
			'unlock.unreachableTitle' => ({required Object storage}) => '${storage} nicht erreichbar',
			'unlock.unreachableDetail' => 'Prüfen Sie Ihre Verbindung und versuchen Sie es erneut. Ihr Geheimnis ist noch eingetragen.',
			'unlock.offlineDetail' => ({required Object storage}) => 'Zum Entsperren ist eine Verbindung zu ${storage} nötig. „Entsperren“ wird aktiv, sobald Sie wieder online sind.',
			'unlock.accountLine' => ({required Object email, required Object storage}) => '${email} · ${storage}',
			'unlock.lockedInactivity' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Nach ${n} Minute Inaktivität gesperrt', other: 'Nach ${n} Minuten Inaktivität gesperrt', ), 
			'newVault.backLabel' => 'Entsperren',
			'newVault.backToUnlock' => 'Zurück zum Entsperren',
			'newVault.title' => 'Einen neuen Tresor beginnen',
			'newVault.oldMeta' => 'Alter Tresor · mit dem alten Geheimnis gesperrt',
			'newVault.newMeta' => 'Neuer Tresor · leer',
			'newVault.body' => ({required Object provider}) => 'Ein vergessenes Geheimnis lässt sich nicht zurücksetzen — weder durch KeeperPass noch durch ${provider}. Sie können stattdessen mit einem neuen, leeren Tresor neu beginnen.',
			'newVault.pointLocked' => 'Ihr aktueller Tresor bleibt mit dem alten Geheimnis gesperrt.',
			'newVault.pointKept' => ({required InlineSpan file, required InlineSpan storage}) => TextSpan(children: [ const TextSpan(text: 'Seine Datei bleibt als '), file, const TextSpan(text: ' in Ihrem '), storage, const TextSpan(text: ' erhalten. Nichts wird gelöscht.'), ]), 
			'newVault.pointFresh' => 'Sie beginnen neu mit einem brandneuen, leeren Tresor.',
			'newVault.account' => 'Konto',
			'newVault.newSecret' => 'Neues Geheimnis',
			'newVault.newSecretPlaceholder' => 'Wählen Sie ein neues Geheimnis',
			'newVault.repeat' => 'Neues Geheimnis wiederholen',
			'newVault.weakWarning' => 'Dieses Geheimnis ist schwach, wodurch die Verschlüsselung Ihrer Tresore leichter zu knacken ist. Sie können fortfahren, aber eine längere Passphrase wird dringend empfohlen.',
			'newVault.warn' => 'Wie das alte kann auch Ihr neues Geheimnis weder nachgeschlagen noch zurückgesetzt werden. Schreiben Sie es auf, bevor Sie fortfahren.',
			'newVault.start' => 'Neuen Tresor beginnen',
			'newVault.confirmTitle' => 'Einen neuen Tresor beginnen?',
			'newVault.confirmKept' => ({required Object storage}) => 'Seine Datei bleibt als datierte Sicherung in Ihrem ${storage} erhalten.',
			'newVault.confirmFresh' => 'Sie beginnen neu mit einem leeren Tresor unter Ihrem neuen Geheimnis.',
			'newVault.progressTitle' => 'Neuer Tresor wird begonnen',
			'newVault.encrypting' => 'Ihr neuer Tresor wird verschlüsselt …',
			'newVault.backingUp' => 'Ihr alter Tresor wird als Sicherung aufbewahrt …',
			'newVault.backingUpDetail' => ({required Object storage}) => 'Sie wird in ${storage} umbenannt.',
			'newVault.readyMeta' => 'Verschlüsselt · bereit zum Speichern',
			'newVault.backupFailedMeta' => 'Konnte nicht umbenannt werden · nichts geändert',
			'newVault.nothingChanged' => 'Es wurde nichts verändert',
			'newVault.backupFailedDetail' => ({required Object storage}) => 'Ihr bestehender Tresor konnte in ${storage} nicht gesichert werden. Es wurde nichts verändert.',
			'newVault.doneTitle' => 'Neuer Tresor begonnen',
			'newVault.doneDetail' => ({required Object storage}) => 'Ihr alter Tresor bleibt als Sicherung in ${storage} erhalten.',
			'tabs.vault' => 'Tresor',
			'tabs.codes' => 'Codes',
			'tabs.generator' => 'Generator',
			'tabs.security' => 'Sicherheit',
			'tabs.settings' => 'Einstellungen',
			'tabs.securityFlagged' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Sicherheit, ${n} Eintrag markiert', other: 'Sicherheit, ${n} Einträge markiert', ), 
			'codes.subtitle' => '2FA-Codes aus Ihrem Tresor, auf diesem Telefon erzeugt',
			'codes.searchPlaceholder' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Code durchsuchen', other: '${n} Codes durchsuchen', ), 
			'codes.codeCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Code', other: '${n} Codes', ), 
			'codes.copied' => 'Code kopiert',
			'codes.trust' => 'Auf diesem Telefon aus den Einrichtungsschlüsseln in Ihrem Tresor erzeugt. Es wird nichts Neues gespeichert.',
			'codes.emptyTitle' => 'Noch keine 2FA-Codes',
			'codes.emptyBody' => 'Wenn eine Website eine Zwei-Faktor-Anmeldung anbietet, scannen Sie hier ihren QR-Code oder fügen Sie einen Eintrag „Authentifizierung“ hinzu.',
			'codes.createAuthenticator' => 'Eintrag „Authentifizierung“ erstellen',
			'comingSoon.body' => ({required Object part}) => 'Kommt in Teil ${part}.',
			'vaultList.lock' => 'Sperren',
			'vaultList.newItem' => 'Neuer Eintrag',
			'vaultList.allVaults' => 'Alle Tresore',
			'vaultList.favorites' => 'Favoriten',
			'vaultList.recentlyUsed' => 'Kürzlich verwendet',
			'vaultList.statusSaved' => ({required Object items, required Object storage}) => '${items} · In ${storage} gespeichert',
			'vaultList.statusInVault' => ({required Object items, required Object vault}) => '${items} in ${vault}',
			'vaultList.statusTagged' => ({required Object items, required Object tag}) => '${items} mit Tag ${tag}',
			'vaultList.statusReport' => ({required Object items, required Object report}) => '${items} · ${report}',
			'vaultList.statusNotConnected' => ({required Object storage}) => 'Nicht mit ${storage} verbunden',
			'vaultList.statusOffline' => ({required Object items}) => 'Offline · ${items}',
			'vaultList.reportWeak' => 'Schwache Passwörter',
			'vaultList.reportReused' => 'Wiederverwendete Passwörter',
			'vaultList.reportCompromised' => 'Kompromittierte Passwörter',
			'vaultList.searchHint' => 'Jedes Wort muss passen, in beliebiger Reihenfolge: Namen, Tags, Feldnamen und Werte.',
			'vaultList.filterByTag' => 'Nach Tag filtern',
			'vaultList.manageTags' => 'Tags verwalten',
			'vaultList.clearFilter' => 'Filter entfernen',
			'vaultList.today' => 'Heute',
			'vaultList.thisWeek' => 'Diese Woche',
			'vaultList.earlier' => 'Früher',
			'vaultList.aToZ' => 'A bis Z',
			'vaultList.sortHeading' => 'Nach letzter Änderung sortieren',
			'vaultList.newestFirst' => 'Neueste zuerst',
			'vaultList.oldestFirst' => 'Älteste zuerst',
			'vaultList.refreshing' => ({required Object storage}) => 'Ihr Tresor wird aus ${storage} gelesen …',
			'vaultList.copyPasswordFor' => ({required Object name}) => 'Passwort für ${name} kopieren',
			'vaultList.copyCodeFor' => ({required Object name}) => 'Code für ${name} kopieren',
			'vaultList.copyCardNumberFor' => ({required Object name}) => 'Kartennummer für ${name} kopieren',
			'vaultList.swipePassword' => 'Passwort',
			'vaultList.swipeCode' => 'Code',
			'vaultList.swipeCardNumber' => 'Kartennummer',
			'vaultList.swipeUsername' => 'Benutzername',
			'vaultList.swipeMore' => 'Mehr',
			'vaultList.copyPassword' => 'Passwort kopieren',
			'vaultList.copyCode' => 'Code kopieren',
			'vaultList.copyCardNumber' => 'Kartennummer kopieren',
			'vaultList.copyUsername' => 'Benutzernamen kopieren',
			'vaultList.moreActions' => 'Weitere Aktionen',
			'vaultList.favorite' => 'Favorit',
			'vaultList.addToFavorites' => 'Zu Favoriten hinzufügen',
			'vaultList.removeFromFavorites' => 'Aus Favoriten entfernen',
			'vaultList.findingWeak' => 'Schwaches Passwort',
			'vaultList.findingReused' => 'Wiederverwendetes Passwort',
			'vaultList.findingCompromised' => 'Kompromittiertes Passwort',
			'vaultList.findingWeakReused' => 'Schwaches und wiederverwendetes Passwort',
			'vaultList.findingWeakCompromised' => 'Schwaches und kompromittiertes Passwort',
			'vaultList.findingReusedCompromised' => 'Wiederverwendetes und kompromittiertes Passwort',
			'vaultList.findingAll' => 'Schwaches, wiederverwendetes und kompromittiertes Passwort',
			'vaultList.unnamed' => 'Neuer Eintrag',
			'vaultList.scopeTitle' => 'Tresore',
			'vaultList.manageVaults' => 'Tresore verwalten',
			'vaultList.scopeNote' => ({required Object storage}) => 'Alle Ihre Tresore liegen in einer verschlüsselten Datei, vault.json.enc, in Ihrem ${storage}.',
			'vaultList.quickActions' => ({required Object name}) => '${name}, Schnellaktionen',
			'vaultList.openWebsite' => 'Website öffnen',
			'vaultList.moveToVault' => 'In Tresor verschieben …',
			'vaultList.select' => 'Auswählen',
			'vaultList.delete' => 'Löschen',
			'vaultList.selectAll' => 'Alle auswählen',
			'vaultList.selectOrDeselectAll' => 'Alle auswählen oder abwählen',
			'vaultList.listTwo' => ({required Object a, required Object b}) => '${a} und ${b}',
			'vaultList.listThree' => ({required Object a, required Object b, required Object c}) => '${a}, ${b} und ${c}',
			'vaultList.deleteItemTitle' => 'Eintrag löschen',
			'vaultList.deleteItemConfirm' => ({required Object name}) => 'Möchten Sie „${name}“ wirklich löschen? Dies kann nicht rückgängig gemacht werden.',
			'vaultList.deleteItemAction' => 'Eintrag löschen',
			'vaultList.moveToVaultTitle' => 'In Tresor verschieben',
			'vaultList.moveDescription' => 'Wählen Sie den Tresor, in dem dieser Eintrag liegen soll.',
			'vaultList.current' => 'Aktuell',
			'vaultList.newVaultOption' => 'Neuer Tresor …',
			'vaultList.noOtherVaultOne' => 'Es gibt keinen anderen Tresor, in den dieser Eintrag verschoben werden kann.',
			'vaultList.noOtherVaultMany' => 'Es gibt keinen anderen Tresor, in den diese Einträge verschoben werden können.',
			'vaultList.noOtherVaultDetail' => 'Ein zweiter Tresor hält eine Gruppe von Einträgen getrennt — Arbeit von Privatem, oder Geteiltes von Privatem.',
			'vaultList.createAVault' => 'Einen Tresor erstellen',
			'vaultList.newVaultTitle' => 'Neuer Tresor',
			'vaultList.newVaultBody' => 'Ein Tresor ist eine eigene Gruppe von Einträgen. Anders als bei einem Eintrag gibt es vorab nichts weiter zu wählen.',
			'vaultList.vaultName' => 'Tresorname',
			'vaultList.duplicateVault' => 'Ein Tresor mit diesem Namen existiert bereits.',
			'vaultList.noItemsTitle' => 'Sie haben noch keine Einträge.',
			'vaultList.noItemsBody' => 'Fügen Sie Ihr erstes Login, Ihre erste Karte oder Notiz hinzu. Jeder Eintrag wird auf diesem Telefon verschlüsselt, bevor er gespeichert wird.',
			'vaultList.importCsv' => 'Aus CSV importieren',
			'vaultList.vaultReady' => 'Ihr Tresor ist bereit. Noch ist nichts darin.',
			'vaultList.savedMeta' => ({required Object storage, required Object items}) => 'In ${storage} gespeichert · ${items}',
			'vaultList.vaultEmptyTitle' => 'Dieser Tresor enthält noch keine Einträge.',
			'vaultList.vaultEmptyBody' => ({required Object vault}) => 'Fügen Sie hier einen hinzu oder verschieben Sie Einträge aus ${vault} hierher.',
			'vaultList.noFavoritesTitle' => 'Sie haben noch keine Favoriten.',
			'vaultList.noFavoritesBody' => 'Tippen Sie bei einem Eintrag auf den Stern, um ihn hier zu behalten.',
			'vaultList.nothingRecentTitle' => 'Noch nichts verwendet',
			'vaultList.nothingRecentBody' => 'Einträge, die Sie öffnen oder aus denen Sie kopieren, erscheinen hier — die neuesten zuerst.',
			'vaultList.noResultsTitle' => 'Ihre Suche ergab keine Treffer.',
			'vaultList.noResultsBody' => 'Jedes Wort muss passen. Versuchen Sie es mit weniger Wörtern oder prüfen Sie die Schreibweise.',
			'vaultList.allClearWeak' => 'Alle Passwörter in Ihrem Tresor sind stark genug.',
			'vaultList.allClearReused' => 'Jedes Passwort in Ihrem Tresor wird genau einmal verwendet.',
			'vaultList.allClearCompromised' => 'Keines Ihrer Passwörter wurde in einem bekannten Datenleck gefunden.',
			'vaultList.allClearBody' => 'Hier gibt es nichts zu beheben. KeeperPass prüft erneut, sobald sich ein Passwort ändert.',
			'vaultList.backToSecurity' => 'Zurück zu Sicherheit',
			'vaultList.fieldCopied' => ({required Object field}) => '${field} kopiert',
			'vaultList.copiedFrom' => ({required Object item}) => 'Von ${item}',
			'vaultList.itemCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Eintrag', other: '${n} Einträge', ), 
			'vaultList.statusNotSaved' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Änderung nicht gespeichert', other: '${n} Änderungen nicht gespeichert', ), 
			'vaultList.searchPlaceholder' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Eintrag durchsuchen', other: '${n} Einträge durchsuchen', ), 
			'vaultList.results' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Treffer', other: '${n} Treffer', ), 
			'vaultList.selectedCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} ausgewählt', other: '${n} ausgewählt', ), 
			'vaultList.moveItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Eintrag verschieben', other: '${n} Einträge verschieben', ), 
			'vaultList.moveItemsTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Eintrag verschieben', other: '${n} Einträge verschieben', ), 
			'vaultList.deleteItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Eintrag löschen', other: '${n} Einträge löschen', ), 
			'vaultList.deleteTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Eintrag löschen?', other: '${n} Einträge löschen?', ), 
			'vaultList.deleteFromVault' => ({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${names} wird aus ${vault} gelöscht. Dies kann nicht rückgängig gemacht werden.', other: '${names} werden aus ${vault} gelöscht. Dies kann nicht rückgängig gemacht werden.', ), 
			'vaultList.deleteFromVaults' => ({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${names} wird gelöscht. Dies kann nicht rückgängig gemacht werden.', other: '${names} werden gelöscht. Dies kann nicht rückgängig gemacht werden.', ), 
			'vaultList.moveLine' => ({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${names} wird mit Verlauf und Tags verschoben.', other: '${names} werden mit Verlauf und Tags verschoben.', ), 
			'vaultList.movedTitle' => ({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${names} nach ${vault} verschoben', other: '${names} nach ${vault} verschoben', ), 
			'vaultList.movedDetail' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Verlauf und Tags bleiben erhalten.', other: 'Verlauf und Tags bleiben erhalten.', ), 
			'vaultList.itemsOf' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${count} von ${n} Eintrag', other: '${count} von ${n} Einträgen', ), 
			'itemDetail.edit' => 'Bearbeiten',
			'itemDetail.editItem' => 'Eintrag bearbeiten',
			'itemDetail.moreOptions' => 'Weitere Optionen',
			'itemDetail.updatedAgo' => ({required Object ago}) => 'Aktualisiert ${ago}',
			'itemDetail.showTagged' => ({required Object tag}) => 'Einträge mit Tag ${tag} anzeigen',
			'itemDetail.fields' => 'Felder',
			'itemDetail.noFields' => 'Dieser Eintrag hat keine Felder.',
			'itemDetail.history' => 'Verlauf',
			'itemDetail.currentVersion' => 'Aktuelle Version',
			'itemDetail.todayAt' => ({required Object time}) => 'Heute, ${time}',
			'itemDetail.unnamedField' => 'Unbenannt',
			'itemDetail.copyField' => ({required Object field}) => '${field} kopieren',
			'itemDetail.revealValue' => 'Wert anzeigen',
			'itemDetail.hideValue' => 'Wert verbergen',
			'itemDetail.hiddenValue' => ({required Object field}) => '${field}, verborgen',
			'itemDetail.openSite' => ({required Object site}) => '${site} öffnen',
			'itemDetail.call' => 'Anrufen',
			'itemDetail.message' => 'Nachricht',
			'itemDetail.checksumFail' => 'Diese Nummer besteht ihre Prüfsumme nicht — vermutlich ist eine der Ziffern falsch.',
			'itemDetail.codeCardHint' => 'Zum Kopieren tippen · auch im Tab „Codes“',
			'itemDetail.copyAllCodes' => 'Alle Codes kopieren',
			'itemDetail.copyCodeNumber' => ({required Object n}) => 'Code ${n} kopieren',
			'itemDetail.cardFace' => 'Karte, Nummer verborgen',
			'itemDetail.cardFaceBrand' => ({required Object brand}) => '${brand}-Karte, Nummer verborgen',
			'itemDetail.cardExpires' => ({required Object date}) => 'gültig bis ${date}',
			'itemDetail.largeTypeTurn' => 'Drehen Sie Ihr Telefon quer, um alles in einer Zeile zu lesen.',
			'itemDetail.largeTypeHides' => 'Beim Verlassen dieses Bildschirms wird es wieder verborgen.',
			'itemDetail.earlierVersion' => 'Frühere Version',
			'itemDetail.readOnly' => ({required Object ago}) => '${ago} · nur lesbar',
			'itemDetail.changedSince' => 'Seitdem geändert',
			'itemDetail.restoreThisVersion' => 'Diese Version wiederherstellen',
			'itemDetail.deleteVersion' => 'Version löschen',
			'itemDetail.restoreTitle' => 'Diese Version wiederherstellen?',
			'itemDetail.restoreBody' => ({required Object name, required Object date}) => '${name} wird auf den Stand vom ${date} zurückgesetzt. Die aktuelle Version bleibt im Verlauf.',
			'itemDetail.restore' => 'Wiederherstellen',
			'itemDetail.deleteVersionTitle' => 'Diese Version löschen',
			'itemDetail.deleteVersionConfirm' => 'Möchten Sie diese Version wirklich aus dem Verlauf löschen? Dies kann nicht rückgängig gemacht werden.',
			'itemDetail.delete' => 'Löschen',
			'itemDetail.notFound' => 'Dieser Eintrag existiert nicht mehr.',
			'itemDetail.notFoundHint' => 'Er wurde möglicherweise von einem anderen Gerät gelöscht.',
			'itemDetail.backToVault' => 'Zurück zum Tresor',
			'itemDetail.hiddenLines' => ({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${field}, verborgen, ${n} Zeile', other: '${field}, verborgen, ${n} Zeilen', ), 
			'itemDetail.largeTypeLabel' => ({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${field} in großer Schrift, ${n} Zeichen', other: '${field} in großer Schrift, ${n} Zeichen', ), 
			'editItem.newVaultItem' => 'Neuer Tresoreintrag',
			'editItem.vault' => 'Tresor',
			'editItem.template' => 'Vorlage',
			'editItem.templateNote' => 'Vorlagen sind nur ein Anfang: Felder lassen sich jederzeit umbenennen, entfernen oder hinzufügen.',
			'editItem.templates.website' => 'Website oder App',
			'editItem.templates.computer' => 'Computer',
			'editItem.templates.creditCard' => 'Kreditkarte',
			'editItem.templates.bankAccount' => 'Bankkonto',
			'editItem.templates.wifi' => 'WLAN-Netzwerk',
			'editItem.templates.passport' => 'Reisepass',
			'editItem.templates.note' => 'Notiz',
			'editItem.templates.authenticator' => 'Authentifizierung',
			'editItem.templates.custom' => 'Benutzerdefiniert',
			'editItem.templateHints.website' => 'Benutzername, Passwort, URL',
			'editItem.templateHints.computer' => 'Benutzername, Passwort',
			'editItem.templateHints.creditCard' => 'Nummer, Inhaber, Ablauf, CVC, PIN',
			'editItem.templateHints.bankAccount' => 'Inhaber, IBAN, BIC, PIN',
			'editItem.templateHints.wifi' => 'Netzwerkname, Passwort',
			'editItem.templateHints.passport' => 'Nummer, Name, Daten',
			'editItem.templateHints.note' => 'Eine formatierte Notiz',
			'editItem.templateHints.authenticator' => 'Ein 2FA-Code',
			'editItem.templateHints.custom' => 'Noch keine Felder',
			'editItem.templateFields.cardholder' => 'Karteninhaber',
			'editItem.templateFields.expiresOn' => 'Gültig bis',
			'editItem.templateFields.cvc' => 'CVC',
			'editItem.templateFields.accountHolder' => 'Kontoinhaber',
			'editItem.templateFields.iban' => 'IBAN',
			'editItem.templateFields.bic' => 'BIC',
			'editItem.templateFields.cardPin' => 'Karten-PIN',
			'editItem.templateFields.networkName' => 'Netzwerkname',
			'editItem.templateFields.fullName' => 'Vollständiger Name',
			'editItem.templateFields.passportNumber' => 'Passnummer',
			'editItem.templateFields.issuingCountry' => 'Ausstellendes Land',
			'editItem.templateFields.dateOfBirth' => 'Geburtsdatum',
			'editItem.templateFields.placeOfBirth' => 'Geburtsort',
			'editItem.templateFields.issuedOn' => 'Ausgestellt am',
			'editItem.types.username' => 'Benutzername',
			'editItem.types.password' => 'Passwort',
			'editItem.types.email' => 'E-Mail',
			'editItem.types.url' => 'URL',
			'editItem.types.ipHost' => 'IP / Host',
			'editItem.types.date' => 'Datum',
			'editItem.types.month' => 'Monat',
			_ => null,
		} ?? switch (path) {
			'editItem.types.credit' => 'Kartennummer',
			'editItem.types.phone' => 'Telefon',
			'editItem.types.pin' => 'PIN',
			'editItem.types.totp' => 'Authentifizierungscode',
			'editItem.types.certificate' => 'Zertifikat',
			'editItem.types.sshKey' => 'SSH-/Privatschlüssel',
			'editItem.types.recoveryCodes' => 'Wiederherstellungscodes',
			'editItem.types.note' => 'Formatierte Notiz',
			'editItem.types.text' => 'Text',
			'editItem.newItem' => 'Neuer Eintrag',
			'editItem.editItem' => 'Eintrag bearbeiten',
			'editItem.changeIcon' => 'Symbol ändern',
			'editItem.name' => 'Name',
			'editItem.namePlaceholder' => 'z. B. GitHub',
			'editItem.tags' => 'Tags',
			'editItem.addField' => 'Feld hinzufügen',
			'editItem.addFieldTitle' => 'Feld hinzufügen',
			'editItem.noFieldsTitle' => 'Noch keine Felder',
			'editItem.noFieldsBody' => 'Fügen Sie einen der 16 Feldtypen hinzu — eine Policennummer, eine Telefonnummer, eine PIN.',
			'editItem.fieldNamePlaceholder' => 'Feldname',
			'editItem.addTag' => 'Tag hinzufügen',
			'editItem.tagSuggestions' => 'Tag-Vorschläge',
			'editItem.createTag' => ({required Object name}) => '„${name}“ erstellen',
			'editItem.tagTooLong' => 'Dieser Name ist zu lang.',
			'editItem.removeFieldTitle' => 'Möchten Sie dieses Feld wirklich entfernen?',
			'editItem.removeFieldBody' => ({required Object field, required Object item}) => '„${field}“ und sein Wert verschwinden beim Speichern aus ${item}.',
			'editItem.remove' => 'Entfernen',
			'editItem.discardTitle' => 'Änderungen verwerfen?',
			'editItem.discardBody' => ({required Object name}) => 'Ihre Änderungen an ${name} wurden nicht gespeichert. Beim Verwerfen bleibt der Eintrag, wie er war.',
			'editItem.discardNewTitle' => 'Diesen neuen Eintrag verwerfen?',
			'editItem.discardNewBody' => 'Er wurde nicht gespeichert. Beim Verwerfen geht er verloren.',
			'editItem.discard' => 'Verwerfen',
			'editItem.usernamePlaceholder' => 'Benutzername oder E-Mail',
			'editItem.passwordPlaceholder' => 'Passwort',
			'editItem.valuePlaceholder' => 'Wert hier eingeben',
			'editItem.ipHostPlaceholder' => 'z. B. 192.168.1.1, ::1 oder db.beispiel.de',
			'editItem.recoveryCodesPlaceholder' => 'Einer pro Zeile — jedes Format funktioniert',
			'editItem.notEmail' => 'Das sieht nicht wie eine E-Mail-Adresse aus.',
			'editItem.phoneNumber' => 'Telefonnummer',
			'editItem.searchCountries' => 'Länder suchen',
			'editItem.noCountryMatch' => 'Kein Land stimmt überein.',
			'editItem.generate' => 'Generieren',
			'editItem.generatePassword' => 'Passwort generieren',
			'editItem.currentCode' => 'Aktueller Code',
			'editItem.scanQr' => 'QR-Code scannen',
			'editItem.enterSetupKey' => 'Einrichtungsschlüssel eingeben',
			'editItem.setupKeyTitle' => 'Einrichtungsschlüssel eingeben',
			'editItem.setupKeyBody' => 'Websites zeigen neben dem QR-Code einen Einrichtungsschlüssel, oft unter „Scannen nicht möglich?“.',
			'editItem.setupKey' => 'Einrichtungsschlüssel',
			'editItem.setupKeyHint' => 'Leerzeichen und Großschreibung spielen keine Rolle.',
			'editItem.saveCode' => 'Code speichern',
			'editItem.chooseIcon' => 'Symbol wählen',
			'editItem.searchIcons' => 'Symbole suchen — z. B. „Bank“ oder „Schloss“',
			'editItem.popular' => 'Beliebt',
			'editItem.noIcons' => ({required Object search}) => 'Keine Symbole für „${search}“ gefunden.',
			'editItem.useDefaultIcon' => 'Standardsymbol verwenden',
			'editItem.iconMatches' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Treffer', other: '${n} Treffer', ), 
			'generator.title' => 'Passwort generieren',
			'generator.notFilledIn' => 'Nichts wird eingefügt, bevor Sie es übernehmen.',
			'generator.generated' => 'Generiertes Passwort',
			'generator.mode' => 'Art',
			'generator.passphrase' => 'Passphrase',
			'generator.randomString' => 'Zufällige Zeichenfolge',
			'generator.words' => 'Wörter',
			'generator.fewerWords' => 'Weniger Wörter',
			'generator.moreWords' => 'Mehr Wörter',
			'generator.length' => 'Länge',
			'generator.shorter' => 'Kürzer',
			'generator.longer' => 'Länger',
			'generator.wordSeparator' => 'Worttrennzeichen',
			'generator.dash' => 'Bindestrich',
			'generator.underscore' => 'Unterstrich',
			'generator.slash' => 'Schrägstrich',
			'generator.space' => 'Leerzeichen',
			'generator.language' => 'Sprache',
			'generator.regenerate' => 'Neu generieren',
			'generator.charCount' => ({required Object count}) => '${count} Zeichen',
			'generator.lowercase' => 'Kleinbuchstaben',
			'generator.uppercase' => 'Großbuchstaben',
			'generator.digits' => 'Ziffern',
			'generator.symbols' => 'Symbole',
			'generator.pickOne' => 'Wählen Sie mindestens eine Zeichenart.',
			'generator.use' => 'Dieses Passwort verwenden',
			'generator.wordCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Wort', other: '${n} Wörter', ), 
			'generator.pageTitle' => 'Passwortgenerator',
			'generator.subtitle' => 'Zufällige Passwörter und Passphrasen, auf diesem Gerät erzeugt',
			'generator.separatorDash' => 'Bindestrich ( - )',
			'generator.separatorUnderscore' => 'Unterstrich ( _ )',
			'generator.separatorSlash' => 'Schrägstrich ( / )',
			'generator.separatorSpace' => 'Leerzeichen',
			'generator.nothingToGenerate' => 'Nichts zu generieren.',
			'generator.copyPassword' => 'Passwort kopieren',
			'generator.copied' => 'Passwort kopiert',
			'generator.fromGenerator' => 'Aus dem Generator',
			'report.title' => 'Sicherheitsbericht',
			'report.subtitle' => 'Wie gut Ihre gespeicherten Passwörter standhalten',
			'report.healthLabel' => 'Tresor-Zustand',
			'report.healthGood' => 'Stark',
			'report.healthFair' => 'Verbesserungsbedarf',
			'report.healthPoor' => 'Gefährdet',
			'report.allClearTitle' => 'Keine Probleme gefunden',
			'report.allClearDescription' => 'Jedes Passwort in Ihren Tresoren hat den letzten Audit bestanden.',
			'report.aboutSection' => ({required Object title}) => 'Über ${title}',
			'report.nothingFound' => 'Nichts gefunden',
			'report.openItem' => ({required Object name}) => '${name} öffnen',
			'report.checkAgain' => 'Erneut prüfen',
			'report.statWeak' => 'Schwach',
			'report.statReused' => 'Wiederverwendet',
			'report.statCompromised' => 'Kompromittiert',
			'report.statValue' => ({required Object label, required Object count}) => '${label}: ${count}',
			'report.statNotChecked' => ({required Object label}) => '${label}: noch nicht geprüft',
			'report.healthPercent' => ({required Object title, required Object score}) => '${title} ${score} Prozent',
			'report.sameAs' => ({required Object names}) => 'Wie bei ${names}',
			'report.sameAsField' => 'Wie ein anderes Passwort in diesem Eintrag',
			'report.foundInBreach' => 'In einem bekannten Datenleck gefunden',
			'report.trust' => 'Die Prüfung auf Datenlecks nutzt Have I Been Pwned mit k-Anonymität: Nur die ersten 5 Zeichen eines SHA-1-Hashes verlassen dieses Telefon.',
			'report.lastCheckedJustNow' => 'Zuletzt geprüft: gerade eben',
			'report.lastCheckedToday' => ({required Object time}) => 'Zuletzt geprüft: heute um ${time}',
			'report.lastCheckedOn' => ({required Object date}) => 'Zuletzt geprüft: ${date}',
			'report.checking' => 'Wird geprüft …',
			'report.checkingBreaches' => ({required Object done, required Object total}) => 'Suche nach Datenlecks · ${done} von ${total}',
			'report.progress' => ({required Object done, required Object total}) => '${done} von ${total}',
			'report.progressTime' => ({required Object done, required Object total, required Object time}) => '${done} von ${total} · ${time}',
			'report.offlineBody' => 'Ihre Passwörter konnten nicht geprüft werden. Die Prüfung braucht eine Verbindung.',
			'report.failedTitle' => 'Die Prüfung konnte nicht abgeschlossen werden',
			'report.failedBody' => 'Versuchen Sie es gleich noch einmal.',
			'report.nothingTitle' => 'Noch nichts zu prüfen',
			'report.nothingBody' => 'Speichern Sie einen Eintrag mit Passwort, und er wird hier auf diesem Telefon auf schwache, wiederverwendete und geleakte Passwörter geprüft.',
			'report.howToFix' => 'So beheben Sie es',
			'report.stepOpen' => 'Öffnen Sie den Eintrag',
			'report.stepGenerate' => 'Tippen Sie auf Bearbeiten, dann beim Passwort auf Generieren',
			'report.stepSave' => 'Speichern – die Markierung verschwindet von selbst',
			'report.stepSaveCompromised' => 'Speichern Sie, und ändern Sie es auch auf der Website',
			'report.changePassword' => 'Passwort ändern',
			'report.fixedClear' => ({required Object name}) => 'Gespeichert · ${name} ist nicht mehr markiert',
			'report.fixedFlagged' => ({required Object name}) => 'Gespeichert · ${name} ist weiterhin markiert',
			'report.savedTo' => ({required Object storage}) => 'Ihr Tresor wurde in ${storage} gespeichert',
			'report.noLongerWeak' => 'Nicht mehr schwach',
			'report.noLongerReused' => 'Nicht mehr wiederverwendet',
			'report.noLongerWeakOrReused' => 'Nicht mehr schwach oder wiederverwendet',
			'report.hintReusedOne' => ({required Object n}) => 'Diese ${n} nutzen dasselbe Passwort. Geben Sie jedem ein eigenes: einen öffnen, auf Bearbeiten tippen, dann auf Generieren.',
			'report.hintReusedSome' => 'Einige davon nutzen dasselbe Passwort. Geben Sie jedem ein eigenes: einen öffnen, auf Bearbeiten tippen, dann auf Generieren.',
			'report.hintWeak' => 'Geben Sie jedem ein stärkeres: öffnen, auf Bearbeiten tippen, dann auf Generieren.',
			'report.hintCompromised' => 'Diese stehen in bekannten Datenlecks. Ändern Sie jedes: öffnen, auf Bearbeiten tippen, dann auf Generieren.',
			'report.itemsChecked' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Eintrag mit Passwort geprüft', other: '${n} Einträge mit Passwort geprüft', ), 
			'report.flagged' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Eintrag markiert', other: '${n} Einträge markiert', ), 
			'report.sameAsOthers' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Wie bei ${n} anderen Eintrag', other: 'Wie bei ${n} anderen Einträgen', ), 
			'report.checkingPasswords' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Passwort wird geprüft', other: '${n} Passwörter werden geprüft', ), 
			'report.aboutSeconds' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'etwa ${n} Sekunde', other: 'etwa ${n} Sekunden', ), 
			'report.aboutMinutes' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'etwa ${n} Minute', other: 'etwa ${n} Minuten', ), 
			'audit.weakPassword.label' => 'Schwache Passwörter',
			'audit.weakPassword.description' => 'Ein Passwort ist schwach, wenn der Suchraum für einen Angreifer klein ist: Es ist kurz, nutzt nur wenige verschiedene Zeichen oder basiert auf einem Wort, Namen oder einer Tastaturfolge, die in jedem Cracking-Wörterbuch steht. Offline-Angriffe schaffen Milliarden Versuche pro Sekunde, sodass alles in dieser Kategorie schnell fällt. Ersetzen Sie es durch ein langes, zufällig generiertes Passwort.',
			'audit.reusedPassword.label' => 'Wiederverwendete Passwörter',
			'audit.reusedPassword.description' => 'Ein Passwort, das an mehreren Stellen verwendet wird, bedeutet, dass ein einziges Datenleck alle diese Konten öffnet – und Sie haben keinen Einfluss darauf, welcher dieser Dienste als Nächstes betroffen ist. Geben Sie jedem Eintrag ein eigenes generiertes Passwort, damit ein Leck auf das Konto beschränkt bleibt, aus dem es stammt.',
			'audit.compromisedPassword.label' => 'Kompromittierte Passwörter',
			'audit.compromisedPassword.description' => 'Dieses Passwort erscheint in einer öffentlichen Liste geleakter Zugangsdaten, wodurch es zu den ersten gehört, die Angreifer ausprobieren – egal wie stark es wirkt. Ändern Sie es überall, wo es verwendet wird: Ein Passwort muss nur einmal geleakt werden, um dauerhaft kompromittiert zu bleiben.',
			'myVaults.title' => 'Meine Tresore',
			'myVaults.subtitle' => 'Getrennte Gruppen von Einträgen — Arbeit, Familie, Privat',
			'myVaults.defaultBadge' => 'Standard',
			'myVaults.newVault' => 'Neuer Tresor',
			'myVaults.emptyTitle' => 'Sie haben nur den Standardtresor',
			'myVaults.emptyBody' => 'Ein zweiter Tresor hält eine Gruppe von Einträgen getrennt — Arbeit von Privatem, oder Geteiltes von Privatem.',
			'myVaults.createdOn' => ({required Object date}) => 'erstellt ${date}',
			'myVaults.renameTitle' => 'Tresor umbenennen',
			'myVaults.renameBody' => 'Die enthaltenen Einträge sind davon nicht betroffen.',
			'myVaults.duplicateRename' => ({required Object name}) => 'Ein Tresor namens „${name}“ existiert bereits.',
			'myVaults.deleteTitle' => ({required Object name}) => '„${name}“ löschen?',
			'myVaults.deleteAction' => 'Tresor löschen',
			'myVaults.renameAria' => ({required Object name}) => '${name} umbenennen',
			'myVaults.deleteAria' => ({required Object name}) => '${name} löschen',
			'myVaults.itemCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Eintrag', other: '${n} Einträge', ), 
			'myVaults.deleteBody' => ({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Sein ${n} Eintrag wird in ${vault} verschoben. Dies kann nicht rückgängig gemacht werden.', other: 'Seine ${n} Einträge werden in ${vault} verschoben. Dies kann nicht rückgängig gemacht werden.', ), 
			'myVaults.deleteSelectedTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tresor löschen?', other: '${n} Tresore löschen?', ), 
			'myVaults.deleteSelectedBody' => ({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Alles darin — ${n} Eintrag — wird in ${vault} verschoben. Dies kann nicht rückgängig gemacht werden.', other: 'Alles darin — ${n} Einträge — wird in ${vault} verschoben. Dies kann nicht rückgängig gemacht werden.', ), 
			'myVaults.personalSummary' => ({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${name} enthält ${n} Eintrag und kann nicht umbenannt oder gelöscht werden.', other: '${name} enthält ${n} Einträge und kann nicht umbenannt oder gelöscht werden.', ), 
			'myVaults.selected' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tresor ausgewählt', other: '${n} Tresore ausgewählt', ), 
			'myVaults.deleteVaults' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tresor löschen', other: '${n} Tresore löschen', ), 
			'tags.title' => 'Tags',
			'tags.subtitle' => 'Markierungen über alle Tresore hinweg, um Dinge schnell zu finden',
			'tags.since' => ({required Object date}) => 'seit ${date}',
			'tags.addTag' => 'Tag hinzufügen',
			'tags.addTitle' => 'Tag hinzufügen',
			'tags.emptyTitle' => 'Noch keine Tags',
			'tags.emptyBody' => 'Tags werden von einem Eintrag aus oder hier erstellt — so oder so gruppieren sie Einträge über Tresore hinweg.',
			'tags.addBody' => 'Ein Tag ohne Einträge. Weisen Sie es einem Eintrag von dessen eigener Seite aus zu.',
			'tags.tagName' => 'Tag-Name',
			'tags.duplicate' => 'Ein Tag mit diesem Namen existiert bereits.',
			'tags.colorNote' => 'Seine Farbe ergibt sich aus dem Namen.',
			'tags.renameTitle' => 'Tag umbenennen',
			'tags.renameBody' => 'Jeder Eintrag, der es trägt, wird aktualisiert.',
			'tags.mergeNotice' => ({required Object name}) => '„${name}“ existiert bereits — das Umbenennen führt sie zusammen.',
			'tags.deleteTitle' => ({required Object name}) => '„${name}“ löschen?',
			'tags.deleteAction' => 'Tag löschen',
			'tags.deleteSelectedBody' => 'Jedes wird von jedem Eintrag entfernt, der es trägt. Die Einträge selbst bleiben erhalten. Dies kann nicht rückgängig gemacht werden.',
			'tags.footer' => 'Tippen Sie auf einen Tag, um seine Einträge im Tab „Tresor“ zu sehen.',
			'tags.renameAria' => ({required Object name}) => '${name} umbenennen',
			'tags.deleteAria' => ({required Object name}) => '${name} löschen',
			'tags.itemCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Eintrag', other: '${n} Einträge', ), 
			'tags.deleteBody' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Es wird von ${n} Eintrag entfernt. Die Einträge selbst bleiben erhalten. Dies kann nicht rückgängig gemacht werden.', other: 'Es wird von ${n} Einträgen entfernt. Die Einträge selbst bleiben erhalten. Dies kann nicht rückgängig gemacht werden.', ), 
			'tags.deleteSelectedTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tag löschen?', other: '${n} Tags löschen?', ), 
			'tags.selected' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tag ausgewählt', other: '${n} Tags ausgewählt', ), 
			'tags.deleteTags' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tag löschen', other: '${n} Tags löschen', ), 
			'changeSecret.title' => 'Geheimnis ändern',
			'changeSecret.intro' => 'Ihr Tresor wird mit dem neuen Geheimnis neu verschlüsselt und erneut hochgeladen. Er kann nicht wiederhergestellt werden, wenn Sie es vergessen.',
			'changeSecret.current' => 'Aktuelles Geheimnis',
			'changeSecret.wrong' => 'Das ist nicht Ihr aktuelles Geheimnis.',
			'changeSecret.match' => 'Die beiden Geheimnisse stimmen überein.',
			'changeSecret.otherDevices' => 'Andere Geräte fragen beim nächsten Öffnen Ihres Tresors nach dem neuen Geheimnis.',
			'changeSecret.submit' => 'Geheimnis ändern',
			'changeSecret.verifyingMeta' => 'Ihr aktuelles Geheimnis wird geprüft …',
			'changeSecret.verifyingTitle' => 'Ihr aktuelles Geheimnis wird überprüft …',
			'changeSecret.stepVerify' => 'Aktuelles Geheimnis wird überprüft',
			'changeSecret.stepVerifyNote' => 'Auf einem Telefon bewusst langsam — genau das macht das Erraten teuer',
			'changeSecret.stepEncrypt' => 'Wird mit dem neuen Geheimnis verschlüsselt',
			'changeSecret.stepSave' => 'Tresor wird gespeichert',
			'changeSecret.savingMeta' => ({required Object storage}) => 'Wird in ${storage} gespeichert…',
			'changeSecret.savingTitle' => ({required Object percent}) => 'Ihr Tresor wird gespeichert… ${percent}%',
			'changeSecret.stepVerified' => 'Aktuelles Geheimnis überprüft',
			'changeSecret.stepEncrypted' => 'Mit dem neuen Geheimnis verschlüsselt',
			'changeSecret.stepSaving' => ({required Object storage}) => 'Wird in ${storage} gespeichert',
			'changeSecret.keepOpen' => 'Lassen Sie KeeperPass geöffnet, bis der Vorgang abgeschlossen ist.',
			'changeSecret.doneMeta' => ({required Object storage}) => 'In ${storage} gespeichert',
			'changeSecret.doneTitle' => 'Ihr Geheimnis wurde geändert',
			'changeSecret.doneBody' => 'Alle Einträge sind erhalten geblieben. Andere Geräte fragen beim nächsten Öffnen Ihres Tresors nach dem neuen Geheimnis.',
			'changeSecret.toast' => 'Geheimnis geändert',
			'changeSecret.failTitle' => 'Ihr Tresor wurde nicht gespeichert',
			'changeSecret.failBody' => ({required Object storage}) => '${storage} war nicht erreichbar. Ihr Geheimnis wurde nicht geändert: Der Tresor lässt sich weiterhin mit dem aktuellen öffnen.',
			'storage.title' => 'Speicher',
			'storage.subtitle' => 'Wo Ihr Tresor liegt und was darauf zugreifen kann',
			'storage.diagram' => ({required Object storage}) => 'Auf diesem Telefon verschlüsselt, in Ihrem ${storage} gespeichert',
			'storage.thisPhone' => 'Dieses Telefon',
			'storage.encryptedOnly' => 'Nur verschlüsselte Datei',
			'storage.googleFolder' => 'Ordner keeperpass',
			'storage.dropboxFolder' => 'Ordner Apps/keeperpass',
			'storage.savedToday' => ({required Object folder, required Object time}) => '${folder} · heute um ${time} gespeichert',
			'storage.savedOn' => ({required Object folder, required Object date}) => '${folder} · gespeichert am ${date}',
			'storage.access' => 'Zugriff',
			'storage.googlePermissions' => 'Berechtigungen des Google-Kontos',
			'storage.dropboxApps' => 'Verbundene Dropbox-Apps',
			'storage.accessNote' => 'KeeperPass kann nur auf die Dateien zugreifen, die es selbst erstellt. Sie können diesen Zugriff hier jederzeit widerrufen; die Tresordatei bleibt, wo sie ist.',
			'moveVault.title' => 'Tresor verschieben',
			'moveVault.diagram' => ({required Object from, required Object to}) => 'Ihr Tresor wird von ${from} nach ${to} verschoben',
			'moveVault.from' => 'Quelle',
			'moveVault.to' => 'Ziel',
			'moveVault.intro' => 'Ihr Tresor wird kopiert und geprüft, und erst danach wird die alte Datei umbenannt. Schlägt etwas fehl, bleibt alles unverändert.',
			'moveVault.step1' => ({required Object storage}) => 'Melden Sie sich bei ${storage} an, um das Ziel für den Tresor zu wählen.',
			'moveVault.step2' => 'Bestätigen Sie. Vor diesem Schritt ändert sich nichts.',
			'moveVault.step3' => 'Der Tresor wird kopiert und geprüft; danach wird die alte Datei umbenannt, nie gelöscht.',
			'moveVault.connect' => ({required Object storage}) => '${storage} verbinden',
			'moveVault.account' => 'Verschieben in dieses Konto',
			'moveVault.existingTitle' => ({required Object storage}) => 'In diesem ${storage}-Konto gibt es bereits einen KeeperPass-Tresor',
			'moveVault.existingBody' => ({required Object storage}) => 'Wenn Sie fortfahren, wird er als Sicherungsdatei mit Zeitstempel in ${storage} aufbewahrt und durch den Tresor ersetzt, den Sie verschieben.',
			'moveVault.existingConfirm' => 'Ersetzen — der vorhandene Tresor bleibt als Sicherung erhalten',
			'moveVault.secretSection' => 'Geheimnis für den verschobenen Tresor',
			'moveVault.keepSecret' => 'Mein aktuelles Geheimnis behalten',
			'moveVault.newSecret' => 'Neues Geheimnis wählen',
			'moveVault.newSecretNote' => 'Nur der verschobene Tresor verwendet es',
			'moveVault.submit' => 'Tresor verschieben',
			'moveVault.movingTitle' => 'Ihr Tresor wird verschoben',
			'moveVault.stageEncrypting' => 'Ihr Tresor wird verschlüsselt',
			'moveVault.stageSaving' => ({required Object storage}) => 'Wird in ${storage} gespeichert…',
			'moveVault.stageChecking' => 'Die gespeicherte Kopie wird geprüft',
			'moveVault.stageRenaming' => 'Die alte Datei wird umbenannt',
			'moveVault.movingNote' => 'Lassen Sie KeeperPass geöffnet, bis der Vorgang abgeschlossen ist. Schlägt etwas fehl, bleibt alles unverändert.',
			'moveVault.savedTo' => ({required Object storage}) => 'In ${storage} gespeichert',
			'moveVault.doneTitle' => ({required Object storage}) => 'Ihr Tresor liegt jetzt in ${storage}',
			'moveVault.doneBody' => ({required Object provider, required Object from}) => 'Melden Sie sich mit ${provider} an, um ihn zu öffnen. Die alte Datei wurde in ${from} behalten und umbenannt:',
			'moveVault.copyFileName' => 'Dateinamen kopieren',
			'moveVault.fileNameCopied' => 'Dateiname kopiert',
			'moveVault.partlyTitle' => ({required Object storage}) => 'Ihr Tresor wurde nach ${storage} kopiert',
			'moveVault.partlyBody' => ({required Object from}) => 'Die alte Datei in ${from} konnte aber nicht umbenannt werden. Benennen Sie sie selbst um oder löschen Sie sie, damit die beiden Kopien nicht auseinanderlaufen.',
			'moveVault.open' => ({required Object storage}) => '${storage} öffnen',
			'moveVault.unchanged' => ({required Object from}) => 'Weiterhin in ${from} · unverändert',
			'moveVault.notMovedTitle' => 'Ihr Tresor wurde nicht verschoben',
			'moveVault.notMovedBody' => 'Die gespeicherte Kopie stimmte nicht mit Ihrem Tresor überein, daher blieb die alte Datei unberührt. Es ging nichts verloren — bitte versuchen Sie es erneut.',
			'dataIo.importTitle' => 'Importieren',
			'dataIo.file' => 'Datei',
			'dataIo.fileMeta' => ({required Object size}) => '${size} · aus Dateien',
			'dataIo.kilobytes' => ({required Object n}) => '${n} KB',
			'dataIo.megabytes' => ({required Object n}) => '${n} MB',
			'dataIo.change' => 'Ändern',
			'dataIo.found' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Eintrag zum Importieren gefunden.', other: '${n} Einträge zum Importieren gefunden.', ), 
			'dataIo.addTo' => 'Hinzufügen zu',
			'dataIo.importNote' => 'Einträge werden dem gewählten Tresor hinzugefügt. Nichts wird ersetzt.',
			'dataIo.importButton' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Eintrag importieren', other: '${n} Einträge importieren', ), 
			'dataIo.invalidCsv' => 'Diese Datei konnte nicht als CSV gelesen werden.',
			'dataIo.noItems' => 'In dieser Datei wurden keine Einträge gefunden.',
			'dataIo.notCsvNote' => 'Exportieren Sie eine CSV-Datei aus Ihrem anderen Passwortmanager und wählen Sie diese Datei dann hier aus.',
			'dataIo.chooseAnother' => 'Andere Datei wählen',
			'dataIo.exportTitle' => 'Exportieren',
			'dataIo.exportIntro' => 'Schreibt eine CSV-Datei des gewählten Tresors. Exportierte Einträge verlassen die Verschlüsselung des Tresors — was Sie mit der Datei tun, liegt bei Ihnen.',
			'dataIo.sourceVault' => 'Quelltresor',
			'dataIo.notEncryptedTitle' => 'Eine CSV-Datei ist nicht verschlüsselt',
			'dataIo.notEncryptedBody' => 'Wer sie öffnet, kann jedes Passwort darin lesen. Bewahren Sie sie sicher auf und löschen Sie sie, wenn Sie fertig sind.',
			'dataIo.exportButton' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Eintrag exportieren', other: '${n} Einträge exportieren', ), 
			'dataIo.exportNote' => 'Öffnet das Teilen-Menü, damit Sie selbst wählen, wohin die Datei geht.',
			'dataIo.recentTitle' => 'Letzte Exporte',
			'dataIo.recentRow' => ({required num n, required Object scope}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${scope} · ${n} Eintrag', other: '${scope} · ${n} Einträge', ), 
			'dataIo.recentNote' => 'Die letzten 10 Exporte werden in Ihrem Tresor vermerkt. KeeperPass bewahrt keine Kopie der Dateien selbst auf.',
			'dataIo.recentEmpty' => 'Noch keine Exporte.',
			'archive.title' => 'Tresor archivieren',
			'archive.headline' => 'Tresor archivieren und abmelden',
			'archive.body' => ({required Object storage}) => 'Ihr Tresor ist eine einzelne verschlüsselte Datei in Ihrem eigenen ${storage}. Beim Archivieren wird sie umbenannt, sodass diese App sie nicht mehr findet, und Sie werden abgemeldet. Es wird nichts gelöscht.',
			'archive.step1' => ({required Object oldName, required Object folder, required Object newName}) => '${oldName} wird im selben ${folder} in ${newName} umbenannt.',
			'archive.step2' => ({required Object storage}) => 'Dieses Telefon meldet sich von ${storage} ab.',
			'archive.step3' => ({required Object storage}) => 'Um die Daten selbst zu löschen, löschen Sie diese Datei in ${storage}.',
			'archive.typePrefix' => 'Geben Sie zur Bestätigung',
			'archive.typeSuffix' => 'ein.',
			'archive.confirmation' => 'Bestätigung',
			'archive.button' => 'Archivieren und abmelden',
			'archive.doneMeta' => 'Umbenannt · diese App findet sie nicht mehr',
			'archive.doneTitle' => 'Ihre Tresordatei wurde umbenannt',
			'archive.doneBody' => ({required Object folder, required Object storage}) => 'Sie liegt weiterhin im ${folder} in Ihrem ${storage}. Löschen Sie sie dort, wenn die Daten endgültig verschwinden sollen.',
			'archive.signedOut' => 'Sie sind auf diesem Telefon abgemeldet.',
			'archive.error' => 'Die Tresordatei konnte nicht umbenannt werden. Es wurde nichts geändert.',
			'help.howTitle' => 'So funktioniert KeeperPass',
			'help.howSubtitle' => 'Wo Ihre Daten liegen und was sie privat hält',
			'help.whereLives' => 'Wo Ihre Daten liegen',
			'help.diagram' => ({required Object storage}) => 'Ihr Tresor wird auf diesem Telefon verschlüsselt und als eine Datei in Ihrem ${storage} gespeichert',
			'help.thisPhoneNote' => 'Verschlüsselt und entschlüsselt alles. Ihr Geheimnis verlässt es nie.',
			'help.fileEncrypted' => 'vault.json.enc · verschlüsselt',
			'help.yourStorage' => ({required Object storage}) => 'Ihr ${storage}',
			'help.storageNote' => 'Enthält die Datei, die ohne Ihr Geheimnis unlesbar ist.',
			'help.noServer' => 'KeeperPass erhält Ihre Daten nie. Es gibt kein Konto, in das eingebrochen werden könnte, und keinen Betreiber, der Ihren Tresor lesen könnte.',
			'help.protects' => 'Was ihn schützt',
			'help.secretTerm' => 'Ihr Geheimnis',
			'help.secretNote' => 'Nie gesendet, nie gespeichert. Es existiert nur im Arbeitsspeicher, solange die App entsperrt ist.',
			'help.kdfTerm' => 'Schlüsselableitung',
			'help.kdfNote' => 'Bewusst langsam, damit jeder Versuch, Ihr Geheimnis zu erraten, teuer ist.',
			'help.encryptionTerm' => 'Verschlüsselung',
			'help.encryptionNote' => 'Hält die Datei unlesbar und zeigt, ob jemand sie verändert hat.',
			'help.accessTerm' => 'Speicherzugriff',
			'help.accessNote' => 'KeeperPass kann nur auf die Dateien zugreifen, die es selbst erstellt.',
			'help.signingIn' => 'Anmelden',
			'help.step1' => 'Cloud-Speicher verbinden',
			'help.step1Note' => 'Belegt, wem die Datei gehört. Entsperrt wird dadurch nichts.',
			'help.step2' => 'Geheimnis eingeben',
			'help.step2Note' => 'Erzeugt auf diesem Telefon den Schlüssel, der die Datei öffnet. Ihr Speicheranbieter sieht ihn nie.',
			'help.bothNeeded' => 'Wer Ihr Speicherkonto hat, kann Ihren Tresor trotzdem nicht lesen. Wer Ihr Geheimnis kennt, erreicht die Datei trotzdem nicht. Es braucht beides.',
			'help.terms' => 'Begriffe, die Sie kennen sollten',
			'help.secretWord' => 'Geheimnis',
			'help.secretDef' => 'Die eine Phrase, die Ihren Tresor entsperrt. Sie kann nicht wiederhergestellt werden.',
			'help.vaultWord' => 'Tresor',
			'help.vaultDef' => 'Eine Gruppe von Einträgen. Mit mehreren halten Sie Arbeit und Privates getrennt.',
			'help.tagWord' => 'Tag',
			'help.tagDef' => 'Eine Markierung, um Einträge über Tresore hinweg zu finden, etwa Arbeit oder Bank.',
			'help.reportWord' => 'Sicherheitsbericht',
			'help.reportDef' => 'Markiert auf diesem Telefon schwache, wiederverwendete und geleakte Passwörter.',
			'faq.title' => 'Fragen',
			'faq.subtitle' => 'Antworten auf häufige Fragen',
			'faq.forgetQ' => 'Was, wenn ich mein Geheimnis vergesse?',
			'faq.forgetA1' => 'Ihr Tresor kann nicht wiederhergestellt werden — weder von Ihnen noch von uns. Der Schlüssel wird allein aus Ihrem Geheimnis erzeugt, ohne es bleibt die Datei also unlesbar. Das ist der Preis dafür, dass auch sonst niemand sie lesen kann.',
			'faq.forgetA2' => ({required Object forgot, required Object file}) => 'Sie können aber neu beginnen: ${forgot} auf dem Entsperrbildschirm richtet einen neuen, leeren Tresor ein. Ihre alte Datei wird nicht gelöscht — sie wird in ${file} umbenannt und in Ihrem Ordner keeperpass aufbewahrt, sodass die Daten noch da sind, falls Ihnen das Geheimnis wieder einfällt.',
			'faq.forgetA2Link' => 'Geheimnis vergessen?',
			'faq.forgetA3' => 'Notieren Sie sich Ihr Geheimnis und bewahren Sie es sicher auf. Es ist das Einzige bei KeeperPass, das nicht ersetzt werden kann.',
			'faq.seeQ' => 'Kann KeeperPass meine Passwörter sehen?',
			'faq.seeA' => 'Nein — und das ist kein Versprechen, sondern eine Folge des Designs. Verschlüsselt wird auf diesem Telefon, und der Geheimtext geht direkt in Ihren eigenen Speicher. Es gibt keinen KeeperPass-Server dazwischen, der etwas sehen könnte.',
			'faq.syncQ' => 'Synchronisiert es geräteübergreifend?',
			'faq.syncA' => 'Ja. Jedes Gerät liest dieselbe Datei aus Ihrem Speicher. Melden Sie sich mit demselben Konto an, geben Sie dasselbe Geheimnis ein, und Ihr Tresor ist da.',
			'faq.providerQ' => 'Was, wenn mein Speicheranbieter die Datei liest?',
			'faq.providerA' => 'Er sähe nur verschlüsselte Bytes. Der Schlüssel verlässt dieses Telefon nie, daher können weder Google noch Dropbox noch ein anderer Anbieter den Inhalt lesen.',
			'faq.importQ' => 'Kann ich aus einem anderen Passwortmanager importieren?',
			'faq.importA' => 'Ja — exportieren Sie dort als CSV und verwenden Sie dann Importieren in den Einstellungen.',
			'faq.changeSecretQ' => 'Wie ändere ich mein Geheimnis?',
			'faq.changeSecretA' => ({required Object action}) => 'Öffnen Sie die Einstellungen und wählen Sie ${action}. Sie geben Ihr aktuelles Geheimnis und das neue ein; Ihr Tresor wird entschlüsselt, mit dem neuen Geheimnis neu verschlüsselt und zurückgespeichert. Nichts geht verloren — jeder Eintrag bleibt erhalten, und die Änderung gilt auf jedem Gerät, sobald es Ihren Tresor das nächste Mal lädt.',
			'faq.costQ' => 'Was kostet es?',
			'faq.costA' => 'Nichts. KeeperPass ist kostenlos und quelloffen und speichert die Daten in Cloud-Speicher, den Sie bereits haben.',
			'faq.stillStuck' => 'Immer noch nicht weiter?',
			'faq.contactBody' => 'Fragen, Feedback oder ein Problem? Schreiben Sie uns eine E-Mail.',
			'about.version' => ({required Object version, required Object build}) => 'Version ${version} (${build})',
			'about.tagline' => 'Ihre Cloud. Ihre Schlüssel. Ihr Tresor.',
			'about.license' => 'Kostenlos und quelloffen unter AGPL-3.0',
			'about.terms' => 'Nutzungsbedingungen',
			'about.privacy' => 'Datenschutzerklärung',
			'about.promise' => 'Kostenlos, ohne Haken: keine Tarife, keine Premium-Stufe, keine Zusatzverkäufe.',
			'clipboard.clearsIn' => ({required Object time}) => 'Wird in ${time} geleert',
			'clipboard.cleared' => 'Zwischenablage geleert',
			'sync.savedTo' => ({required Object storage}) => 'In ${storage} gespeichert',
			'sync.notSavedTitle' => 'Ihr Tresor wurde nicht gespeichert',
			'sync.notSavedBody' => ({required Object storage}) => '${storage} war nicht erreichbar. Ihre Änderung ist noch da – wiederholen Sie den Vorgang, bevor Sie KeeperPass schließen.',
			'sync.dismiss' => 'Verwerfen',
			'sync.retryingTitle' => 'Neuer Versuch …',
			'sync.retryingBody' => ({required Object storage}) => 'Wird in ${storage} gespeichert.',
			'sync.reconnectTitle' => ({required Object storage}) => 'Erneut mit ${storage} verbinden',
			'sync.keepReading' => 'Sie können weiterlesen; Änderungen werden gespeichert, sobald Sie wieder verbunden sind.',
			'sync.reconnect' => 'Erneut verbinden',
			'sync.later' => 'Später',
			'sync.offlineBody' => ({required Object storage}) => 'Sie können weiter lesen und kopieren. Zum Speichern ist eine Verbindung zu ${storage} nötig.',
			'sync.changedTitle' => 'Ihr Tresor wurde geändert',
			'sync.changedBody' => 'Auf einem anderen Gerät wurde eine neuere Version Ihres Tresors gespeichert. Laden Sie sie, bevor Sie bearbeiten, damit nichts überschrieben wird.',
			'sync.twoVersions' => 'Zwei Versionen',
			'sync.onThisPhone' => 'Auf diesem Telefon',
			'sync.inStorage' => ({required Object storage}) => 'In ${storage}',
			'sync.loadedAt' => ({required Object time}) => 'geladen: ${time}',
			'sync.savedNewer' => ({required Object time}) => 'gespeichert: ${time} · neuer',
			'sync.loadLatest' => 'Neueste Version laden',
			'sync.notNow' => 'Nicht jetzt',
			'sync.pausedNote' => 'Bis dahin können Sie lesen und kopieren, aber nicht bearbeiten.',
			'sync.upToDate' => 'Auf dem neuesten Stand',
			'sync.loadedVersion' => ({required Object time}) => 'Die um ${time} gespeicherte Version wurde geladen',
			'scan.title' => 'QR-Code scannen',
			'scan.primerTitle' => '2FA-Code per Scan hinzufügen',
			'scan.primerBody' => 'Wenn eine Website die Zwei-Faktor-Anmeldung einschaltet, zeigt sie einen QR-Code. KeeperPass liest ihn mit der Kamera und bewahrt den Einrichtungsschlüssel in Ihrem Tresor auf, damit seine Codes unter „Codes“ erscheinen.',
			'scan.primerPrivacy' => 'Die Kamera liest nur den Code. Es wird nichts aufgezeichnet und kein Bild gespeichert.',
			'scan.primerNext' => 'Als Nächstes fragt Ihr Telefon nach dem Kamerazugriff.',
			'scan.enterInstead' => 'Stattdessen Einrichtungsschlüssel eingeben',
			'scan.hint' => 'Richten Sie die Kamera auf den QR-Code, den die Website\nbeim Einschalten der Zwei-Faktor-Anmeldung zeigt.',
			'scan.torch' => 'Licht einschalten',
			'scan.cameraView' => 'Kameraansicht',
			'scan.codeFound' => 'Code gefunden',
			'scan.saveTo' => 'Speichern in',
			'scan.existingItem' => 'Vorhandener Eintrag',
			'scan.existingItemWith' => ({required Object summary}) => 'Vorhandener Eintrag · ${summary}',
			'scan.newAuthenticator' => 'Neuer Eintrag „Authentifizierung“',
			'scan.named' => ({required Object name}) => 'Mit dem Namen ${name}',
			'scan.cameraOffTitle' => 'Kamerazugriff ist aus',
			'scan.cameraOffBody' => 'KeeperPass braucht die Kamera nur, um QR-Codes zu lesen. Schalten Sie sie in den Einstellungen ein oder geben Sie stattdessen den Einrichtungsschlüssel ein.',
			'scan.openSettings' => 'Einstellungen öffnen',
			'scan.unsupported' => 'Dieser Code nutzt Einstellungen, die KeeperPass noch nicht unterstützt',
			'scan.notACode' => 'Das ist kein 2FA-QR-Code',
			'scan.cameraFailed' => 'Die Kamera konnte nicht starten',
			'scan.item' => 'Eintrag',
			'scan.codeSettings' => '6 Ziffern · alle 30 Sekunden · SHA-1',
			'scan.codeAdded' => ({required Object name}) => 'Code zu ${name} hinzugefügt',
			'scan.tapToCopy' => 'Tippen Sie auf die Karte, um ihn zu kopieren.',
			_ => null,
		};
	}
}
