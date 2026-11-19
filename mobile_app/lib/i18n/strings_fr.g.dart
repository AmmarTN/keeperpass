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
class TranslationsFr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$fr app = _Translations$app$fr._(_root);
	@override late final _Translations$connectivity$fr connectivity = _Translations$connectivity$fr._(_root);
	@override late final _Translations$errors$fr errors = _Translations$errors$fr._(_root);
	@override late final _Translations$common$fr common = _Translations$common$fr._(_root);
	@override late final _Translations$strength$fr strength = _Translations$strength$fr._(_root);
	@override late final _Translations$totp$fr totp = _Translations$totp$fr._(_root);
	@override late final _Translations$settings$fr settings = _Translations$settings$fr._(_root);
	@override late final _Translations$auth$fr auth = _Translations$auth$fr._(_root);
	@override late final _Translations$vaults$fr vaults = _Translations$vaults$fr._(_root);
	@override late final _Translations$welcome$fr welcome = _Translations$welcome$fr._(_root);
	@override late final _Translations$connect$fr connect = _Translations$connect$fr._(_root);
	@override late final _Translations$howItWorks$fr howItWorks = _Translations$howItWorks$fr._(_root);
	@override late final _Translations$technicalDetails$fr technicalDetails = _Translations$technicalDetails$fr._(_root);
	@override late final _Translations$createVault$fr createVault = _Translations$createVault$fr._(_root);
	@override late final _Translations$unlock$fr unlock = _Translations$unlock$fr._(_root);
	@override late final _Translations$newVault$fr newVault = _Translations$newVault$fr._(_root);
	@override late final _Translations$tabs$fr tabs = _Translations$tabs$fr._(_root);
	@override late final _Translations$codes$fr codes = _Translations$codes$fr._(_root);
	@override late final _Translations$comingSoon$fr comingSoon = _Translations$comingSoon$fr._(_root);
	@override late final _Translations$vaultList$fr vaultList = _Translations$vaultList$fr._(_root);
	@override late final _Translations$itemDetail$fr itemDetail = _Translations$itemDetail$fr._(_root);
	@override late final _Translations$editItem$fr editItem = _Translations$editItem$fr._(_root);
	@override late final _Translations$generator$fr generator = _Translations$generator$fr._(_root);
	@override late final _Translations$report$fr report = _Translations$report$fr._(_root);
	@override late final _Translations$audit$fr audit = _Translations$audit$fr._(_root);
	@override late final _Translations$myVaults$fr myVaults = _Translations$myVaults$fr._(_root);
	@override late final _Translations$tags$fr tags = _Translations$tags$fr._(_root);
	@override late final _Translations$changeSecret$fr changeSecret = _Translations$changeSecret$fr._(_root);
	@override late final _Translations$storage$fr storage = _Translations$storage$fr._(_root);
	@override late final _Translations$moveVault$fr moveVault = _Translations$moveVault$fr._(_root);
	@override late final _Translations$dataIo$fr dataIo = _Translations$dataIo$fr._(_root);
	@override late final _Translations$archive$fr archive = _Translations$archive$fr._(_root);
	@override late final _Translations$help$fr help = _Translations$help$fr._(_root);
	@override late final _Translations$faq$fr faq = _Translations$faq$fr._(_root);
	@override late final _Translations$about$fr about = _Translations$about$fr._(_root);
	@override late final _Translations$clipboard$fr clipboard = _Translations$clipboard$fr._(_root);
	@override late final _Translations$sync$fr sync = _Translations$sync$fr._(_root);
	@override late final _Translations$scan$fr scan = _Translations$scan$fr._(_root);
}

// Path: app
class _Translations$app$fr extends Translations$app$en {
	_Translations$app$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'KeeperPass';
}

// Path: connectivity
class _Translations$connectivity$fr extends Translations$connectivity$en {
	_Translations$connectivity$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get offline => 'Pas de connexion Internet';
	@override String get online => 'De nouveau en ligne';
}

// Path: errors
class _Translations$errors$fr extends Translations$errors$en {
	_Translations$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$errors$failures$fr failures = _Translations$errors$failures$fr._(_root);
	@override late final _Translations$errors$drive$fr drive = _Translations$errors$drive$fr._(_root);
	@override late final _Translations$errors$dropbox$fr dropbox = _Translations$errors$dropbox$fr._(_root);
	@override late final _Translations$errors$auth$fr auth = _Translations$errors$auth$fr._(_root);
	@override late final _Translations$errors$masterPassword$fr masterPassword = _Translations$errors$masterPassword$fr._(_root);
	@override late final _Translations$errors$vault$fr vault = _Translations$errors$vault$fr._(_root);
}

// Path: common
class _Translations$common$fr extends Translations$common$en {
	_Translations$common$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get close => 'Fermer';
	@override String get copy => 'Copier';
	@override String get copied => 'Copié';
	@override String get cancel => 'Annuler';
	@override String get save => 'Enregistrer';
	@override String get back => 'Retour';
	@override String get favorite => 'Favori';
	@override String get showSecret => 'Afficher le secret';
	@override String get hideSecret => 'Masquer le secret';
	@override String get empty => '[vide]';
	@override String get clearSearch => 'Effacer la recherche';
	@override String get chooseDate => 'Choisir une date';
	@override String get chooseMonth => 'Choisir un mois';
	@override String get countryCode => 'Indicatif du pays';
	@override String countryCodeValue({required Object country, required Object code}) => 'Indicatif du pays : ${country}, ${code}';
	@override String removeTag({required Object tag}) => 'Retirer le tag ${tag}';
	@override String get secretChip => 'Secret';
	@override String secretToggle({required Object field}) => 'Secret : ${field}';
	@override String reorderField({required Object field}) => 'Déplacer ${field}';
	@override String removeField({required Object field}) => 'Retirer ${field}';
	@override String changeFieldIcon({required Object field}) => 'Changer l’icône de ${field}';
	@override String showAll({required Object count}) => 'Afficher les ${count}';
	@override String get showInLargeType => 'Afficher en grands caractères';
	@override String stepOf({required Object current, required Object total}) => 'Étape ${current} sur ${total}';
	@override String get next => 'Suivant';
	@override String get continueAction => 'Continuer';
	@override String get tryAgain => 'Réessayer';
	@override String get retry => 'Réessayer';
	@override String get show => 'Afficher';
	@override String get hide => 'Masquer';
	@override String get gotIt => 'Compris';
	@override String get disconnect => 'Se déconnecter';
	@override String get generateSecret => 'Générer un secret';
	@override String get useAnotherAccount => 'Utiliser un autre compte';
	@override String get offlineTitle => 'Vous êtes hors ligne';
	@override String savingTo({required Object provider}) => 'Enregistrement dans ${provider}…';
	@override String get keepOpen => 'Gardez KeeperPass ouvert jusqu’à la fin.';
	@override String get typeItAgain => 'Saisissez-le à nouveau';
	@override String get secretHiddenValue => 'Masqué';
	@override String get rename => 'Renommer';
	@override String get done => 'Terminé';
}

// Path: strength
class _Translations$strength$fr extends Translations$strength$en {
	_Translations$strength$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get veryWeak => 'Très faible';
	@override String get weak => 'Faible';
	@override String get fair => 'Moyen';
	@override String get strong => 'Fort';
	@override String get veryStrong => 'Très fort';
	@override String meter({required Object level}) => 'Robustesse : ${level}';
}

// Path: totp
class _Translations$totp$fr extends Translations$totp$en {
	_Translations$totp$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get invalidCode => 'Code invalide';
	@override String get invalidKey => 'La clé de configuration n’est pas valide, aucun code ne peut donc être généré.';
	@override String get fixInEdit => 'Corriger dans Modifier';
	@override String secondsShort({required Object count}) => '${count} s';
	@override String secondsLeft({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		one: 'Encore ${count} seconde',
		other: 'Encore ${count} secondes',
	);
}

// Path: settings
class _Translations$settings$fr extends Translations$settings$en {
	_Translations$settings$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$settings$migrate$fr migrate = _Translations$settings$migrate$fr._(_root);
	@override String get title => 'Paramètres';
	@override String get subtitle => 'Compte, langue, sécurité et données';
	@override String get account => 'Compte';
	@override String accountLine({required Object email, required Object storage}) => '${email} · ${storage}';
	@override String get accountNote => 'Le nom et l’adresse e-mail proviennent du compte utilisé pour vous connecter.';
	@override String get logOut => 'Se déconnecter';
	@override String get logOutTitle => 'Se déconnecter ?';
	@override String logOutBody({required Object storage, required Object provider}) => 'Votre coffre-fort reste chiffré dans votre ${storage}. Pour l’ouvrir à nouveau, connectez-vous avec ${provider} et saisissez votre secret.';
	@override String get security => 'Sécurité';
	@override String get lockNow => 'Verrouiller maintenant';
	@override String get autoLock => 'Verrouillage automatique';
	@override String get clearClipboard => 'Effacer le presse-papiers';
	@override String get hideInSwitcher => 'Masquer dans le sélecteur d’apps';
	@override String get hideInSwitcherNote => 'Affiche un écran de confidentialité à la place de votre coffre-fort';
	@override String get changeSecret => 'Changer le secret';
	@override String get securityNote => 'Le verrouillage efface le coffre-fort déchiffré de la mémoire de ce téléphone.';
	@override String get appearance => 'Apparence';
	@override String get theme => 'Thème';
	@override String get themeAuto => 'Auto';
	@override String get themeLight => 'Clair';
	@override String get themeDark => 'Sombre';
	@override String get language => 'Langue';
	@override String get storage => 'Stockage';
	@override String get whereItLives => 'Où vit votre coffre-fort';
	@override String moveTo({required Object storage}) => 'Déplacer le coffre-fort vers ${storage}';
	@override String get data => 'Données';
	@override String get importCsv => 'Importer un CSV';
	@override String get exportCsv => 'Exporter en CSV';
	@override String get recentExports => 'Exports récents';
	@override String get help => 'Aide';
	@override String get howItWorks => 'Comment fonctionne KeeperPass';
	@override String get questions => 'Questions';
	@override String get about => 'À propos de KeeperPass';
	@override String get dangerZone => 'Zone de danger';
	@override String get archive => 'Archiver le coffre-fort et se déconnecter';
	@override String get archiveNote => 'Renomme le fichier de votre coffre-fort et vous déconnecte. Rien n’est effacé.';
	@override String footer({required Object version}) => 'KeeperPass ${version} · Gratuit et open source sous AGPL-3.0';
	@override String get autoLockTitle => 'Verrouillage automatique';
	@override String get autoLockImmediately => 'Immédiatement en quittant l’app';
	@override String get autoLockImmediatelyShort => 'Immédiatement';
	@override String get after1Minute => 'Après 1 minute';
	@override String get after5Minutes => 'Après 5 minutes';
	@override String get after10Minutes => 'Après 10 minutes';
	@override String get autoLockNote => 'KeeperPass se verrouille après cette durée sans utilisation. Le déverrouiller demande à nouveau votre secret.';
	@override String get clearClipboardTitle => 'Effacer le presse-papiers';
	@override String get after30Seconds => 'Après 30 secondes';
	@override String get after2Minutes => 'Après 2 minutes';
	@override String get never => 'Jamais';
	@override String get after30s => 'Après 30 s';
	@override String get after1Min => 'Après 1 min';
	@override String get after2Min => 'Après 2 min';
	@override String get clipboardNote => 'Les mots de passe et les codes que vous copiez sont effacés du presse-papiers après ce délai, si rien d’autre n’a été copié entre-temps.';
	@override String get preview => 'Aperçu';
	@override String get previewFrom => 'Depuis GitHub';
	@override String previewClears({required Object time}) => 'Depuis GitHub · Effacé dans ${time}';
	@override String seconds({required Object n}) => '${n} s';
	@override String minutes({required Object n}) => '${n} min';
	@override String get languageTitle => 'Langue';
	@override String get languageNote => 'Enregistrée uniquement sur ce téléphone — elle ne fait pas partie de votre coffre-fort.';
	@override String get hideInSwitcherBlocks => 'Affiche un écran de confidentialité à la place de votre coffre-fort et bloque les captures d’écran';
	@override String get blockScreenshots => 'Bloquer les captures d’écran';
	@override String get blockScreenshotsNote => 'Android uniquement · bloque aussi l’enregistrement de l’écran';
	@override String get blockScreenshotsWhileHidden => 'Activé tant que « Masquer dans le sélecteur d’apps » est activé';
}

// Path: auth
class _Translations$auth$fr extends Translations$auth$en {
	_Translations$auth$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$auth$unlock$fr unlock = _Translations$auth$unlock$fr._(_root);
}

// Path: vaults
class _Translations$vaults$fr extends Translations$vaults$en {
	_Translations$vaults$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get defaultName => 'Mon coffre-fort';
}

// Path: welcome
class _Translations$welcome$fr extends Translations$welcome$en {
	_Translations$welcome$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get howItWorks => 'Comment ça marche';
	@override String get badge => 'Chiffré de bout en bout';
	@override String get title => 'Bienvenue sur KeeperPass';
	@override String get description => 'Votre coffre-fort est un seul fichier chiffré dans votre propre espace de stockage cloud. Connectez-vous pour l’ouvrir.';
	@override String get fileTag => 'Ce que voit votre stockage';
	@override String get fileMeta => 'Argon2id · AES-256-GCM';
	@override String get continueWithGoogle => 'Continuer avec Google';
	@override String get continueWithDropbox => 'Continuer avec Dropbox';
	@override String connecting({required Object provider}) => 'Connexion à ${provider}…';
	@override String get factAccess => 'Accès uniquement aux fichiers créés par KeeperPass';
	@override String get factEncrypted => 'Chiffré sur ce téléphone, avec votre propre secret';
	@override String get factNoServer => 'Pas de serveur KeeperPass. Rien ne part ailleurs.';
	@override String get footer => 'Pas de compte KeeperPass — seulement celui de Google ou Dropbox que vous avez déjà. La connexion crée le fichier du coffre-fort si vous n’en avez pas encore.';
}

// Path: connect
class _Translations$connect$fr extends Translations$connect$en {
	_Translations$connect$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String lookingIn({required Object storage}) => 'Recherche dans ${storage}…';
	@override String get checkingTitle => 'Vérification de votre coffre-fort…';
	@override String checkingDetail({required Object storage}) => 'Recherche de vault.json.enc dans ${storage}.';
	@override String get foundTitle => 'Votre coffre-fort a été trouvé';
	@override String get foundDetail => 'Ouverture du déverrouillage…';
	@override String foundMeta({required Object storage}) => 'Trouvé dans ${storage}';
	@override String foundMetaUpdated({required Object storage, required Object time}) => 'Trouvé dans ${storage} · mis à jour ${time}';
	@override String get canceledDetail => 'Rien n’a été connecté.';
	@override String get signInFailed => 'Échec de la connexion';
	@override String get offlineDetail => 'La connexion nécessite un accès à Google ou à Dropbox. Cela se met à jour tout seul dès que vous êtes de nouveau en ligne.';
	@override String get welcomeBack => 'Bon retour,';
	@override String expiredDetail({required Object provider}) => 'Votre session ${provider} a expiré. Reconnectez-vous pour déverrouiller votre coffre-fort.';
	@override String get lastUsed => 'Dernière utilisée';
	@override String checkFailedMeta({required Object storage}) => 'Lecture impossible depuis ${storage}';
	@override String get checkFailedTitle => 'Impossible de lire votre coffre-fort';
	@override String checkFailedDetail({required Object storage}) => '${storage} n’a pas répondu. Rien n’a été modifié.';
}

// Path: howItWorks
class _Translations$howItWorks$fr extends Translations$howItWorks$en {
	_Translations$howItWorks$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get step1Title => 'Votre coffre-fort vit\ndans votre cloud';
	@override String get step1Body => 'KeeperPass enregistre un seul fichier chiffré dans votre Google Drive ou Dropbox. Il n’y a pas de serveur KeeperPass : nous n’en recevons jamais de copie.';
	@override String get encrypted => 'Chiffré';
	@override String get step2Title => 'Choisissez un secret';
	@override String get step2Body => 'Il devient la clé. Jamais envoyé, jamais stocké.';
	@override String get step3Title => 'Il faut les deux';
	@override String get step3Body => 'Quelqu’un qui a votre compte de stockage ne peut pas lire votre coffre-fort. Quelqu’un qui a votre secret ne peut pas l’atteindre.';
	@override String get storageAccount => 'Compte de stockage';
	@override String get reachesFile => 'Atteint le fichier';
	@override String get yourSecret => 'Votre secret';
	@override String get opensFile => 'Ouvre le fichier';
	@override String get technicalDetails => 'Détails techniques';
	@override String get technicalSummary => 'Argon2id · AES-256';
}

// Path: technicalDetails
class _Translations$technicalDetails$fr extends Translations$technicalDetails$en {
	_Translations$technicalDetails$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Détails techniques';
	@override String get keyDerivation => 'Dérivation de la clé';
	@override TextSpan keyDerivationValue({required InlineSpan algorithm}) => TextSpan(children: [
		algorithm,
		const TextSpan(text: ' · 64 Mio de mémoire · 3 itérations · parallélisme 4, pour une clé de 256 bits'),
	]);
	@override String get encryption => 'Chiffrement';
	@override TextSpan encryptionValue({required InlineSpan algorithm}) => TextSpan(children: [
		algorithm,
		const TextSpan(text: ', qui détecte aussi toute modification du fichier'),
	]);
	@override String get googleDrive => 'Google Drive';
	@override TextSpan googleDriveValue({required InlineSpan scope}) => TextSpan(children: [
		const TextSpan(text: 'La portée '),
		scope,
		const TextSpan(text: ' : uniquement les fichiers créés par KeeperPass'),
	]);
	@override String get dropbox => 'Dropbox';
	@override TextSpan dropboxValue({required InlineSpan folder}) => TextSpan(children: [
		const TextSpan(text: 'Un dossier d’application : '),
		folder,
	]);
	@override String get vaultFile => 'Fichier du coffre-fort';
	@override TextSpan vaultFileValue({required InlineSpan file}) => TextSpan(children: [
		file,
		const TextSpan(text: ' — un seul fichier, rechiffré et réécrit à chaque enregistrement'),
	]);
	@override String get viewSource => 'Voir le code source sur GitHub';
	@override String get license => 'Gratuit et open source sous AGPL-3.0 : tout ceci peut être vérifié.';
}

// Path: createVault
class _Translations$createVault$fr extends Translations$createVault$en {
	_Translations$createVault$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'Créez votre coffre-fort';
	@override String get step1Title => 'Choisissez votre secret';
	@override String get step1Body => 'Il chiffre votre coffre-fort sur ce téléphone. Tout ce que vous enregistrez est protégé par lui.';
	@override String get settingUpFor => 'Configuration pour';
	@override String get secret => 'Secret';
	@override String get secretPlaceholder => 'Votre secret';
	@override String get generateAnother => 'En générer un autre';
	@override String get generatedNote => 'Les secrets générés sautent l’étape de nouvelle saisie.';
	@override String get weakWarning => 'Ce secret est faible, ce qui facilite le contournement du chiffrement de votre coffre-fort. Vous pouvez continuer, mais une phrase plus longue est fortement recommandée.';
	@override String get tipsTitle => 'Choisir un bon secret';
	@override String get tip1 => 'Plusieurs mots au hasard valent mieux qu’un mot astucieux : plus il est long, plus il est difficile à deviner.';
	@override String get tip2 => 'Ne réutilisez pas un mot de passe que vous utilisez ailleurs.';
	@override String get tip3 => 'Choisissez quelque chose que vous pouvez saisir sur ce téléphone, puis notez-le et rangez-le en lieu sûr.';
	@override String get step2Title => 'Saisissez-le à nouveau';
	@override String get step2Body => 'Juste pour être sûr qu’il n’y a pas de faute de frappe. Personne ne pourra réinitialiser votre secret plus tard.';
	@override String get repeat => 'Répétez le secret';
	@override String get mismatch => 'Les deux secrets ne correspondent pas.';
	@override String get step3Title => 'Notez-le';
	@override String get step3Body => 'Vous en aurez besoin à chaque déverrouillage. Rangez-le en lieu sûr, loin de ce téléphone.';
	@override String secretWords({required Object count}) => 'Votre secret · ${count} mots';
	@override String get secretWhole => 'Votre secret';
	@override String get secretHidden => 'Votre secret, masqué';
	@override String get secretShown => 'Votre secret, affiché';
	@override String get readBefore => 'Veuillez lire ceci avant de continuer';
	@override String get bullet1 => 'Votre secret n’est jamais envoyé nulle part ni stocké. Personne — ni KeeperPass, ni votre fournisseur de stockage — ne peut le consulter ni le réinitialiser.';
	@override String get bullet2 => 'Si vous l’oubliez, votre coffre-fort ne peut pas être récupéré. Aucun lien de réinitialisation ni demande d’assistance ne peut l’ouvrir.';
	@override String get bullet3 => 'Notez-le et conservez-le en lieu sûr avant de continuer.';
	@override String get acknowledge => 'J’ai noté mon secret';
	@override String get create => 'Créer le coffre-fort';
	@override String get progressTitle => 'Création de votre coffre-fort';
	@override String get encrypting => 'Chiffrement de votre coffre-fort…';
	@override String get encryptingDetail => 'Sur ce téléphone. Cela prend quelques secondes.';
	@override String get encryptingMeta => 'Chiffrement sur ce téléphone…';
	@override String get savingDetail => 'Un seul fichier chiffré, dans le dossier keeperpass.';
	@override String get failedTitle => 'Impossible d’enregistrer votre coffre-fort';
	@override String get notSaved => 'Non enregistré';
	@override String failedDetail({required Object storage}) => '${storage} n’a pas répondu. Rien n’a été enregistré, et votre secret est toujours là.';
	@override String get backToSecret => 'Retour à votre secret';
}

// Path: unlock
class _Translations$unlock$fr extends Translations$unlock$en {
	_Translations$unlock$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get notYou => 'Ce n’est pas vous ?';
	@override String get secret => 'Secret';
	@override String get placeholder => 'Saisissez votre secret';
	@override String get unlock => 'Déverrouiller';
	@override String get unlocking => 'Déverrouillage…';
	@override String get unlockingStatus => 'Déverrouillage sur ce téléphone…';
	@override String get slowNote => 'Quelques secondes, exprès : cela rend lente toute tentative de deviner votre secret.';
	@override String get forgot => 'Secret oublié ?';
	@override String get leftApp => 'Verrouillé quand vous avez quitté KeeperPass';
	@override String unreachableTitle({required Object storage}) => 'Impossible de joindre ${storage}';
	@override String get unreachableDetail => 'Vérifiez votre connexion et réessayez. Votre secret est toujours saisi.';
	@override String offlineDetail({required Object storage}) => 'Le déverrouillage nécessite une connexion à ${storage}. « Déverrouiller » se réactive dès que vous êtes de nouveau en ligne.';
	@override String accountLine({required Object email, required Object storage}) => '${email} · ${storage}';
	@override String lockedInactivity({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Verrouillé après ${n} minute d’inactivité',
		other: 'Verrouillé après ${n} minutes d’inactivité',
	);
}

// Path: newVault
class _Translations$newVault$fr extends Translations$newVault$en {
	_Translations$newVault$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get backLabel => 'Déverrouiller';
	@override String get backToUnlock => 'Retour au déverrouillage';
	@override String get title => 'Commencer un nouveau coffre-fort';
	@override String get oldMeta => 'Ancien coffre-fort · verrouillé par l’ancien secret';
	@override String get newMeta => 'Nouveau coffre-fort · vide';
	@override String body({required Object provider}) => 'Il est impossible de réinitialiser un secret oublié — ni par KeeperPass, ni par ${provider}. Vous pouvez plutôt recommencer avec un nouveau coffre-fort vide.';
	@override String get pointLocked => 'Votre coffre-fort actuel reste verrouillé par l’ancien secret.';
	@override TextSpan pointKept({required InlineSpan file, required InlineSpan storage}) => TextSpan(children: [
		const TextSpan(text: 'Son fichier est conservé sous le nom '),
		file,
		const TextSpan(text: ' dans votre '),
		storage,
		const TextSpan(text: '. Rien n’est supprimé.'),
	]);
	@override String get pointFresh => 'Vous recommencez avec un tout nouveau coffre-fort vide.';
	@override String get account => 'Compte';
	@override String get newSecret => 'Nouveau secret';
	@override String get newSecretPlaceholder => 'Choisissez un nouveau secret';
	@override String get repeat => 'Répétez le nouveau secret';
	@override String get weakWarning => 'Ce secret est faible, ce qui facilite le contournement du chiffrement de vos coffres-forts. Vous pouvez continuer, mais une phrase plus longue est fortement recommandée.';
	@override String get warn => 'Comme l’ancien, votre nouveau secret ne peut être ni consulté ni réinitialisé. Notez-le avant de continuer.';
	@override String get start => 'Commencer un nouveau coffre-fort';
	@override String get confirmTitle => 'Commencer un nouveau coffre-fort ?';
	@override String confirmKept({required Object storage}) => 'Son fichier est conservé comme sauvegarde datée dans votre ${storage}.';
	@override String get confirmFresh => 'Vous recommencez avec un coffre-fort vide protégé par votre nouveau secret.';
	@override String get progressTitle => 'Création d’un nouveau coffre-fort';
	@override String get encrypting => 'Chiffrement de votre nouveau coffre-fort…';
	@override String get backingUp => 'Conservation de votre ancien coffre-fort en sauvegarde…';
	@override String backingUpDetail({required Object storage}) => 'Renommage dans ${storage}.';
	@override String get readyMeta => 'Chiffré · prêt à enregistrer';
	@override String get backupFailedMeta => 'Renommage impossible · rien n’a changé';
	@override String get nothingChanged => 'Rien n’a été modifié';
	@override String backupFailedDetail({required Object storage}) => 'Impossible de sauvegarder votre coffre-fort existant dans ${storage}. Rien n’a été modifié.';
	@override String get doneTitle => 'Nouveau coffre-fort commencé';
	@override String doneDetail({required Object storage}) => 'Votre ancien coffre-fort est conservé en sauvegarde dans ${storage}.';
}

// Path: tabs
class _Translations$tabs$fr extends Translations$tabs$en {
	_Translations$tabs$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get vault => 'Coffre-fort';
	@override String get codes => 'Codes';
	@override String get generator => 'Générateur';
	@override String get security => 'Sécurité';
	@override String get settings => 'Paramètres';
	@override String securityFlagged({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Sécurité, ${n} élément signalé',
		other: 'Sécurité, ${n} éléments signalés',
	);
}

// Path: codes
class _Translations$codes$fr extends Translations$codes$en {
	_Translations$codes$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Codes 2FA de votre coffre-fort, générés sur ce téléphone';
	@override String searchPlaceholder({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Rechercher dans ${n} code',
		other: 'Rechercher dans ${n} codes',
	);
	@override String codeCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} code',
		other: '${n} codes',
	);
	@override String get copied => 'Code copié';
	@override String get trust => 'Générés sur ce téléphone à partir des clés de configuration de votre coffre-fort. Rien de nouveau n’est enregistré.';
	@override String get emptyTitle => 'Aucun code 2FA pour l’instant';
	@override String get emptyBody => 'Quand un site propose la connexion à deux facteurs, scannez son code QR ici ou ajoutez un élément Authentificateur.';
	@override String get createAuthenticator => 'Créer un élément Authentificateur';
}

// Path: comingSoon
class _Translations$comingSoon$fr extends Translations$comingSoon$en {
	_Translations$comingSoon$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String body({required Object part}) => 'Arrive dans la partie ${part}.';
}

// Path: vaultList
class _Translations$vaultList$fr extends Translations$vaultList$en {
	_Translations$vaultList$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get lock => 'Verrouiller';
	@override String get newItem => 'Nouvel élément';
	@override String get allVaults => 'Tous les coffres-forts';
	@override String get favorites => 'Favoris';
	@override String get recentlyUsed => 'Récemment utilisés';
	@override String statusSaved({required Object items, required Object storage}) => '${items} · Enregistré dans ${storage}';
	@override String statusInVault({required Object items, required Object vault}) => '${items} dans ${vault}';
	@override String statusTagged({required Object items, required Object tag}) => '${items} avec le tag ${tag}';
	@override String statusReport({required Object items, required Object report}) => '${items} · ${report}';
	@override String statusNotConnected({required Object storage}) => 'Non connecté à ${storage}';
	@override String statusOffline({required Object items}) => 'Hors ligne · ${items}';
	@override String get reportWeak => 'Mots de passe faibles';
	@override String get reportReused => 'Mots de passe réutilisés';
	@override String get reportCompromised => 'Mots de passe compromis';
	@override String get searchHint => 'Chaque mot doit correspondre, dans n’importe quel ordre : noms, tags, noms de champ et valeurs.';
	@override String get filterByTag => 'Filtrer par tag';
	@override String get manageTags => 'Gérer les tags';
	@override String get clearFilter => 'Effacer le filtre';
	@override String get today => 'Aujourd’hui';
	@override String get thisWeek => 'Cette semaine';
	@override String get earlier => 'Plus tôt';
	@override String get aToZ => 'De A à Z';
	@override String get sortHeading => 'Trier par dernière modification';
	@override String get newestFirst => 'Plus récents d’abord';
	@override String get oldestFirst => 'Plus anciens d’abord';
	@override String refreshing({required Object storage}) => 'Lecture de votre coffre-fort depuis ${storage}…';
	@override String copyPasswordFor({required Object name}) => 'Copier le mot de passe de ${name}';
	@override String copyCodeFor({required Object name}) => 'Copier le code de ${name}';
	@override String copyCardNumberFor({required Object name}) => 'Copier le numéro de carte de ${name}';
	@override String get swipePassword => 'Mot de passe';
	@override String get swipeCode => 'Code';
	@override String get swipeCardNumber => 'Numéro de carte';
	@override String get swipeUsername => 'Nom d’utilisateur';
	@override String get swipeMore => 'Plus';
	@override String get copyPassword => 'Copier le mot de passe';
	@override String get copyCode => 'Copier le code';
	@override String get copyCardNumber => 'Copier le numéro de carte';
	@override String get copyUsername => 'Copier le nom d’utilisateur';
	@override String get moreActions => 'Autres actions';
	@override String get favorite => 'Favori';
	@override String get addToFavorites => 'Ajouter aux favoris';
	@override String get removeFromFavorites => 'Retirer des favoris';
	@override String get findingWeak => 'Mot de passe faible';
	@override String get findingReused => 'Mot de passe réutilisé';
	@override String get findingCompromised => 'Mot de passe compromis';
	@override String get findingWeakReused => 'Mot de passe faible et réutilisé';
	@override String get findingWeakCompromised => 'Mot de passe faible et compromis';
	@override String get findingReusedCompromised => 'Mot de passe réutilisé et compromis';
	@override String get findingAll => 'Mot de passe faible, réutilisé et compromis';
	@override String get unnamed => 'Nouvel élément';
	@override String get scopeTitle => 'Coffres-forts';
	@override String get manageVaults => 'Gérer les coffres-forts';
	@override String scopeNote({required Object storage}) => 'Tous vos coffres-forts se trouvent dans un seul fichier chiffré, vault.json.enc, dans votre ${storage}.';
	@override String quickActions({required Object name}) => '${name}, actions rapides';
	@override String get openWebsite => 'Ouvrir le site web';
	@override String get moveToVault => 'Déplacer vers un coffre-fort…';
	@override String get select => 'Sélectionner';
	@override String get delete => 'Supprimer';
	@override String get selectAll => 'Tout sélectionner';
	@override String get selectOrDeselectAll => 'Tout sélectionner ou désélectionner';
	@override String listTwo({required Object a, required Object b}) => '${a} et ${b}';
	@override String listThree({required Object a, required Object b, required Object c}) => '${a}, ${b} et ${c}';
	@override String get deleteItemTitle => 'Supprimer l’élément';
	@override String deleteItemConfirm({required Object name}) => 'Voulez-vous vraiment supprimer « ${name} » ? Cette action est irréversible.';
	@override String get deleteItemAction => 'Supprimer l’élément';
	@override String get moveToVaultTitle => 'Déplacer vers un coffre-fort';
	@override String get moveDescription => 'Choisissez le coffre-fort où cet élément doit se trouver.';
	@override String get current => 'Actuel';
	@override String get newVaultOption => 'Nouveau coffre-fort…';
	@override String get noOtherVaultOne => 'Il n’y a pas d’autre coffre-fort vers lequel déplacer cet élément.';
	@override String get noOtherVaultMany => 'Il n’y a pas d’autre coffre-fort vers lequel déplacer ces éléments.';
	@override String get noOtherVaultDetail => 'Un second coffre-fort permet de séparer un ensemble d’éléments — le travail du personnel, ou le partagé du privé.';
	@override String get createAVault => 'Créer un coffre-fort';
	@override String get newVaultTitle => 'Nouveau coffre-fort';
	@override String get newVaultBody => 'Un coffre-fort est un groupe d’éléments à part. Contrairement à un élément, il n’y a rien d’autre à choisir au départ.';
	@override String get vaultName => 'Nom du coffre-fort';
	@override String get duplicateVault => 'Un coffre-fort portant ce nom existe déjà.';
	@override String get noItemsTitle => 'Vous n’avez encore aucun élément.';
	@override String get noItemsBody => 'Ajoutez votre premier identifiant, carte ou note. Chacun est chiffré sur ce téléphone avant d’être enregistré.';
	@override String get importCsv => 'Importer depuis un CSV';
	@override String get vaultReady => 'Votre coffre-fort est prêt. Il est encore vide.';
	@override String savedMeta({required Object storage, required Object items}) => 'Enregistré dans ${storage} · ${items}';
	@override String get vaultEmptyTitle => 'Ce coffre-fort ne contient encore aucun élément.';
	@override String vaultEmptyBody({required Object vault}) => 'Ajoutez-en un ici, ou déplacez des éléments depuis ${vault}.';
	@override String get noFavoritesTitle => 'Vous n’avez encore aucun favori.';
	@override String get noFavoritesBody => 'Touchez l’étoile d’un élément pour le garder ici.';
	@override String get nothingRecentTitle => 'Rien d’utilisé pour l’instant';
	@override String get nothingRecentBody => 'Les éléments que vous ouvrez ou dont vous copiez une valeur apparaissent ici, les plus récents d’abord.';
	@override String get noResultsTitle => 'Votre recherche ne correspond à aucun élément.';
	@override String get noResultsBody => 'Chaque mot doit correspondre. Essayez avec moins de mots ou vérifiez l’orthographe.';
	@override String get allClearWeak => 'Tous les mots de passe de votre coffre-fort sont suffisamment robustes.';
	@override String get allClearReused => 'Chaque mot de passe de votre coffre-fort n’est utilisé qu’une seule fois.';
	@override String get allClearCompromised => 'Aucun de vos mots de passe n’a été trouvé dans une fuite connue.';
	@override String get allClearBody => 'Rien à corriger ici. KeeperPass vérifie à nouveau dès qu’un mot de passe change.';
	@override String get backToSecurity => 'Retour à Sécurité';
	@override String fieldCopied({required Object field}) => '${field} copié';
	@override String copiedFrom({required Object item}) => 'Depuis ${item}';
	@override String itemCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} élément',
		other: '${n} éléments',
	);
	@override String statusNotSaved({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} modification non enregistrée',
		other: '${n} modifications non enregistrées',
	);
	@override String searchPlaceholder({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Rechercher dans ${n} élément',
		other: 'Rechercher dans ${n} éléments',
	);
	@override String results({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} résultat',
		other: '${n} résultats',
	);
	@override String selectedCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} sélectionné',
		other: '${n} sélectionnés',
	);
	@override String moveItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Déplacer ${n} élément',
		other: 'Déplacer ${n} éléments',
	);
	@override String moveItemsTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Déplacer ${n} élément',
		other: 'Déplacer ${n} éléments',
	);
	@override String deleteItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Supprimer ${n} élément',
		other: 'Supprimer ${n} éléments',
	);
	@override String deleteTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Supprimer ${n} élément ?',
		other: 'Supprimer ${n} éléments ?',
	);
	@override String deleteFromVault({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${names} sera supprimé de ${vault}. Cette action est irréversible.',
		other: '${names} seront supprimés de ${vault}. Cette action est irréversible.',
	);
	@override String deleteFromVaults({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${names} sera supprimé. Cette action est irréversible.',
		other: '${names} seront supprimés. Cette action est irréversible.',
	);
	@override String moveLine({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${names} est déplacé avec son historique et ses tags.',
		other: '${names} sont déplacés avec leur historique et leurs tags.',
	);
	@override String movedTitle({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${names} déplacé vers ${vault}',
		other: '${names} déplacés vers ${vault}',
	);
	@override String movedDetail({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Il garde son historique et ses tags.',
		other: 'Ils gardent leur historique et leurs tags.',
	);
	@override String itemsOf({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${count} sur ${n} élément',
		other: '${count} sur ${n} éléments',
	);
}

// Path: itemDetail
class _Translations$itemDetail$fr extends Translations$itemDetail$en {
	_Translations$itemDetail$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get edit => 'Modifier';
	@override String get editItem => 'Modifier l’élément';
	@override String get moreOptions => 'Plus d’options';
	@override String updatedAgo({required Object ago}) => 'Mis à jour ${ago}';
	@override String showTagged({required Object tag}) => 'Afficher les éléments avec le tag ${tag}';
	@override String get fields => 'Champs';
	@override String get noFields => 'Cet élément n’a aucun champ.';
	@override String get history => 'Historique';
	@override String get currentVersion => 'Version actuelle';
	@override String todayAt({required Object time}) => 'Aujourd’hui, ${time}';
	@override String get unnamedField => 'Sans nom';
	@override String copyField({required Object field}) => 'Copier ${field}';
	@override String get revealValue => 'Afficher la valeur';
	@override String get hideValue => 'Masquer la valeur';
	@override String hiddenValue({required Object field}) => '${field}, masqué';
	@override String openSite({required Object site}) => 'Ouvrir ${site}';
	@override String get call => 'Appeler';
	@override String get message => 'Message';
	@override String get checksumFail => 'Ce numéro échoue à sa somme de contrôle — l’un des chiffres est probablement erroné.';
	@override String get codeCardHint => 'Touchez pour copier · aussi dans l’onglet Codes';
	@override String get copyAllCodes => 'Copier tous les codes';
	@override String copyCodeNumber({required Object n}) => 'Copier le code ${n}';
	@override String get cardFace => 'Carte, numéro masqué';
	@override String cardFaceBrand({required Object brand}) => 'Carte ${brand}, numéro masqué';
	@override String cardExpires({required Object date}) => 'expire en ${date}';
	@override String get largeTypeTurn => 'Tournez votre téléphone pour le lire sur une seule ligne.';
	@override String get largeTypeHides => 'Il est de nouveau masqué quand vous quittez cet écran.';
	@override String get earlierVersion => 'Version précédente';
	@override String readOnly({required Object ago}) => '${ago} · lecture seule';
	@override String get changedSince => 'Modifié depuis';
	@override String get restoreThisVersion => 'Restaurer cette version';
	@override String get deleteVersion => 'Supprimer la version';
	@override String get restoreTitle => 'Restaurer cette version ?';
	@override String restoreBody({required Object name, required Object date}) => '${name} revient à son état du ${date}. La version actuelle reste dans son historique.';
	@override String get restore => 'Restaurer';
	@override String get deleteVersionTitle => 'Supprimer cette version';
	@override String get deleteVersionConfirm => 'Voulez-vous vraiment supprimer cette version de l’historique ? Cette action est irréversible.';
	@override String get delete => 'Supprimer';
	@override String get notFound => 'Cet élément n’existe plus.';
	@override String get notFoundHint => 'Il a peut-être été supprimé depuis un autre appareil.';
	@override String get backToVault => 'Retour au coffre-fort';
	@override String hiddenLines({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${field}, masqué, ${n} ligne',
		other: '${field}, masqué, ${n} lignes',
	);
	@override String largeTypeLabel({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${field} en grands caractères, ${n} caractère',
		other: '${field} en grands caractères, ${n} caractères',
	);
}

// Path: editItem
class _Translations$editItem$fr extends Translations$editItem$en {
	_Translations$editItem$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get newVaultItem => 'Nouvel élément du coffre-fort';
	@override String get vault => 'Coffre-fort';
	@override String get template => 'Modèle';
	@override String get templateNote => 'Les modèles ne sont qu’un point de départ : renommez, retirez ou ajoutez des champs à tout moment.';
	@override late final _Translations$editItem$templates$fr templates = _Translations$editItem$templates$fr._(_root);
	@override late final _Translations$editItem$templateHints$fr templateHints = _Translations$editItem$templateHints$fr._(_root);
	@override late final _Translations$editItem$templateFields$fr templateFields = _Translations$editItem$templateFields$fr._(_root);
	@override late final _Translations$editItem$types$fr types = _Translations$editItem$types$fr._(_root);
	@override String get newItem => 'Nouvel élément';
	@override String get editItem => 'Modifier l’élément';
	@override String get changeIcon => 'Changer l’icône';
	@override String get name => 'Nom';
	@override String get namePlaceholder => 'ex. GitHub';
	@override String get tags => 'Tags';
	@override String get addField => 'Ajouter un champ';
	@override String get addFieldTitle => 'Ajouter un champ';
	@override String get noFieldsTitle => 'Aucun champ pour l’instant';
	@override String get noFieldsBody => 'Ajoutez l’un des 16 types de champ — un numéro de contrat, un numéro de téléphone, un code PIN.';
	@override String get fieldNamePlaceholder => 'Nom du champ';
	@override String get addTag => 'Ajouter un tag';
	@override String get tagSuggestions => 'Suggestions de tags';
	@override String createTag({required Object name}) => 'Créer « ${name} »';
	@override String get tagTooLong => 'Ce nom est trop long.';
	@override String get removeFieldTitle => 'Voulez-vous vraiment supprimer ce champ ?';
	@override String removeFieldBody({required Object field, required Object item}) => '« ${field} » et sa valeur quittent ${item} à l’enregistrement.';
	@override String get remove => 'Retirer';
	@override String get discardTitle => 'Abandonner les modifications ?';
	@override String discardBody({required Object name}) => 'Vos modifications de ${name} n’ont pas été enregistrées. Les abandonner laisse l’élément tel qu’il était.';
	@override String get discardNewTitle => 'Abandonner ce nouvel élément ?';
	@override String get discardNewBody => 'Il n’a pas été enregistré. L’abandonner le supprime.';
	@override String get discard => 'Abandonner';
	@override String get usernamePlaceholder => 'Nom d’utilisateur ou e-mail';
	@override String get passwordPlaceholder => 'Mot de passe';
	@override String get valuePlaceholder => 'Saisissez la valeur ici';
	@override String get ipHostPlaceholder => 'ex. 192.168.1.1, ::1 ou db.exemple.com';
	@override String get recoveryCodesPlaceholder => 'Un par ligne — tout format convient';
	@override String get notEmail => 'Cela ne ressemble pas à une adresse e-mail.';
	@override String get phoneNumber => 'Numéro de téléphone';
	@override String get searchCountries => 'Rechercher des pays';
	@override String get noCountryMatch => 'Aucun pays ne correspond.';
	@override String get generate => 'Générer';
	@override String get generatePassword => 'Générer un mot de passe';
	@override String get currentCode => 'Code actuel';
	@override String get scanQr => 'Scanner le code QR';
	@override String get enterSetupKey => 'Saisir la clé de configuration';
	@override String get setupKeyTitle => 'Saisir la clé de configuration';
	@override String get setupKeyBody => 'Les sites affichent une clé de configuration à côté du code QR, souvent sous « Impossible de scanner ? ».';
	@override String get setupKey => 'Clé de configuration';
	@override String get setupKeyHint => 'Les espaces et les majuscules n’ont pas d’importance.';
	@override String get saveCode => 'Enregistrer le code';
	@override String get chooseIcon => 'Choisir une icône';
	@override String get searchIcons => 'Rechercher des icônes — essayez « banque » ou « cadenas »';
	@override String get popular => 'Populaires';
	@override String noIcons({required Object search}) => 'Aucune icône ne correspond à « ${search} ».';
	@override String get useDefaultIcon => 'Utiliser l’icône par défaut';
	@override String iconMatches({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} résultat',
		other: '${n} résultats',
	);
}

// Path: generator
class _Translations$generator$fr extends Translations$generator$en {
	_Translations$generator$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Générer un mot de passe';
	@override String get notFilledIn => 'Rien n’est rempli tant que vous ne l’acceptez pas.';
	@override String get generated => 'Mot de passe généré';
	@override String get mode => 'Mode';
	@override String get passphrase => 'Phrase de passe';
	@override String get randomString => 'Chaîne aléatoire';
	@override String get words => 'Mots';
	@override String get fewerWords => 'Moins de mots';
	@override String get moreWords => 'Plus de mots';
	@override String get length => 'Longueur';
	@override String get shorter => 'Plus court';
	@override String get longer => 'Plus long';
	@override String get wordSeparator => 'Séparateur de mots';
	@override String get dash => 'Tiret';
	@override String get underscore => 'Tiret bas';
	@override String get slash => 'Barre oblique';
	@override String get space => 'Espace';
	@override String get language => 'Langue';
	@override String get regenerate => 'Régénérer';
	@override String charCount({required Object count}) => '${count} caractères';
	@override String get lowercase => 'Lettres minuscules';
	@override String get uppercase => 'Lettres majuscules';
	@override String get digits => 'Chiffres';
	@override String get symbols => 'Symboles';
	@override String get pickOne => 'Choisissez au moins un type de caractère.';
	@override String get use => 'Utiliser ce mot de passe';
	@override String wordCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} mot',
		other: '${n} mots',
	);
	@override String get pageTitle => 'Générateur de mots de passe';
	@override String get subtitle => 'Mots de passe et phrases de passe aléatoires, créés sur cet appareil';
	@override String get separatorDash => 'Tiret ( - )';
	@override String get separatorUnderscore => 'Tiret bas ( _ )';
	@override String get separatorSlash => 'Barre oblique ( / )';
	@override String get separatorSpace => 'Espace';
	@override String get nothingToGenerate => 'Rien à générer.';
	@override String get copyPassword => 'Copier le mot de passe';
	@override String get copied => 'Mot de passe copié';
	@override String get fromGenerator => 'Depuis le générateur';
}

// Path: report
class _Translations$report$fr extends Translations$report$en {
	_Translations$report$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Rapport de sécurité';
	@override String get subtitle => 'La solidité de vos mots de passe enregistrés';
	@override String get healthLabel => 'Santé du coffre-fort';
	@override String get healthGood => 'Solide';
	@override String get healthFair => 'À améliorer';
	@override String get healthPoor => 'À risque';
	@override String get allClearTitle => 'Aucun problème détecté';
	@override String get allClearDescription => 'Tous les mots de passe de vos coffres-forts ont passé le dernier audit.';
	@override String aboutSection({required Object title}) => 'À propos de ${title}';
	@override String get nothingFound => 'Rien trouvé';
	@override String openItem({required Object name}) => 'Ouvrir ${name}';
	@override String get checkAgain => 'Vérifier à nouveau';
	@override String get statWeak => 'Faibles';
	@override String get statReused => 'Réutilisés';
	@override String get statCompromised => 'Compromis';
	@override String statValue({required Object label, required Object count}) => '${label} : ${count}';
	@override String statNotChecked({required Object label}) => '${label} : pas encore vérifié';
	@override String healthPercent({required Object title, required Object score}) => '${title} ${score} pour cent';
	@override String sameAs({required Object names}) => 'Le même que pour ${names}';
	@override String get sameAsField => 'Le même qu’un autre mot de passe de cet élément';
	@override String get foundInBreach => 'Trouvé dans une fuite connue';
	@override String get trust => 'La vérification des fuites utilise Have I Been Pwned avec le k-anonymat : seuls les 5 premiers caractères d’un hachage SHA-1 quittent ce téléphone.';
	@override String get lastCheckedJustNow => 'Dernière vérification : à l’instant';
	@override String lastCheckedToday({required Object time}) => 'Dernière vérification : aujourd’hui à ${time}';
	@override String lastCheckedOn({required Object date}) => 'Dernière vérification : ${date}';
	@override String get checking => 'Vérification…';
	@override String checkingBreaches({required Object done, required Object total}) => 'Recherche de fuites · ${done} sur ${total}';
	@override String progress({required Object done, required Object total}) => '${done} sur ${total}';
	@override String progressTime({required Object done, required Object total, required Object time}) => '${done} sur ${total} · ${time}';
	@override String get offlineBody => 'Vos mots de passe n’ont pas pu être vérifiés. La vérification nécessite une connexion.';
	@override String get failedTitle => 'La vérification n’a pas pu aboutir';
	@override String get failedBody => 'Réessayez dans un instant.';
	@override String get nothingTitle => 'Rien à vérifier pour l’instant';
	@override String get nothingBody => 'Enregistrez un élément avec un mot de passe : il sera vérifié ici, sur ce téléphone, pour repérer les mots de passe faibles, réutilisés ou piratés.';
	@override String get howToFix => 'Comment y remédier';
	@override String get stepOpen => 'Ouvrez l’élément';
	@override String get stepGenerate => 'Touchez Modifier, puis Générer sur le mot de passe';
	@override String get stepSave => 'Enregistrez : le signalement disparaît de lui-même';
	@override String get stepSaveCompromised => 'Enregistrez, puis changez-le aussi sur le site';
	@override String get changePassword => 'Changer le mot de passe';
	@override String fixedClear({required Object name}) => 'Enregistré · ${name} n’est plus signalé';
	@override String fixedFlagged({required Object name}) => 'Enregistré · ${name} est toujours signalé';
	@override String savedTo({required Object storage}) => 'Votre coffre-fort a été enregistré dans ${storage}';
	@override String get noLongerWeak => 'N’est plus faible';
	@override String get noLongerReused => 'N’est plus réutilisé';
	@override String get noLongerWeakOrReused => 'N’est plus faible ni réutilisé';
	@override String hintReusedOne({required Object n}) => 'Ces ${n} partagent un même mot de passe. Donnez-en un propre à chacun : ouvrez-en un, touchez Modifier, puis Générer.';
	@override String get hintReusedSome => 'Certains partagent un mot de passe. Donnez-en un propre à chacun : ouvrez-en un, touchez Modifier, puis Générer.';
	@override String get hintWeak => 'Donnez-en un plus solide à chacun : ouvrez-le, touchez Modifier, puis Générer.';
	@override String get hintCompromised => 'Ceux-ci figurent dans des fuites connues. Changez chacun : ouvrez-le, touchez Modifier, puis Générer.';
	@override String itemsChecked({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} élément avec mot de passe vérifié',
		other: '${n} éléments avec mot de passe vérifiés',
	);
	@override String flagged({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} élément signalé',
		other: '${n} éléments signalés',
	);
	@override String sameAsOthers({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Le même que pour ${n} autre élément',
		other: 'Le même que pour ${n} autres éléments',
	);
	@override String checkingPasswords({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Vérification de ${n} mot de passe',
		other: 'Vérification de ${n} mots de passe',
	);
	@override String aboutSeconds({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'environ ${n} seconde',
		other: 'environ ${n} secondes',
	);
	@override String aboutMinutes({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'environ ${n} minute',
		other: 'environ ${n} minutes',
	);
}

// Path: audit
class _Translations$audit$fr extends Translations$audit$en {
	_Translations$audit$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$audit$weakPassword$fr weakPassword = _Translations$audit$weakPassword$fr._(_root);
	@override late final _Translations$audit$reusedPassword$fr reusedPassword = _Translations$audit$reusedPassword$fr._(_root);
	@override late final _Translations$audit$compromisedPassword$fr compromisedPassword = _Translations$audit$compromisedPassword$fr._(_root);
}

// Path: myVaults
class _Translations$myVaults$fr extends Translations$myVaults$en {
	_Translations$myVaults$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mes coffres-forts';
	@override String get subtitle => 'Des groupes d’éléments séparés — travail, famille, personnel';
	@override String get defaultBadge => 'Par défaut';
	@override String get newVault => 'Nouveau coffre-fort';
	@override String get emptyTitle => 'Vous n’avez que le coffre-fort par défaut';
	@override String get emptyBody => 'Un second coffre-fort permet de séparer un ensemble d’éléments — le travail du personnel, ou le partagé du privé.';
	@override String createdOn({required Object date}) => 'créé le ${date}';
	@override String get renameTitle => 'Renommer le coffre-fort';
	@override String get renameBody => 'Les éléments qu’il contient ne sont pas affectés.';
	@override String duplicateRename({required Object name}) => 'Un coffre-fort nommé « ${name} » existe déjà.';
	@override String deleteTitle({required Object name}) => 'Supprimer « ${name} » ?';
	@override String get deleteAction => 'Supprimer le coffre-fort';
	@override String renameAria({required Object name}) => 'Renommer ${name}';
	@override String deleteAria({required Object name}) => 'Supprimer ${name}';
	@override String itemCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} élément',
		other: '${n} éléments',
	);
	@override String deleteBody({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Son ${n} élément sera déplacé vers ${vault}. Cette action est irréversible.',
		other: 'Ses ${n} éléments seront déplacés vers ${vault}. Cette action est irréversible.',
	);
	@override String deleteSelectedTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Supprimer ${n} coffre-fort ?',
		other: 'Supprimer ${n} coffres-forts ?',
	);
	@override String deleteSelectedBody({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Tout ce qu’ils contiennent — ${n} élément — sera déplacé vers ${vault}. Cette action est irréversible.',
		other: 'Tout ce qu’ils contiennent — ${n} éléments — sera déplacé vers ${vault}. Cette action est irréversible.',
	);
	@override String personalSummary({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${name} contient ${n} élément et ne peut être ni renommé ni supprimé.',
		other: '${name} contient ${n} éléments et ne peut être ni renommé ni supprimé.',
	);
	@override String selected({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} coffre-fort sélectionné',
		other: '${n} coffres-forts sélectionnés',
	);
	@override String deleteVaults({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Supprimer ${n} coffre-fort',
		other: 'Supprimer ${n} coffres-forts',
	);
}

// Path: tags
class _Translations$tags$fr extends Translations$tags$en {
	_Translations$tags$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tags';
	@override String get subtitle => 'Des étiquettes communes à tous les coffres-forts, pour tout retrouver vite';
	@override String since({required Object date}) => 'depuis le ${date}';
	@override String get addTag => 'Ajouter un tag';
	@override String get addTitle => 'Ajouter un tag';
	@override String get emptyTitle => 'Aucun tag pour l’instant';
	@override String get emptyBody => 'Les tags se créent depuis un élément, ou ici — dans les deux cas, ils regroupent des éléments entre coffres-forts.';
	@override String get addBody => 'Un tag sans élément pour l’instant. Ajoutez-le à un élément depuis la page de cet élément.';
	@override String get tagName => 'Nom du tag';
	@override String get duplicate => 'Un tag portant ce nom existe déjà.';
	@override String get colorNote => 'Sa couleur vient de son nom.';
	@override String get renameTitle => 'Renommer le tag';
	@override String get renameBody => 'Chaque élément qui le porte est mis à jour.';
	@override String mergeNotice({required Object name}) => '« ${name} » existe déjà — le renommage les fusionnera.';
	@override String deleteTitle({required Object name}) => 'Supprimer « ${name} » ?';
	@override String get deleteAction => 'Supprimer le tag';
	@override String get deleteSelectedBody => 'Chacun est retiré de tous les éléments qui le portent. Les éléments eux-mêmes sont conservés. Cette action est irréversible.';
	@override String get footer => 'Touchez un tag pour voir ses éléments dans l’onglet Coffre-fort.';
	@override String renameAria({required Object name}) => 'Renommer ${name}';
	@override String deleteAria({required Object name}) => 'Supprimer ${name}';
	@override String itemCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} élément',
		other: '${n} éléments',
	);
	@override String deleteBody({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Il sera retiré de ${n} élément. Les éléments eux-mêmes sont conservés. Cette action est irréversible.',
		other: 'Il sera retiré de ${n} éléments. Les éléments eux-mêmes sont conservés. Cette action est irréversible.',
	);
	@override String deleteSelectedTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Supprimer ${n} tag ?',
		other: 'Supprimer ${n} tags ?',
	);
	@override String selected({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} tag sélectionné',
		other: '${n} tags sélectionnés',
	);
	@override String deleteTags({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Supprimer ${n} tag',
		other: 'Supprimer ${n} tags',
	);
}

// Path: changeSecret
class _Translations$changeSecret$fr extends Translations$changeSecret$en {
	_Translations$changeSecret$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Changer le secret';
	@override String get intro => 'Votre coffre-fort est rechiffré avec le nouveau secret puis renvoyé. Il ne peut pas être récupéré si vous l’oubliez.';
	@override String get current => 'Secret actuel';
	@override String get wrong => 'Ce n’est pas votre secret actuel.';
	@override String get match => 'Les deux secrets correspondent.';
	@override String get otherDevices => 'Vos autres appareils demanderont le nouveau secret la prochaine fois qu’ils ouvriront votre coffre-fort.';
	@override String get submit => 'Changer le secret';
	@override String get verifyingMeta => 'Vérification de votre secret actuel…';
	@override String get verifyingTitle => 'Vérification de votre secret actuel…';
	@override String get stepVerify => 'Vérification de votre secret actuel';
	@override String get stepVerifyNote => 'Volontairement lent sur un téléphone — c’est ce qui rend chaque tentative coûteuse';
	@override String get stepEncrypt => 'Chiffrement avec le nouveau secret';
	@override String get stepSave => 'Enregistrement de votre coffre-fort';
	@override String savingMeta({required Object storage}) => 'Enregistrement dans ${storage}…';
	@override String savingTitle({required Object percent}) => 'Enregistrement de votre coffre-fort… ${percent} %';
	@override String get stepVerified => 'Secret actuel vérifié';
	@override String get stepEncrypted => 'Chiffré avec le nouveau secret';
	@override String stepSaving({required Object storage}) => 'Enregistrement dans ${storage}';
	@override String get keepOpen => 'Gardez KeeperPass ouvert jusqu’à la fin.';
	@override String doneMeta({required Object storage}) => 'Enregistré dans ${storage}';
	@override String get doneTitle => 'Votre secret a été changé';
	@override String get doneBody => 'Tous vos éléments vous ont suivi. Vos autres appareils demanderont le nouveau secret la prochaine fois qu’ils ouvriront votre coffre-fort.';
	@override String get toast => 'Secret changé';
	@override String get failTitle => 'Votre coffre-fort n’a pas été enregistré';
	@override String failBody({required Object storage}) => 'Impossible de joindre ${storage}. Votre secret n’a pas changé : le coffre-fort s’ouvre toujours avec l’actuel.';
}

// Path: storage
class _Translations$storage$fr extends Translations$storage$en {
	_Translations$storage$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Stockage';
	@override String get subtitle => 'Où vit votre coffre-fort, et ce qui peut y accéder';
	@override String diagram({required Object storage}) => 'Chiffré sur ce téléphone, stocké dans votre ${storage}';
	@override String get thisPhone => 'Ce téléphone';
	@override String get encryptedOnly => 'Fichier chiffré uniquement';
	@override String get googleFolder => 'dossier keeperpass';
	@override String get dropboxFolder => 'dossier Apps/keeperpass';
	@override String savedToday({required Object folder, required Object time}) => '${folder} · enregistré aujourd’hui à ${time}';
	@override String savedOn({required Object folder, required Object date}) => '${folder} · enregistré le ${date}';
	@override String get access => 'Accès';
	@override String get googlePermissions => 'Autorisations du compte Google';
	@override String get dropboxApps => 'Applications connectées à Dropbox';
	@override String get accessNote => 'KeeperPass n’accède qu’aux fichiers qu’il crée. Vous pouvez révoquer cet accès ici à tout moment ; le fichier du coffre-fort reste où il est.';
}

// Path: moveVault
class _Translations$moveVault$fr extends Translations$moveVault$en {
	_Translations$moveVault$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Déplacer le coffre-fort';
	@override String diagram({required Object from, required Object to}) => 'Votre coffre-fort passe de ${from} à ${to}';
	@override String get from => 'Source';
	@override String get to => 'Destination';
	@override String get intro => 'Votre coffre-fort est copié et vérifié, et ce n’est qu’ensuite que l’ancien fichier est renommé. Si quelque chose échoue, rien n’est modifié.';
	@override String step1({required Object storage}) => 'Connectez-vous à ${storage} pour choisir où va le coffre-fort.';
	@override String get step2 => 'Confirmez. Rien ne change avant cette étape.';
	@override String get step3 => 'Le coffre-fort est copié et vérifié ; ensuite, l’ancien fichier est renommé, jamais supprimé.';
	@override String connect({required Object storage}) => 'Connecter ${storage}';
	@override String get account => 'Déplacement vers ce compte';
	@override String existingTitle({required Object storage}) => 'Ce compte ${storage} contient déjà un coffre-fort KeeperPass';
	@override String existingBody({required Object storage}) => 'Si vous continuez, il est conservé comme fichier de sauvegarde horodaté dans ${storage} et remplacé par le coffre-fort que vous déplacez.';
	@override String get existingConfirm => 'Le remplacer — le coffre-fort existant est conservé comme sauvegarde';
	@override String get secretSection => 'Secret du coffre-fort déplacé';
	@override String get keepSecret => 'Conserver mon secret actuel';
	@override String get newSecret => 'Choisir un nouveau secret';
	@override String get newSecretNote => 'Seul le coffre-fort déplacé l’utilise';
	@override String get submit => 'Déplacer le coffre-fort';
	@override String get movingTitle => 'Déplacement de votre coffre-fort';
	@override String get stageEncrypting => 'Chiffrement de votre coffre-fort';
	@override String stageSaving({required Object storage}) => 'Enregistrement dans ${storage}…';
	@override String get stageChecking => 'Vérification de la copie enregistrée';
	@override String get stageRenaming => 'Renommage de l’ancien fichier';
	@override String get movingNote => 'Gardez KeeperPass ouvert jusqu’à la fin. Si quelque chose échoue, rien n’est modifié.';
	@override String savedTo({required Object storage}) => 'Enregistré dans ${storage}';
	@override String doneTitle({required Object storage}) => 'Votre coffre-fort se trouve maintenant dans ${storage}';
	@override String doneBody({required Object provider, required Object from}) => 'Connectez-vous avec ${provider} pour l’ouvrir. L’ancien fichier a été conservé et renommé dans ${from} :';
	@override String get copyFileName => 'Copier le nom du fichier';
	@override String get fileNameCopied => 'Nom du fichier copié';
	@override String partlyTitle({required Object storage}) => 'Votre coffre-fort a été copié dans ${storage}';
	@override String partlyBody({required Object from}) => 'Mais l’ancien fichier dans ${from} n’a pas pu être renommé. Renommez-le ou supprimez-le vous-même pour que les deux copies ne divergent pas.';
	@override String open({required Object storage}) => 'Ouvrir ${storage}';
	@override String unchanged({required Object from}) => 'Toujours dans ${from} · inchangé';
	@override String get notMovedTitle => 'Votre coffre-fort n’a pas été déplacé';
	@override String get notMovedBody => 'La copie enregistrée ne correspondait pas à votre coffre-fort, l’ancien fichier est donc resté intact. Rien n’a été perdu — veuillez réessayer.';
}

// Path: dataIo
class _Translations$dataIo$fr extends Translations$dataIo$en {
	_Translations$dataIo$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get importTitle => 'Importer';
	@override String get file => 'Fichier';
	@override String fileMeta({required Object size}) => '${size} · depuis Fichiers';
	@override String kilobytes({required Object n}) => '${n} Ko';
	@override String megabytes({required Object n}) => '${n} Mo';
	@override String get change => 'Changer';
	@override String found({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} élément trouvé à importer.',
		other: '${n} éléments trouvés à importer.',
	);
	@override String get addTo => 'Les ajouter à';
	@override String get importNote => 'Les éléments sont ajoutés au coffre-fort que vous choisissez. Rien n’est remplacé.';
	@override String importButton({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Importer ${n} élément',
		other: 'Importer ${n} éléments',
	);
	@override String get invalidCsv => 'Ce fichier n’a pas pu être lu comme un CSV.';
	@override String get noItems => 'Aucun élément trouvé dans ce fichier.';
	@override String get notCsvNote => 'Exportez un CSV depuis votre autre gestionnaire de mots de passe, puis choisissez ce fichier ici.';
	@override String get chooseAnother => 'Choisir un autre fichier';
	@override String get exportTitle => 'Exporter';
	@override String get exportIntro => 'Écrit un CSV du coffre-fort que vous choisissez. Les éléments exportés perdent le chiffrement du coffre-fort — ce que vous faites du fichier ensuite vous appartient.';
	@override String get sourceVault => 'Coffre-fort source';
	@override String get notEncryptedTitle => 'Un fichier CSV n’est pas chiffré';
	@override String get notEncryptedBody => 'Quiconque l’ouvre peut y lire chaque mot de passe. Conservez-le en lieu sûr et supprimez-le une fois terminé.';
	@override String exportButton({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Exporter ${n} élément',
		other: 'Exporter ${n} éléments',
	);
	@override String get exportNote => 'Ouvre la feuille de partage pour que vous choisissiez où va le fichier.';
	@override String get recentTitle => 'Exports récents';
	@override String recentRow({required num n, required Object scope}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${scope} · ${n} élément',
		other: '${scope} · ${n} éléments',
	);
	@override String get recentNote => 'Les 10 derniers exports sont mémorisés, dans votre coffre-fort. KeeperPass ne garde aucune copie des fichiers eux-mêmes.';
	@override String get recentEmpty => 'Aucun export pour l’instant.';
}

// Path: archive
class _Translations$archive$fr extends Translations$archive$en {
	_Translations$archive$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Archiver le coffre-fort';
	@override String get headline => 'Archiver le coffre-fort et se déconnecter';
	@override String body({required Object storage}) => 'Votre coffre-fort est un seul fichier chiffré dans votre propre ${storage}. L’archiver renomme ce fichier pour que cette application ne le trouve plus, et vous déconnecte. Rien n’est effacé.';
	@override String step1({required Object oldName, required Object newName, required Object folder}) => '${oldName} est renommé en ${newName}, dans le même ${folder}.';
	@override String step2({required Object storage}) => 'Ce téléphone se déconnecte de ${storage}.';
	@override String step3({required Object storage}) => 'Pour supprimer les données elles-mêmes, supprimez ce fichier dans ${storage}.';
	@override String get typePrefix => 'Saisissez';
	@override String get typeSuffix => 'pour confirmer.';
	@override String get confirmation => 'Confirmation';
	@override String get button => 'Archiver et se déconnecter';
	@override String get doneMeta => 'Renommé · cette application ne le trouve plus';
	@override String get doneTitle => 'Votre fichier de coffre-fort a été renommé';
	@override String doneBody({required Object folder, required Object storage}) => 'Il se trouve toujours dans le ${folder} de votre ${storage}. Supprimez-le là-bas quand vous voulez effacer définitivement les données.';
	@override String get signedOut => 'Vous êtes déconnecté sur ce téléphone.';
	@override String get error => 'Impossible de renommer votre fichier de coffre-fort. Rien n’a été modifié.';
}

// Path: help
class _Translations$help$fr extends Translations$help$en {
	_Translations$help$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get howTitle => 'Comment fonctionne KeeperPass';
	@override String get howSubtitle => 'Où vivent vos données, et ce qui les garde privées';
	@override String get whereLives => 'Où vivent vos données';
	@override String diagram({required Object storage}) => 'Votre coffre-fort est chiffré sur ce téléphone et stocké sous forme d’un seul fichier dans votre ${storage}';
	@override String get thisPhoneNote => 'Chiffre et déchiffre tout. Votre secret ne le quitte jamais.';
	@override String get fileEncrypted => 'vault.json.enc · chiffré';
	@override String yourStorage({required Object storage}) => 'Votre ${storage}';
	@override String get storageNote => 'Contient le fichier, illisible sans votre secret.';
	@override String get noServer => 'KeeperPass ne reçoit jamais vos données. Il n’y a aucun compte à pirater ni aucun opérateur capable de lire votre coffre-fort.';
	@override String get protects => 'Ce qui le protège';
	@override String get secretTerm => 'Votre secret';
	@override String get secretNote => 'Jamais envoyé, jamais stocké. Il n’existe qu’en mémoire tant que l’application est déverrouillée.';
	@override String get kdfTerm => 'Dérivation de clé';
	@override String get kdfNote => 'Volontairement lente, pour que chaque tentative de deviner votre secret soit coûteuse.';
	@override String get encryptionTerm => 'Chiffrement';
	@override String get encryptionNote => 'Rend le fichier illisible et révèle si quelqu’un l’a modifié.';
	@override String get accessTerm => 'Accès au stockage';
	@override String get accessNote => 'KeeperPass n’accède qu’aux fichiers qu’il crée.';
	@override String get signingIn => 'Connexion';
	@override String get step1 => 'Connectez votre stockage cloud';
	@override String get step1Note => 'Prouve à qui appartient le fichier. Cela ne déverrouille rien.';
	@override String get step2 => 'Saisissez votre secret';
	@override String get step2Note => 'Crée sur ce téléphone la clé qui ouvre le fichier. Votre fournisseur de stockage ne la voit jamais.';
	@override String get bothNeeded => 'Quelqu’un qui a votre compte de stockage ne peut toujours pas lire votre coffre-fort. Quelqu’un qui connaît votre secret ne peut toujours pas atteindre le fichier. Il faut les deux.';
	@override String get terms => 'Termes à connaître';
	@override String get secretWord => 'Secret';
	@override String get secretDef => 'L’unique phrase qui déverrouille votre coffre-fort. Elle ne peut pas être récupérée.';
	@override String get vaultWord => 'Coffre-fort';
	@override String get vaultDef => 'Un groupe d’éléments. Avec plusieurs, séparez le travail du personnel.';
	@override String get tagWord => 'Tag';
	@override String get tagDef => 'Une étiquette pour retrouver des éléments entre coffres-forts, comme travail ou banque.';
	@override String get reportWord => 'Rapport de sécurité';
	@override String get reportDef => 'Signale les mots de passe faibles, réutilisés et piratés, sur ce téléphone.';
}

// Path: faq
class _Translations$faq$fr extends Translations$faq$en {
	_Translations$faq$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Questions';
	@override String get subtitle => 'Réponses aux questions fréquentes';
	@override String get forgetQ => 'Que se passe-t-il si j’oublie mon secret ?';
	@override String get forgetA1 => 'Votre coffre-fort ne peut pas être récupéré — ni par vous, ni par nous. La clé est créée à partir de votre seul secret : sans lui, le fichier reste illisible. C’est le prix à payer pour que personne d’autre ne puisse le lire non plus.';
	@override String forgetA2({required Object forgot, required Object file}) => 'Ce que vous pouvez faire, c’est repartir de zéro : ${forgot} sur l’écran de déverrouillage crée un nouveau coffre-fort vide. Votre ancien fichier n’est pas supprimé — il est renommé en ${file} et conservé dans votre dossier keeperpass, donc les données sont toujours là si le secret vous revient.';
	@override String get forgetA2Link => 'Secret oublié ?';
	@override String get forgetA3 => 'Notez votre secret et conservez-le en lieu sûr. C’est la seule chose de KeeperPass qui ne peut pas être remplacée.';
	@override String get seeQ => 'KeeperPass peut-il voir mes mots de passe ?';
	@override String get seeA => 'Non — et ce n’est pas une promesse, c’est une conséquence de la conception. Le chiffrement a lieu sur ce téléphone et le texte chiffré va directement dans votre propre stockage. Aucun serveur KeeperPass ne se trouve sur le chemin pour voir quoi que ce soit.';
	@override String get syncQ => 'Est-ce synchronisé entre les appareils ?';
	@override String get syncA => 'Oui. Chaque appareil lit le même fichier depuis votre stockage. Connectez-vous avec le même compte, saisissez le même secret, et votre coffre-fort est là.';
	@override String get providerQ => 'Et si mon fournisseur de stockage lit le fichier ?';
	@override String get providerA => 'Il verrait des octets chiffrés. La clé ne quitte jamais ce téléphone : ni Google, ni Dropbox, ni aucun autre fournisseur ne peut en lire le contenu.';
	@override String get importQ => 'Puis-je importer depuis un autre gestionnaire de mots de passe ?';
	@override String get importA => 'Oui — exportez en CSV depuis celui-ci, puis utilisez Importer dans Paramètres.';
	@override String get changeSecretQ => 'Comment changer mon secret ?';
	@override String changeSecretA({required Object action}) => 'Ouvrez Paramètres et choisissez ${action}. Vous saisissez votre secret actuel et le nouveau ; votre coffre-fort est déchiffré, rechiffré avec le nouveau secret, puis réenregistré. Rien n’est perdu — chaque élément vous accompagne, et le changement s’applique sur chaque appareil dès qu’il recharge votre coffre-fort.';
	@override String get costQ => 'Combien ça coûte ?';
	@override String get costA => 'Rien. KeeperPass est gratuit et open source, et stocke les données dans l’espace cloud que vous avez déjà.';
	@override String get stillStuck => 'Toujours bloqué ?';
	@override String get contactBody => 'Une question, un retour ou un problème à signaler ? Écrivez-nous.';
}

// Path: about
class _Translations$about$fr extends Translations$about$en {
	_Translations$about$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String version({required Object version, required Object build}) => 'Version ${version} (${build})';
	@override String get tagline => 'Votre cloud. Vos clés. Votre coffre-fort.';
	@override String get license => 'Gratuit et open source sous AGPL-3.0';
	@override String get terms => 'Conditions d’utilisation';
	@override String get privacy => 'Politique de confidentialité';
	@override String get promise => 'Gratuit, sans piège : pas de formules, pas d’offre premium, pas de vente forcée.';
}

// Path: clipboard
class _Translations$clipboard$fr extends Translations$clipboard$en {
	_Translations$clipboard$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String clearsIn({required Object time}) => 'S’efface dans ${time}';
	@override String get cleared => 'Presse-papiers effacé';
}

// Path: sync
class _Translations$sync$fr extends Translations$sync$en {
	_Translations$sync$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String savedTo({required Object storage}) => 'Enregistré dans ${storage}';
	@override String get notSavedTitle => 'Votre coffre-fort n’a pas été enregistré';
	@override String notSavedBody({required Object storage}) => 'Impossible de joindre ${storage}. Votre modification est toujours là — réessayez avant de fermer KeeperPass.';
	@override String get dismiss => 'Ignorer';
	@override String get retryingTitle => 'Nouvelle tentative…';
	@override String retryingBody({required Object storage}) => 'Enregistrement dans ${storage}.';
	@override String reconnectTitle({required Object storage}) => 'Reconnectez-vous à ${storage}';
	@override String get keepReading => 'Vous pouvez continuer à lire ; les modifications seront enregistrées dès votre retour.';
	@override String get reconnect => 'Se reconnecter';
	@override String get later => 'Plus tard';
	@override String offlineBody({required Object storage}) => 'Vous pouvez continuer à lire et à copier. L’enregistrement nécessite une connexion à ${storage}.';
	@override String get changedTitle => 'Votre coffre-fort a changé';
	@override String get changedBody => 'Une version plus récente de votre coffre-fort a été enregistrée depuis un autre appareil. Chargez-la avant de modifier, pour que rien ne soit écrasé.';
	@override String get twoVersions => 'Deux versions';
	@override String get onThisPhone => 'Sur ce téléphone';
	@override String inStorage({required Object storage}) => 'Dans ${storage}';
	@override String loadedAt({required Object time}) => 'chargée : ${time}';
	@override String savedNewer({required Object time}) => 'enregistrée : ${time} · plus récente';
	@override String get loadLatest => 'Charger la dernière version';
	@override String get notNow => 'Pas maintenant';
	@override String get pausedNote => 'D’ici là, vous pouvez lire et copier, mais pas modifier.';
	@override String get upToDate => 'À jour';
	@override String loadedVersion({required Object time}) => 'Version enregistrée à ${time} chargée';
}

// Path: scan
class _Translations$scan$fr extends Translations$scan$en {
	_Translations$scan$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Scanner le code QR';
	@override String get primerTitle => 'Ajouter un code 2FA en scannant';
	@override String get primerBody => 'Quand un site active la connexion à deux facteurs, il affiche un code QR. KeeperPass le lit avec l’appareil photo et garde la clé de configuration dans votre coffre-fort, pour que ses codes apparaissent dans Codes.';
	@override String get primerPrivacy => 'L’appareil photo ne fait que lire le code. Rien n’est enregistré et aucune image n’est conservée.';
	@override String get primerNext => 'Votre téléphone va ensuite demander l’accès à l’appareil photo.';
	@override String get enterInstead => 'Saisir plutôt la clé de configuration';
	@override String get hint => 'Visez le code QR que le site affiche\nquand vous activez la connexion à deux facteurs.';
	@override String get torch => 'Allumer la lampe';
	@override String get cameraView => 'Vue de l’appareil photo';
	@override String get codeFound => 'Code trouvé';
	@override String get saveTo => 'L’enregistrer dans';
	@override String get existingItem => 'Élément existant';
	@override String existingItemWith({required Object summary}) => 'Élément existant · ${summary}';
	@override String get newAuthenticator => 'Nouvel élément Authentificateur';
	@override String named({required Object name}) => 'Nommé ${name}';
	@override String get cameraOffTitle => 'L’accès à l’appareil photo est désactivé';
	@override String get cameraOffBody => 'KeeperPass n’a besoin de l’appareil photo que pour lire les codes QR. Activez-le dans les réglages, ou saisissez plutôt la clé de configuration.';
	@override String get openSettings => 'Ouvrir les réglages';
	@override String get unsupported => 'Ce code utilise des réglages que KeeperPass ne prend pas encore en charge';
	@override String get notACode => 'Ce n’est pas un code QR 2FA';
	@override String get cameraFailed => 'Impossible de démarrer l’appareil photo';
	@override String get item => 'Élément';
	@override String get codeSettings => '6 chiffres · toutes les 30 secondes · SHA-1';
	@override String codeAdded({required Object name}) => 'Code ajouté à ${name}';
	@override String get tapToCopy => 'Touchez la carte pour le copier.';
}

// Path: errors.failures
class _Translations$errors$failures$fr extends Translations$errors$failures$en {
	_Translations$errors$failures$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get networkFailure => 'Une erreur s\'est produite. Veuillez réessayer.';
	@override String get undocumentedError => 'Une erreur s\'est produite. Veuillez réessayer.';
	@override String get platformError => 'Une erreur s\'est produite. Veuillez réessayer.';
	@override String get notFound => 'Une erreur s\'est produite. Veuillez réessayer.';
	@override String get formatException => 'Une erreur s\'est produite. Veuillez réessayer.';
	@override String get unableToProcess => 'Une erreur s\'est produite. Veuillez réessayer.';
	@override String get requestTimeout => 'Une erreur s\'est produite. Veuillez réessayer.';
	@override String get connectionError => 'Une erreur s\'est produite. Veuillez réessayer.';
	@override String get unexpectedError => 'Une erreur s\'est produite. Veuillez réessayer.';
	@override String get accessTokenFailure => 'Une erreur s\'est produite. Veuillez réessayer.';
	@override String get cacheReadFailure => 'Une erreur s\'est produite. Veuillez réessayer.';
	@override String get cacheWriteFailure => 'Une erreur s\'est produite. Veuillez réessayer.';
}

// Path: errors.drive
class _Translations$errors$drive$fr extends Translations$errors$drive$en {
	_Translations$errors$drive$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get authExpired => 'Votre session Google a expiré. Veuillez vous reconnecter.';
	@override String get backupFailed => 'Impossible de sauvegarder votre coffre-fort existant dans Google Drive. Veuillez réessayer.';
	@override String get renameFailed => 'Impossible de renommer votre fichier de coffre-fort dans Google Drive. Rien n’a été modifié — veuillez réessayer.';
	@override String get createFolderFailed => 'Impossible de créer le dossier keeperpass dans Google Drive. Veuillez réessayer.';
	@override String get readFailed => 'Impossible de lire votre coffre-fort depuis Google Drive. Veuillez réessayer.';
	@override String get saveFailed => 'Impossible d’enregistrer votre coffre-fort dans Google Drive. Veuillez réessayer.';
	@override String get unreachable => 'Impossible de joindre Google Drive. Veuillez réessayer.';
}

// Path: errors.dropbox
class _Translations$errors$dropbox$fr extends Translations$errors$dropbox$en {
	_Translations$errors$dropbox$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get authExpired => 'Votre session Dropbox a expiré. Veuillez vous reconnecter.';
	@override String get profileFailed => 'Impossible de lire votre profil Dropbox. Veuillez réessayer.';
	@override String get unknown => 'Un problème est survenu lors de la connexion à Dropbox. Veuillez réessayer.';
	@override String get unreachable => 'Impossible de joindre Dropbox. Veuillez réessayer.';
	@override String get readFailed => 'Impossible de lire votre coffre-fort depuis Dropbox. Veuillez réessayer.';
	@override String get saveFailed => 'Impossible d’enregistrer votre coffre-fort dans Dropbox. Veuillez réessayer.';
	@override String get backupFailed => 'Impossible de sauvegarder votre coffre-fort existant dans Dropbox. Veuillez réessayer.';
	@override String get renameFailed => 'Impossible de renommer votre fichier de coffre-fort dans Dropbox. Rien n’a été modifié — veuillez réessayer.';
	@override String get missingScope => 'Il manque une autorisation Dropbox à KeeperPass. C’est un problème de configuration qu’une nouvelle connexion ne résoudra pas.';
	@override String get rateLimited => 'Dropbox nous demande de ralentir. Patientez un instant et réessayez.';
}

// Path: errors.auth
class _Translations$errors$auth$fr extends Translations$errors$auth$en {
	_Translations$errors$auth$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get profileFailed => 'Impossible de lire votre profil Google. Veuillez réessayer.';
	@override String get unknown => 'Un problème est survenu lors de la connexion à Google. Veuillez réessayer.';
}

// Path: errors.masterPassword
class _Translations$errors$masterPassword$fr extends Translations$errors$masterPassword$en {
	_Translations$errors$masterPassword$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get vaultNotFound => 'Votre coffre-fort est introuvable.';
}

// Path: errors.vault
class _Translations$errors$vault$fr extends Translations$errors$vault$en {
	_Translations$errors$vault$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String accountMismatch({required Object email}) => 'Connectez-vous avec ${email} pour enregistrer vos modifications.';
	@override String get driveAccessNotGranted => 'Google n’a pas donné à KeeperPass l’accès aux fichiers qu’il crée dans votre Drive. Réessayez et autorisez cet accès sur la page de Google.';
	@override String get conflict => 'Une version plus récente de votre coffre-fort a été enregistrée depuis un autre appareil. Chargez-la avant de modifier quoi que ce soit, pour que rien ne soit écrasé.';
	@override String get signInCanceled => 'Connexion annulée';
	@override String get unsupported => 'Ce fichier de coffre-fort ne peut pas être ouvert avec cette version de KeeperPass.';
	@override String get corrupt => 'Le fichier de votre coffre-fort est endommagé et ne peut pas être ouvert.';
}

// Path: settings.migrate
class _Translations$settings$migrate$fr extends Translations$settings$migrate$en {
	_Translations$settings$migrate$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$settings$migrate$error$fr error = _Translations$settings$migrate$error$fr._(_root);
}

// Path: auth.unlock
class _Translations$auth$unlock$fr extends Translations$auth$unlock$en {
	_Translations$auth$unlock$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get incorrectSecret => 'Secret incorrect. Veuillez réessayer.';
}

// Path: editItem.templates
class _Translations$editItem$templates$fr extends Translations$editItem$templates$en {
	_Translations$editItem$templates$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get website => 'Site web ou application';
	@override String get computer => 'Ordinateur';
	@override String get creditCard => 'Carte bancaire';
	@override String get bankAccount => 'Compte bancaire';
	@override String get wifi => 'Réseau Wi-Fi';
	@override String get passport => 'Passeport';
	@override String get note => 'Note';
	@override String get authenticator => 'Authentificateur';
	@override String get custom => 'Personnalisé';
}

// Path: editItem.templateHints
class _Translations$editItem$templateHints$fr extends Translations$editItem$templateHints$en {
	_Translations$editItem$templateHints$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get website => 'Nom d’utilisateur, mot de passe, URL';
	@override String get computer => 'Nom d’utilisateur, mot de passe';
	@override String get creditCard => 'Numéro, titulaire, expiration, CVC, PIN';
	@override String get bankAccount => 'Titulaire, IBAN, BIC, PIN';
	@override String get wifi => 'Nom du réseau, mot de passe';
	@override String get passport => 'Numéro, nom, dates';
	@override String get note => 'Une note mise en forme';
	@override String get authenticator => 'Un code 2FA';
	@override String get custom => 'Aucun champ pour l’instant';
}

// Path: editItem.templateFields
class _Translations$editItem$templateFields$fr extends Translations$editItem$templateFields$en {
	_Translations$editItem$templateFields$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get cardholder => 'Titulaire de la carte';
	@override String get expiresOn => 'Date d’expiration';
	@override String get cvc => 'CVC';
	@override String get accountHolder => 'Titulaire du compte';
	@override String get iban => 'IBAN';
	@override String get bic => 'BIC';
	@override String get cardPin => 'Code PIN de la carte';
	@override String get networkName => 'Nom du réseau';
	@override String get fullName => 'Nom complet';
	@override String get passportNumber => 'Numéro de passeport';
	@override String get issuingCountry => 'Pays de délivrance';
	@override String get dateOfBirth => 'Date de naissance';
	@override String get placeOfBirth => 'Lieu de naissance';
	@override String get issuedOn => 'Date de délivrance';
}

// Path: editItem.types
class _Translations$editItem$types$fr extends Translations$editItem$types$en {
	_Translations$editItem$types$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get username => 'Nom d’utilisateur';
	@override String get password => 'Mot de passe';
	@override String get email => 'E-mail';
	@override String get url => 'URL';
	@override String get ipHost => 'IP / Hôte';
	@override String get date => 'Date';
	@override String get month => 'Mois';
	@override String get credit => 'Numéro de carte';
	@override String get phone => 'Téléphone';
	@override String get pin => 'Code PIN';
	@override String get totp => 'Code d’authentification';
	@override String get certificate => 'Certificat';
	@override String get sshKey => 'Clé SSH / privée';
	@override String get recoveryCodes => 'Codes de récupération';
	@override String get note => 'Note formatée';
	@override String get text => 'Texte';
}

// Path: audit.weakPassword
class _Translations$audit$weakPassword$fr extends Translations$audit$weakPassword$en {
	_Translations$audit$weakPassword$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Mots de passe faibles';
	@override String get description => 'Un mot de passe est faible lorsque l’espace de recherche pour un attaquant est réduit : il est court, utilise un jeu de caractères limité, ou repose sur un mot, un nom ou une suite du clavier présente dans tous les dictionnaires de piratage. Les attaques hors ligne testent des milliards de combinaisons par seconde, donc tout ce qui entre dans cette catégorie tombe rapidement. Remplacez-le par un mot de passe long et généré aléatoirement.';
}

// Path: audit.reusedPassword
class _Translations$audit$reusedPassword$fr extends Translations$audit$reusedPassword$en {
	_Translations$audit$reusedPassword$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Mots de passe réutilisés';
	@override String get description => 'Utiliser le même mot de passe à plusieurs endroits signifie qu’une seule fuite, où qu’elle survienne, les compromet tous — et vous n’avez aucun contrôle sur lequel de ces services sera celui qui fuitera. Donnez à chaque élément son propre mot de passe généré pour qu’une fuite reste limitée au compte d’où elle provient.';
}

// Path: audit.compromisedPassword
class _Translations$audit$compromisedPassword$fr extends Translations$audit$compromisedPassword$en {
	_Translations$audit$compromisedPassword$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Mots de passe compromis';
	@override String get description => 'Ce mot de passe figure dans un registre public d’identifiants piratés, ce qui en fait l’un des premiers que les attaquants essaieront, aussi solide soit-il en apparence. Changez-le partout où il est utilisé : un mot de passe n’a besoin de fuiter qu’une seule fois pour rester compromis.';
}

// Path: settings.migrate.error
class _Translations$settings$migrate$error$fr extends Translations$settings$migrate$error$en {
	_Translations$settings$migrate$error$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get sameProvider => 'Le coffre-fort se trouve déjà dans ce stockage.';
	@override String get busy => 'Un enregistrement est encore en cours. Attendez qu’il se termine puis réessayez.';
	@override String get sourceExpired => 'Votre session actuelle a expiré. Reconnectez-vous avant de déplacer le coffre-fort.';
	@override String targetExpired({required Object provider}) => 'Votre connexion à ${provider} a expiré. Rien n’a été modifié — veuillez recommencer.';
	@override String get verifyFailed => 'La copie enregistrée ne correspondait pas à votre coffre-fort, l’ancien fichier est donc resté intact. Rien n’a été perdu — veuillez réessayer.';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'KeeperPass',
			'connectivity.offline' => 'Pas de connexion Internet',
			'connectivity.online' => 'De nouveau en ligne',
			'errors.failures.networkFailure' => 'Une erreur s\'est produite. Veuillez réessayer.',
			'errors.failures.undocumentedError' => 'Une erreur s\'est produite. Veuillez réessayer.',
			'errors.failures.platformError' => 'Une erreur s\'est produite. Veuillez réessayer.',
			'errors.failures.notFound' => 'Une erreur s\'est produite. Veuillez réessayer.',
			'errors.failures.formatException' => 'Une erreur s\'est produite. Veuillez réessayer.',
			'errors.failures.unableToProcess' => 'Une erreur s\'est produite. Veuillez réessayer.',
			'errors.failures.requestTimeout' => 'Une erreur s\'est produite. Veuillez réessayer.',
			'errors.failures.connectionError' => 'Une erreur s\'est produite. Veuillez réessayer.',
			'errors.failures.unexpectedError' => 'Une erreur s\'est produite. Veuillez réessayer.',
			'errors.failures.accessTokenFailure' => 'Une erreur s\'est produite. Veuillez réessayer.',
			'errors.failures.cacheReadFailure' => 'Une erreur s\'est produite. Veuillez réessayer.',
			'errors.failures.cacheWriteFailure' => 'Une erreur s\'est produite. Veuillez réessayer.',
			'errors.drive.authExpired' => 'Votre session Google a expiré. Veuillez vous reconnecter.',
			'errors.drive.backupFailed' => 'Impossible de sauvegarder votre coffre-fort existant dans Google Drive. Veuillez réessayer.',
			'errors.drive.renameFailed' => 'Impossible de renommer votre fichier de coffre-fort dans Google Drive. Rien n’a été modifié — veuillez réessayer.',
			'errors.drive.createFolderFailed' => 'Impossible de créer le dossier keeperpass dans Google Drive. Veuillez réessayer.',
			'errors.drive.readFailed' => 'Impossible de lire votre coffre-fort depuis Google Drive. Veuillez réessayer.',
			'errors.drive.saveFailed' => 'Impossible d’enregistrer votre coffre-fort dans Google Drive. Veuillez réessayer.',
			'errors.drive.unreachable' => 'Impossible de joindre Google Drive. Veuillez réessayer.',
			'errors.dropbox.authExpired' => 'Votre session Dropbox a expiré. Veuillez vous reconnecter.',
			'errors.dropbox.profileFailed' => 'Impossible de lire votre profil Dropbox. Veuillez réessayer.',
			'errors.dropbox.unknown' => 'Un problème est survenu lors de la connexion à Dropbox. Veuillez réessayer.',
			'errors.dropbox.unreachable' => 'Impossible de joindre Dropbox. Veuillez réessayer.',
			'errors.dropbox.readFailed' => 'Impossible de lire votre coffre-fort depuis Dropbox. Veuillez réessayer.',
			'errors.dropbox.saveFailed' => 'Impossible d’enregistrer votre coffre-fort dans Dropbox. Veuillez réessayer.',
			'errors.dropbox.backupFailed' => 'Impossible de sauvegarder votre coffre-fort existant dans Dropbox. Veuillez réessayer.',
			'errors.dropbox.renameFailed' => 'Impossible de renommer votre fichier de coffre-fort dans Dropbox. Rien n’a été modifié — veuillez réessayer.',
			'errors.dropbox.missingScope' => 'Il manque une autorisation Dropbox à KeeperPass. C’est un problème de configuration qu’une nouvelle connexion ne résoudra pas.',
			'errors.dropbox.rateLimited' => 'Dropbox nous demande de ralentir. Patientez un instant et réessayez.',
			'errors.auth.profileFailed' => 'Impossible de lire votre profil Google. Veuillez réessayer.',
			'errors.auth.unknown' => 'Un problème est survenu lors de la connexion à Google. Veuillez réessayer.',
			'errors.masterPassword.vaultNotFound' => 'Votre coffre-fort est introuvable.',
			'errors.vault.accountMismatch' => ({required Object email}) => 'Connectez-vous avec ${email} pour enregistrer vos modifications.',
			'errors.vault.driveAccessNotGranted' => 'Google n’a pas donné à KeeperPass l’accès aux fichiers qu’il crée dans votre Drive. Réessayez et autorisez cet accès sur la page de Google.',
			'errors.vault.conflict' => 'Une version plus récente de votre coffre-fort a été enregistrée depuis un autre appareil. Chargez-la avant de modifier quoi que ce soit, pour que rien ne soit écrasé.',
			'errors.vault.signInCanceled' => 'Connexion annulée',
			'errors.vault.unsupported' => 'Ce fichier de coffre-fort ne peut pas être ouvert avec cette version de KeeperPass.',
			'errors.vault.corrupt' => 'Le fichier de votre coffre-fort est endommagé et ne peut pas être ouvert.',
			'common.close' => 'Fermer',
			'common.copy' => 'Copier',
			'common.copied' => 'Copié',
			'common.cancel' => 'Annuler',
			'common.save' => 'Enregistrer',
			'common.back' => 'Retour',
			'common.favorite' => 'Favori',
			'common.showSecret' => 'Afficher le secret',
			'common.hideSecret' => 'Masquer le secret',
			'common.empty' => '[vide]',
			'common.clearSearch' => 'Effacer la recherche',
			'common.chooseDate' => 'Choisir une date',
			'common.chooseMonth' => 'Choisir un mois',
			'common.countryCode' => 'Indicatif du pays',
			'common.countryCodeValue' => ({required Object country, required Object code}) => 'Indicatif du pays : ${country}, ${code}',
			'common.removeTag' => ({required Object tag}) => 'Retirer le tag ${tag}',
			'common.secretChip' => 'Secret',
			'common.secretToggle' => ({required Object field}) => 'Secret : ${field}',
			'common.reorderField' => ({required Object field}) => 'Déplacer ${field}',
			'common.removeField' => ({required Object field}) => 'Retirer ${field}',
			'common.changeFieldIcon' => ({required Object field}) => 'Changer l’icône de ${field}',
			'common.showAll' => ({required Object count}) => 'Afficher les ${count}',
			'common.showInLargeType' => 'Afficher en grands caractères',
			'common.stepOf' => ({required Object current, required Object total}) => 'Étape ${current} sur ${total}',
			'common.next' => 'Suivant',
			'common.continueAction' => 'Continuer',
			'common.tryAgain' => 'Réessayer',
			'common.retry' => 'Réessayer',
			'common.show' => 'Afficher',
			'common.hide' => 'Masquer',
			'common.gotIt' => 'Compris',
			'common.disconnect' => 'Se déconnecter',
			'common.generateSecret' => 'Générer un secret',
			'common.useAnotherAccount' => 'Utiliser un autre compte',
			'common.offlineTitle' => 'Vous êtes hors ligne',
			'common.savingTo' => ({required Object provider}) => 'Enregistrement dans ${provider}…',
			'common.keepOpen' => 'Gardez KeeperPass ouvert jusqu’à la fin.',
			'common.typeItAgain' => 'Saisissez-le à nouveau',
			'common.secretHiddenValue' => 'Masqué',
			'common.rename' => 'Renommer',
			'common.done' => 'Terminé',
			'strength.veryWeak' => 'Très faible',
			'strength.weak' => 'Faible',
			'strength.fair' => 'Moyen',
			'strength.strong' => 'Fort',
			'strength.veryStrong' => 'Très fort',
			'strength.meter' => ({required Object level}) => 'Robustesse : ${level}',
			'totp.invalidCode' => 'Code invalide',
			'totp.invalidKey' => 'La clé de configuration n’est pas valide, aucun code ne peut donc être généré.',
			'totp.fixInEdit' => 'Corriger dans Modifier',
			'totp.secondsShort' => ({required Object count}) => '${count} s',
			'totp.secondsLeft' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, one: 'Encore ${count} seconde', other: 'Encore ${count} secondes', ), 
			'settings.migrate.error.sameProvider' => 'Le coffre-fort se trouve déjà dans ce stockage.',
			'settings.migrate.error.busy' => 'Un enregistrement est encore en cours. Attendez qu’il se termine puis réessayez.',
			'settings.migrate.error.sourceExpired' => 'Votre session actuelle a expiré. Reconnectez-vous avant de déplacer le coffre-fort.',
			'settings.migrate.error.targetExpired' => ({required Object provider}) => 'Votre connexion à ${provider} a expiré. Rien n’a été modifié — veuillez recommencer.',
			'settings.migrate.error.verifyFailed' => 'La copie enregistrée ne correspondait pas à votre coffre-fort, l’ancien fichier est donc resté intact. Rien n’a été perdu — veuillez réessayer.',
			'settings.title' => 'Paramètres',
			'settings.subtitle' => 'Compte, langue, sécurité et données',
			'settings.account' => 'Compte',
			'settings.accountLine' => ({required Object email, required Object storage}) => '${email} · ${storage}',
			'settings.accountNote' => 'Le nom et l’adresse e-mail proviennent du compte utilisé pour vous connecter.',
			'settings.logOut' => 'Se déconnecter',
			'settings.logOutTitle' => 'Se déconnecter ?',
			'settings.logOutBody' => ({required Object storage, required Object provider}) => 'Votre coffre-fort reste chiffré dans votre ${storage}. Pour l’ouvrir à nouveau, connectez-vous avec ${provider} et saisissez votre secret.',
			'settings.security' => 'Sécurité',
			'settings.lockNow' => 'Verrouiller maintenant',
			'settings.autoLock' => 'Verrouillage automatique',
			'settings.clearClipboard' => 'Effacer le presse-papiers',
			'settings.hideInSwitcher' => 'Masquer dans le sélecteur d’apps',
			'settings.hideInSwitcherNote' => 'Affiche un écran de confidentialité à la place de votre coffre-fort',
			'settings.changeSecret' => 'Changer le secret',
			'settings.securityNote' => 'Le verrouillage efface le coffre-fort déchiffré de la mémoire de ce téléphone.',
			'settings.appearance' => 'Apparence',
			'settings.theme' => 'Thème',
			'settings.themeAuto' => 'Auto',
			'settings.themeLight' => 'Clair',
			'settings.themeDark' => 'Sombre',
			'settings.language' => 'Langue',
			'settings.storage' => 'Stockage',
			'settings.whereItLives' => 'Où vit votre coffre-fort',
			'settings.moveTo' => ({required Object storage}) => 'Déplacer le coffre-fort vers ${storage}',
			'settings.data' => 'Données',
			'settings.importCsv' => 'Importer un CSV',
			'settings.exportCsv' => 'Exporter en CSV',
			'settings.recentExports' => 'Exports récents',
			'settings.help' => 'Aide',
			'settings.howItWorks' => 'Comment fonctionne KeeperPass',
			'settings.questions' => 'Questions',
			'settings.about' => 'À propos de KeeperPass',
			'settings.dangerZone' => 'Zone de danger',
			'settings.archive' => 'Archiver le coffre-fort et se déconnecter',
			'settings.archiveNote' => 'Renomme le fichier de votre coffre-fort et vous déconnecte. Rien n’est effacé.',
			'settings.footer' => ({required Object version}) => 'KeeperPass ${version} · Gratuit et open source sous AGPL-3.0',
			'settings.autoLockTitle' => 'Verrouillage automatique',
			'settings.autoLockImmediately' => 'Immédiatement en quittant l’app',
			'settings.autoLockImmediatelyShort' => 'Immédiatement',
			'settings.after1Minute' => 'Après 1 minute',
			'settings.after5Minutes' => 'Après 5 minutes',
			'settings.after10Minutes' => 'Après 10 minutes',
			'settings.autoLockNote' => 'KeeperPass se verrouille après cette durée sans utilisation. Le déverrouiller demande à nouveau votre secret.',
			'settings.clearClipboardTitle' => 'Effacer le presse-papiers',
			'settings.after30Seconds' => 'Après 30 secondes',
			'settings.after2Minutes' => 'Après 2 minutes',
			'settings.never' => 'Jamais',
			'settings.after30s' => 'Après 30 s',
			'settings.after1Min' => 'Après 1 min',
			'settings.after2Min' => 'Après 2 min',
			'settings.clipboardNote' => 'Les mots de passe et les codes que vous copiez sont effacés du presse-papiers après ce délai, si rien d’autre n’a été copié entre-temps.',
			'settings.preview' => 'Aperçu',
			'settings.previewFrom' => 'Depuis GitHub',
			'settings.previewClears' => ({required Object time}) => 'Depuis GitHub · Effacé dans ${time}',
			'settings.seconds' => ({required Object n}) => '${n} s',
			'settings.minutes' => ({required Object n}) => '${n} min',
			'settings.languageTitle' => 'Langue',
			'settings.languageNote' => 'Enregistrée uniquement sur ce téléphone — elle ne fait pas partie de votre coffre-fort.',
			'settings.hideInSwitcherBlocks' => 'Affiche un écran de confidentialité à la place de votre coffre-fort et bloque les captures d’écran',
			'settings.blockScreenshots' => 'Bloquer les captures d’écran',
			'settings.blockScreenshotsNote' => 'Android uniquement · bloque aussi l’enregistrement de l’écran',
			'settings.blockScreenshotsWhileHidden' => 'Activé tant que « Masquer dans le sélecteur d’apps » est activé',
			'auth.unlock.incorrectSecret' => 'Secret incorrect. Veuillez réessayer.',
			'vaults.defaultName' => 'Mon coffre-fort',
			'welcome.howItWorks' => 'Comment ça marche',
			'welcome.badge' => 'Chiffré de bout en bout',
			'welcome.title' => 'Bienvenue sur KeeperPass',
			'welcome.description' => 'Votre coffre-fort est un seul fichier chiffré dans votre propre espace de stockage cloud. Connectez-vous pour l’ouvrir.',
			'welcome.fileTag' => 'Ce que voit votre stockage',
			'welcome.fileMeta' => 'Argon2id · AES-256-GCM',
			'welcome.continueWithGoogle' => 'Continuer avec Google',
			'welcome.continueWithDropbox' => 'Continuer avec Dropbox',
			'welcome.connecting' => ({required Object provider}) => 'Connexion à ${provider}…',
			'welcome.factAccess' => 'Accès uniquement aux fichiers créés par KeeperPass',
			'welcome.factEncrypted' => 'Chiffré sur ce téléphone, avec votre propre secret',
			'welcome.factNoServer' => 'Pas de serveur KeeperPass. Rien ne part ailleurs.',
			'welcome.footer' => 'Pas de compte KeeperPass — seulement celui de Google ou Dropbox que vous avez déjà. La connexion crée le fichier du coffre-fort si vous n’en avez pas encore.',
			'connect.lookingIn' => ({required Object storage}) => 'Recherche dans ${storage}…',
			'connect.checkingTitle' => 'Vérification de votre coffre-fort…',
			'connect.checkingDetail' => ({required Object storage}) => 'Recherche de vault.json.enc dans ${storage}.',
			'connect.foundTitle' => 'Votre coffre-fort a été trouvé',
			'connect.foundDetail' => 'Ouverture du déverrouillage…',
			'connect.foundMeta' => ({required Object storage}) => 'Trouvé dans ${storage}',
			'connect.foundMetaUpdated' => ({required Object storage, required Object time}) => 'Trouvé dans ${storage} · mis à jour ${time}',
			'connect.canceledDetail' => 'Rien n’a été connecté.',
			'connect.signInFailed' => 'Échec de la connexion',
			'connect.offlineDetail' => 'La connexion nécessite un accès à Google ou à Dropbox. Cela se met à jour tout seul dès que vous êtes de nouveau en ligne.',
			'connect.welcomeBack' => 'Bon retour,',
			'connect.expiredDetail' => ({required Object provider}) => 'Votre session ${provider} a expiré. Reconnectez-vous pour déverrouiller votre coffre-fort.',
			'connect.lastUsed' => 'Dernière utilisée',
			'connect.checkFailedMeta' => ({required Object storage}) => 'Lecture impossible depuis ${storage}',
			'connect.checkFailedTitle' => 'Impossible de lire votre coffre-fort',
			'connect.checkFailedDetail' => ({required Object storage}) => '${storage} n’a pas répondu. Rien n’a été modifié.',
			'howItWorks.step1Title' => 'Votre coffre-fort vit\ndans votre cloud',
			'howItWorks.step1Body' => 'KeeperPass enregistre un seul fichier chiffré dans votre Google Drive ou Dropbox. Il n’y a pas de serveur KeeperPass : nous n’en recevons jamais de copie.',
			'howItWorks.encrypted' => 'Chiffré',
			'howItWorks.step2Title' => 'Choisissez un secret',
			'howItWorks.step2Body' => 'Il devient la clé. Jamais envoyé, jamais stocké.',
			'howItWorks.step3Title' => 'Il faut les deux',
			'howItWorks.step3Body' => 'Quelqu’un qui a votre compte de stockage ne peut pas lire votre coffre-fort. Quelqu’un qui a votre secret ne peut pas l’atteindre.',
			'howItWorks.storageAccount' => 'Compte de stockage',
			'howItWorks.reachesFile' => 'Atteint le fichier',
			'howItWorks.yourSecret' => 'Votre secret',
			'howItWorks.opensFile' => 'Ouvre le fichier',
			'howItWorks.technicalDetails' => 'Détails techniques',
			'howItWorks.technicalSummary' => 'Argon2id · AES-256',
			'technicalDetails.title' => 'Détails techniques',
			'technicalDetails.keyDerivation' => 'Dérivation de la clé',
			'technicalDetails.keyDerivationValue' => ({required InlineSpan algorithm}) => TextSpan(children: [ algorithm, const TextSpan(text: ' · 64 Mio de mémoire · 3 itérations · parallélisme 4, pour une clé de 256 bits'), ]), 
			'technicalDetails.encryption' => 'Chiffrement',
			'technicalDetails.encryptionValue' => ({required InlineSpan algorithm}) => TextSpan(children: [ algorithm, const TextSpan(text: ', qui détecte aussi toute modification du fichier'), ]), 
			'technicalDetails.googleDrive' => 'Google Drive',
			'technicalDetails.googleDriveValue' => ({required InlineSpan scope}) => TextSpan(children: [ const TextSpan(text: 'La portée '), scope, const TextSpan(text: ' : uniquement les fichiers créés par KeeperPass'), ]), 
			'technicalDetails.dropbox' => 'Dropbox',
			'technicalDetails.dropboxValue' => ({required InlineSpan folder}) => TextSpan(children: [ const TextSpan(text: 'Un dossier d’application : '), folder, ]), 
			'technicalDetails.vaultFile' => 'Fichier du coffre-fort',
			'technicalDetails.vaultFileValue' => ({required InlineSpan file}) => TextSpan(children: [ file, const TextSpan(text: ' — un seul fichier, rechiffré et réécrit à chaque enregistrement'), ]), 
			'technicalDetails.viewSource' => 'Voir le code source sur GitHub',
			'technicalDetails.license' => 'Gratuit et open source sous AGPL-3.0 : tout ceci peut être vérifié.',
			'createVault.eyebrow' => 'Créez votre coffre-fort',
			'createVault.step1Title' => 'Choisissez votre secret',
			'createVault.step1Body' => 'Il chiffre votre coffre-fort sur ce téléphone. Tout ce que vous enregistrez est protégé par lui.',
			'createVault.settingUpFor' => 'Configuration pour',
			'createVault.secret' => 'Secret',
			'createVault.secretPlaceholder' => 'Votre secret',
			'createVault.generateAnother' => 'En générer un autre',
			'createVault.generatedNote' => 'Les secrets générés sautent l’étape de nouvelle saisie.',
			'createVault.weakWarning' => 'Ce secret est faible, ce qui facilite le contournement du chiffrement de votre coffre-fort. Vous pouvez continuer, mais une phrase plus longue est fortement recommandée.',
			'createVault.tipsTitle' => 'Choisir un bon secret',
			'createVault.tip1' => 'Plusieurs mots au hasard valent mieux qu’un mot astucieux : plus il est long, plus il est difficile à deviner.',
			'createVault.tip2' => 'Ne réutilisez pas un mot de passe que vous utilisez ailleurs.',
			'createVault.tip3' => 'Choisissez quelque chose que vous pouvez saisir sur ce téléphone, puis notez-le et rangez-le en lieu sûr.',
			'createVault.step2Title' => 'Saisissez-le à nouveau',
			'createVault.step2Body' => 'Juste pour être sûr qu’il n’y a pas de faute de frappe. Personne ne pourra réinitialiser votre secret plus tard.',
			'createVault.repeat' => 'Répétez le secret',
			'createVault.mismatch' => 'Les deux secrets ne correspondent pas.',
			'createVault.step3Title' => 'Notez-le',
			'createVault.step3Body' => 'Vous en aurez besoin à chaque déverrouillage. Rangez-le en lieu sûr, loin de ce téléphone.',
			'createVault.secretWords' => ({required Object count}) => 'Votre secret · ${count} mots',
			'createVault.secretWhole' => 'Votre secret',
			'createVault.secretHidden' => 'Votre secret, masqué',
			'createVault.secretShown' => 'Votre secret, affiché',
			'createVault.readBefore' => 'Veuillez lire ceci avant de continuer',
			'createVault.bullet1' => 'Votre secret n’est jamais envoyé nulle part ni stocké. Personne — ni KeeperPass, ni votre fournisseur de stockage — ne peut le consulter ni le réinitialiser.',
			'createVault.bullet2' => 'Si vous l’oubliez, votre coffre-fort ne peut pas être récupéré. Aucun lien de réinitialisation ni demande d’assistance ne peut l’ouvrir.',
			'createVault.bullet3' => 'Notez-le et conservez-le en lieu sûr avant de continuer.',
			'createVault.acknowledge' => 'J’ai noté mon secret',
			'createVault.create' => 'Créer le coffre-fort',
			'createVault.progressTitle' => 'Création de votre coffre-fort',
			'createVault.encrypting' => 'Chiffrement de votre coffre-fort…',
			'createVault.encryptingDetail' => 'Sur ce téléphone. Cela prend quelques secondes.',
			'createVault.encryptingMeta' => 'Chiffrement sur ce téléphone…',
			'createVault.savingDetail' => 'Un seul fichier chiffré, dans le dossier keeperpass.',
			'createVault.failedTitle' => 'Impossible d’enregistrer votre coffre-fort',
			'createVault.notSaved' => 'Non enregistré',
			'createVault.failedDetail' => ({required Object storage}) => '${storage} n’a pas répondu. Rien n’a été enregistré, et votre secret est toujours là.',
			'createVault.backToSecret' => 'Retour à votre secret',
			'unlock.notYou' => 'Ce n’est pas vous ?',
			'unlock.secret' => 'Secret',
			'unlock.placeholder' => 'Saisissez votre secret',
			'unlock.unlock' => 'Déverrouiller',
			'unlock.unlocking' => 'Déverrouillage…',
			'unlock.unlockingStatus' => 'Déverrouillage sur ce téléphone…',
			'unlock.slowNote' => 'Quelques secondes, exprès : cela rend lente toute tentative de deviner votre secret.',
			'unlock.forgot' => 'Secret oublié ?',
			'unlock.leftApp' => 'Verrouillé quand vous avez quitté KeeperPass',
			'unlock.unreachableTitle' => ({required Object storage}) => 'Impossible de joindre ${storage}',
			'unlock.unreachableDetail' => 'Vérifiez votre connexion et réessayez. Votre secret est toujours saisi.',
			'unlock.offlineDetail' => ({required Object storage}) => 'Le déverrouillage nécessite une connexion à ${storage}. « Déverrouiller » se réactive dès que vous êtes de nouveau en ligne.',
			'unlock.accountLine' => ({required Object email, required Object storage}) => '${email} · ${storage}',
			'unlock.lockedInactivity' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Verrouillé après ${n} minute d’inactivité', other: 'Verrouillé après ${n} minutes d’inactivité', ), 
			'newVault.backLabel' => 'Déverrouiller',
			'newVault.backToUnlock' => 'Retour au déverrouillage',
			'newVault.title' => 'Commencer un nouveau coffre-fort',
			'newVault.oldMeta' => 'Ancien coffre-fort · verrouillé par l’ancien secret',
			'newVault.newMeta' => 'Nouveau coffre-fort · vide',
			'newVault.body' => ({required Object provider}) => 'Il est impossible de réinitialiser un secret oublié — ni par KeeperPass, ni par ${provider}. Vous pouvez plutôt recommencer avec un nouveau coffre-fort vide.',
			'newVault.pointLocked' => 'Votre coffre-fort actuel reste verrouillé par l’ancien secret.',
			'newVault.pointKept' => ({required InlineSpan file, required InlineSpan storage}) => TextSpan(children: [ const TextSpan(text: 'Son fichier est conservé sous le nom '), file, const TextSpan(text: ' dans votre '), storage, const TextSpan(text: '. Rien n’est supprimé.'), ]), 
			'newVault.pointFresh' => 'Vous recommencez avec un tout nouveau coffre-fort vide.',
			'newVault.account' => 'Compte',
			'newVault.newSecret' => 'Nouveau secret',
			'newVault.newSecretPlaceholder' => 'Choisissez un nouveau secret',
			'newVault.repeat' => 'Répétez le nouveau secret',
			'newVault.weakWarning' => 'Ce secret est faible, ce qui facilite le contournement du chiffrement de vos coffres-forts. Vous pouvez continuer, mais une phrase plus longue est fortement recommandée.',
			'newVault.warn' => 'Comme l’ancien, votre nouveau secret ne peut être ni consulté ni réinitialisé. Notez-le avant de continuer.',
			'newVault.start' => 'Commencer un nouveau coffre-fort',
			'newVault.confirmTitle' => 'Commencer un nouveau coffre-fort ?',
			'newVault.confirmKept' => ({required Object storage}) => 'Son fichier est conservé comme sauvegarde datée dans votre ${storage}.',
			'newVault.confirmFresh' => 'Vous recommencez avec un coffre-fort vide protégé par votre nouveau secret.',
			'newVault.progressTitle' => 'Création d’un nouveau coffre-fort',
			'newVault.encrypting' => 'Chiffrement de votre nouveau coffre-fort…',
			'newVault.backingUp' => 'Conservation de votre ancien coffre-fort en sauvegarde…',
			'newVault.backingUpDetail' => ({required Object storage}) => 'Renommage dans ${storage}.',
			'newVault.readyMeta' => 'Chiffré · prêt à enregistrer',
			'newVault.backupFailedMeta' => 'Renommage impossible · rien n’a changé',
			'newVault.nothingChanged' => 'Rien n’a été modifié',
			'newVault.backupFailedDetail' => ({required Object storage}) => 'Impossible de sauvegarder votre coffre-fort existant dans ${storage}. Rien n’a été modifié.',
			'newVault.doneTitle' => 'Nouveau coffre-fort commencé',
			'newVault.doneDetail' => ({required Object storage}) => 'Votre ancien coffre-fort est conservé en sauvegarde dans ${storage}.',
			'tabs.vault' => 'Coffre-fort',
			'tabs.codes' => 'Codes',
			'tabs.generator' => 'Générateur',
			'tabs.security' => 'Sécurité',
			'tabs.settings' => 'Paramètres',
			'tabs.securityFlagged' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Sécurité, ${n} élément signalé', other: 'Sécurité, ${n} éléments signalés', ), 
			'codes.subtitle' => 'Codes 2FA de votre coffre-fort, générés sur ce téléphone',
			'codes.searchPlaceholder' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Rechercher dans ${n} code', other: 'Rechercher dans ${n} codes', ), 
			'codes.codeCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} code', other: '${n} codes', ), 
			'codes.copied' => 'Code copié',
			'codes.trust' => 'Générés sur ce téléphone à partir des clés de configuration de votre coffre-fort. Rien de nouveau n’est enregistré.',
			'codes.emptyTitle' => 'Aucun code 2FA pour l’instant',
			'codes.emptyBody' => 'Quand un site propose la connexion à deux facteurs, scannez son code QR ici ou ajoutez un élément Authentificateur.',
			'codes.createAuthenticator' => 'Créer un élément Authentificateur',
			'comingSoon.body' => ({required Object part}) => 'Arrive dans la partie ${part}.',
			'vaultList.lock' => 'Verrouiller',
			'vaultList.newItem' => 'Nouvel élément',
			'vaultList.allVaults' => 'Tous les coffres-forts',
			'vaultList.favorites' => 'Favoris',
			'vaultList.recentlyUsed' => 'Récemment utilisés',
			'vaultList.statusSaved' => ({required Object items, required Object storage}) => '${items} · Enregistré dans ${storage}',
			'vaultList.statusInVault' => ({required Object items, required Object vault}) => '${items} dans ${vault}',
			'vaultList.statusTagged' => ({required Object items, required Object tag}) => '${items} avec le tag ${tag}',
			'vaultList.statusReport' => ({required Object items, required Object report}) => '${items} · ${report}',
			'vaultList.statusNotConnected' => ({required Object storage}) => 'Non connecté à ${storage}',
			'vaultList.statusOffline' => ({required Object items}) => 'Hors ligne · ${items}',
			'vaultList.reportWeak' => 'Mots de passe faibles',
			'vaultList.reportReused' => 'Mots de passe réutilisés',
			'vaultList.reportCompromised' => 'Mots de passe compromis',
			'vaultList.searchHint' => 'Chaque mot doit correspondre, dans n’importe quel ordre : noms, tags, noms de champ et valeurs.',
			'vaultList.filterByTag' => 'Filtrer par tag',
			'vaultList.manageTags' => 'Gérer les tags',
			'vaultList.clearFilter' => 'Effacer le filtre',
			'vaultList.today' => 'Aujourd’hui',
			'vaultList.thisWeek' => 'Cette semaine',
			'vaultList.earlier' => 'Plus tôt',
			'vaultList.aToZ' => 'De A à Z',
			'vaultList.sortHeading' => 'Trier par dernière modification',
			'vaultList.newestFirst' => 'Plus récents d’abord',
			'vaultList.oldestFirst' => 'Plus anciens d’abord',
			'vaultList.refreshing' => ({required Object storage}) => 'Lecture de votre coffre-fort depuis ${storage}…',
			'vaultList.copyPasswordFor' => ({required Object name}) => 'Copier le mot de passe de ${name}',
			'vaultList.copyCodeFor' => ({required Object name}) => 'Copier le code de ${name}',
			'vaultList.copyCardNumberFor' => ({required Object name}) => 'Copier le numéro de carte de ${name}',
			'vaultList.swipePassword' => 'Mot de passe',
			'vaultList.swipeCode' => 'Code',
			'vaultList.swipeCardNumber' => 'Numéro de carte',
			'vaultList.swipeUsername' => 'Nom d’utilisateur',
			'vaultList.swipeMore' => 'Plus',
			'vaultList.copyPassword' => 'Copier le mot de passe',
			'vaultList.copyCode' => 'Copier le code',
			'vaultList.copyCardNumber' => 'Copier le numéro de carte',
			'vaultList.copyUsername' => 'Copier le nom d’utilisateur',
			'vaultList.moreActions' => 'Autres actions',
			'vaultList.favorite' => 'Favori',
			'vaultList.addToFavorites' => 'Ajouter aux favoris',
			'vaultList.removeFromFavorites' => 'Retirer des favoris',
			'vaultList.findingWeak' => 'Mot de passe faible',
			'vaultList.findingReused' => 'Mot de passe réutilisé',
			'vaultList.findingCompromised' => 'Mot de passe compromis',
			'vaultList.findingWeakReused' => 'Mot de passe faible et réutilisé',
			'vaultList.findingWeakCompromised' => 'Mot de passe faible et compromis',
			'vaultList.findingReusedCompromised' => 'Mot de passe réutilisé et compromis',
			'vaultList.findingAll' => 'Mot de passe faible, réutilisé et compromis',
			'vaultList.unnamed' => 'Nouvel élément',
			'vaultList.scopeTitle' => 'Coffres-forts',
			'vaultList.manageVaults' => 'Gérer les coffres-forts',
			'vaultList.scopeNote' => ({required Object storage}) => 'Tous vos coffres-forts se trouvent dans un seul fichier chiffré, vault.json.enc, dans votre ${storage}.',
			'vaultList.quickActions' => ({required Object name}) => '${name}, actions rapides',
			'vaultList.openWebsite' => 'Ouvrir le site web',
			'vaultList.moveToVault' => 'Déplacer vers un coffre-fort…',
			'vaultList.select' => 'Sélectionner',
			'vaultList.delete' => 'Supprimer',
			'vaultList.selectAll' => 'Tout sélectionner',
			'vaultList.selectOrDeselectAll' => 'Tout sélectionner ou désélectionner',
			'vaultList.listTwo' => ({required Object a, required Object b}) => '${a} et ${b}',
			'vaultList.listThree' => ({required Object a, required Object b, required Object c}) => '${a}, ${b} et ${c}',
			'vaultList.deleteItemTitle' => 'Supprimer l’élément',
			'vaultList.deleteItemConfirm' => ({required Object name}) => 'Voulez-vous vraiment supprimer « ${name} » ? Cette action est irréversible.',
			'vaultList.deleteItemAction' => 'Supprimer l’élément',
			'vaultList.moveToVaultTitle' => 'Déplacer vers un coffre-fort',
			'vaultList.moveDescription' => 'Choisissez le coffre-fort où cet élément doit se trouver.',
			'vaultList.current' => 'Actuel',
			'vaultList.newVaultOption' => 'Nouveau coffre-fort…',
			'vaultList.noOtherVaultOne' => 'Il n’y a pas d’autre coffre-fort vers lequel déplacer cet élément.',
			'vaultList.noOtherVaultMany' => 'Il n’y a pas d’autre coffre-fort vers lequel déplacer ces éléments.',
			'vaultList.noOtherVaultDetail' => 'Un second coffre-fort permet de séparer un ensemble d’éléments — le travail du personnel, ou le partagé du privé.',
			'vaultList.createAVault' => 'Créer un coffre-fort',
			'vaultList.newVaultTitle' => 'Nouveau coffre-fort',
			'vaultList.newVaultBody' => 'Un coffre-fort est un groupe d’éléments à part. Contrairement à un élément, il n’y a rien d’autre à choisir au départ.',
			'vaultList.vaultName' => 'Nom du coffre-fort',
			'vaultList.duplicateVault' => 'Un coffre-fort portant ce nom existe déjà.',
			'vaultList.noItemsTitle' => 'Vous n’avez encore aucun élément.',
			'vaultList.noItemsBody' => 'Ajoutez votre premier identifiant, carte ou note. Chacun est chiffré sur ce téléphone avant d’être enregistré.',
			'vaultList.importCsv' => 'Importer depuis un CSV',
			'vaultList.vaultReady' => 'Votre coffre-fort est prêt. Il est encore vide.',
			'vaultList.savedMeta' => ({required Object storage, required Object items}) => 'Enregistré dans ${storage} · ${items}',
			'vaultList.vaultEmptyTitle' => 'Ce coffre-fort ne contient encore aucun élément.',
			'vaultList.vaultEmptyBody' => ({required Object vault}) => 'Ajoutez-en un ici, ou déplacez des éléments depuis ${vault}.',
			'vaultList.noFavoritesTitle' => 'Vous n’avez encore aucun favori.',
			'vaultList.noFavoritesBody' => 'Touchez l’étoile d’un élément pour le garder ici.',
			'vaultList.nothingRecentTitle' => 'Rien d’utilisé pour l’instant',
			'vaultList.nothingRecentBody' => 'Les éléments que vous ouvrez ou dont vous copiez une valeur apparaissent ici, les plus récents d’abord.',
			'vaultList.noResultsTitle' => 'Votre recherche ne correspond à aucun élément.',
			'vaultList.noResultsBody' => 'Chaque mot doit correspondre. Essayez avec moins de mots ou vérifiez l’orthographe.',
			'vaultList.allClearWeak' => 'Tous les mots de passe de votre coffre-fort sont suffisamment robustes.',
			'vaultList.allClearReused' => 'Chaque mot de passe de votre coffre-fort n’est utilisé qu’une seule fois.',
			'vaultList.allClearCompromised' => 'Aucun de vos mots de passe n’a été trouvé dans une fuite connue.',
			'vaultList.allClearBody' => 'Rien à corriger ici. KeeperPass vérifie à nouveau dès qu’un mot de passe change.',
			'vaultList.backToSecurity' => 'Retour à Sécurité',
			'vaultList.fieldCopied' => ({required Object field}) => '${field} copié',
			'vaultList.copiedFrom' => ({required Object item}) => 'Depuis ${item}',
			'vaultList.itemCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} élément', other: '${n} éléments', ), 
			'vaultList.statusNotSaved' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} modification non enregistrée', other: '${n} modifications non enregistrées', ), 
			'vaultList.searchPlaceholder' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Rechercher dans ${n} élément', other: 'Rechercher dans ${n} éléments', ), 
			'vaultList.results' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} résultat', other: '${n} résultats', ), 
			'vaultList.selectedCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} sélectionné', other: '${n} sélectionnés', ), 
			'vaultList.moveItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Déplacer ${n} élément', other: 'Déplacer ${n} éléments', ), 
			'vaultList.moveItemsTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Déplacer ${n} élément', other: 'Déplacer ${n} éléments', ), 
			'vaultList.deleteItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Supprimer ${n} élément', other: 'Supprimer ${n} éléments', ), 
			'vaultList.deleteTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Supprimer ${n} élément ?', other: 'Supprimer ${n} éléments ?', ), 
			'vaultList.deleteFromVault' => ({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${names} sera supprimé de ${vault}. Cette action est irréversible.', other: '${names} seront supprimés de ${vault}. Cette action est irréversible.', ), 
			'vaultList.deleteFromVaults' => ({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${names} sera supprimé. Cette action est irréversible.', other: '${names} seront supprimés. Cette action est irréversible.', ), 
			'vaultList.moveLine' => ({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${names} est déplacé avec son historique et ses tags.', other: '${names} sont déplacés avec leur historique et leurs tags.', ), 
			'vaultList.movedTitle' => ({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${names} déplacé vers ${vault}', other: '${names} déplacés vers ${vault}', ), 
			'vaultList.movedDetail' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Il garde son historique et ses tags.', other: 'Ils gardent leur historique et leurs tags.', ), 
			'vaultList.itemsOf' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${count} sur ${n} élément', other: '${count} sur ${n} éléments', ), 
			'itemDetail.edit' => 'Modifier',
			'itemDetail.editItem' => 'Modifier l’élément',
			'itemDetail.moreOptions' => 'Plus d’options',
			'itemDetail.updatedAgo' => ({required Object ago}) => 'Mis à jour ${ago}',
			'itemDetail.showTagged' => ({required Object tag}) => 'Afficher les éléments avec le tag ${tag}',
			'itemDetail.fields' => 'Champs',
			'itemDetail.noFields' => 'Cet élément n’a aucun champ.',
			'itemDetail.history' => 'Historique',
			'itemDetail.currentVersion' => 'Version actuelle',
			'itemDetail.todayAt' => ({required Object time}) => 'Aujourd’hui, ${time}',
			'itemDetail.unnamedField' => 'Sans nom',
			'itemDetail.copyField' => ({required Object field}) => 'Copier ${field}',
			'itemDetail.revealValue' => 'Afficher la valeur',
			'itemDetail.hideValue' => 'Masquer la valeur',
			'itemDetail.hiddenValue' => ({required Object field}) => '${field}, masqué',
			'itemDetail.openSite' => ({required Object site}) => 'Ouvrir ${site}',
			'itemDetail.call' => 'Appeler',
			'itemDetail.message' => 'Message',
			'itemDetail.checksumFail' => 'Ce numéro échoue à sa somme de contrôle — l’un des chiffres est probablement erroné.',
			'itemDetail.codeCardHint' => 'Touchez pour copier · aussi dans l’onglet Codes',
			'itemDetail.copyAllCodes' => 'Copier tous les codes',
			'itemDetail.copyCodeNumber' => ({required Object n}) => 'Copier le code ${n}',
			'itemDetail.cardFace' => 'Carte, numéro masqué',
			'itemDetail.cardFaceBrand' => ({required Object brand}) => 'Carte ${brand}, numéro masqué',
			'itemDetail.cardExpires' => ({required Object date}) => 'expire en ${date}',
			'itemDetail.largeTypeTurn' => 'Tournez votre téléphone pour le lire sur une seule ligne.',
			'itemDetail.largeTypeHides' => 'Il est de nouveau masqué quand vous quittez cet écran.',
			'itemDetail.earlierVersion' => 'Version précédente',
			'itemDetail.readOnly' => ({required Object ago}) => '${ago} · lecture seule',
			'itemDetail.changedSince' => 'Modifié depuis',
			'itemDetail.restoreThisVersion' => 'Restaurer cette version',
			'itemDetail.deleteVersion' => 'Supprimer la version',
			'itemDetail.restoreTitle' => 'Restaurer cette version ?',
			'itemDetail.restoreBody' => ({required Object name, required Object date}) => '${name} revient à son état du ${date}. La version actuelle reste dans son historique.',
			'itemDetail.restore' => 'Restaurer',
			'itemDetail.deleteVersionTitle' => 'Supprimer cette version',
			'itemDetail.deleteVersionConfirm' => 'Voulez-vous vraiment supprimer cette version de l’historique ? Cette action est irréversible.',
			'itemDetail.delete' => 'Supprimer',
			'itemDetail.notFound' => 'Cet élément n’existe plus.',
			'itemDetail.notFoundHint' => 'Il a peut-être été supprimé depuis un autre appareil.',
			'itemDetail.backToVault' => 'Retour au coffre-fort',
			'itemDetail.hiddenLines' => ({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${field}, masqué, ${n} ligne', other: '${field}, masqué, ${n} lignes', ), 
			'itemDetail.largeTypeLabel' => ({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${field} en grands caractères, ${n} caractère', other: '${field} en grands caractères, ${n} caractères', ), 
			'editItem.newVaultItem' => 'Nouvel élément du coffre-fort',
			'editItem.vault' => 'Coffre-fort',
			'editItem.template' => 'Modèle',
			'editItem.templateNote' => 'Les modèles ne sont qu’un point de départ : renommez, retirez ou ajoutez des champs à tout moment.',
			'editItem.templates.website' => 'Site web ou application',
			'editItem.templates.computer' => 'Ordinateur',
			'editItem.templates.creditCard' => 'Carte bancaire',
			'editItem.templates.bankAccount' => 'Compte bancaire',
			'editItem.templates.wifi' => 'Réseau Wi-Fi',
			'editItem.templates.passport' => 'Passeport',
			'editItem.templates.note' => 'Note',
			'editItem.templates.authenticator' => 'Authentificateur',
			'editItem.templates.custom' => 'Personnalisé',
			'editItem.templateHints.website' => 'Nom d’utilisateur, mot de passe, URL',
			'editItem.templateHints.computer' => 'Nom d’utilisateur, mot de passe',
			'editItem.templateHints.creditCard' => 'Numéro, titulaire, expiration, CVC, PIN',
			'editItem.templateHints.bankAccount' => 'Titulaire, IBAN, BIC, PIN',
			'editItem.templateHints.wifi' => 'Nom du réseau, mot de passe',
			'editItem.templateHints.passport' => 'Numéro, nom, dates',
			'editItem.templateHints.note' => 'Une note mise en forme',
			'editItem.templateHints.authenticator' => 'Un code 2FA',
			'editItem.templateHints.custom' => 'Aucun champ pour l’instant',
			'editItem.templateFields.cardholder' => 'Titulaire de la carte',
			'editItem.templateFields.expiresOn' => 'Date d’expiration',
			'editItem.templateFields.cvc' => 'CVC',
			'editItem.templateFields.accountHolder' => 'Titulaire du compte',
			'editItem.templateFields.iban' => 'IBAN',
			'editItem.templateFields.bic' => 'BIC',
			'editItem.templateFields.cardPin' => 'Code PIN de la carte',
			'editItem.templateFields.networkName' => 'Nom du réseau',
			'editItem.templateFields.fullName' => 'Nom complet',
			'editItem.templateFields.passportNumber' => 'Numéro de passeport',
			'editItem.templateFields.issuingCountry' => 'Pays de délivrance',
			'editItem.templateFields.dateOfBirth' => 'Date de naissance',
			'editItem.templateFields.placeOfBirth' => 'Lieu de naissance',
			'editItem.templateFields.issuedOn' => 'Date de délivrance',
			'editItem.types.username' => 'Nom d’utilisateur',
			'editItem.types.password' => 'Mot de passe',
			'editItem.types.email' => 'E-mail',
			'editItem.types.url' => 'URL',
			'editItem.types.ipHost' => 'IP / Hôte',
			'editItem.types.date' => 'Date',
			'editItem.types.month' => 'Mois',
			_ => null,
		} ?? switch (path) {
			'editItem.types.credit' => 'Numéro de carte',
			'editItem.types.phone' => 'Téléphone',
			'editItem.types.pin' => 'Code PIN',
			'editItem.types.totp' => 'Code d’authentification',
			'editItem.types.certificate' => 'Certificat',
			'editItem.types.sshKey' => 'Clé SSH / privée',
			'editItem.types.recoveryCodes' => 'Codes de récupération',
			'editItem.types.note' => 'Note formatée',
			'editItem.types.text' => 'Texte',
			'editItem.newItem' => 'Nouvel élément',
			'editItem.editItem' => 'Modifier l’élément',
			'editItem.changeIcon' => 'Changer l’icône',
			'editItem.name' => 'Nom',
			'editItem.namePlaceholder' => 'ex. GitHub',
			'editItem.tags' => 'Tags',
			'editItem.addField' => 'Ajouter un champ',
			'editItem.addFieldTitle' => 'Ajouter un champ',
			'editItem.noFieldsTitle' => 'Aucun champ pour l’instant',
			'editItem.noFieldsBody' => 'Ajoutez l’un des 16 types de champ — un numéro de contrat, un numéro de téléphone, un code PIN.',
			'editItem.fieldNamePlaceholder' => 'Nom du champ',
			'editItem.addTag' => 'Ajouter un tag',
			'editItem.tagSuggestions' => 'Suggestions de tags',
			'editItem.createTag' => ({required Object name}) => 'Créer « ${name} »',
			'editItem.tagTooLong' => 'Ce nom est trop long.',
			'editItem.removeFieldTitle' => 'Voulez-vous vraiment supprimer ce champ ?',
			'editItem.removeFieldBody' => ({required Object field, required Object item}) => '« ${field} » et sa valeur quittent ${item} à l’enregistrement.',
			'editItem.remove' => 'Retirer',
			'editItem.discardTitle' => 'Abandonner les modifications ?',
			'editItem.discardBody' => ({required Object name}) => 'Vos modifications de ${name} n’ont pas été enregistrées. Les abandonner laisse l’élément tel qu’il était.',
			'editItem.discardNewTitle' => 'Abandonner ce nouvel élément ?',
			'editItem.discardNewBody' => 'Il n’a pas été enregistré. L’abandonner le supprime.',
			'editItem.discard' => 'Abandonner',
			'editItem.usernamePlaceholder' => 'Nom d’utilisateur ou e-mail',
			'editItem.passwordPlaceholder' => 'Mot de passe',
			'editItem.valuePlaceholder' => 'Saisissez la valeur ici',
			'editItem.ipHostPlaceholder' => 'ex. 192.168.1.1, ::1 ou db.exemple.com',
			'editItem.recoveryCodesPlaceholder' => 'Un par ligne — tout format convient',
			'editItem.notEmail' => 'Cela ne ressemble pas à une adresse e-mail.',
			'editItem.phoneNumber' => 'Numéro de téléphone',
			'editItem.searchCountries' => 'Rechercher des pays',
			'editItem.noCountryMatch' => 'Aucun pays ne correspond.',
			'editItem.generate' => 'Générer',
			'editItem.generatePassword' => 'Générer un mot de passe',
			'editItem.currentCode' => 'Code actuel',
			'editItem.scanQr' => 'Scanner le code QR',
			'editItem.enterSetupKey' => 'Saisir la clé de configuration',
			'editItem.setupKeyTitle' => 'Saisir la clé de configuration',
			'editItem.setupKeyBody' => 'Les sites affichent une clé de configuration à côté du code QR, souvent sous « Impossible de scanner ? ».',
			'editItem.setupKey' => 'Clé de configuration',
			'editItem.setupKeyHint' => 'Les espaces et les majuscules n’ont pas d’importance.',
			'editItem.saveCode' => 'Enregistrer le code',
			'editItem.chooseIcon' => 'Choisir une icône',
			'editItem.searchIcons' => 'Rechercher des icônes — essayez « banque » ou « cadenas »',
			'editItem.popular' => 'Populaires',
			'editItem.noIcons' => ({required Object search}) => 'Aucune icône ne correspond à « ${search} ».',
			'editItem.useDefaultIcon' => 'Utiliser l’icône par défaut',
			'editItem.iconMatches' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} résultat', other: '${n} résultats', ), 
			'generator.title' => 'Générer un mot de passe',
			'generator.notFilledIn' => 'Rien n’est rempli tant que vous ne l’acceptez pas.',
			'generator.generated' => 'Mot de passe généré',
			'generator.mode' => 'Mode',
			'generator.passphrase' => 'Phrase de passe',
			'generator.randomString' => 'Chaîne aléatoire',
			'generator.words' => 'Mots',
			'generator.fewerWords' => 'Moins de mots',
			'generator.moreWords' => 'Plus de mots',
			'generator.length' => 'Longueur',
			'generator.shorter' => 'Plus court',
			'generator.longer' => 'Plus long',
			'generator.wordSeparator' => 'Séparateur de mots',
			'generator.dash' => 'Tiret',
			'generator.underscore' => 'Tiret bas',
			'generator.slash' => 'Barre oblique',
			'generator.space' => 'Espace',
			'generator.language' => 'Langue',
			'generator.regenerate' => 'Régénérer',
			'generator.charCount' => ({required Object count}) => '${count} caractères',
			'generator.lowercase' => 'Lettres minuscules',
			'generator.uppercase' => 'Lettres majuscules',
			'generator.digits' => 'Chiffres',
			'generator.symbols' => 'Symboles',
			'generator.pickOne' => 'Choisissez au moins un type de caractère.',
			'generator.use' => 'Utiliser ce mot de passe',
			'generator.wordCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} mot', other: '${n} mots', ), 
			'generator.pageTitle' => 'Générateur de mots de passe',
			'generator.subtitle' => 'Mots de passe et phrases de passe aléatoires, créés sur cet appareil',
			'generator.separatorDash' => 'Tiret ( - )',
			'generator.separatorUnderscore' => 'Tiret bas ( _ )',
			'generator.separatorSlash' => 'Barre oblique ( / )',
			'generator.separatorSpace' => 'Espace',
			'generator.nothingToGenerate' => 'Rien à générer.',
			'generator.copyPassword' => 'Copier le mot de passe',
			'generator.copied' => 'Mot de passe copié',
			'generator.fromGenerator' => 'Depuis le générateur',
			'report.title' => 'Rapport de sécurité',
			'report.subtitle' => 'La solidité de vos mots de passe enregistrés',
			'report.healthLabel' => 'Santé du coffre-fort',
			'report.healthGood' => 'Solide',
			'report.healthFair' => 'À améliorer',
			'report.healthPoor' => 'À risque',
			'report.allClearTitle' => 'Aucun problème détecté',
			'report.allClearDescription' => 'Tous les mots de passe de vos coffres-forts ont passé le dernier audit.',
			'report.aboutSection' => ({required Object title}) => 'À propos de ${title}',
			'report.nothingFound' => 'Rien trouvé',
			'report.openItem' => ({required Object name}) => 'Ouvrir ${name}',
			'report.checkAgain' => 'Vérifier à nouveau',
			'report.statWeak' => 'Faibles',
			'report.statReused' => 'Réutilisés',
			'report.statCompromised' => 'Compromis',
			'report.statValue' => ({required Object label, required Object count}) => '${label} : ${count}',
			'report.statNotChecked' => ({required Object label}) => '${label} : pas encore vérifié',
			'report.healthPercent' => ({required Object title, required Object score}) => '${title} ${score} pour cent',
			'report.sameAs' => ({required Object names}) => 'Le même que pour ${names}',
			'report.sameAsField' => 'Le même qu’un autre mot de passe de cet élément',
			'report.foundInBreach' => 'Trouvé dans une fuite connue',
			'report.trust' => 'La vérification des fuites utilise Have I Been Pwned avec le k-anonymat : seuls les 5 premiers caractères d’un hachage SHA-1 quittent ce téléphone.',
			'report.lastCheckedJustNow' => 'Dernière vérification : à l’instant',
			'report.lastCheckedToday' => ({required Object time}) => 'Dernière vérification : aujourd’hui à ${time}',
			'report.lastCheckedOn' => ({required Object date}) => 'Dernière vérification : ${date}',
			'report.checking' => 'Vérification…',
			'report.checkingBreaches' => ({required Object done, required Object total}) => 'Recherche de fuites · ${done} sur ${total}',
			'report.progress' => ({required Object done, required Object total}) => '${done} sur ${total}',
			'report.progressTime' => ({required Object done, required Object total, required Object time}) => '${done} sur ${total} · ${time}',
			'report.offlineBody' => 'Vos mots de passe n’ont pas pu être vérifiés. La vérification nécessite une connexion.',
			'report.failedTitle' => 'La vérification n’a pas pu aboutir',
			'report.failedBody' => 'Réessayez dans un instant.',
			'report.nothingTitle' => 'Rien à vérifier pour l’instant',
			'report.nothingBody' => 'Enregistrez un élément avec un mot de passe : il sera vérifié ici, sur ce téléphone, pour repérer les mots de passe faibles, réutilisés ou piratés.',
			'report.howToFix' => 'Comment y remédier',
			'report.stepOpen' => 'Ouvrez l’élément',
			'report.stepGenerate' => 'Touchez Modifier, puis Générer sur le mot de passe',
			'report.stepSave' => 'Enregistrez : le signalement disparaît de lui-même',
			'report.stepSaveCompromised' => 'Enregistrez, puis changez-le aussi sur le site',
			'report.changePassword' => 'Changer le mot de passe',
			'report.fixedClear' => ({required Object name}) => 'Enregistré · ${name} n’est plus signalé',
			'report.fixedFlagged' => ({required Object name}) => 'Enregistré · ${name} est toujours signalé',
			'report.savedTo' => ({required Object storage}) => 'Votre coffre-fort a été enregistré dans ${storage}',
			'report.noLongerWeak' => 'N’est plus faible',
			'report.noLongerReused' => 'N’est plus réutilisé',
			'report.noLongerWeakOrReused' => 'N’est plus faible ni réutilisé',
			'report.hintReusedOne' => ({required Object n}) => 'Ces ${n} partagent un même mot de passe. Donnez-en un propre à chacun : ouvrez-en un, touchez Modifier, puis Générer.',
			'report.hintReusedSome' => 'Certains partagent un mot de passe. Donnez-en un propre à chacun : ouvrez-en un, touchez Modifier, puis Générer.',
			'report.hintWeak' => 'Donnez-en un plus solide à chacun : ouvrez-le, touchez Modifier, puis Générer.',
			'report.hintCompromised' => 'Ceux-ci figurent dans des fuites connues. Changez chacun : ouvrez-le, touchez Modifier, puis Générer.',
			'report.itemsChecked' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} élément avec mot de passe vérifié', other: '${n} éléments avec mot de passe vérifiés', ), 
			'report.flagged' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} élément signalé', other: '${n} éléments signalés', ), 
			'report.sameAsOthers' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Le même que pour ${n} autre élément', other: 'Le même que pour ${n} autres éléments', ), 
			'report.checkingPasswords' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Vérification de ${n} mot de passe', other: 'Vérification de ${n} mots de passe', ), 
			'report.aboutSeconds' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'environ ${n} seconde', other: 'environ ${n} secondes', ), 
			'report.aboutMinutes' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'environ ${n} minute', other: 'environ ${n} minutes', ), 
			'audit.weakPassword.label' => 'Mots de passe faibles',
			'audit.weakPassword.description' => 'Un mot de passe est faible lorsque l’espace de recherche pour un attaquant est réduit : il est court, utilise un jeu de caractères limité, ou repose sur un mot, un nom ou une suite du clavier présente dans tous les dictionnaires de piratage. Les attaques hors ligne testent des milliards de combinaisons par seconde, donc tout ce qui entre dans cette catégorie tombe rapidement. Remplacez-le par un mot de passe long et généré aléatoirement.',
			'audit.reusedPassword.label' => 'Mots de passe réutilisés',
			'audit.reusedPassword.description' => 'Utiliser le même mot de passe à plusieurs endroits signifie qu’une seule fuite, où qu’elle survienne, les compromet tous — et vous n’avez aucun contrôle sur lequel de ces services sera celui qui fuitera. Donnez à chaque élément son propre mot de passe généré pour qu’une fuite reste limitée au compte d’où elle provient.',
			'audit.compromisedPassword.label' => 'Mots de passe compromis',
			'audit.compromisedPassword.description' => 'Ce mot de passe figure dans un registre public d’identifiants piratés, ce qui en fait l’un des premiers que les attaquants essaieront, aussi solide soit-il en apparence. Changez-le partout où il est utilisé : un mot de passe n’a besoin de fuiter qu’une seule fois pour rester compromis.',
			'myVaults.title' => 'Mes coffres-forts',
			'myVaults.subtitle' => 'Des groupes d’éléments séparés — travail, famille, personnel',
			'myVaults.defaultBadge' => 'Par défaut',
			'myVaults.newVault' => 'Nouveau coffre-fort',
			'myVaults.emptyTitle' => 'Vous n’avez que le coffre-fort par défaut',
			'myVaults.emptyBody' => 'Un second coffre-fort permet de séparer un ensemble d’éléments — le travail du personnel, ou le partagé du privé.',
			'myVaults.createdOn' => ({required Object date}) => 'créé le ${date}',
			'myVaults.renameTitle' => 'Renommer le coffre-fort',
			'myVaults.renameBody' => 'Les éléments qu’il contient ne sont pas affectés.',
			'myVaults.duplicateRename' => ({required Object name}) => 'Un coffre-fort nommé « ${name} » existe déjà.',
			'myVaults.deleteTitle' => ({required Object name}) => 'Supprimer « ${name} » ?',
			'myVaults.deleteAction' => 'Supprimer le coffre-fort',
			'myVaults.renameAria' => ({required Object name}) => 'Renommer ${name}',
			'myVaults.deleteAria' => ({required Object name}) => 'Supprimer ${name}',
			'myVaults.itemCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} élément', other: '${n} éléments', ), 
			'myVaults.deleteBody' => ({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Son ${n} élément sera déplacé vers ${vault}. Cette action est irréversible.', other: 'Ses ${n} éléments seront déplacés vers ${vault}. Cette action est irréversible.', ), 
			'myVaults.deleteSelectedTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Supprimer ${n} coffre-fort ?', other: 'Supprimer ${n} coffres-forts ?', ), 
			'myVaults.deleteSelectedBody' => ({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Tout ce qu’ils contiennent — ${n} élément — sera déplacé vers ${vault}. Cette action est irréversible.', other: 'Tout ce qu’ils contiennent — ${n} éléments — sera déplacé vers ${vault}. Cette action est irréversible.', ), 
			'myVaults.personalSummary' => ({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${name} contient ${n} élément et ne peut être ni renommé ni supprimé.', other: '${name} contient ${n} éléments et ne peut être ni renommé ni supprimé.', ), 
			'myVaults.selected' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} coffre-fort sélectionné', other: '${n} coffres-forts sélectionnés', ), 
			'myVaults.deleteVaults' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Supprimer ${n} coffre-fort', other: 'Supprimer ${n} coffres-forts', ), 
			'tags.title' => 'Tags',
			'tags.subtitle' => 'Des étiquettes communes à tous les coffres-forts, pour tout retrouver vite',
			'tags.since' => ({required Object date}) => 'depuis le ${date}',
			'tags.addTag' => 'Ajouter un tag',
			'tags.addTitle' => 'Ajouter un tag',
			'tags.emptyTitle' => 'Aucun tag pour l’instant',
			'tags.emptyBody' => 'Les tags se créent depuis un élément, ou ici — dans les deux cas, ils regroupent des éléments entre coffres-forts.',
			'tags.addBody' => 'Un tag sans élément pour l’instant. Ajoutez-le à un élément depuis la page de cet élément.',
			'tags.tagName' => 'Nom du tag',
			'tags.duplicate' => 'Un tag portant ce nom existe déjà.',
			'tags.colorNote' => 'Sa couleur vient de son nom.',
			'tags.renameTitle' => 'Renommer le tag',
			'tags.renameBody' => 'Chaque élément qui le porte est mis à jour.',
			'tags.mergeNotice' => ({required Object name}) => '« ${name} » existe déjà — le renommage les fusionnera.',
			'tags.deleteTitle' => ({required Object name}) => 'Supprimer « ${name} » ?',
			'tags.deleteAction' => 'Supprimer le tag',
			'tags.deleteSelectedBody' => 'Chacun est retiré de tous les éléments qui le portent. Les éléments eux-mêmes sont conservés. Cette action est irréversible.',
			'tags.footer' => 'Touchez un tag pour voir ses éléments dans l’onglet Coffre-fort.',
			'tags.renameAria' => ({required Object name}) => 'Renommer ${name}',
			'tags.deleteAria' => ({required Object name}) => 'Supprimer ${name}',
			'tags.itemCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} élément', other: '${n} éléments', ), 
			'tags.deleteBody' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Il sera retiré de ${n} élément. Les éléments eux-mêmes sont conservés. Cette action est irréversible.', other: 'Il sera retiré de ${n} éléments. Les éléments eux-mêmes sont conservés. Cette action est irréversible.', ), 
			'tags.deleteSelectedTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Supprimer ${n} tag ?', other: 'Supprimer ${n} tags ?', ), 
			'tags.selected' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} tag sélectionné', other: '${n} tags sélectionnés', ), 
			'tags.deleteTags' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Supprimer ${n} tag', other: 'Supprimer ${n} tags', ), 
			'changeSecret.title' => 'Changer le secret',
			'changeSecret.intro' => 'Votre coffre-fort est rechiffré avec le nouveau secret puis renvoyé. Il ne peut pas être récupéré si vous l’oubliez.',
			'changeSecret.current' => 'Secret actuel',
			'changeSecret.wrong' => 'Ce n’est pas votre secret actuel.',
			'changeSecret.match' => 'Les deux secrets correspondent.',
			'changeSecret.otherDevices' => 'Vos autres appareils demanderont le nouveau secret la prochaine fois qu’ils ouvriront votre coffre-fort.',
			'changeSecret.submit' => 'Changer le secret',
			'changeSecret.verifyingMeta' => 'Vérification de votre secret actuel…',
			'changeSecret.verifyingTitle' => 'Vérification de votre secret actuel…',
			'changeSecret.stepVerify' => 'Vérification de votre secret actuel',
			'changeSecret.stepVerifyNote' => 'Volontairement lent sur un téléphone — c’est ce qui rend chaque tentative coûteuse',
			'changeSecret.stepEncrypt' => 'Chiffrement avec le nouveau secret',
			'changeSecret.stepSave' => 'Enregistrement de votre coffre-fort',
			'changeSecret.savingMeta' => ({required Object storage}) => 'Enregistrement dans ${storage}…',
			'changeSecret.savingTitle' => ({required Object percent}) => 'Enregistrement de votre coffre-fort… ${percent} %',
			'changeSecret.stepVerified' => 'Secret actuel vérifié',
			'changeSecret.stepEncrypted' => 'Chiffré avec le nouveau secret',
			'changeSecret.stepSaving' => ({required Object storage}) => 'Enregistrement dans ${storage}',
			'changeSecret.keepOpen' => 'Gardez KeeperPass ouvert jusqu’à la fin.',
			'changeSecret.doneMeta' => ({required Object storage}) => 'Enregistré dans ${storage}',
			'changeSecret.doneTitle' => 'Votre secret a été changé',
			'changeSecret.doneBody' => 'Tous vos éléments vous ont suivi. Vos autres appareils demanderont le nouveau secret la prochaine fois qu’ils ouvriront votre coffre-fort.',
			'changeSecret.toast' => 'Secret changé',
			'changeSecret.failTitle' => 'Votre coffre-fort n’a pas été enregistré',
			'changeSecret.failBody' => ({required Object storage}) => 'Impossible de joindre ${storage}. Votre secret n’a pas changé : le coffre-fort s’ouvre toujours avec l’actuel.',
			'storage.title' => 'Stockage',
			'storage.subtitle' => 'Où vit votre coffre-fort, et ce qui peut y accéder',
			'storage.diagram' => ({required Object storage}) => 'Chiffré sur ce téléphone, stocké dans votre ${storage}',
			'storage.thisPhone' => 'Ce téléphone',
			'storage.encryptedOnly' => 'Fichier chiffré uniquement',
			'storage.googleFolder' => 'dossier keeperpass',
			'storage.dropboxFolder' => 'dossier Apps/keeperpass',
			'storage.savedToday' => ({required Object folder, required Object time}) => '${folder} · enregistré aujourd’hui à ${time}',
			'storage.savedOn' => ({required Object folder, required Object date}) => '${folder} · enregistré le ${date}',
			'storage.access' => 'Accès',
			'storage.googlePermissions' => 'Autorisations du compte Google',
			'storage.dropboxApps' => 'Applications connectées à Dropbox',
			'storage.accessNote' => 'KeeperPass n’accède qu’aux fichiers qu’il crée. Vous pouvez révoquer cet accès ici à tout moment ; le fichier du coffre-fort reste où il est.',
			'moveVault.title' => 'Déplacer le coffre-fort',
			'moveVault.diagram' => ({required Object from, required Object to}) => 'Votre coffre-fort passe de ${from} à ${to}',
			'moveVault.from' => 'Source',
			'moveVault.to' => 'Destination',
			'moveVault.intro' => 'Votre coffre-fort est copié et vérifié, et ce n’est qu’ensuite que l’ancien fichier est renommé. Si quelque chose échoue, rien n’est modifié.',
			'moveVault.step1' => ({required Object storage}) => 'Connectez-vous à ${storage} pour choisir où va le coffre-fort.',
			'moveVault.step2' => 'Confirmez. Rien ne change avant cette étape.',
			'moveVault.step3' => 'Le coffre-fort est copié et vérifié ; ensuite, l’ancien fichier est renommé, jamais supprimé.',
			'moveVault.connect' => ({required Object storage}) => 'Connecter ${storage}',
			'moveVault.account' => 'Déplacement vers ce compte',
			'moveVault.existingTitle' => ({required Object storage}) => 'Ce compte ${storage} contient déjà un coffre-fort KeeperPass',
			'moveVault.existingBody' => ({required Object storage}) => 'Si vous continuez, il est conservé comme fichier de sauvegarde horodaté dans ${storage} et remplacé par le coffre-fort que vous déplacez.',
			'moveVault.existingConfirm' => 'Le remplacer — le coffre-fort existant est conservé comme sauvegarde',
			'moveVault.secretSection' => 'Secret du coffre-fort déplacé',
			'moveVault.keepSecret' => 'Conserver mon secret actuel',
			'moveVault.newSecret' => 'Choisir un nouveau secret',
			'moveVault.newSecretNote' => 'Seul le coffre-fort déplacé l’utilise',
			'moveVault.submit' => 'Déplacer le coffre-fort',
			'moveVault.movingTitle' => 'Déplacement de votre coffre-fort',
			'moveVault.stageEncrypting' => 'Chiffrement de votre coffre-fort',
			'moveVault.stageSaving' => ({required Object storage}) => 'Enregistrement dans ${storage}…',
			'moveVault.stageChecking' => 'Vérification de la copie enregistrée',
			'moveVault.stageRenaming' => 'Renommage de l’ancien fichier',
			'moveVault.movingNote' => 'Gardez KeeperPass ouvert jusqu’à la fin. Si quelque chose échoue, rien n’est modifié.',
			'moveVault.savedTo' => ({required Object storage}) => 'Enregistré dans ${storage}',
			'moveVault.doneTitle' => ({required Object storage}) => 'Votre coffre-fort se trouve maintenant dans ${storage}',
			'moveVault.doneBody' => ({required Object provider, required Object from}) => 'Connectez-vous avec ${provider} pour l’ouvrir. L’ancien fichier a été conservé et renommé dans ${from} :',
			'moveVault.copyFileName' => 'Copier le nom du fichier',
			'moveVault.fileNameCopied' => 'Nom du fichier copié',
			'moveVault.partlyTitle' => ({required Object storage}) => 'Votre coffre-fort a été copié dans ${storage}',
			'moveVault.partlyBody' => ({required Object from}) => 'Mais l’ancien fichier dans ${from} n’a pas pu être renommé. Renommez-le ou supprimez-le vous-même pour que les deux copies ne divergent pas.',
			'moveVault.open' => ({required Object storage}) => 'Ouvrir ${storage}',
			'moveVault.unchanged' => ({required Object from}) => 'Toujours dans ${from} · inchangé',
			'moveVault.notMovedTitle' => 'Votre coffre-fort n’a pas été déplacé',
			'moveVault.notMovedBody' => 'La copie enregistrée ne correspondait pas à votre coffre-fort, l’ancien fichier est donc resté intact. Rien n’a été perdu — veuillez réessayer.',
			'dataIo.importTitle' => 'Importer',
			'dataIo.file' => 'Fichier',
			'dataIo.fileMeta' => ({required Object size}) => '${size} · depuis Fichiers',
			'dataIo.kilobytes' => ({required Object n}) => '${n} Ko',
			'dataIo.megabytes' => ({required Object n}) => '${n} Mo',
			'dataIo.change' => 'Changer',
			'dataIo.found' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} élément trouvé à importer.', other: '${n} éléments trouvés à importer.', ), 
			'dataIo.addTo' => 'Les ajouter à',
			'dataIo.importNote' => 'Les éléments sont ajoutés au coffre-fort que vous choisissez. Rien n’est remplacé.',
			'dataIo.importButton' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Importer ${n} élément', other: 'Importer ${n} éléments', ), 
			'dataIo.invalidCsv' => 'Ce fichier n’a pas pu être lu comme un CSV.',
			'dataIo.noItems' => 'Aucun élément trouvé dans ce fichier.',
			'dataIo.notCsvNote' => 'Exportez un CSV depuis votre autre gestionnaire de mots de passe, puis choisissez ce fichier ici.',
			'dataIo.chooseAnother' => 'Choisir un autre fichier',
			'dataIo.exportTitle' => 'Exporter',
			'dataIo.exportIntro' => 'Écrit un CSV du coffre-fort que vous choisissez. Les éléments exportés perdent le chiffrement du coffre-fort — ce que vous faites du fichier ensuite vous appartient.',
			'dataIo.sourceVault' => 'Coffre-fort source',
			'dataIo.notEncryptedTitle' => 'Un fichier CSV n’est pas chiffré',
			'dataIo.notEncryptedBody' => 'Quiconque l’ouvre peut y lire chaque mot de passe. Conservez-le en lieu sûr et supprimez-le une fois terminé.',
			'dataIo.exportButton' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Exporter ${n} élément', other: 'Exporter ${n} éléments', ), 
			'dataIo.exportNote' => 'Ouvre la feuille de partage pour que vous choisissiez où va le fichier.',
			'dataIo.recentTitle' => 'Exports récents',
			'dataIo.recentRow' => ({required num n, required Object scope}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${scope} · ${n} élément', other: '${scope} · ${n} éléments', ), 
			'dataIo.recentNote' => 'Les 10 derniers exports sont mémorisés, dans votre coffre-fort. KeeperPass ne garde aucune copie des fichiers eux-mêmes.',
			'dataIo.recentEmpty' => 'Aucun export pour l’instant.',
			'archive.title' => 'Archiver le coffre-fort',
			'archive.headline' => 'Archiver le coffre-fort et se déconnecter',
			'archive.body' => ({required Object storage}) => 'Votre coffre-fort est un seul fichier chiffré dans votre propre ${storage}. L’archiver renomme ce fichier pour que cette application ne le trouve plus, et vous déconnecte. Rien n’est effacé.',
			'archive.step1' => ({required Object oldName, required Object newName, required Object folder}) => '${oldName} est renommé en ${newName}, dans le même ${folder}.',
			'archive.step2' => ({required Object storage}) => 'Ce téléphone se déconnecte de ${storage}.',
			'archive.step3' => ({required Object storage}) => 'Pour supprimer les données elles-mêmes, supprimez ce fichier dans ${storage}.',
			'archive.typePrefix' => 'Saisissez',
			'archive.typeSuffix' => 'pour confirmer.',
			'archive.confirmation' => 'Confirmation',
			'archive.button' => 'Archiver et se déconnecter',
			'archive.doneMeta' => 'Renommé · cette application ne le trouve plus',
			'archive.doneTitle' => 'Votre fichier de coffre-fort a été renommé',
			'archive.doneBody' => ({required Object folder, required Object storage}) => 'Il se trouve toujours dans le ${folder} de votre ${storage}. Supprimez-le là-bas quand vous voulez effacer définitivement les données.',
			'archive.signedOut' => 'Vous êtes déconnecté sur ce téléphone.',
			'archive.error' => 'Impossible de renommer votre fichier de coffre-fort. Rien n’a été modifié.',
			'help.howTitle' => 'Comment fonctionne KeeperPass',
			'help.howSubtitle' => 'Où vivent vos données, et ce qui les garde privées',
			'help.whereLives' => 'Où vivent vos données',
			'help.diagram' => ({required Object storage}) => 'Votre coffre-fort est chiffré sur ce téléphone et stocké sous forme d’un seul fichier dans votre ${storage}',
			'help.thisPhoneNote' => 'Chiffre et déchiffre tout. Votre secret ne le quitte jamais.',
			'help.fileEncrypted' => 'vault.json.enc · chiffré',
			'help.yourStorage' => ({required Object storage}) => 'Votre ${storage}',
			'help.storageNote' => 'Contient le fichier, illisible sans votre secret.',
			'help.noServer' => 'KeeperPass ne reçoit jamais vos données. Il n’y a aucun compte à pirater ni aucun opérateur capable de lire votre coffre-fort.',
			'help.protects' => 'Ce qui le protège',
			'help.secretTerm' => 'Votre secret',
			'help.secretNote' => 'Jamais envoyé, jamais stocké. Il n’existe qu’en mémoire tant que l’application est déverrouillée.',
			'help.kdfTerm' => 'Dérivation de clé',
			'help.kdfNote' => 'Volontairement lente, pour que chaque tentative de deviner votre secret soit coûteuse.',
			'help.encryptionTerm' => 'Chiffrement',
			'help.encryptionNote' => 'Rend le fichier illisible et révèle si quelqu’un l’a modifié.',
			'help.accessTerm' => 'Accès au stockage',
			'help.accessNote' => 'KeeperPass n’accède qu’aux fichiers qu’il crée.',
			'help.signingIn' => 'Connexion',
			'help.step1' => 'Connectez votre stockage cloud',
			'help.step1Note' => 'Prouve à qui appartient le fichier. Cela ne déverrouille rien.',
			'help.step2' => 'Saisissez votre secret',
			'help.step2Note' => 'Crée sur ce téléphone la clé qui ouvre le fichier. Votre fournisseur de stockage ne la voit jamais.',
			'help.bothNeeded' => 'Quelqu’un qui a votre compte de stockage ne peut toujours pas lire votre coffre-fort. Quelqu’un qui connaît votre secret ne peut toujours pas atteindre le fichier. Il faut les deux.',
			'help.terms' => 'Termes à connaître',
			'help.secretWord' => 'Secret',
			'help.secretDef' => 'L’unique phrase qui déverrouille votre coffre-fort. Elle ne peut pas être récupérée.',
			'help.vaultWord' => 'Coffre-fort',
			'help.vaultDef' => 'Un groupe d’éléments. Avec plusieurs, séparez le travail du personnel.',
			'help.tagWord' => 'Tag',
			'help.tagDef' => 'Une étiquette pour retrouver des éléments entre coffres-forts, comme travail ou banque.',
			'help.reportWord' => 'Rapport de sécurité',
			'help.reportDef' => 'Signale les mots de passe faibles, réutilisés et piratés, sur ce téléphone.',
			'faq.title' => 'Questions',
			'faq.subtitle' => 'Réponses aux questions fréquentes',
			'faq.forgetQ' => 'Que se passe-t-il si j’oublie mon secret ?',
			'faq.forgetA1' => 'Votre coffre-fort ne peut pas être récupéré — ni par vous, ni par nous. La clé est créée à partir de votre seul secret : sans lui, le fichier reste illisible. C’est le prix à payer pour que personne d’autre ne puisse le lire non plus.',
			'faq.forgetA2' => ({required Object forgot, required Object file}) => 'Ce que vous pouvez faire, c’est repartir de zéro : ${forgot} sur l’écran de déverrouillage crée un nouveau coffre-fort vide. Votre ancien fichier n’est pas supprimé — il est renommé en ${file} et conservé dans votre dossier keeperpass, donc les données sont toujours là si le secret vous revient.',
			'faq.forgetA2Link' => 'Secret oublié ?',
			'faq.forgetA3' => 'Notez votre secret et conservez-le en lieu sûr. C’est la seule chose de KeeperPass qui ne peut pas être remplacée.',
			'faq.seeQ' => 'KeeperPass peut-il voir mes mots de passe ?',
			'faq.seeA' => 'Non — et ce n’est pas une promesse, c’est une conséquence de la conception. Le chiffrement a lieu sur ce téléphone et le texte chiffré va directement dans votre propre stockage. Aucun serveur KeeperPass ne se trouve sur le chemin pour voir quoi que ce soit.',
			'faq.syncQ' => 'Est-ce synchronisé entre les appareils ?',
			'faq.syncA' => 'Oui. Chaque appareil lit le même fichier depuis votre stockage. Connectez-vous avec le même compte, saisissez le même secret, et votre coffre-fort est là.',
			'faq.providerQ' => 'Et si mon fournisseur de stockage lit le fichier ?',
			'faq.providerA' => 'Il verrait des octets chiffrés. La clé ne quitte jamais ce téléphone : ni Google, ni Dropbox, ni aucun autre fournisseur ne peut en lire le contenu.',
			'faq.importQ' => 'Puis-je importer depuis un autre gestionnaire de mots de passe ?',
			'faq.importA' => 'Oui — exportez en CSV depuis celui-ci, puis utilisez Importer dans Paramètres.',
			'faq.changeSecretQ' => 'Comment changer mon secret ?',
			'faq.changeSecretA' => ({required Object action}) => 'Ouvrez Paramètres et choisissez ${action}. Vous saisissez votre secret actuel et le nouveau ; votre coffre-fort est déchiffré, rechiffré avec le nouveau secret, puis réenregistré. Rien n’est perdu — chaque élément vous accompagne, et le changement s’applique sur chaque appareil dès qu’il recharge votre coffre-fort.',
			'faq.costQ' => 'Combien ça coûte ?',
			'faq.costA' => 'Rien. KeeperPass est gratuit et open source, et stocke les données dans l’espace cloud que vous avez déjà.',
			'faq.stillStuck' => 'Toujours bloqué ?',
			'faq.contactBody' => 'Une question, un retour ou un problème à signaler ? Écrivez-nous.',
			'about.version' => ({required Object version, required Object build}) => 'Version ${version} (${build})',
			'about.tagline' => 'Votre cloud. Vos clés. Votre coffre-fort.',
			'about.license' => 'Gratuit et open source sous AGPL-3.0',
			'about.terms' => 'Conditions d’utilisation',
			'about.privacy' => 'Politique de confidentialité',
			'about.promise' => 'Gratuit, sans piège : pas de formules, pas d’offre premium, pas de vente forcée.',
			'clipboard.clearsIn' => ({required Object time}) => 'S’efface dans ${time}',
			'clipboard.cleared' => 'Presse-papiers effacé',
			'sync.savedTo' => ({required Object storage}) => 'Enregistré dans ${storage}',
			'sync.notSavedTitle' => 'Votre coffre-fort n’a pas été enregistré',
			'sync.notSavedBody' => ({required Object storage}) => 'Impossible de joindre ${storage}. Votre modification est toujours là — réessayez avant de fermer KeeperPass.',
			'sync.dismiss' => 'Ignorer',
			'sync.retryingTitle' => 'Nouvelle tentative…',
			'sync.retryingBody' => ({required Object storage}) => 'Enregistrement dans ${storage}.',
			'sync.reconnectTitle' => ({required Object storage}) => 'Reconnectez-vous à ${storage}',
			'sync.keepReading' => 'Vous pouvez continuer à lire ; les modifications seront enregistrées dès votre retour.',
			'sync.reconnect' => 'Se reconnecter',
			'sync.later' => 'Plus tard',
			'sync.offlineBody' => ({required Object storage}) => 'Vous pouvez continuer à lire et à copier. L’enregistrement nécessite une connexion à ${storage}.',
			'sync.changedTitle' => 'Votre coffre-fort a changé',
			'sync.changedBody' => 'Une version plus récente de votre coffre-fort a été enregistrée depuis un autre appareil. Chargez-la avant de modifier, pour que rien ne soit écrasé.',
			'sync.twoVersions' => 'Deux versions',
			'sync.onThisPhone' => 'Sur ce téléphone',
			'sync.inStorage' => ({required Object storage}) => 'Dans ${storage}',
			'sync.loadedAt' => ({required Object time}) => 'chargée : ${time}',
			'sync.savedNewer' => ({required Object time}) => 'enregistrée : ${time} · plus récente',
			'sync.loadLatest' => 'Charger la dernière version',
			'sync.notNow' => 'Pas maintenant',
			'sync.pausedNote' => 'D’ici là, vous pouvez lire et copier, mais pas modifier.',
			'sync.upToDate' => 'À jour',
			'sync.loadedVersion' => ({required Object time}) => 'Version enregistrée à ${time} chargée',
			'scan.title' => 'Scanner le code QR',
			'scan.primerTitle' => 'Ajouter un code 2FA en scannant',
			'scan.primerBody' => 'Quand un site active la connexion à deux facteurs, il affiche un code QR. KeeperPass le lit avec l’appareil photo et garde la clé de configuration dans votre coffre-fort, pour que ses codes apparaissent dans Codes.',
			'scan.primerPrivacy' => 'L’appareil photo ne fait que lire le code. Rien n’est enregistré et aucune image n’est conservée.',
			'scan.primerNext' => 'Votre téléphone va ensuite demander l’accès à l’appareil photo.',
			'scan.enterInstead' => 'Saisir plutôt la clé de configuration',
			'scan.hint' => 'Visez le code QR que le site affiche\nquand vous activez la connexion à deux facteurs.',
			'scan.torch' => 'Allumer la lampe',
			'scan.cameraView' => 'Vue de l’appareil photo',
			'scan.codeFound' => 'Code trouvé',
			'scan.saveTo' => 'L’enregistrer dans',
			'scan.existingItem' => 'Élément existant',
			'scan.existingItemWith' => ({required Object summary}) => 'Élément existant · ${summary}',
			'scan.newAuthenticator' => 'Nouvel élément Authentificateur',
			'scan.named' => ({required Object name}) => 'Nommé ${name}',
			'scan.cameraOffTitle' => 'L’accès à l’appareil photo est désactivé',
			'scan.cameraOffBody' => 'KeeperPass n’a besoin de l’appareil photo que pour lire les codes QR. Activez-le dans les réglages, ou saisissez plutôt la clé de configuration.',
			'scan.openSettings' => 'Ouvrir les réglages',
			'scan.unsupported' => 'Ce code utilise des réglages que KeeperPass ne prend pas encore en charge',
			'scan.notACode' => 'Ce n’est pas un code QR 2FA',
			'scan.cameraFailed' => 'Impossible de démarrer l’appareil photo',
			'scan.item' => 'Élément',
			'scan.codeSettings' => '6 chiffres · toutes les 30 secondes · SHA-1',
			'scan.codeAdded' => ({required Object name}) => 'Code ajouté à ${name}',
			'scan.tapToCopy' => 'Touchez la carte pour le copier.',
			_ => null,
		};
	}
}
