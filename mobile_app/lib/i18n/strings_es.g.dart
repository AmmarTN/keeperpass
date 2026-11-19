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
class TranslationsEs extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$es app = _Translations$app$es._(_root);
	@override late final _Translations$connectivity$es connectivity = _Translations$connectivity$es._(_root);
	@override late final _Translations$errors$es errors = _Translations$errors$es._(_root);
	@override late final _Translations$common$es common = _Translations$common$es._(_root);
	@override late final _Translations$strength$es strength = _Translations$strength$es._(_root);
	@override late final _Translations$totp$es totp = _Translations$totp$es._(_root);
	@override late final _Translations$settings$es settings = _Translations$settings$es._(_root);
	@override late final _Translations$auth$es auth = _Translations$auth$es._(_root);
	@override late final _Translations$vaults$es vaults = _Translations$vaults$es._(_root);
	@override late final _Translations$welcome$es welcome = _Translations$welcome$es._(_root);
	@override late final _Translations$connect$es connect = _Translations$connect$es._(_root);
	@override late final _Translations$howItWorks$es howItWorks = _Translations$howItWorks$es._(_root);
	@override late final _Translations$technicalDetails$es technicalDetails = _Translations$technicalDetails$es._(_root);
	@override late final _Translations$createVault$es createVault = _Translations$createVault$es._(_root);
	@override late final _Translations$unlock$es unlock = _Translations$unlock$es._(_root);
	@override late final _Translations$newVault$es newVault = _Translations$newVault$es._(_root);
	@override late final _Translations$tabs$es tabs = _Translations$tabs$es._(_root);
	@override late final _Translations$codes$es codes = _Translations$codes$es._(_root);
	@override late final _Translations$comingSoon$es comingSoon = _Translations$comingSoon$es._(_root);
	@override late final _Translations$vaultList$es vaultList = _Translations$vaultList$es._(_root);
	@override late final _Translations$itemDetail$es itemDetail = _Translations$itemDetail$es._(_root);
	@override late final _Translations$editItem$es editItem = _Translations$editItem$es._(_root);
	@override late final _Translations$generator$es generator = _Translations$generator$es._(_root);
	@override late final _Translations$report$es report = _Translations$report$es._(_root);
	@override late final _Translations$audit$es audit = _Translations$audit$es._(_root);
	@override late final _Translations$myVaults$es myVaults = _Translations$myVaults$es._(_root);
	@override late final _Translations$tags$es tags = _Translations$tags$es._(_root);
	@override late final _Translations$changeSecret$es changeSecret = _Translations$changeSecret$es._(_root);
	@override late final _Translations$storage$es storage = _Translations$storage$es._(_root);
	@override late final _Translations$moveVault$es moveVault = _Translations$moveVault$es._(_root);
	@override late final _Translations$dataIo$es dataIo = _Translations$dataIo$es._(_root);
	@override late final _Translations$archive$es archive = _Translations$archive$es._(_root);
	@override late final _Translations$help$es help = _Translations$help$es._(_root);
	@override late final _Translations$faq$es faq = _Translations$faq$es._(_root);
	@override late final _Translations$about$es about = _Translations$about$es._(_root);
	@override late final _Translations$clipboard$es clipboard = _Translations$clipboard$es._(_root);
	@override late final _Translations$sync$es sync = _Translations$sync$es._(_root);
	@override late final _Translations$scan$es scan = _Translations$scan$es._(_root);
}

// Path: app
class _Translations$app$es extends Translations$app$en {
	_Translations$app$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'KeeperPass';
}

// Path: connectivity
class _Translations$connectivity$es extends Translations$connectivity$en {
	_Translations$connectivity$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get offline => 'Sin conexión a internet';
	@override String get online => 'De nuevo en línea';
}

// Path: errors
class _Translations$errors$es extends Translations$errors$en {
	_Translations$errors$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$errors$failures$es failures = _Translations$errors$failures$es._(_root);
	@override late final _Translations$errors$drive$es drive = _Translations$errors$drive$es._(_root);
	@override late final _Translations$errors$dropbox$es dropbox = _Translations$errors$dropbox$es._(_root);
	@override late final _Translations$errors$auth$es auth = _Translations$errors$auth$es._(_root);
	@override late final _Translations$errors$masterPassword$es masterPassword = _Translations$errors$masterPassword$es._(_root);
	@override late final _Translations$errors$vault$es vault = _Translations$errors$vault$es._(_root);
}

// Path: common
class _Translations$common$es extends Translations$common$en {
	_Translations$common$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get close => 'Cerrar';
	@override String get copy => 'Copiar';
	@override String get copied => 'Copiado';
	@override String get cancel => 'Cancelar';
	@override String get save => 'Guardar';
	@override String get back => 'Atrás';
	@override String get favorite => 'Favorito';
	@override String get showSecret => 'Mostrar secreto';
	@override String get hideSecret => 'Ocultar secreto';
	@override String get empty => '[vacío]';
	@override String get clearSearch => 'Borrar la búsqueda';
	@override String get chooseDate => 'Elige una fecha';
	@override String get chooseMonth => 'Elige un mes';
	@override String get countryCode => 'Código de país';
	@override String countryCodeValue({required Object country, required Object code}) => 'Código de país: ${country}, ${code}';
	@override String removeTag({required Object tag}) => 'Quitar la etiqueta ${tag}';
	@override String get secretChip => 'Secreto';
	@override String secretToggle({required Object field}) => 'Secreto: ${field}';
	@override String reorderField({required Object field}) => 'Reordenar ${field}';
	@override String removeField({required Object field}) => 'Quitar ${field}';
	@override String changeFieldIcon({required Object field}) => 'Cambiar el icono de ${field}';
	@override String showAll({required Object count}) => 'Mostrar los ${count}';
	@override String get showInLargeType => 'Mostrar en letra grande';
	@override String stepOf({required Object current, required Object total}) => 'Paso ${current} de ${total}';
	@override String get next => 'Siguiente';
	@override String get continueAction => 'Continuar';
	@override String get tryAgain => 'Intentar de nuevo';
	@override String get retry => 'Reintentar';
	@override String get show => 'Mostrar';
	@override String get hide => 'Ocultar';
	@override String get gotIt => 'Entendido';
	@override String get disconnect => 'Desconectar';
	@override String get generateSecret => 'Generar un secreto';
	@override String get useAnotherAccount => 'Usar otra cuenta';
	@override String get offlineTitle => 'Estás sin conexión';
	@override String savingTo({required Object provider}) => 'Guardando en ${provider}…';
	@override String get keepOpen => 'Mantén KeeperPass abierto hasta que termine.';
	@override String get typeItAgain => 'Escríbelo de nuevo';
	@override String get secretHiddenValue => 'Oculto';
	@override String get rename => 'Renombrar';
	@override String get done => 'Listo';
}

// Path: strength
class _Translations$strength$es extends Translations$strength$en {
	_Translations$strength$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get veryWeak => 'Muy débil';
	@override String get weak => 'Débil';
	@override String get fair => 'Aceptable';
	@override String get strong => 'Fuerte';
	@override String get veryStrong => 'Muy fuerte';
	@override String meter({required Object level}) => 'Fortaleza: ${level}';
}

// Path: totp
class _Translations$totp$es extends Translations$totp$en {
	_Translations$totp$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get invalidCode => 'Código no válido';
	@override String get invalidKey => 'La clave de configuración no es válida, así que no se puede generar ningún código.';
	@override String get fixInEdit => 'Corrígelo en Editar';
	@override String secondsShort({required Object count}) => '${count} s';
	@override String secondsLeft({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(count,
		one: 'Queda ${count} segundo',
		other: 'Quedan ${count} segundos',
	);
}

// Path: settings
class _Translations$settings$es extends Translations$settings$en {
	_Translations$settings$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$settings$migrate$es migrate = _Translations$settings$migrate$es._(_root);
	@override String get title => 'Ajustes';
	@override String get subtitle => 'Cuenta, idioma, seguridad y datos';
	@override String get account => 'Cuenta';
	@override String accountLine({required Object email, required Object storage}) => '${email} · ${storage}';
	@override String get accountNote => 'El nombre y el correo electrónico proceden de la cuenta con la que iniciaste sesión.';
	@override String get logOut => 'Cerrar sesión';
	@override String get logOutTitle => '¿Cerrar sesión?';
	@override String logOutBody({required Object storage, required Object provider}) => 'Tu caja fuerte se queda cifrada en tu ${storage}. Para volver a abrirla, inicia sesión con ${provider} e introduce tu secreto.';
	@override String get security => 'Seguridad';
	@override String get lockNow => 'Bloquear ahora';
	@override String get autoLock => 'Bloqueo automático';
	@override String get clearClipboard => 'Borrar portapapeles';
	@override String get hideInSwitcher => 'Ocultar en el selector de apps';
	@override String get hideInSwitcherNote => 'Muestra una pantalla de privacidad en lugar de tu caja fuerte';
	@override String get changeSecret => 'Cambiar secreto';
	@override String get securityNote => 'Al bloquear, la caja fuerte descifrada se borra de la memoria de este teléfono.';
	@override String get appearance => 'Apariencia';
	@override String get theme => 'Tema';
	@override String get themeAuto => 'Auto';
	@override String get themeLight => 'Claro';
	@override String get themeDark => 'Oscuro';
	@override String get language => 'Idioma';
	@override String get storage => 'Almacenamiento';
	@override String get whereItLives => 'Dónde vive tu caja fuerte';
	@override String moveTo({required Object storage}) => 'Mover la caja fuerte a ${storage}';
	@override String get data => 'Datos';
	@override String get importCsv => 'Importar CSV';
	@override String get exportCsv => 'Exportar CSV';
	@override String get recentExports => 'Exportaciones recientes';
	@override String get help => 'Ayuda';
	@override String get howItWorks => 'Cómo funciona KeeperPass';
	@override String get questions => 'Preguntas';
	@override String get about => 'Acerca de KeeperPass';
	@override String get dangerZone => 'Zona de peligro';
	@override String get archive => 'Archivar caja fuerte y cerrar sesión';
	@override String get archiveNote => 'Cambia el nombre del archivo de tu caja fuerte y cierra tu sesión. No se borra nada.';
	@override String footer({required Object version}) => 'KeeperPass ${version} · Gratis y de código abierto bajo AGPL-3.0';
	@override String get autoLockTitle => 'Bloqueo automático';
	@override String get autoLockImmediately => 'Inmediatamente al salir de la app';
	@override String get autoLockImmediatelyShort => 'Inmediatamente';
	@override String get after1Minute => 'Después de 1 minuto';
	@override String get after5Minutes => 'Después de 5 minutos';
	@override String get after10Minutes => 'Después de 10 minutos';
	@override String get autoLockNote => 'KeeperPass se bloquea tras este tiempo sin uso. Para volver a desbloquearlo necesitas tu secreto.';
	@override String get clearClipboardTitle => 'Borrar portapapeles';
	@override String get after30Seconds => 'Después de 30 segundos';
	@override String get after2Minutes => 'Después de 2 minutos';
	@override String get never => 'Nunca';
	@override String get after30s => 'Tras 30 s';
	@override String get after1Min => 'Tras 1 min';
	@override String get after2Min => 'Tras 2 min';
	@override String get clipboardNote => 'Las contraseñas y los códigos que copies se borran del portapapeles pasado este tiempo, si no has copiado nada más desde entonces.';
	@override String get preview => 'Vista previa';
	@override String get previewFrom => 'De GitHub';
	@override String previewClears({required Object time}) => 'De GitHub · Se borra en ${time}';
	@override String seconds({required Object n}) => '${n} s';
	@override String minutes({required Object n}) => '${n} min';
	@override String get languageTitle => 'Idioma';
	@override String get languageNote => 'Se guarda solo en este teléfono — no forma parte de tu caja fuerte.';
	@override String get hideInSwitcherBlocks => 'Muestra una pantalla de privacidad en lugar de tu caja fuerte y bloquea las capturas de pantalla';
	@override String get blockScreenshots => 'Bloquear capturas de pantalla';
	@override String get blockScreenshotsNote => 'Solo Android · también bloquea la grabación de pantalla';
	@override String get blockScreenshotsWhileHidden => 'Activado mientras «Ocultar en el selector de apps» esté activado';
}

// Path: auth
class _Translations$auth$es extends Translations$auth$en {
	_Translations$auth$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$auth$unlock$es unlock = _Translations$auth$unlock$es._(_root);
}

// Path: vaults
class _Translations$vaults$es extends Translations$vaults$en {
	_Translations$vaults$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get defaultName => 'Mi caja fuerte';
}

// Path: welcome
class _Translations$welcome$es extends Translations$welcome$en {
	_Translations$welcome$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get howItWorks => 'Cómo funciona';
	@override String get badge => 'Cifrado de extremo a extremo';
	@override String get title => 'Bienvenido a KeeperPass';
	@override String get description => 'Tu caja fuerte es un único archivo cifrado en tu propio almacenamiento en la nube. Inicia sesión para abrirla.';
	@override String get fileTag => 'Lo que ve tu almacenamiento';
	@override String get fileMeta => 'Argon2id · AES-256-GCM';
	@override String get continueWithGoogle => 'Continuar con Google';
	@override String get continueWithDropbox => 'Continuar con Dropbox';
	@override String connecting({required Object provider}) => 'Conectando con ${provider}…';
	@override String get factAccess => 'Acceso solo a los archivos que crea KeeperPass';
	@override String get factEncrypted => 'Cifrado en este teléfono, con tu propio secreto';
	@override String get factNoServer => 'Sin servidor de KeeperPass. Nada va a ningún otro sitio.';
	@override String get footer => 'Sin cuenta de KeeperPass: solo la de Google o Dropbox que ya tienes. Al iniciar sesión se crea el archivo de la caja fuerte si aún no lo tienes.';
}

// Path: connect
class _Translations$connect$es extends Translations$connect$en {
	_Translations$connect$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String lookingIn({required Object storage}) => 'Buscando en ${storage}…';
	@override String get checkingTitle => 'Comprobando tu caja fuerte…';
	@override String checkingDetail({required Object storage}) => 'Buscando vault.json.enc en ${storage}.';
	@override String get foundTitle => 'Hemos encontrado tu caja fuerte';
	@override String get foundDetail => 'Abriendo el desbloqueo…';
	@override String foundMeta({required Object storage}) => 'Encontrado en ${storage}';
	@override String foundMetaUpdated({required Object storage, required Object time}) => 'Encontrado en ${storage} · actualizado ${time}';
	@override String get canceledDetail => 'No se conectó nada.';
	@override String get signInFailed => 'Error al iniciar sesión';
	@override String get offlineDetail => 'Para iniciar sesión hace falta conexión con Google o Dropbox. Se actualizará solo cuando vuelvas a estar en línea.';
	@override String get welcomeBack => 'Hola de nuevo,';
	@override String expiredDetail({required Object provider}) => 'Tu sesión de ${provider} ha caducado. Vuelve a iniciar sesión para desbloquear tu caja fuerte.';
	@override String get lastUsed => 'Usada por última vez';
	@override String checkFailedMeta({required Object storage}) => 'No se pudo leer desde ${storage}';
	@override String get checkFailedTitle => 'No se pudo leer tu caja fuerte';
	@override String checkFailedDetail({required Object storage}) => '${storage} no respondió. No se cambió nada.';
}

// Path: howItWorks
class _Translations$howItWorks$es extends Translations$howItWorks$en {
	_Translations$howItWorks$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get step1Title => 'Tu caja fuerte vive\nen tu nube';
	@override String get step1Body => 'KeeperPass guarda un único archivo cifrado en tu Google Drive o Dropbox. No hay ningún servidor de KeeperPass, así que nunca recibimos una copia.';
	@override String get encrypted => 'Cifrado';
	@override String get step2Title => 'Elige un secreto';
	@override String get step2Body => 'Se convierte en la llave. Nunca se envía ni se guarda.';
	@override String get step3Title => 'Hacen falta los dos';
	@override String get step3Body => 'Quien tenga tu cuenta de almacenamiento no puede leer tu caja fuerte. Quien tenga tu secreto no puede llegar a ella.';
	@override String get storageAccount => 'Cuenta de almacenamiento';
	@override String get reachesFile => 'Llega al archivo';
	@override String get yourSecret => 'Tu secreto';
	@override String get opensFile => 'Abre el archivo';
	@override String get technicalDetails => 'Detalles técnicos';
	@override String get technicalSummary => 'Argon2id · AES-256';
}

// Path: technicalDetails
class _Translations$technicalDetails$es extends Translations$technicalDetails$en {
	_Translations$technicalDetails$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalles técnicos';
	@override String get keyDerivation => 'Derivación de la clave';
	@override TextSpan keyDerivationValue({required InlineSpan algorithm}) => TextSpan(children: [
		algorithm,
		const TextSpan(text: ' · 64 MiB de memoria · 3 iteraciones · paralelismo 4, que generan una clave de 256 bits'),
	]);
	@override String get encryption => 'Cifrado';
	@override TextSpan encryptionValue({required InlineSpan algorithm}) => TextSpan(children: [
		algorithm,
		const TextSpan(text: ', que también detecta cualquier cambio en el archivo'),
	]);
	@override String get googleDrive => 'Google Drive';
	@override TextSpan googleDriveValue({required InlineSpan scope}) => TextSpan(children: [
		const TextSpan(text: 'El ámbito '),
		scope,
		const TextSpan(text: ': solo los archivos que creó KeeperPass'),
	]);
	@override String get dropbox => 'Dropbox';
	@override TextSpan dropboxValue({required InlineSpan folder}) => TextSpan(children: [
		const TextSpan(text: 'Una carpeta de la app: '),
		folder,
	]);
	@override String get vaultFile => 'Archivo de la caja fuerte';
	@override TextSpan vaultFileValue({required InlineSpan file}) => TextSpan(children: [
		file,
		const TextSpan(text: ': un único archivo, cifrado y reescrito de nuevo en cada guardado'),
	]);
	@override String get viewSource => 'Ver el código fuente en GitHub';
	@override String get license => 'Gratis y de código abierto bajo AGPL-3.0, así que todo esto se puede comprobar.';
}

// Path: createVault
class _Translations$createVault$es extends Translations$createVault$en {
	_Translations$createVault$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'Crea tu caja fuerte';
	@override String get step1Title => 'Elige tu secreto';
	@override String get step1Body => 'Cifra tu caja fuerte en este teléfono. Todo lo que guardes queda protegido con él.';
	@override String get settingUpFor => 'Configurando para';
	@override String get secret => 'Secreto';
	@override String get secretPlaceholder => 'Tu secreto';
	@override String get generateAnother => 'Generar otro';
	@override String get generatedNote => 'Los secretos generados se saltan el paso de volver a escribirlos.';
	@override String get weakWarning => 'Este secreto es débil, lo que facilita romper el cifrado de tu caja fuerte. Puedes continuar, pero se recomienda encarecidamente una frase más larga.';
	@override String get tipsTitle => 'Elegir un buen secreto';
	@override String get tip1 => 'Varias palabras al azar valen más que una palabra ingeniosa: cuanto más largo, más difícil de adivinar.';
	@override String get tip2 => 'No reutilices una contraseña que uses en otro sitio.';
	@override String get tip3 => 'Que sea algo que puedas escribir en este teléfono; luego apúntalo y guárdalo en un lugar seguro.';
	@override String get step2Title => 'Escríbelo de nuevo';
	@override String get step2Body => 'Solo para asegurarnos de que no hay errores. Nadie puede restablecer tu secreto más tarde.';
	@override String get repeat => 'Repite el secreto';
	@override String get mismatch => 'Los dos secretos no coinciden.';
	@override String get step3Title => 'Apúntalo';
	@override String get step3Body => 'Lo necesitarás cada vez que desbloquees. Guárdalo en un lugar seguro, lejos de este teléfono.';
	@override String secretWords({required Object count}) => 'Tu secreto · ${count} palabras';
	@override String get secretWhole => 'Tu secreto';
	@override String get secretHidden => 'Tu secreto, oculto';
	@override String get secretShown => 'Tu secreto, visible';
	@override String get readBefore => 'Lee esto antes de continuar';
	@override String get bullet1 => 'Tu secreto nunca se envía a ningún sitio ni se guarda. Nadie —ni KeeperPass ni tu proveedor de almacenamiento— puede consultarlo ni restablecerlo.';
	@override String get bullet2 => 'Si lo olvidas, tu caja fuerte no se puede recuperar. Ningún enlace de restablecimiento ni solicitud de soporte puede abrirla.';
	@override String get bullet3 => 'Anótalo y guárdalo en un lugar seguro antes de continuar.';
	@override String get acknowledge => 'He apuntado mi secreto';
	@override String get create => 'Crear caja fuerte';
	@override String get progressTitle => 'Creando tu caja fuerte';
	@override String get encrypting => 'Cifrando tu caja fuerte…';
	@override String get encryptingDetail => 'En este teléfono. Tarda unos segundos.';
	@override String get encryptingMeta => 'Cifrando en este teléfono…';
	@override String get savingDetail => 'Un único archivo cifrado, en la carpeta keeperpass.';
	@override String get failedTitle => 'No se pudo guardar tu caja fuerte';
	@override String get notSaved => 'No guardado';
	@override String failedDetail({required Object storage}) => '${storage} no respondió. No se guardó nada y tu secreto sigue aquí.';
	@override String get backToSecret => 'Volver a tu secreto';
}

// Path: unlock
class _Translations$unlock$es extends Translations$unlock$en {
	_Translations$unlock$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get notYou => '¿No eres tú?';
	@override String get secret => 'Secreto';
	@override String get placeholder => 'Introduce tu secreto';
	@override String get unlock => 'Desbloquear';
	@override String get unlocking => 'Desbloqueando…';
	@override String get unlockingStatus => 'Desbloqueando en este teléfono…';
	@override String get slowNote => 'Unos segundos, a propósito: así adivinar tu secreto es lento.';
	@override String get forgot => '¿Olvidaste tu secreto?';
	@override String get leftApp => 'Bloqueado al salir de KeeperPass';
	@override String unreachableTitle({required Object storage}) => 'No se pudo conectar con ${storage}';
	@override String get unreachableDetail => 'Comprueba tu conexión e inténtalo de nuevo. Tu secreto sigue escrito.';
	@override String offlineDetail({required Object storage}) => 'Para desbloquear hace falta conexión con ${storage}. «Desbloquear» se activará cuando vuelvas a estar en línea.';
	@override String accountLine({required Object email, required Object storage}) => '${email} · ${storage}';
	@override String lockedInactivity({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Bloqueado tras ${n} minuto de inactividad',
		other: 'Bloqueado tras ${n} minutos de inactividad',
	);
}

// Path: newVault
class _Translations$newVault$es extends Translations$newVault$en {
	_Translations$newVault$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get backLabel => 'Desbloquear';
	@override String get backToUnlock => 'Volver a desbloqueo';
	@override String get title => 'Empezar una caja fuerte nueva';
	@override String get oldMeta => 'Caja fuerte antigua · bloqueada con el secreto anterior';
	@override String get newMeta => 'Caja fuerte nueva · vacía';
	@override String body({required Object provider}) => 'No hay forma de restablecer un secreto olvidado: ni KeeperPass ni ${provider} pueden hacerlo. En su lugar, puedes empezar de nuevo con una caja fuerte nueva y vacía.';
	@override String get pointLocked => 'Tu caja fuerte actual sigue bloqueada con el secreto anterior.';
	@override TextSpan pointKept({required InlineSpan file, required InlineSpan storage}) => TextSpan(children: [
		const TextSpan(text: 'Su archivo se conserva como '),
		file,
		const TextSpan(text: ' en tu '),
		storage,
		const TextSpan(text: '. No se borra nada.'),
	]);
	@override String get pointFresh => 'Empiezas de nuevo con una caja fuerte nueva y vacía.';
	@override String get account => 'Cuenta';
	@override String get newSecret => 'Nuevo secreto';
	@override String get newSecretPlaceholder => 'Elige un secreto nuevo';
	@override String get repeat => 'Repite el nuevo secreto';
	@override String get weakWarning => 'Este secreto es débil, lo que facilita romper el cifrado de tus cajas fuertes. Puedes continuar, pero se recomienda encarecidamente una frase más larga.';
	@override String get warn => 'Como el anterior, tu secreto nuevo no se puede consultar ni restablecer. Apúntalo antes de continuar.';
	@override String get start => 'Empezar una caja fuerte nueva';
	@override String get confirmTitle => '¿Empezar una caja fuerte nueva?';
	@override String confirmKept({required Object storage}) => 'Su archivo se conserva como copia de seguridad con fecha en tu ${storage}.';
	@override String get confirmFresh => 'Empiezas de nuevo con una caja fuerte vacía protegida con tu secreto nuevo.';
	@override String get progressTitle => 'Empezando una caja fuerte nueva';
	@override String get encrypting => 'Cifrando tu caja fuerte nueva…';
	@override String get backingUp => 'Guardando tu caja fuerte antigua como copia de seguridad…';
	@override String backingUpDetail({required Object storage}) => 'Cambiándole el nombre en ${storage}.';
	@override String get readyMeta => 'Cifrada · lista para guardar';
	@override String get backupFailedMeta => 'No se pudo renombrar · no cambió nada';
	@override String get nothingChanged => 'No se cambió nada';
	@override String backupFailedDetail({required Object storage}) => 'No se pudo hacer una copia de seguridad de tu caja fuerte actual en ${storage}. No se cambió nada.';
	@override String get doneTitle => 'Caja fuerte nueva creada';
	@override String doneDetail({required Object storage}) => 'Tu caja fuerte antigua se conserva como copia de seguridad en ${storage}.';
}

// Path: tabs
class _Translations$tabs$es extends Translations$tabs$en {
	_Translations$tabs$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get vault => 'Caja fuerte';
	@override String get codes => 'Códigos';
	@override String get generator => 'Generador';
	@override String get security => 'Seguridad';
	@override String get settings => 'Ajustes';
	@override String securityFlagged({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Seguridad, ${n} elemento marcado',
		other: 'Seguridad, ${n} elementos marcados',
	);
}

// Path: codes
class _Translations$codes$es extends Translations$codes$en {
	_Translations$codes$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Códigos 2FA de tu caja fuerte, generados en este teléfono';
	@override String searchPlaceholder({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Buscar en ${n} código',
		other: 'Buscar en ${n} códigos',
	);
	@override String codeCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} código',
		other: '${n} códigos',
	);
	@override String get copied => 'Código copiado';
	@override String get trust => 'Generados en este teléfono a partir de las claves de configuración de tu caja fuerte. No se guarda nada nuevo.';
	@override String get emptyTitle => 'Aún no hay códigos 2FA';
	@override String get emptyBody => 'Cuando un sitio ofrezca el inicio de sesión en dos pasos, escanea aquí su código QR o añade un elemento Autenticador.';
	@override String get createAuthenticator => 'Crear un elemento Autenticador';
}

// Path: comingSoon
class _Translations$comingSoon$es extends Translations$comingSoon$en {
	_Translations$comingSoon$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String body({required Object part}) => 'Llega en la parte ${part}.';
}

// Path: vaultList
class _Translations$vaultList$es extends Translations$vaultList$en {
	_Translations$vaultList$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get lock => 'Bloquear';
	@override String get newItem => 'Nuevo elemento';
	@override String get allVaults => 'Todas las cajas fuertes';
	@override String get favorites => 'Favoritos';
	@override String get recentlyUsed => 'Usados recientemente';
	@override String statusSaved({required Object items, required Object storage}) => '${items} · Guardado en ${storage}';
	@override String statusInVault({required Object items, required Object vault}) => '${items} en ${vault}';
	@override String statusTagged({required Object items, required Object tag}) => '${items} con la etiqueta ${tag}';
	@override String statusReport({required Object items, required Object report}) => '${items} · ${report}';
	@override String statusNotConnected({required Object storage}) => 'Sin conexión con ${storage}';
	@override String statusOffline({required Object items}) => 'Sin conexión · ${items}';
	@override String get reportWeak => 'Contraseñas débiles';
	@override String get reportReused => 'Contraseñas reutilizadas';
	@override String get reportCompromised => 'Contraseñas comprometidas';
	@override String get searchHint => 'Cada palabra tiene que coincidir, en cualquier orden: nombres, etiquetas, nombres de campo y valores.';
	@override String get filterByTag => 'Filtrar por etiqueta';
	@override String get manageTags => 'Gestionar etiquetas';
	@override String get clearFilter => 'Quitar filtro';
	@override String get today => 'Hoy';
	@override String get thisWeek => 'Esta semana';
	@override String get earlier => 'Anteriores';
	@override String get aToZ => 'De la A a la Z';
	@override String get sortHeading => 'Ordenar por última actualización';
	@override String get newestFirst => 'Más recientes primero';
	@override String get oldestFirst => 'Más antiguos primero';
	@override String refreshing({required Object storage}) => 'Leyendo tu caja fuerte desde ${storage}…';
	@override String copyPasswordFor({required Object name}) => 'Copiar la contraseña de ${name}';
	@override String copyCodeFor({required Object name}) => 'Copiar el código de ${name}';
	@override String copyCardNumberFor({required Object name}) => 'Copiar el número de tarjeta de ${name}';
	@override String get swipePassword => 'Contraseña';
	@override String get swipeCode => 'Código';
	@override String get swipeCardNumber => 'Número de tarjeta';
	@override String get swipeUsername => 'Usuario';
	@override String get swipeMore => 'Más';
	@override String get copyPassword => 'Copiar contraseña';
	@override String get copyCode => 'Copiar código';
	@override String get copyCardNumber => 'Copiar número de tarjeta';
	@override String get copyUsername => 'Copiar usuario';
	@override String get moreActions => 'Más acciones';
	@override String get favorite => 'Favorito';
	@override String get addToFavorites => 'Añadir a favoritos';
	@override String get removeFromFavorites => 'Quitar de favoritos';
	@override String get findingWeak => 'Contraseña débil';
	@override String get findingReused => 'Contraseña reutilizada';
	@override String get findingCompromised => 'Contraseña comprometida';
	@override String get findingWeakReused => 'Contraseña débil y reutilizada';
	@override String get findingWeakCompromised => 'Contraseña débil y comprometida';
	@override String get findingReusedCompromised => 'Contraseña reutilizada y comprometida';
	@override String get findingAll => 'Contraseña débil, reutilizada y comprometida';
	@override String get unnamed => 'Nuevo elemento';
	@override String get scopeTitle => 'Cajas fuertes';
	@override String get manageVaults => 'Gestionar cajas fuertes';
	@override String scopeNote({required Object storage}) => 'Todas tus cajas fuertes están en un único archivo cifrado, vault.json.enc, en tu ${storage}.';
	@override String quickActions({required Object name}) => '${name}, acciones rápidas';
	@override String get openWebsite => 'Abrir sitio web';
	@override String get moveToVault => 'Mover a una caja fuerte…';
	@override String get select => 'Seleccionar';
	@override String get delete => 'Eliminar';
	@override String get selectAll => 'Seleccionar todo';
	@override String get selectOrDeselectAll => 'Seleccionar o deseleccionar todo';
	@override String listTwo({required Object a, required Object b}) => '${a} y ${b}';
	@override String listThree({required Object a, required Object b, required Object c}) => '${a}, ${b} y ${c}';
	@override String get deleteItemTitle => 'Eliminar elemento';
	@override String deleteItemConfirm({required Object name}) => '¿Seguro que quieres eliminar «${name}»? Esto no se puede deshacer.';
	@override String get deleteItemAction => 'Eliminar elemento';
	@override String get moveToVaultTitle => 'Mover a otra caja fuerte';
	@override String get moveDescription => 'Elige la caja fuerte en la que debería estar este elemento.';
	@override String get current => 'Actual';
	@override String get newVaultOption => 'Nueva caja fuerte…';
	@override String get noOtherVaultOne => 'No hay otra caja fuerte a la que mover este elemento.';
	@override String get noOtherVaultMany => 'No hay otra caja fuerte a la que mover estos elementos.';
	@override String get noOtherVaultDetail => 'Una segunda caja fuerte mantiene un conjunto de elementos aparte — trabajo separado de lo personal, o lo compartido de lo privado.';
	@override String get createAVault => 'Crear una caja fuerte';
	@override String get newVaultTitle => 'Nueva caja fuerte';
	@override String get newVaultBody => 'Una caja fuerte es un grupo aparte de elementos. A diferencia de un elemento, no hay nada más que elegir de entrada.';
	@override String get vaultName => 'Nombre de la caja fuerte';
	@override String get duplicateVault => 'Ya existe una caja fuerte con este nombre.';
	@override String get noItemsTitle => 'Todavía no tienes ningún elemento.';
	@override String get noItemsBody => 'Añade tu primer inicio de sesión, tarjeta o nota. Cada uno se cifra en este teléfono antes de guardarse.';
	@override String get importCsv => 'Importar desde CSV';
	@override String get vaultReady => 'Tu caja fuerte está lista. Todavía no hay nada.';
	@override String savedMeta({required Object storage, required Object items}) => 'Guardado en ${storage} · ${items}';
	@override String get vaultEmptyTitle => 'Esta caja fuerte todavía no tiene elementos.';
	@override String vaultEmptyBody({required Object vault}) => 'Añade uno aquí o mueve elementos desde ${vault}.';
	@override String get noFavoritesTitle => 'Todavía no tienes ningún favorito.';
	@override String get noFavoritesBody => 'Toca la estrella de cualquier elemento para tenerlo aquí.';
	@override String get nothingRecentTitle => 'Todavía no has usado nada';
	@override String get nothingRecentBody => 'Los elementos que abres o de los que copias aparecen aquí, los más recientes primero.';
	@override String get noResultsTitle => 'Tu búsqueda no coincide con ningún elemento.';
	@override String get noResultsBody => 'Cada palabra tiene que coincidir. Prueba con menos palabras o revisa la ortografía.';
	@override String get allClearWeak => 'Todas las contraseñas de tu caja fuerte son suficientemente seguras.';
	@override String get allClearReused => 'Cada contraseña de tu caja fuerte se usa exactamente una vez.';
	@override String get allClearCompromised => 'Ninguna de tus contraseñas apareció en una filtración conocida.';
	@override String get allClearBody => 'Aquí no hay nada que arreglar. KeeperPass vuelve a comprobarlo cada vez que cambia una contraseña.';
	@override String get backToSecurity => 'Volver a Seguridad';
	@override String fieldCopied({required Object field}) => '${field} copiado';
	@override String copiedFrom({required Object item}) => 'De ${item}';
	@override String itemCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} elemento',
		other: '${n} elementos',
	);
	@override String statusNotSaved({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} cambio sin guardar',
		other: '${n} cambios sin guardar',
	);
	@override String searchPlaceholder({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Buscar en ${n} elemento',
		other: 'Buscar en ${n} elementos',
	);
	@override String results({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} resultado',
		other: '${n} resultados',
	);
	@override String selectedCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} seleccionado',
		other: '${n} seleccionados',
	);
	@override String moveItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Mover ${n} elemento',
		other: 'Mover ${n} elementos',
	);
	@override String moveItemsTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Mover ${n} elemento',
		other: 'Mover ${n} elementos',
	);
	@override String deleteItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Eliminar ${n} elemento',
		other: 'Eliminar ${n} elementos',
	);
	@override String deleteTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '¿Eliminar ${n} elemento?',
		other: '¿Eliminar ${n} elementos?',
	);
	@override String deleteFromVault({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${names} se eliminará de ${vault}. Esto no se puede deshacer.',
		other: '${names} se eliminarán de ${vault}. Esto no se puede deshacer.',
	);
	@override String deleteFromVaults({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${names} se eliminará. Esto no se puede deshacer.',
		other: '${names} se eliminarán. Esto no se puede deshacer.',
	);
	@override String moveLine({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${names} se mueve con su historial y sus etiquetas.',
		other: '${names} se mueven con su historial y sus etiquetas.',
	);
	@override String movedTitle({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${names} se movió a ${vault}',
		other: '${names} se movieron a ${vault}',
	);
	@override String movedDetail({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Conserva su historial y sus etiquetas.',
		other: 'Conservan su historial y sus etiquetas.',
	);
	@override String itemsOf({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${count} de ${n} elemento',
		other: '${count} de ${n} elementos',
	);
}

// Path: itemDetail
class _Translations$itemDetail$es extends Translations$itemDetail$en {
	_Translations$itemDetail$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get edit => 'Editar';
	@override String get editItem => 'Editar elemento';
	@override String get moreOptions => 'Más opciones';
	@override String updatedAgo({required Object ago}) => 'Actualizado ${ago}';
	@override String showTagged({required Object tag}) => 'Mostrar elementos con la etiqueta ${tag}';
	@override String get fields => 'Campos';
	@override String get noFields => 'Este elemento no tiene campos.';
	@override String get history => 'Historial';
	@override String get currentVersion => 'Versión actual';
	@override String todayAt({required Object time}) => 'Hoy, ${time}';
	@override String get unnamedField => 'Sin nombre';
	@override String copyField({required Object field}) => 'Copiar ${field}';
	@override String get revealValue => 'Mostrar valor';
	@override String get hideValue => 'Ocultar valor';
	@override String hiddenValue({required Object field}) => '${field}, oculto';
	@override String openSite({required Object site}) => 'Abrir ${site}';
	@override String get call => 'Llamar';
	@override String get message => 'Mensaje';
	@override String get checksumFail => 'Ese número no supera su suma de comprobación — probablemente uno de los dígitos sea incorrecto.';
	@override String get codeCardHint => 'Toca para copiar · también en la pestaña Códigos';
	@override String get copyAllCodes => 'Copiar todos los códigos';
	@override String copyCodeNumber({required Object n}) => 'Copiar código ${n}';
	@override String get cardFace => 'Tarjeta, número oculto';
	@override String cardFaceBrand({required Object brand}) => 'Tarjeta ${brand}, número oculto';
	@override String cardExpires({required Object date}) => 'caduca en ${date}';
	@override String get largeTypeTurn => 'Gira el teléfono para leerlo en una sola línea.';
	@override String get largeTypeHides => 'Se vuelve a ocultar al salir de esta pantalla.';
	@override String get earlierVersion => 'Versión anterior';
	@override String readOnly({required Object ago}) => '${ago} · solo lectura';
	@override String get changedSince => 'Cambiado desde entonces';
	@override String get restoreThisVersion => 'Restaurar esta versión';
	@override String get deleteVersion => 'Eliminar versión';
	@override String get restoreTitle => '¿Restaurar esta versión?';
	@override String restoreBody({required Object name, required Object date}) => '${name} vuelve a como estaba el ${date}. La versión actual se queda en su historial.';
	@override String get restore => 'Restaurar';
	@override String get deleteVersionTitle => 'Eliminar esta versión';
	@override String get deleteVersionConfirm => '¿Seguro que quieres eliminar esta versión del historial? Esto no se puede deshacer.';
	@override String get delete => 'Eliminar';
	@override String get notFound => 'Este elemento ya no existe.';
	@override String get notFoundHint => 'Puede que se haya eliminado desde otro dispositivo.';
	@override String get backToVault => 'Volver a la caja fuerte';
	@override String hiddenLines({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${field}, oculto, ${n} línea',
		other: '${field}, oculto, ${n} líneas',
	);
	@override String largeTypeLabel({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${field} en letra grande, ${n} carácter',
		other: '${field} en letra grande, ${n} caracteres',
	);
}

// Path: editItem
class _Translations$editItem$es extends Translations$editItem$en {
	_Translations$editItem$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get newVaultItem => 'Nuevo elemento de la caja fuerte';
	@override String get vault => 'Caja fuerte';
	@override String get template => 'Plantilla';
	@override String get templateNote => 'Las plantillas son solo un punto de partida: cambia el nombre, quita o añade campos cuando quieras.';
	@override late final _Translations$editItem$templates$es templates = _Translations$editItem$templates$es._(_root);
	@override late final _Translations$editItem$templateHints$es templateHints = _Translations$editItem$templateHints$es._(_root);
	@override late final _Translations$editItem$templateFields$es templateFields = _Translations$editItem$templateFields$es._(_root);
	@override late final _Translations$editItem$types$es types = _Translations$editItem$types$es._(_root);
	@override String get newItem => 'Nuevo elemento';
	@override String get editItem => 'Editar elemento';
	@override String get changeIcon => 'Cambiar icono';
	@override String get name => 'Nombre';
	@override String get namePlaceholder => 'p. ej., GitHub';
	@override String get tags => 'Etiquetas';
	@override String get addField => 'Añadir campo';
	@override String get addFieldTitle => 'Añadir campo';
	@override String get noFieldsTitle => 'Aún no hay campos';
	@override String get noFieldsBody => 'Añade cualquiera de los 16 tipos de campo: un número de póliza, un número de teléfono, un PIN.';
	@override String get fieldNamePlaceholder => 'Nombre del campo';
	@override String get addTag => 'Añadir una etiqueta';
	@override String get tagSuggestions => 'Sugerencias de etiquetas';
	@override String createTag({required Object name}) => 'Crear «${name}»';
	@override String get tagTooLong => 'Ese nombre es demasiado largo.';
	@override String get removeFieldTitle => '¿Seguro que quieres quitar este campo?';
	@override String removeFieldBody({required Object field, required Object item}) => '«${field}» y su valor desaparecen de ${item} al guardar.';
	@override String get remove => 'Quitar';
	@override String get discardTitle => '¿Descartar los cambios?';
	@override String discardBody({required Object name}) => 'Tus cambios en ${name} no se han guardado. Al descartarlos, el elemento queda como estaba.';
	@override String get discardNewTitle => '¿Descartar este elemento nuevo?';
	@override String get discardNewBody => 'No se ha guardado. Al descartarlo, se pierde.';
	@override String get discard => 'Descartar';
	@override String get usernamePlaceholder => 'Usuario o correo electrónico';
	@override String get passwordPlaceholder => 'Contraseña';
	@override String get valuePlaceholder => 'Escribe el valor aquí';
	@override String get ipHostPlaceholder => 'p. ej., 192.168.1.1, ::1 o db.ejemplo.com';
	@override String get recoveryCodesPlaceholder => 'Uno por línea — cualquier formato sirve';
	@override String get notEmail => 'Eso no parece una dirección de correo electrónico.';
	@override String get phoneNumber => 'Número de teléfono';
	@override String get searchCountries => 'Buscar países';
	@override String get noCountryMatch => 'Ningún país coincide.';
	@override String get generate => 'Generar';
	@override String get generatePassword => 'Generar una contraseña';
	@override String get currentCode => 'Código actual';
	@override String get scanQr => 'Escanear código QR';
	@override String get enterSetupKey => 'Introducir clave de configuración';
	@override String get setupKeyTitle => 'Introducir clave de configuración';
	@override String get setupKeyBody => 'Los sitios muestran una clave de configuración junto al código QR, a menudo en «¿No puedes escanearlo?».';
	@override String get setupKey => 'Clave de configuración';
	@override String get setupKeyHint => 'Los espacios y las mayúsculas dan igual.';
	@override String get saveCode => 'Guardar código';
	@override String get chooseIcon => 'Elegir icono';
	@override String get searchIcons => 'Buscar iconos — prueba «banco» o «candado»';
	@override String get popular => 'Populares';
	@override String noIcons({required Object search}) => 'Ningún icono coincide con «${search}».';
	@override String get useDefaultIcon => 'Usar icono predeterminado';
	@override String iconMatches({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} resultado',
		other: '${n} resultados',
	);
}

// Path: generator
class _Translations$generator$es extends Translations$generator$en {
	_Translations$generator$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Generar una contraseña';
	@override String get notFilledIn => 'No se rellena nada hasta que lo aceptes.';
	@override String get generated => 'Contraseña generada';
	@override String get mode => 'Modo';
	@override String get passphrase => 'Frase de contraseña';
	@override String get randomString => 'Cadena aleatoria';
	@override String get words => 'Palabras';
	@override String get fewerWords => 'Menos palabras';
	@override String get moreWords => 'Más palabras';
	@override String get length => 'Longitud';
	@override String get shorter => 'Más corta';
	@override String get longer => 'Más larga';
	@override String get wordSeparator => 'Separador de palabras';
	@override String get dash => 'Guion';
	@override String get underscore => 'Guion bajo';
	@override String get slash => 'Barra';
	@override String get space => 'Espacio';
	@override String get language => 'Idioma';
	@override String get regenerate => 'Regenerar';
	@override String charCount({required Object count}) => '${count} caracteres';
	@override String get lowercase => 'Letras minúsculas';
	@override String get uppercase => 'Letras mayúsculas';
	@override String get digits => 'Dígitos';
	@override String get symbols => 'Símbolos';
	@override String get pickOne => 'Elige al menos un tipo de carácter.';
	@override String get use => 'Usar esta contraseña';
	@override String wordCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} palabra',
		other: '${n} palabras',
	);
	@override String get pageTitle => 'Generador de contraseñas';
	@override String get subtitle => 'Contraseñas y frases de contraseña aleatorias, creadas en este dispositivo';
	@override String get separatorDash => 'Guion ( - )';
	@override String get separatorUnderscore => 'Guion bajo ( _ )';
	@override String get separatorSlash => 'Barra ( / )';
	@override String get separatorSpace => 'Espacio';
	@override String get nothingToGenerate => 'Nada que generar.';
	@override String get copyPassword => 'Copiar contraseña';
	@override String get copied => 'Contraseña copiada';
	@override String get fromGenerator => 'Del generador';
}

// Path: report
class _Translations$report$es extends Translations$report$en {
	_Translations$report$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Informe de seguridad';
	@override String get subtitle => 'Qué tan seguras son tus contraseñas guardadas';
	@override String get healthLabel => 'Salud de la caja fuerte';
	@override String get healthGood => 'Sólida';
	@override String get healthFair => 'Mejorable';
	@override String get healthPoor => 'En riesgo';
	@override String get allClearTitle => 'No se encontraron problemas';
	@override String get allClearDescription => 'Todas las contraseñas de tus cajas fuertes pasaron la última auditoría.';
	@override String aboutSection({required Object title}) => 'Acerca de ${title}';
	@override String get nothingFound => 'No se encontró nada';
	@override String openItem({required Object name}) => 'Abrir ${name}';
	@override String get checkAgain => 'Volver a comprobar';
	@override String get statWeak => 'Débiles';
	@override String get statReused => 'Reutilizadas';
	@override String get statCompromised => 'Comprometidas';
	@override String statValue({required Object label, required Object count}) => '${label}: ${count}';
	@override String statNotChecked({required Object label}) => '${label}: aún sin comprobar';
	@override String healthPercent({required Object title, required Object score}) => '${title} ${score} por ciento';
	@override String sameAs({required Object names}) => 'Igual que en ${names}';
	@override String get sameAsField => 'Igual que otra contraseña de este elemento';
	@override String get foundInBreach => 'Encontrada en una filtración conocida';
	@override String get trust => 'La comprobación de filtraciones usa Have I Been Pwned con k-anonimato: solo los primeros 5 caracteres de un hash SHA-1 salen de este teléfono.';
	@override String get lastCheckedJustNow => 'Última comprobación: ahora mismo';
	@override String lastCheckedToday({required Object time}) => 'Última comprobación: hoy a las ${time}';
	@override String lastCheckedOn({required Object date}) => 'Última comprobación: ${date}';
	@override String get checking => 'Comprobando…';
	@override String checkingBreaches({required Object done, required Object total}) => 'Buscando filtraciones · ${done} de ${total}';
	@override String progress({required Object done, required Object total}) => '${done} de ${total}';
	@override String progressTime({required Object done, required Object total, required Object time}) => '${done} de ${total} · ${time}';
	@override String get offlineBody => 'No se pudieron comprobar tus contraseñas. La comprobación necesita conexión.';
	@override String get failedTitle => 'La comprobación no pudo terminar';
	@override String get failedBody => 'Vuelve a intentarlo en un momento.';
	@override String get nothingTitle => 'Aún no hay nada que comprobar';
	@override String get nothingBody => 'Guarda un elemento con contraseña y se comprobará aquí, en este teléfono, si hay contraseñas débiles, reutilizadas o filtradas.';
	@override String get howToFix => 'Cómo solucionarlo';
	@override String get stepOpen => 'Abre el elemento';
	@override String get stepGenerate => 'Toca Editar y luego Generar en la contraseña';
	@override String get stepSave => 'Guarda: la marca desaparece sola';
	@override String get stepSaveCompromised => 'Guarda y cámbiala también en el sitio';
	@override String get changePassword => 'Cambiar contraseña';
	@override String fixedClear({required Object name}) => 'Guardado · ${name} ya no está marcado';
	@override String fixedFlagged({required Object name}) => 'Guardado · ${name} sigue marcado';
	@override String savedTo({required Object storage}) => 'Tu caja fuerte se guardó en ${storage}';
	@override String get noLongerWeak => 'Ya no es débil';
	@override String get noLongerReused => 'Ya no está reutilizada';
	@override String get noLongerWeakOrReused => 'Ya no es débil ni está reutilizada';
	@override String hintReusedOne({required Object n}) => 'Estos ${n} comparten una contraseña. Dale a cada uno la suya: abre uno, toca Editar y luego Generar.';
	@override String get hintReusedSome => 'Algunos comparten contraseña. Dale a cada uno la suya: abre uno, toca Editar y luego Generar.';
	@override String get hintWeak => 'Dale a cada uno una más segura: ábrelo, toca Editar y luego Generar.';
	@override String get hintCompromised => 'Estos aparecen en filtraciones conocidas. Cambia cada uno: ábrelo, toca Editar y luego Generar.';
	@override String itemsChecked({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} elemento con contraseña revisado',
		other: '${n} elementos con contraseña revisados',
	);
	@override String flagged({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} elemento marcado',
		other: '${n} elementos marcados',
	);
	@override String sameAsOthers({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Igual que en ${n} elemento más',
		other: 'Igual que en ${n} elementos más',
	);
	@override String checkingPasswords({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Comprobando ${n} contraseña',
		other: 'Comprobando ${n} contraseñas',
	);
	@override String aboutSeconds({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'alrededor de ${n} segundo',
		other: 'alrededor de ${n} segundos',
	);
	@override String aboutMinutes({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'alrededor de ${n} minuto',
		other: 'alrededor de ${n} minutos',
	);
}

// Path: audit
class _Translations$audit$es extends Translations$audit$en {
	_Translations$audit$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$audit$weakPassword$es weakPassword = _Translations$audit$weakPassword$es._(_root);
	@override late final _Translations$audit$reusedPassword$es reusedPassword = _Translations$audit$reusedPassword$es._(_root);
	@override late final _Translations$audit$compromisedPassword$es compromisedPassword = _Translations$audit$compromisedPassword$es._(_root);
}

// Path: myVaults
class _Translations$myVaults$es extends Translations$myVaults$en {
	_Translations$myVaults$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mis cajas fuertes';
	@override String get subtitle => 'Grupos separados de elementos: trabajo, familia, personal';
	@override String get defaultBadge => 'Predeterminada';
	@override String get newVault => 'Nueva caja fuerte';
	@override String get emptyTitle => 'Solo tienes la caja fuerte predeterminada';
	@override String get emptyBody => 'Una segunda caja fuerte mantiene un conjunto de elementos aparte — trabajo separado de lo personal, o lo compartido de lo privado.';
	@override String createdOn({required Object date}) => 'creada el ${date}';
	@override String get renameTitle => 'Renombrar caja fuerte';
	@override String get renameBody => 'Los elementos que contiene no se ven afectados.';
	@override String duplicateRename({required Object name}) => 'Ya existe una caja fuerte llamada «${name}».';
	@override String deleteTitle({required Object name}) => '¿Eliminar «${name}»?';
	@override String get deleteAction => 'Eliminar caja fuerte';
	@override String renameAria({required Object name}) => 'Renombrar ${name}';
	@override String deleteAria({required Object name}) => 'Eliminar ${name}';
	@override String itemCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} elemento',
		other: '${n} elementos',
	);
	@override String deleteBody({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Su ${n} elemento se moverá a ${vault}. Esto no se puede deshacer.',
		other: 'Sus ${n} elementos se moverán a ${vault}. Esto no se puede deshacer.',
	);
	@override String deleteSelectedTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '¿Eliminar ${n} caja fuerte?',
		other: '¿Eliminar ${n} cajas fuertes?',
	);
	@override String deleteSelectedBody({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Todo lo que contienen — ${n} elemento — se moverá a ${vault}. Esto no se puede deshacer.',
		other: 'Todo lo que contienen — ${n} elementos — se moverá a ${vault}. Esto no se puede deshacer.',
	);
	@override String personalSummary({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${name} tiene ${n} elemento y no se puede renombrar ni eliminar.',
		other: '${name} tiene ${n} elementos y no se puede renombrar ni eliminar.',
	);
	@override String selected({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} caja fuerte seleccionada',
		other: '${n} cajas fuertes seleccionadas',
	);
	@override String deleteVaults({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Eliminar ${n} caja fuerte',
		other: 'Eliminar ${n} cajas fuertes',
	);
}

// Path: tags
class _Translations$tags$es extends Translations$tags$en {
	_Translations$tags$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Etiquetas';
	@override String get subtitle => 'Etiquetas que atraviesan las cajas fuertes, para encontrar todo rápido';
	@override String since({required Object date}) => 'desde ${date}';
	@override String get addTag => 'Añadir etiqueta';
	@override String get addTitle => 'Añadir etiqueta';
	@override String get emptyTitle => 'Todavía no hay etiquetas';
	@override String get emptyBody => 'Las etiquetas se crean desde un elemento o desde aquí — de cualquier forma, agrupan elementos entre cajas fuertes.';
	@override String get addBody => 'Una etiqueta sin elementos todavía. Asígnala a un elemento desde la propia página de ese elemento.';
	@override String get tagName => 'Nombre de la etiqueta';
	@override String get duplicate => 'Ya existe una etiqueta con este nombre.';
	@override String get colorNote => 'Su color sale de su nombre.';
	@override String get renameTitle => 'Renombrar etiqueta';
	@override String get renameBody => 'Se actualiza en todos los elementos que la llevan.';
	@override String mergeNotice({required Object name}) => '«${name}» ya existe — al renombrarla se combinarán.';
	@override String deleteTitle({required Object name}) => '¿Eliminar «${name}»?';
	@override String get deleteAction => 'Eliminar etiqueta';
	@override String get deleteSelectedBody => 'Cada una se quitará de todos los elementos que la lleven. Los elementos en sí se conservan. Esto no se puede deshacer.';
	@override String get footer => 'Toca una etiqueta para ver sus elementos en la pestaña Caja fuerte.';
	@override String renameAria({required Object name}) => 'Renombrar ${name}';
	@override String deleteAria({required Object name}) => 'Eliminar ${name}';
	@override String itemCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} elemento',
		other: '${n} elementos',
	);
	@override String deleteBody({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Se quitará de ${n} elemento. Los elementos en sí se conservan. Esto no se puede deshacer.',
		other: 'Se quitará de ${n} elementos. Los elementos en sí se conservan. Esto no se puede deshacer.',
	);
	@override String deleteSelectedTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '¿Eliminar ${n} etiqueta?',
		other: '¿Eliminar ${n} etiquetas?',
	);
	@override String selected({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} etiqueta seleccionada',
		other: '${n} etiquetas seleccionadas',
	);
	@override String deleteTags({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Eliminar ${n} etiqueta',
		other: 'Eliminar ${n} etiquetas',
	);
}

// Path: changeSecret
class _Translations$changeSecret$es extends Translations$changeSecret$en {
	_Translations$changeSecret$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cambiar secreto';
	@override String get intro => 'Tu caja fuerte se vuelve a cifrar con el nuevo secreto y se sube de nuevo. No se puede recuperar si lo olvidas.';
	@override String get current => 'Secreto actual';
	@override String get wrong => 'Ese no es tu secreto actual.';
	@override String get match => 'Los dos secretos coinciden.';
	@override String get otherDevices => 'Los demás dispositivos te pedirán el nuevo secreto la próxima vez que abran tu caja fuerte.';
	@override String get submit => 'Cambiar secreto';
	@override String get verifyingMeta => 'Comprobando tu secreto actual…';
	@override String get verifyingTitle => 'Verificando tu secreto actual…';
	@override String get stepVerify => 'Verificando tu secreto actual';
	@override String get stepVerifyNote => 'Deliberadamente lento en un teléfono — eso es lo que encarece adivinarlo';
	@override String get stepEncrypt => 'Cifrando con el nuevo secreto';
	@override String get stepSave => 'Guardando tu caja fuerte';
	@override String savingMeta({required Object storage}) => 'Guardando en ${storage}…';
	@override String savingTitle({required Object percent}) => 'Guardando tu caja fuerte… ${percent}%';
	@override String get stepVerified => 'Secreto actual verificado';
	@override String get stepEncrypted => 'Cifrado con el nuevo secreto';
	@override String stepSaving({required Object storage}) => 'Guardando en ${storage}';
	@override String get keepOpen => 'Mantén KeeperPass abierto hasta que termine.';
	@override String doneMeta({required Object storage}) => 'Guardado en ${storage}';
	@override String get doneTitle => 'Tu secreto se ha cambiado';
	@override String get doneBody => 'Todos tus elementos siguen contigo. Los demás dispositivos te pedirán el nuevo secreto la próxima vez que abran tu caja fuerte.';
	@override String get toast => 'Secreto cambiado';
	@override String get failTitle => 'No se guardó tu caja fuerte';
	@override String failBody({required Object storage}) => 'No se pudo conectar con ${storage}. Tu secreto no ha cambiado: la caja fuerte se sigue abriendo con el actual.';
}

// Path: storage
class _Translations$storage$es extends Translations$storage$en {
	_Translations$storage$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Almacenamiento';
	@override String get subtitle => 'Dónde vive tu caja fuerte y qué puede acceder a ella';
	@override String diagram({required Object storage}) => 'Cifrada en este teléfono y guardada en tu ${storage}';
	@override String get thisPhone => 'Este teléfono';
	@override String get encryptedOnly => 'Solo el archivo cifrado';
	@override String get googleFolder => 'carpeta keeperpass';
	@override String get dropboxFolder => 'carpeta Apps/keeperpass';
	@override String savedToday({required Object folder, required Object time}) => '${folder} · guardado hoy a las ${time}';
	@override String savedOn({required Object folder, required Object date}) => '${folder} · guardado el ${date}';
	@override String get access => 'Acceso';
	@override String get googlePermissions => 'Permisos de la cuenta de Google';
	@override String get dropboxApps => 'Apps conectadas a Dropbox';
	@override String get accessNote => 'KeeperPass solo puede acceder a los archivos que crea. Puedes revocar ese acceso aquí en cualquier momento; el archivo de la caja fuerte se queda donde está.';
}

// Path: moveVault
class _Translations$moveVault$es extends Translations$moveVault$en {
	_Translations$moveVault$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mover caja fuerte';
	@override String diagram({required Object from, required Object to}) => 'Tu caja fuerte se mueve de ${from} a ${to}';
	@override String get from => 'Origen';
	@override String get to => 'Destino';
	@override String get intro => 'Tu caja fuerte se copia y se comprueba, y solo entonces se renombra el archivo antiguo. Si algo falla, no se cambia nada.';
	@override String step1({required Object storage}) => 'Inicia sesión en ${storage} para elegir adónde va la caja fuerte.';
	@override String get step2 => 'Confirma. Antes de este paso no cambia nada.';
	@override String get step3 => 'La caja fuerte se copia y se comprueba; después, el archivo antiguo se renombra, nunca se borra.';
	@override String connect({required Object storage}) => 'Conectar ${storage}';
	@override String get account => 'Se moverá a esta cuenta';
	@override String existingTitle({required Object storage}) => 'Esta cuenta de ${storage} ya tiene una caja fuerte de KeeperPass';
	@override String existingBody({required Object storage}) => 'Si continúas, se conserva como copia de seguridad con marca de tiempo en ${storage} y se sustituye por la caja fuerte que estás moviendo.';
	@override String get existingConfirm => 'Sustituirla: la caja fuerte existente se conserva como copia de seguridad';
	@override String get secretSection => 'Secreto para la caja fuerte movida';
	@override String get keepSecret => 'Mantener mi secreto actual';
	@override String get newSecret => 'Elegir un secreto nuevo';
	@override String get newSecretNote => 'Solo lo usa la caja fuerte movida';
	@override String get submit => 'Mover caja fuerte';
	@override String get movingTitle => 'Moviendo tu caja fuerte';
	@override String get stageEncrypting => 'Cifrando tu caja fuerte';
	@override String stageSaving({required Object storage}) => 'Guardando en ${storage}…';
	@override String get stageChecking => 'Comprobando la copia guardada';
	@override String get stageRenaming => 'Renombrando el archivo antiguo';
	@override String get movingNote => 'Mantén KeeperPass abierto hasta que termine. Si algo falla, no se cambia nada.';
	@override String savedTo({required Object storage}) => 'Guardado en ${storage}';
	@override String doneTitle({required Object storage}) => 'Tu caja fuerte ahora está en ${storage}';
	@override String doneBody({required Object provider, required Object from}) => 'Inicia sesión con ${provider} para abrirla. El archivo antiguo se conservó y se renombró en ${from}:';
	@override String get copyFileName => 'Copiar nombre del archivo';
	@override String get fileNameCopied => 'Nombre del archivo copiado';
	@override String partlyTitle({required Object storage}) => 'Tu caja fuerte se copió a ${storage}';
	@override String partlyBody({required Object from}) => 'Pero no se pudo renombrar el archivo antiguo en ${from}. Renómbralo o bórralo tú para que las dos copias no se desincronicen.';
	@override String open({required Object storage}) => 'Abrir ${storage}';
	@override String unchanged({required Object from}) => 'Sigue en ${from} · sin cambios';
	@override String get notMovedTitle => 'Tu caja fuerte no se movió';
	@override String get notMovedBody => 'La copia guardada no coincidía con tu caja fuerte, así que el archivo antiguo quedó intacto. No se perdió nada; inténtalo de nuevo.';
}

// Path: dataIo
class _Translations$dataIo$es extends Translations$dataIo$en {
	_Translations$dataIo$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get importTitle => 'Importar';
	@override String get file => 'Archivo';
	@override String fileMeta({required Object size}) => '${size} · de Archivos';
	@override String kilobytes({required Object n}) => '${n} KB';
	@override String megabytes({required Object n}) => '${n} MB';
	@override String get change => 'Cambiar';
	@override String found({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Se encontró ${n} elemento para importar.',
		other: 'Se encontraron ${n} elementos para importar.',
	);
	@override String get addTo => 'Añadirlos a';
	@override String get importNote => 'Los elementos se añaden a la caja fuerte que elijas. No se reemplaza nada.';
	@override String importButton({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Importar ${n} elemento',
		other: 'Importar ${n} elementos',
	);
	@override String get invalidCsv => 'Este archivo no se pudo leer como CSV.';
	@override String get noItems => 'No se encontraron elementos en este archivo.';
	@override String get notCsvNote => 'Exporta un CSV desde tu otro gestor de contraseñas y luego elige ese archivo aquí.';
	@override String get chooseAnother => 'Elegir otro archivo';
	@override String get exportTitle => 'Exportar';
	@override String get exportIntro => 'Genera un CSV de la caja fuerte que elijas. Los elementos exportados dejan atrás el cifrado de la caja fuerte — lo que hagas con el archivo depende de ti.';
	@override String get sourceVault => 'Caja fuerte de origen';
	@override String get notEncryptedTitle => 'Un archivo CSV no está cifrado';
	@override String get notEncryptedBody => 'Quien lo abra podrá leer todas las contraseñas que contiene. Guárdalo en un lugar seguro y elimínalo cuando termines.';
	@override String exportButton({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Exportar ${n} elemento',
		other: 'Exportar ${n} elementos',
	);
	@override String get exportNote => 'Abre el menú de compartir para que elijas adónde va el archivo.';
	@override String get recentTitle => 'Exportaciones recientes';
	@override String recentRow({required num n, required Object scope}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${scope} · ${n} elemento',
		other: '${scope} · ${n} elementos',
	);
	@override String get recentNote => 'Se recuerdan las últimas 10 exportaciones, en tu caja fuerte. KeeperPass no guarda ninguna copia de los archivos.';
	@override String get recentEmpty => 'Aún no hay exportaciones.';
}

// Path: archive
class _Translations$archive$es extends Translations$archive$en {
	_Translations$archive$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Archivar caja fuerte';
	@override String get headline => 'Archivar caja fuerte y cerrar sesión';
	@override String body({required Object storage}) => 'Tu caja fuerte es un único archivo cifrado en tu propio ${storage}. Al archivarla, se cambia el nombre del archivo para que esta app ya no lo encuentre y se cierra tu sesión. No se borra nada.';
	@override String step1({required Object oldName, required Object newName, required Object folder}) => '${oldName} se renombra a ${newName}, en la misma ${folder}.';
	@override String step2({required Object storage}) => 'Este teléfono cierra la sesión de ${storage}.';
	@override String step3({required Object storage}) => 'Para borrar los datos en sí, borra ese archivo en ${storage}.';
	@override String get typePrefix => 'Escribe';
	@override String get typeSuffix => 'para confirmar.';
	@override String get confirmation => 'Confirmación';
	@override String get button => 'Archivar y cerrar sesión';
	@override String get doneMeta => 'Renombrado · esta app ya no lo encuentra';
	@override String get doneTitle => 'Se ha cambiado el nombre de tu archivo de caja fuerte';
	@override String doneBody({required Object folder, required Object storage}) => 'Sigue en la ${folder} de tu ${storage}. Bórralo allí cuando quieras que los datos desaparezcan definitivamente.';
	@override String get signedOut => 'Has cerrado sesión en este teléfono.';
	@override String get error => 'No se ha podido cambiar el nombre del archivo. No se ha modificado nada.';
}

// Path: help
class _Translations$help$es extends Translations$help$en {
	_Translations$help$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get howTitle => 'Cómo funciona KeeperPass';
	@override String get howSubtitle => 'Dónde viven tus datos y qué los mantiene privados';
	@override String get whereLives => 'Dónde viven tus datos';
	@override String diagram({required Object storage}) => 'Tu caja fuerte se cifra en este teléfono y se guarda como un único archivo en tu ${storage}';
	@override String get thisPhoneNote => 'Cifra y descifra todo. Tu secreto nunca sale de él.';
	@override String get fileEncrypted => 'vault.json.enc · cifrado';
	@override String yourStorage({required Object storage}) => 'Tu ${storage}';
	@override String get storageNote => 'Guarda el archivo, que es ilegible sin tu secreto.';
	@override String get noServer => 'KeeperPass nunca recibe tus datos. No hay cuenta que vulnerar ni operador que pueda leer tu caja fuerte.';
	@override String get protects => 'Qué lo protege';
	@override String get secretTerm => 'Tu secreto';
	@override String get secretNote => 'Nunca se envía ni se guarda. Solo existe en memoria mientras la app está desbloqueada.';
	@override String get kdfTerm => 'Derivación de claves';
	@override String get kdfNote => 'Deliberadamente lenta, para que cada intento de adivinar tu secreto sea costoso.';
	@override String get encryptionTerm => 'Cifrado';
	@override String get encryptionNote => 'Mantiene el archivo ilegible y muestra si alguien lo ha modificado.';
	@override String get accessTerm => 'Acceso al almacenamiento';
	@override String get accessNote => 'KeeperPass solo puede acceder a los archivos que crea.';
	@override String get signingIn => 'Inicio de sesión';
	@override String get step1 => 'Conecta tu almacenamiento en la nube';
	@override String get step1Note => 'Demuestra quién es el dueño del archivo. No desbloquea nada.';
	@override String get step2 => 'Introduce tu secreto';
	@override String get step2Note => 'Genera en este teléfono la clave que abre el archivo. Tu proveedor de almacenamiento nunca la ve.';
	@override String get bothNeeded => 'Quien tenga tu cuenta de almacenamiento sigue sin poder leer tu caja fuerte. Quien conozca tu secreto sigue sin poder llegar al archivo. Hacen falta las dos cosas.';
	@override String get terms => 'Términos que conviene conocer';
	@override String get secretWord => 'Secreto';
	@override String get secretDef => 'La única frase que desbloquea tu caja fuerte. No se puede recuperar.';
	@override String get vaultWord => 'Caja fuerte';
	@override String get vaultDef => 'Un grupo de elementos. Con varias, mantienes separado lo laboral de lo personal.';
	@override String get tagWord => 'Etiqueta';
	@override String get tagDef => 'Una etiqueta para encontrar elementos entre cajas fuertes, como trabajo o banca.';
	@override String get reportWord => 'Informe de seguridad';
	@override String get reportDef => 'Marca las contraseñas débiles, reutilizadas y filtradas, en este teléfono.';
}

// Path: faq
class _Translations$faq$es extends Translations$faq$en {
	_Translations$faq$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Preguntas';
	@override String get subtitle => 'Respuestas a preguntas frecuentes';
	@override String get forgetQ => '¿Qué pasa si olvido mi secreto?';
	@override String get forgetA1 => 'Tu caja fuerte no se puede recuperar — ni tú ni nosotros podemos hacerlo. La clave se genera solo a partir de tu secreto, así que sin él el archivo sigue siendo ilegible. Ese es el precio de que nadie más pueda leerlo tampoco.';
	@override String forgetA2({required Object forgot, required Object file}) => 'Lo que puedes hacer es empezar de nuevo: ${forgot} en la pantalla de desbloqueo crea una caja fuerte nueva y vacía. Tu archivo antiguo no se borra — se renombra a ${file} y se conserva en tu carpeta keeperpass, así que los datos siguen ahí si recuerdas el secreto.';
	@override String get forgetA2Link => '¿Olvidaste tu secreto?';
	@override String get forgetA3 => 'Anota tu secreto y guárdalo en un lugar seguro. Es lo único en KeeperPass que no se puede reemplazar.';
	@override String get seeQ => '¿Puede KeeperPass ver mis contraseñas?';
	@override String get seeA => 'No — y no es una promesa, sino una consecuencia del diseño. El cifrado ocurre en este teléfono y el texto cifrado va directo a tu propio almacenamiento. No hay ningún servidor de KeeperPass en el camino que pueda ver nada.';
	@override String get syncQ => '¿Se sincroniza entre dispositivos?';
	@override String get syncA => 'Sí. Todos los dispositivos leen el mismo archivo de tu almacenamiento. Inicia sesión con la misma cuenta, introduce el mismo secreto y tu caja fuerte estará ahí.';
	@override String get providerQ => '¿Y si mi proveedor de almacenamiento lee el archivo?';
	@override String get providerA => 'Verían bytes cifrados. La clave nunca sale de este teléfono, así que ni Google ni Dropbox ni ningún otro proveedor pueden leer el contenido.';
	@override String get importQ => '¿Puedo importar desde otro gestor de contraseñas?';
	@override String get importA => 'Sí — exporta a CSV desde ahí y luego usa Importar en Ajustes.';
	@override String get changeSecretQ => '¿Cómo cambio mi secreto?';
	@override String changeSecretA({required Object action}) => 'Abre Ajustes y elige ${action}. Introduces tu secreto actual y el nuevo; tu caja fuerte se descifra, se vuelve a cifrar con el nuevo secreto y se guarda de nuevo. No se pierde nada — todos los elementos te acompañan, y el cambio se aplica en cada dispositivo la próxima vez que cargue tu caja fuerte.';
	@override String get costQ => '¿Cuánto cuesta?';
	@override String get costA => 'Nada. KeeperPass es gratuito y de código abierto, y guarda los datos en el espacio en la nube que ya tienes.';
	@override String get stillStuck => '¿Sigues atascado?';
	@override String get contactBody => '¿Preguntas, comentarios o algún problema? Escríbenos un correo.';
}

// Path: about
class _Translations$about$es extends Translations$about$en {
	_Translations$about$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String version({required Object version, required Object build}) => 'Versión ${version} (${build})';
	@override String get tagline => 'Tu nube. Tus claves. Tu caja fuerte.';
	@override String get license => 'Gratis y de código abierto bajo AGPL-3.0';
	@override String get terms => 'Términos del servicio';
	@override String get privacy => 'Política de privacidad';
	@override String get promise => 'Gratis y sin trampa: sin planes, sin versión premium, sin ventas adicionales.';
}

// Path: clipboard
class _Translations$clipboard$es extends Translations$clipboard$en {
	_Translations$clipboard$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String clearsIn({required Object time}) => 'Se borra en ${time}';
	@override String get cleared => 'Portapapeles borrado';
}

// Path: sync
class _Translations$sync$es extends Translations$sync$en {
	_Translations$sync$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String savedTo({required Object storage}) => 'Guardado en ${storage}';
	@override String get notSavedTitle => 'No se guardó tu caja fuerte';
	@override String notSavedBody({required Object storage}) => 'No se pudo conectar con ${storage}. Tu cambio sigue aquí; vuelve a intentarlo antes de cerrar KeeperPass.';
	@override String get dismiss => 'Descartar';
	@override String get retryingTitle => 'Reintentando…';
	@override String retryingBody({required Object storage}) => 'Guardando en ${storage}.';
	@override String reconnectTitle({required Object storage}) => 'Vuelve a conectar con ${storage}';
	@override String get keepReading => 'Puedes seguir leyendo; los cambios se guardarán cuando vuelvas a conectarte.';
	@override String get reconnect => 'Reconectar';
	@override String get later => 'Más tarde';
	@override String offlineBody({required Object storage}) => 'Puedes seguir leyendo y copiando. Para guardar hace falta conexión con ${storage}.';
	@override String get changedTitle => 'Tu caja fuerte cambió';
	@override String get changedBody => 'Se guardó una versión más reciente de tu caja fuerte desde otro dispositivo. Cárgala antes de editar para que no se sobrescriba nada.';
	@override String get twoVersions => 'Dos versiones';
	@override String get onThisPhone => 'En este teléfono';
	@override String inStorage({required Object storage}) => 'En ${storage}';
	@override String loadedAt({required Object time}) => 'cargada: ${time}';
	@override String savedNewer({required Object time}) => 'guardada: ${time} · más reciente';
	@override String get loadLatest => 'Cargar la versión más reciente';
	@override String get notNow => 'Ahora no';
	@override String get pausedNote => 'Hasta entonces puedes leer y copiar, pero no editar.';
	@override String get upToDate => 'Actualizada';
	@override String loadedVersion({required Object time}) => 'Se cargó la versión guardada a las ${time}';
}

// Path: scan
class _Translations$scan$es extends Translations$scan$en {
	_Translations$scan$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Escanear código QR';
	@override String get primerTitle => 'Añadir un código 2FA escaneando';
	@override String get primerBody => 'Cuando un sitio activa el inicio de sesión en dos pasos, muestra un código QR. KeeperPass lo lee con la cámara y guarda la clave de configuración en tu caja fuerte, para que sus códigos aparezcan en Códigos.';
	@override String get primerPrivacy => 'La cámara solo lee el código. No se graba nada ni se guarda ninguna imagen.';
	@override String get primerNext => 'A continuación, tu teléfono pedirá acceso a la cámara.';
	@override String get enterInstead => 'Introducir la clave de configuración';
	@override String get hint => 'Apunta al código QR que muestra el sitio web\nal activar el inicio de sesión en dos pasos.';
	@override String get torch => 'Encender la luz';
	@override String get cameraView => 'Vista de la cámara';
	@override String get codeFound => 'Código encontrado';
	@override String get saveTo => 'Guardarlo en';
	@override String get existingItem => 'Elemento existente';
	@override String existingItemWith({required Object summary}) => 'Elemento existente · ${summary}';
	@override String get newAuthenticator => 'Nuevo elemento Autenticador';
	@override String named({required Object name}) => 'Con el nombre ${name}';
	@override String get cameraOffTitle => 'El acceso a la cámara está desactivado';
	@override String get cameraOffBody => 'KeeperPass solo necesita la cámara para leer códigos QR. Actívala en Ajustes o escribe la clave de configuración.';
	@override String get openSettings => 'Abrir Ajustes';
	@override String get unsupported => 'Este código usa ajustes que KeeperPass aún no admite';
	@override String get notACode => 'Este no es un código QR de 2FA';
	@override String get cameraFailed => 'No se ha podido iniciar la cámara';
	@override String get item => 'Elemento';
	@override String get codeSettings => '6 dígitos · cada 30 segundos · SHA-1';
	@override String codeAdded({required Object name}) => 'Código añadido a ${name}';
	@override String get tapToCopy => 'Toca la tarjeta para copiarlo.';
}

// Path: errors.failures
class _Translations$errors$failures$es extends Translations$errors$failures$en {
	_Translations$errors$failures$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get networkFailure => 'Algo salió mal. Inténtalo de nuevo.';
	@override String get undocumentedError => 'Algo salió mal. Inténtalo de nuevo.';
	@override String get platformError => 'Algo salió mal. Inténtalo de nuevo.';
	@override String get notFound => 'Algo salió mal. Inténtalo de nuevo.';
	@override String get formatException => 'Algo salió mal. Inténtalo de nuevo.';
	@override String get unableToProcess => 'Algo salió mal. Inténtalo de nuevo.';
	@override String get requestTimeout => 'Algo salió mal. Inténtalo de nuevo.';
	@override String get connectionError => 'Algo salió mal. Inténtalo de nuevo.';
	@override String get unexpectedError => 'Algo salió mal. Inténtalo de nuevo.';
	@override String get accessTokenFailure => 'Algo salió mal. Inténtalo de nuevo.';
	@override String get cacheReadFailure => 'Algo salió mal. Inténtalo de nuevo.';
	@override String get cacheWriteFailure => 'Algo salió mal. Inténtalo de nuevo.';
}

// Path: errors.drive
class _Translations$errors$drive$es extends Translations$errors$drive$en {
	_Translations$errors$drive$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get authExpired => 'Tu sesión de Google ha caducado. Vuelve a conectarte.';
	@override String get backupFailed => 'No se pudo hacer una copia de seguridad de tu caja fuerte actual en Google Drive. Inténtalo de nuevo.';
	@override String get renameFailed => 'No se pudo renombrar tu archivo de caja fuerte en Google Drive. No se cambió nada; inténtalo de nuevo.';
	@override String get createFolderFailed => 'No se pudo crear la carpeta keeperpass en Google Drive. Inténtalo de nuevo.';
	@override String get readFailed => 'No se pudo leer tu caja fuerte desde Google Drive. Inténtalo de nuevo.';
	@override String get saveFailed => 'No se pudo guardar tu caja fuerte en Google Drive. Inténtalo de nuevo.';
	@override String get unreachable => 'No se pudo conectar con Google Drive. Inténtalo de nuevo.';
}

// Path: errors.dropbox
class _Translations$errors$dropbox$es extends Translations$errors$dropbox$en {
	_Translations$errors$dropbox$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get authExpired => 'Tu sesión de Dropbox ha caducado. Vuelve a conectarte.';
	@override String get profileFailed => 'No se pudo leer tu perfil de Dropbox. Inténtalo de nuevo.';
	@override String get unknown => 'Algo salió mal al conectar con Dropbox. Inténtalo de nuevo.';
	@override String get unreachable => 'No se pudo conectar con Dropbox. Inténtalo de nuevo.';
	@override String get readFailed => 'No se pudo leer tu caja fuerte desde Dropbox. Inténtalo de nuevo.';
	@override String get saveFailed => 'No se pudo guardar tu caja fuerte en Dropbox. Inténtalo de nuevo.';
	@override String get backupFailed => 'No se pudo hacer una copia de seguridad de tu caja fuerte actual en Dropbox. Inténtalo de nuevo.';
	@override String get renameFailed => 'No se pudo renombrar tu archivo de caja fuerte en Dropbox. No se cambió nada; inténtalo de nuevo.';
	@override String get missingScope => 'A KeeperPass le falta un permiso de Dropbox. Es un problema de configuración que no se arregla iniciando sesión de nuevo.';
	@override String get rateLimited => 'Dropbox nos pide ir más despacio. Espera un momento e inténtalo de nuevo.';
}

// Path: errors.auth
class _Translations$errors$auth$es extends Translations$errors$auth$en {
	_Translations$errors$auth$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get profileFailed => 'No se pudo leer tu perfil de Google. Inténtalo de nuevo.';
	@override String get unknown => 'Algo salió mal al conectar con Google. Inténtalo de nuevo.';
}

// Path: errors.masterPassword
class _Translations$errors$masterPassword$es extends Translations$errors$masterPassword$en {
	_Translations$errors$masterPassword$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get vaultNotFound => 'No se encontró tu caja fuerte.';
}

// Path: errors.vault
class _Translations$errors$vault$es extends Translations$errors$vault$en {
	_Translations$errors$vault$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String accountMismatch({required Object email}) => 'Inicia sesión con ${email} para guardar tus cambios.';
	@override String get driveAccessNotGranted => 'Google no dio a KeeperPass acceso a los archivos que crea en tu Drive. Vuelve a intentarlo y permite ese acceso en la página de Google.';
	@override String get conflict => 'Se guardó una versión más reciente de tu caja fuerte desde otro dispositivo. Cárgala antes de editar para que no se sobrescriba nada.';
	@override String get signInCanceled => 'Inicio de sesión cancelado';
	@override String get unsupported => 'Esta versión de KeeperPass no puede abrir este archivo de caja fuerte.';
	@override String get corrupt => 'El archivo de tu caja fuerte está dañado y no se puede abrir.';
}

// Path: settings.migrate
class _Translations$settings$migrate$es extends Translations$settings$migrate$en {
	_Translations$settings$migrate$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$settings$migrate$error$es error = _Translations$settings$migrate$error$es._(_root);
}

// Path: auth.unlock
class _Translations$auth$unlock$es extends Translations$auth$unlock$en {
	_Translations$auth$unlock$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get incorrectSecret => 'Secreto incorrecto. Inténtalo de nuevo.';
}

// Path: editItem.templates
class _Translations$editItem$templates$es extends Translations$editItem$templates$en {
	_Translations$editItem$templates$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get website => 'Sitio web o app';
	@override String get computer => 'Ordenador';
	@override String get creditCard => 'Tarjeta de crédito';
	@override String get bankAccount => 'Cuenta bancaria';
	@override String get wifi => 'Red Wi-Fi';
	@override String get passport => 'Pasaporte';
	@override String get note => 'Nota';
	@override String get authenticator => 'Autenticador';
	@override String get custom => 'Personalizado';
}

// Path: editItem.templateHints
class _Translations$editItem$templateHints$es extends Translations$editItem$templateHints$en {
	_Translations$editItem$templateHints$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get website => 'Usuario, contraseña, URL';
	@override String get computer => 'Usuario, contraseña';
	@override String get creditCard => 'Número, titular, caducidad, CVC, PIN';
	@override String get bankAccount => 'Titular, IBAN, BIC, PIN';
	@override String get wifi => 'Nombre de la red, contraseña';
	@override String get passport => 'Número, nombre, fechas';
	@override String get note => 'Una nota con formato';
	@override String get authenticator => 'Un código 2FA';
	@override String get custom => 'Aún sin campos';
}

// Path: editItem.templateFields
class _Translations$editItem$templateFields$es extends Translations$editItem$templateFields$en {
	_Translations$editItem$templateFields$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get cardholder => 'Titular de la tarjeta';
	@override String get expiresOn => 'Fecha de caducidad';
	@override String get cvc => 'CVC';
	@override String get accountHolder => 'Titular de la cuenta';
	@override String get iban => 'IBAN';
	@override String get bic => 'BIC';
	@override String get cardPin => 'PIN de la tarjeta';
	@override String get networkName => 'Nombre de la red';
	@override String get fullName => 'Nombre completo';
	@override String get passportNumber => 'Número de pasaporte';
	@override String get issuingCountry => 'País de emisión';
	@override String get dateOfBirth => 'Fecha de nacimiento';
	@override String get placeOfBirth => 'Lugar de nacimiento';
	@override String get issuedOn => 'Fecha de emisión';
}

// Path: editItem.types
class _Translations$editItem$types$es extends Translations$editItem$types$en {
	_Translations$editItem$types$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get username => 'Usuario';
	@override String get password => 'Contraseña';
	@override String get email => 'Correo electrónico';
	@override String get url => 'URL';
	@override String get ipHost => 'IP / Host';
	@override String get date => 'Fecha';
	@override String get month => 'Mes';
	@override String get credit => 'Número de tarjeta';
	@override String get phone => 'Teléfono';
	@override String get pin => 'PIN';
	@override String get totp => 'Código de autenticación';
	@override String get certificate => 'Certificado';
	@override String get sshKey => 'Clave SSH / privada';
	@override String get recoveryCodes => 'Códigos de recuperación';
	@override String get note => 'Nota con formato';
	@override String get text => 'Texto';
}

// Path: audit.weakPassword
class _Translations$audit$weakPassword$es extends Translations$audit$weakPassword$en {
	_Translations$audit$weakPassword$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get label => 'Contraseñas débiles';
	@override String get description => 'Una contraseña es débil cuando el espacio de búsqueda para un atacante es pequeño: es corta, usa un conjunto reducido de caracteres o se basa en una palabra, nombre o secuencia de teclado que aparece en cualquier diccionario de descifrado. Los ataques offline prueban miles de millones de combinaciones por segundo, así que cualquier contraseña en esa categoría cae rápido. Sustitúyela por una larga y generada aleatoriamente.';
}

// Path: audit.reusedPassword
class _Translations$audit$reusedPassword$es extends Translations$audit$reusedPassword$en {
	_Translations$audit$reusedPassword$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get label => 'Contraseñas reutilizadas';
	@override String get description => 'Usar una misma contraseña en varios sitios significa que una sola filtración en cualquiera de ellos las compromete todas, y no tienes forma de saber cuál de esos servicios será el que se filtre. Dale a cada elemento su propia contraseña generada para que una filtración quede contenida a la cuenta de la que proviene.';
}

// Path: audit.compromisedPassword
class _Translations$audit$compromisedPassword$es extends Translations$audit$compromisedPassword$en {
	_Translations$audit$compromisedPassword$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get label => 'Contraseñas comprometidas';
	@override String get description => 'Esta contraseña aparece en un registro público de credenciales filtradas, lo que la convierte en una de las primeras que probarán los atacantes, por fuerte que parezca. Cámbiala en todos los sitios donde la uses: una contraseña solo necesita filtrarse una vez para quedar comprometida para siempre.';
}

// Path: settings.migrate.error
class _Translations$settings$migrate$error$es extends Translations$settings$migrate$error$en {
	_Translations$settings$migrate$error$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get sameProvider => 'La caja fuerte ya está en ese almacenamiento.';
	@override String get busy => 'Todavía hay un guardado en curso. Espera a que termine e inténtalo de nuevo.';
	@override String get sourceExpired => 'Tu sesión actual ha caducado. Vuelve a iniciar sesión antes de mover la caja fuerte.';
	@override String targetExpired({required Object provider}) => 'Tu inicio de sesión en ${provider} ha caducado. No se cambió nada; empieza de nuevo.';
	@override String get verifyFailed => 'La copia guardada no coincidía con tu caja fuerte, así que el archivo antiguo quedó intacto. No se perdió nada; inténtalo de nuevo.';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'KeeperPass',
			'connectivity.offline' => 'Sin conexión a internet',
			'connectivity.online' => 'De nuevo en línea',
			'errors.failures.networkFailure' => 'Algo salió mal. Inténtalo de nuevo.',
			'errors.failures.undocumentedError' => 'Algo salió mal. Inténtalo de nuevo.',
			'errors.failures.platformError' => 'Algo salió mal. Inténtalo de nuevo.',
			'errors.failures.notFound' => 'Algo salió mal. Inténtalo de nuevo.',
			'errors.failures.formatException' => 'Algo salió mal. Inténtalo de nuevo.',
			'errors.failures.unableToProcess' => 'Algo salió mal. Inténtalo de nuevo.',
			'errors.failures.requestTimeout' => 'Algo salió mal. Inténtalo de nuevo.',
			'errors.failures.connectionError' => 'Algo salió mal. Inténtalo de nuevo.',
			'errors.failures.unexpectedError' => 'Algo salió mal. Inténtalo de nuevo.',
			'errors.failures.accessTokenFailure' => 'Algo salió mal. Inténtalo de nuevo.',
			'errors.failures.cacheReadFailure' => 'Algo salió mal. Inténtalo de nuevo.',
			'errors.failures.cacheWriteFailure' => 'Algo salió mal. Inténtalo de nuevo.',
			'errors.drive.authExpired' => 'Tu sesión de Google ha caducado. Vuelve a conectarte.',
			'errors.drive.backupFailed' => 'No se pudo hacer una copia de seguridad de tu caja fuerte actual en Google Drive. Inténtalo de nuevo.',
			'errors.drive.renameFailed' => 'No se pudo renombrar tu archivo de caja fuerte en Google Drive. No se cambió nada; inténtalo de nuevo.',
			'errors.drive.createFolderFailed' => 'No se pudo crear la carpeta keeperpass en Google Drive. Inténtalo de nuevo.',
			'errors.drive.readFailed' => 'No se pudo leer tu caja fuerte desde Google Drive. Inténtalo de nuevo.',
			'errors.drive.saveFailed' => 'No se pudo guardar tu caja fuerte en Google Drive. Inténtalo de nuevo.',
			'errors.drive.unreachable' => 'No se pudo conectar con Google Drive. Inténtalo de nuevo.',
			'errors.dropbox.authExpired' => 'Tu sesión de Dropbox ha caducado. Vuelve a conectarte.',
			'errors.dropbox.profileFailed' => 'No se pudo leer tu perfil de Dropbox. Inténtalo de nuevo.',
			'errors.dropbox.unknown' => 'Algo salió mal al conectar con Dropbox. Inténtalo de nuevo.',
			'errors.dropbox.unreachable' => 'No se pudo conectar con Dropbox. Inténtalo de nuevo.',
			'errors.dropbox.readFailed' => 'No se pudo leer tu caja fuerte desde Dropbox. Inténtalo de nuevo.',
			'errors.dropbox.saveFailed' => 'No se pudo guardar tu caja fuerte en Dropbox. Inténtalo de nuevo.',
			'errors.dropbox.backupFailed' => 'No se pudo hacer una copia de seguridad de tu caja fuerte actual en Dropbox. Inténtalo de nuevo.',
			'errors.dropbox.renameFailed' => 'No se pudo renombrar tu archivo de caja fuerte en Dropbox. No se cambió nada; inténtalo de nuevo.',
			'errors.dropbox.missingScope' => 'A KeeperPass le falta un permiso de Dropbox. Es un problema de configuración que no se arregla iniciando sesión de nuevo.',
			'errors.dropbox.rateLimited' => 'Dropbox nos pide ir más despacio. Espera un momento e inténtalo de nuevo.',
			'errors.auth.profileFailed' => 'No se pudo leer tu perfil de Google. Inténtalo de nuevo.',
			'errors.auth.unknown' => 'Algo salió mal al conectar con Google. Inténtalo de nuevo.',
			'errors.masterPassword.vaultNotFound' => 'No se encontró tu caja fuerte.',
			'errors.vault.accountMismatch' => ({required Object email}) => 'Inicia sesión con ${email} para guardar tus cambios.',
			'errors.vault.driveAccessNotGranted' => 'Google no dio a KeeperPass acceso a los archivos que crea en tu Drive. Vuelve a intentarlo y permite ese acceso en la página de Google.',
			'errors.vault.conflict' => 'Se guardó una versión más reciente de tu caja fuerte desde otro dispositivo. Cárgala antes de editar para que no se sobrescriba nada.',
			'errors.vault.signInCanceled' => 'Inicio de sesión cancelado',
			'errors.vault.unsupported' => 'Esta versión de KeeperPass no puede abrir este archivo de caja fuerte.',
			'errors.vault.corrupt' => 'El archivo de tu caja fuerte está dañado y no se puede abrir.',
			'common.close' => 'Cerrar',
			'common.copy' => 'Copiar',
			'common.copied' => 'Copiado',
			'common.cancel' => 'Cancelar',
			'common.save' => 'Guardar',
			'common.back' => 'Atrás',
			'common.favorite' => 'Favorito',
			'common.showSecret' => 'Mostrar secreto',
			'common.hideSecret' => 'Ocultar secreto',
			'common.empty' => '[vacío]',
			'common.clearSearch' => 'Borrar la búsqueda',
			'common.chooseDate' => 'Elige una fecha',
			'common.chooseMonth' => 'Elige un mes',
			'common.countryCode' => 'Código de país',
			'common.countryCodeValue' => ({required Object country, required Object code}) => 'Código de país: ${country}, ${code}',
			'common.removeTag' => ({required Object tag}) => 'Quitar la etiqueta ${tag}',
			'common.secretChip' => 'Secreto',
			'common.secretToggle' => ({required Object field}) => 'Secreto: ${field}',
			'common.reorderField' => ({required Object field}) => 'Reordenar ${field}',
			'common.removeField' => ({required Object field}) => 'Quitar ${field}',
			'common.changeFieldIcon' => ({required Object field}) => 'Cambiar el icono de ${field}',
			'common.showAll' => ({required Object count}) => 'Mostrar los ${count}',
			'common.showInLargeType' => 'Mostrar en letra grande',
			'common.stepOf' => ({required Object current, required Object total}) => 'Paso ${current} de ${total}',
			'common.next' => 'Siguiente',
			'common.continueAction' => 'Continuar',
			'common.tryAgain' => 'Intentar de nuevo',
			'common.retry' => 'Reintentar',
			'common.show' => 'Mostrar',
			'common.hide' => 'Ocultar',
			'common.gotIt' => 'Entendido',
			'common.disconnect' => 'Desconectar',
			'common.generateSecret' => 'Generar un secreto',
			'common.useAnotherAccount' => 'Usar otra cuenta',
			'common.offlineTitle' => 'Estás sin conexión',
			'common.savingTo' => ({required Object provider}) => 'Guardando en ${provider}…',
			'common.keepOpen' => 'Mantén KeeperPass abierto hasta que termine.',
			'common.typeItAgain' => 'Escríbelo de nuevo',
			'common.secretHiddenValue' => 'Oculto',
			'common.rename' => 'Renombrar',
			'common.done' => 'Listo',
			'strength.veryWeak' => 'Muy débil',
			'strength.weak' => 'Débil',
			'strength.fair' => 'Aceptable',
			'strength.strong' => 'Fuerte',
			'strength.veryStrong' => 'Muy fuerte',
			'strength.meter' => ({required Object level}) => 'Fortaleza: ${level}',
			'totp.invalidCode' => 'Código no válido',
			'totp.invalidKey' => 'La clave de configuración no es válida, así que no se puede generar ningún código.',
			'totp.fixInEdit' => 'Corrígelo en Editar',
			'totp.secondsShort' => ({required Object count}) => '${count} s',
			'totp.secondsLeft' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(count, one: 'Queda ${count} segundo', other: 'Quedan ${count} segundos', ), 
			'settings.migrate.error.sameProvider' => 'La caja fuerte ya está en ese almacenamiento.',
			'settings.migrate.error.busy' => 'Todavía hay un guardado en curso. Espera a que termine e inténtalo de nuevo.',
			'settings.migrate.error.sourceExpired' => 'Tu sesión actual ha caducado. Vuelve a iniciar sesión antes de mover la caja fuerte.',
			'settings.migrate.error.targetExpired' => ({required Object provider}) => 'Tu inicio de sesión en ${provider} ha caducado. No se cambió nada; empieza de nuevo.',
			'settings.migrate.error.verifyFailed' => 'La copia guardada no coincidía con tu caja fuerte, así que el archivo antiguo quedó intacto. No se perdió nada; inténtalo de nuevo.',
			'settings.title' => 'Ajustes',
			'settings.subtitle' => 'Cuenta, idioma, seguridad y datos',
			'settings.account' => 'Cuenta',
			'settings.accountLine' => ({required Object email, required Object storage}) => '${email} · ${storage}',
			'settings.accountNote' => 'El nombre y el correo electrónico proceden de la cuenta con la que iniciaste sesión.',
			'settings.logOut' => 'Cerrar sesión',
			'settings.logOutTitle' => '¿Cerrar sesión?',
			'settings.logOutBody' => ({required Object storage, required Object provider}) => 'Tu caja fuerte se queda cifrada en tu ${storage}. Para volver a abrirla, inicia sesión con ${provider} e introduce tu secreto.',
			'settings.security' => 'Seguridad',
			'settings.lockNow' => 'Bloquear ahora',
			'settings.autoLock' => 'Bloqueo automático',
			'settings.clearClipboard' => 'Borrar portapapeles',
			'settings.hideInSwitcher' => 'Ocultar en el selector de apps',
			'settings.hideInSwitcherNote' => 'Muestra una pantalla de privacidad en lugar de tu caja fuerte',
			'settings.changeSecret' => 'Cambiar secreto',
			'settings.securityNote' => 'Al bloquear, la caja fuerte descifrada se borra de la memoria de este teléfono.',
			'settings.appearance' => 'Apariencia',
			'settings.theme' => 'Tema',
			'settings.themeAuto' => 'Auto',
			'settings.themeLight' => 'Claro',
			'settings.themeDark' => 'Oscuro',
			'settings.language' => 'Idioma',
			'settings.storage' => 'Almacenamiento',
			'settings.whereItLives' => 'Dónde vive tu caja fuerte',
			'settings.moveTo' => ({required Object storage}) => 'Mover la caja fuerte a ${storage}',
			'settings.data' => 'Datos',
			'settings.importCsv' => 'Importar CSV',
			'settings.exportCsv' => 'Exportar CSV',
			'settings.recentExports' => 'Exportaciones recientes',
			'settings.help' => 'Ayuda',
			'settings.howItWorks' => 'Cómo funciona KeeperPass',
			'settings.questions' => 'Preguntas',
			'settings.about' => 'Acerca de KeeperPass',
			'settings.dangerZone' => 'Zona de peligro',
			'settings.archive' => 'Archivar caja fuerte y cerrar sesión',
			'settings.archiveNote' => 'Cambia el nombre del archivo de tu caja fuerte y cierra tu sesión. No se borra nada.',
			'settings.footer' => ({required Object version}) => 'KeeperPass ${version} · Gratis y de código abierto bajo AGPL-3.0',
			'settings.autoLockTitle' => 'Bloqueo automático',
			'settings.autoLockImmediately' => 'Inmediatamente al salir de la app',
			'settings.autoLockImmediatelyShort' => 'Inmediatamente',
			'settings.after1Minute' => 'Después de 1 minuto',
			'settings.after5Minutes' => 'Después de 5 minutos',
			'settings.after10Minutes' => 'Después de 10 minutos',
			'settings.autoLockNote' => 'KeeperPass se bloquea tras este tiempo sin uso. Para volver a desbloquearlo necesitas tu secreto.',
			'settings.clearClipboardTitle' => 'Borrar portapapeles',
			'settings.after30Seconds' => 'Después de 30 segundos',
			'settings.after2Minutes' => 'Después de 2 minutos',
			'settings.never' => 'Nunca',
			'settings.after30s' => 'Tras 30 s',
			'settings.after1Min' => 'Tras 1 min',
			'settings.after2Min' => 'Tras 2 min',
			'settings.clipboardNote' => 'Las contraseñas y los códigos que copies se borran del portapapeles pasado este tiempo, si no has copiado nada más desde entonces.',
			'settings.preview' => 'Vista previa',
			'settings.previewFrom' => 'De GitHub',
			'settings.previewClears' => ({required Object time}) => 'De GitHub · Se borra en ${time}',
			'settings.seconds' => ({required Object n}) => '${n} s',
			'settings.minutes' => ({required Object n}) => '${n} min',
			'settings.languageTitle' => 'Idioma',
			'settings.languageNote' => 'Se guarda solo en este teléfono — no forma parte de tu caja fuerte.',
			'settings.hideInSwitcherBlocks' => 'Muestra una pantalla de privacidad en lugar de tu caja fuerte y bloquea las capturas de pantalla',
			'settings.blockScreenshots' => 'Bloquear capturas de pantalla',
			'settings.blockScreenshotsNote' => 'Solo Android · también bloquea la grabación de pantalla',
			'settings.blockScreenshotsWhileHidden' => 'Activado mientras «Ocultar en el selector de apps» esté activado',
			'auth.unlock.incorrectSecret' => 'Secreto incorrecto. Inténtalo de nuevo.',
			'vaults.defaultName' => 'Mi caja fuerte',
			'welcome.howItWorks' => 'Cómo funciona',
			'welcome.badge' => 'Cifrado de extremo a extremo',
			'welcome.title' => 'Bienvenido a KeeperPass',
			'welcome.description' => 'Tu caja fuerte es un único archivo cifrado en tu propio almacenamiento en la nube. Inicia sesión para abrirla.',
			'welcome.fileTag' => 'Lo que ve tu almacenamiento',
			'welcome.fileMeta' => 'Argon2id · AES-256-GCM',
			'welcome.continueWithGoogle' => 'Continuar con Google',
			'welcome.continueWithDropbox' => 'Continuar con Dropbox',
			'welcome.connecting' => ({required Object provider}) => 'Conectando con ${provider}…',
			'welcome.factAccess' => 'Acceso solo a los archivos que crea KeeperPass',
			'welcome.factEncrypted' => 'Cifrado en este teléfono, con tu propio secreto',
			'welcome.factNoServer' => 'Sin servidor de KeeperPass. Nada va a ningún otro sitio.',
			'welcome.footer' => 'Sin cuenta de KeeperPass: solo la de Google o Dropbox que ya tienes. Al iniciar sesión se crea el archivo de la caja fuerte si aún no lo tienes.',
			'connect.lookingIn' => ({required Object storage}) => 'Buscando en ${storage}…',
			'connect.checkingTitle' => 'Comprobando tu caja fuerte…',
			'connect.checkingDetail' => ({required Object storage}) => 'Buscando vault.json.enc en ${storage}.',
			'connect.foundTitle' => 'Hemos encontrado tu caja fuerte',
			'connect.foundDetail' => 'Abriendo el desbloqueo…',
			'connect.foundMeta' => ({required Object storage}) => 'Encontrado en ${storage}',
			'connect.foundMetaUpdated' => ({required Object storage, required Object time}) => 'Encontrado en ${storage} · actualizado ${time}',
			'connect.canceledDetail' => 'No se conectó nada.',
			'connect.signInFailed' => 'Error al iniciar sesión',
			'connect.offlineDetail' => 'Para iniciar sesión hace falta conexión con Google o Dropbox. Se actualizará solo cuando vuelvas a estar en línea.',
			'connect.welcomeBack' => 'Hola de nuevo,',
			'connect.expiredDetail' => ({required Object provider}) => 'Tu sesión de ${provider} ha caducado. Vuelve a iniciar sesión para desbloquear tu caja fuerte.',
			'connect.lastUsed' => 'Usada por última vez',
			'connect.checkFailedMeta' => ({required Object storage}) => 'No se pudo leer desde ${storage}',
			'connect.checkFailedTitle' => 'No se pudo leer tu caja fuerte',
			'connect.checkFailedDetail' => ({required Object storage}) => '${storage} no respondió. No se cambió nada.',
			'howItWorks.step1Title' => 'Tu caja fuerte vive\nen tu nube',
			'howItWorks.step1Body' => 'KeeperPass guarda un único archivo cifrado en tu Google Drive o Dropbox. No hay ningún servidor de KeeperPass, así que nunca recibimos una copia.',
			'howItWorks.encrypted' => 'Cifrado',
			'howItWorks.step2Title' => 'Elige un secreto',
			'howItWorks.step2Body' => 'Se convierte en la llave. Nunca se envía ni se guarda.',
			'howItWorks.step3Title' => 'Hacen falta los dos',
			'howItWorks.step3Body' => 'Quien tenga tu cuenta de almacenamiento no puede leer tu caja fuerte. Quien tenga tu secreto no puede llegar a ella.',
			'howItWorks.storageAccount' => 'Cuenta de almacenamiento',
			'howItWorks.reachesFile' => 'Llega al archivo',
			'howItWorks.yourSecret' => 'Tu secreto',
			'howItWorks.opensFile' => 'Abre el archivo',
			'howItWorks.technicalDetails' => 'Detalles técnicos',
			'howItWorks.technicalSummary' => 'Argon2id · AES-256',
			'technicalDetails.title' => 'Detalles técnicos',
			'technicalDetails.keyDerivation' => 'Derivación de la clave',
			'technicalDetails.keyDerivationValue' => ({required InlineSpan algorithm}) => TextSpan(children: [ algorithm, const TextSpan(text: ' · 64 MiB de memoria · 3 iteraciones · paralelismo 4, que generan una clave de 256 bits'), ]), 
			'technicalDetails.encryption' => 'Cifrado',
			'technicalDetails.encryptionValue' => ({required InlineSpan algorithm}) => TextSpan(children: [ algorithm, const TextSpan(text: ', que también detecta cualquier cambio en el archivo'), ]), 
			'technicalDetails.googleDrive' => 'Google Drive',
			'technicalDetails.googleDriveValue' => ({required InlineSpan scope}) => TextSpan(children: [ const TextSpan(text: 'El ámbito '), scope, const TextSpan(text: ': solo los archivos que creó KeeperPass'), ]), 
			'technicalDetails.dropbox' => 'Dropbox',
			'technicalDetails.dropboxValue' => ({required InlineSpan folder}) => TextSpan(children: [ const TextSpan(text: 'Una carpeta de la app: '), folder, ]), 
			'technicalDetails.vaultFile' => 'Archivo de la caja fuerte',
			'technicalDetails.vaultFileValue' => ({required InlineSpan file}) => TextSpan(children: [ file, const TextSpan(text: ': un único archivo, cifrado y reescrito de nuevo en cada guardado'), ]), 
			'technicalDetails.viewSource' => 'Ver el código fuente en GitHub',
			'technicalDetails.license' => 'Gratis y de código abierto bajo AGPL-3.0, así que todo esto se puede comprobar.',
			'createVault.eyebrow' => 'Crea tu caja fuerte',
			'createVault.step1Title' => 'Elige tu secreto',
			'createVault.step1Body' => 'Cifra tu caja fuerte en este teléfono. Todo lo que guardes queda protegido con él.',
			'createVault.settingUpFor' => 'Configurando para',
			'createVault.secret' => 'Secreto',
			'createVault.secretPlaceholder' => 'Tu secreto',
			'createVault.generateAnother' => 'Generar otro',
			'createVault.generatedNote' => 'Los secretos generados se saltan el paso de volver a escribirlos.',
			'createVault.weakWarning' => 'Este secreto es débil, lo que facilita romper el cifrado de tu caja fuerte. Puedes continuar, pero se recomienda encarecidamente una frase más larga.',
			'createVault.tipsTitle' => 'Elegir un buen secreto',
			'createVault.tip1' => 'Varias palabras al azar valen más que una palabra ingeniosa: cuanto más largo, más difícil de adivinar.',
			'createVault.tip2' => 'No reutilices una contraseña que uses en otro sitio.',
			'createVault.tip3' => 'Que sea algo que puedas escribir en este teléfono; luego apúntalo y guárdalo en un lugar seguro.',
			'createVault.step2Title' => 'Escríbelo de nuevo',
			'createVault.step2Body' => 'Solo para asegurarnos de que no hay errores. Nadie puede restablecer tu secreto más tarde.',
			'createVault.repeat' => 'Repite el secreto',
			'createVault.mismatch' => 'Los dos secretos no coinciden.',
			'createVault.step3Title' => 'Apúntalo',
			'createVault.step3Body' => 'Lo necesitarás cada vez que desbloquees. Guárdalo en un lugar seguro, lejos de este teléfono.',
			'createVault.secretWords' => ({required Object count}) => 'Tu secreto · ${count} palabras',
			'createVault.secretWhole' => 'Tu secreto',
			'createVault.secretHidden' => 'Tu secreto, oculto',
			'createVault.secretShown' => 'Tu secreto, visible',
			'createVault.readBefore' => 'Lee esto antes de continuar',
			'createVault.bullet1' => 'Tu secreto nunca se envía a ningún sitio ni se guarda. Nadie —ni KeeperPass ni tu proveedor de almacenamiento— puede consultarlo ni restablecerlo.',
			'createVault.bullet2' => 'Si lo olvidas, tu caja fuerte no se puede recuperar. Ningún enlace de restablecimiento ni solicitud de soporte puede abrirla.',
			'createVault.bullet3' => 'Anótalo y guárdalo en un lugar seguro antes de continuar.',
			'createVault.acknowledge' => 'He apuntado mi secreto',
			'createVault.create' => 'Crear caja fuerte',
			'createVault.progressTitle' => 'Creando tu caja fuerte',
			'createVault.encrypting' => 'Cifrando tu caja fuerte…',
			'createVault.encryptingDetail' => 'En este teléfono. Tarda unos segundos.',
			'createVault.encryptingMeta' => 'Cifrando en este teléfono…',
			'createVault.savingDetail' => 'Un único archivo cifrado, en la carpeta keeperpass.',
			'createVault.failedTitle' => 'No se pudo guardar tu caja fuerte',
			'createVault.notSaved' => 'No guardado',
			'createVault.failedDetail' => ({required Object storage}) => '${storage} no respondió. No se guardó nada y tu secreto sigue aquí.',
			'createVault.backToSecret' => 'Volver a tu secreto',
			'unlock.notYou' => '¿No eres tú?',
			'unlock.secret' => 'Secreto',
			'unlock.placeholder' => 'Introduce tu secreto',
			'unlock.unlock' => 'Desbloquear',
			'unlock.unlocking' => 'Desbloqueando…',
			'unlock.unlockingStatus' => 'Desbloqueando en este teléfono…',
			'unlock.slowNote' => 'Unos segundos, a propósito: así adivinar tu secreto es lento.',
			'unlock.forgot' => '¿Olvidaste tu secreto?',
			'unlock.leftApp' => 'Bloqueado al salir de KeeperPass',
			'unlock.unreachableTitle' => ({required Object storage}) => 'No se pudo conectar con ${storage}',
			'unlock.unreachableDetail' => 'Comprueba tu conexión e inténtalo de nuevo. Tu secreto sigue escrito.',
			'unlock.offlineDetail' => ({required Object storage}) => 'Para desbloquear hace falta conexión con ${storage}. «Desbloquear» se activará cuando vuelvas a estar en línea.',
			'unlock.accountLine' => ({required Object email, required Object storage}) => '${email} · ${storage}',
			'unlock.lockedInactivity' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Bloqueado tras ${n} minuto de inactividad', other: 'Bloqueado tras ${n} minutos de inactividad', ), 
			'newVault.backLabel' => 'Desbloquear',
			'newVault.backToUnlock' => 'Volver a desbloqueo',
			'newVault.title' => 'Empezar una caja fuerte nueva',
			'newVault.oldMeta' => 'Caja fuerte antigua · bloqueada con el secreto anterior',
			'newVault.newMeta' => 'Caja fuerte nueva · vacía',
			'newVault.body' => ({required Object provider}) => 'No hay forma de restablecer un secreto olvidado: ni KeeperPass ni ${provider} pueden hacerlo. En su lugar, puedes empezar de nuevo con una caja fuerte nueva y vacía.',
			'newVault.pointLocked' => 'Tu caja fuerte actual sigue bloqueada con el secreto anterior.',
			'newVault.pointKept' => ({required InlineSpan file, required InlineSpan storage}) => TextSpan(children: [ const TextSpan(text: 'Su archivo se conserva como '), file, const TextSpan(text: ' en tu '), storage, const TextSpan(text: '. No se borra nada.'), ]), 
			'newVault.pointFresh' => 'Empiezas de nuevo con una caja fuerte nueva y vacía.',
			'newVault.account' => 'Cuenta',
			'newVault.newSecret' => 'Nuevo secreto',
			'newVault.newSecretPlaceholder' => 'Elige un secreto nuevo',
			'newVault.repeat' => 'Repite el nuevo secreto',
			'newVault.weakWarning' => 'Este secreto es débil, lo que facilita romper el cifrado de tus cajas fuertes. Puedes continuar, pero se recomienda encarecidamente una frase más larga.',
			'newVault.warn' => 'Como el anterior, tu secreto nuevo no se puede consultar ni restablecer. Apúntalo antes de continuar.',
			'newVault.start' => 'Empezar una caja fuerte nueva',
			'newVault.confirmTitle' => '¿Empezar una caja fuerte nueva?',
			'newVault.confirmKept' => ({required Object storage}) => 'Su archivo se conserva como copia de seguridad con fecha en tu ${storage}.',
			'newVault.confirmFresh' => 'Empiezas de nuevo con una caja fuerte vacía protegida con tu secreto nuevo.',
			'newVault.progressTitle' => 'Empezando una caja fuerte nueva',
			'newVault.encrypting' => 'Cifrando tu caja fuerte nueva…',
			'newVault.backingUp' => 'Guardando tu caja fuerte antigua como copia de seguridad…',
			'newVault.backingUpDetail' => ({required Object storage}) => 'Cambiándole el nombre en ${storage}.',
			'newVault.readyMeta' => 'Cifrada · lista para guardar',
			'newVault.backupFailedMeta' => 'No se pudo renombrar · no cambió nada',
			'newVault.nothingChanged' => 'No se cambió nada',
			'newVault.backupFailedDetail' => ({required Object storage}) => 'No se pudo hacer una copia de seguridad de tu caja fuerte actual en ${storage}. No se cambió nada.',
			'newVault.doneTitle' => 'Caja fuerte nueva creada',
			'newVault.doneDetail' => ({required Object storage}) => 'Tu caja fuerte antigua se conserva como copia de seguridad en ${storage}.',
			'tabs.vault' => 'Caja fuerte',
			'tabs.codes' => 'Códigos',
			'tabs.generator' => 'Generador',
			'tabs.security' => 'Seguridad',
			'tabs.settings' => 'Ajustes',
			'tabs.securityFlagged' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Seguridad, ${n} elemento marcado', other: 'Seguridad, ${n} elementos marcados', ), 
			'codes.subtitle' => 'Códigos 2FA de tu caja fuerte, generados en este teléfono',
			'codes.searchPlaceholder' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Buscar en ${n} código', other: 'Buscar en ${n} códigos', ), 
			'codes.codeCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} código', other: '${n} códigos', ), 
			'codes.copied' => 'Código copiado',
			'codes.trust' => 'Generados en este teléfono a partir de las claves de configuración de tu caja fuerte. No se guarda nada nuevo.',
			'codes.emptyTitle' => 'Aún no hay códigos 2FA',
			'codes.emptyBody' => 'Cuando un sitio ofrezca el inicio de sesión en dos pasos, escanea aquí su código QR o añade un elemento Autenticador.',
			'codes.createAuthenticator' => 'Crear un elemento Autenticador',
			'comingSoon.body' => ({required Object part}) => 'Llega en la parte ${part}.',
			'vaultList.lock' => 'Bloquear',
			'vaultList.newItem' => 'Nuevo elemento',
			'vaultList.allVaults' => 'Todas las cajas fuertes',
			'vaultList.favorites' => 'Favoritos',
			'vaultList.recentlyUsed' => 'Usados recientemente',
			'vaultList.statusSaved' => ({required Object items, required Object storage}) => '${items} · Guardado en ${storage}',
			'vaultList.statusInVault' => ({required Object items, required Object vault}) => '${items} en ${vault}',
			'vaultList.statusTagged' => ({required Object items, required Object tag}) => '${items} con la etiqueta ${tag}',
			'vaultList.statusReport' => ({required Object items, required Object report}) => '${items} · ${report}',
			'vaultList.statusNotConnected' => ({required Object storage}) => 'Sin conexión con ${storage}',
			'vaultList.statusOffline' => ({required Object items}) => 'Sin conexión · ${items}',
			'vaultList.reportWeak' => 'Contraseñas débiles',
			'vaultList.reportReused' => 'Contraseñas reutilizadas',
			'vaultList.reportCompromised' => 'Contraseñas comprometidas',
			'vaultList.searchHint' => 'Cada palabra tiene que coincidir, en cualquier orden: nombres, etiquetas, nombres de campo y valores.',
			'vaultList.filterByTag' => 'Filtrar por etiqueta',
			'vaultList.manageTags' => 'Gestionar etiquetas',
			'vaultList.clearFilter' => 'Quitar filtro',
			'vaultList.today' => 'Hoy',
			'vaultList.thisWeek' => 'Esta semana',
			'vaultList.earlier' => 'Anteriores',
			'vaultList.aToZ' => 'De la A a la Z',
			'vaultList.sortHeading' => 'Ordenar por última actualización',
			'vaultList.newestFirst' => 'Más recientes primero',
			'vaultList.oldestFirst' => 'Más antiguos primero',
			'vaultList.refreshing' => ({required Object storage}) => 'Leyendo tu caja fuerte desde ${storage}…',
			'vaultList.copyPasswordFor' => ({required Object name}) => 'Copiar la contraseña de ${name}',
			'vaultList.copyCodeFor' => ({required Object name}) => 'Copiar el código de ${name}',
			'vaultList.copyCardNumberFor' => ({required Object name}) => 'Copiar el número de tarjeta de ${name}',
			'vaultList.swipePassword' => 'Contraseña',
			'vaultList.swipeCode' => 'Código',
			'vaultList.swipeCardNumber' => 'Número de tarjeta',
			'vaultList.swipeUsername' => 'Usuario',
			'vaultList.swipeMore' => 'Más',
			'vaultList.copyPassword' => 'Copiar contraseña',
			'vaultList.copyCode' => 'Copiar código',
			'vaultList.copyCardNumber' => 'Copiar número de tarjeta',
			'vaultList.copyUsername' => 'Copiar usuario',
			'vaultList.moreActions' => 'Más acciones',
			'vaultList.favorite' => 'Favorito',
			'vaultList.addToFavorites' => 'Añadir a favoritos',
			'vaultList.removeFromFavorites' => 'Quitar de favoritos',
			'vaultList.findingWeak' => 'Contraseña débil',
			'vaultList.findingReused' => 'Contraseña reutilizada',
			'vaultList.findingCompromised' => 'Contraseña comprometida',
			'vaultList.findingWeakReused' => 'Contraseña débil y reutilizada',
			'vaultList.findingWeakCompromised' => 'Contraseña débil y comprometida',
			'vaultList.findingReusedCompromised' => 'Contraseña reutilizada y comprometida',
			'vaultList.findingAll' => 'Contraseña débil, reutilizada y comprometida',
			'vaultList.unnamed' => 'Nuevo elemento',
			'vaultList.scopeTitle' => 'Cajas fuertes',
			'vaultList.manageVaults' => 'Gestionar cajas fuertes',
			'vaultList.scopeNote' => ({required Object storage}) => 'Todas tus cajas fuertes están en un único archivo cifrado, vault.json.enc, en tu ${storage}.',
			'vaultList.quickActions' => ({required Object name}) => '${name}, acciones rápidas',
			'vaultList.openWebsite' => 'Abrir sitio web',
			'vaultList.moveToVault' => 'Mover a una caja fuerte…',
			'vaultList.select' => 'Seleccionar',
			'vaultList.delete' => 'Eliminar',
			'vaultList.selectAll' => 'Seleccionar todo',
			'vaultList.selectOrDeselectAll' => 'Seleccionar o deseleccionar todo',
			'vaultList.listTwo' => ({required Object a, required Object b}) => '${a} y ${b}',
			'vaultList.listThree' => ({required Object a, required Object b, required Object c}) => '${a}, ${b} y ${c}',
			'vaultList.deleteItemTitle' => 'Eliminar elemento',
			'vaultList.deleteItemConfirm' => ({required Object name}) => '¿Seguro que quieres eliminar «${name}»? Esto no se puede deshacer.',
			'vaultList.deleteItemAction' => 'Eliminar elemento',
			'vaultList.moveToVaultTitle' => 'Mover a otra caja fuerte',
			'vaultList.moveDescription' => 'Elige la caja fuerte en la que debería estar este elemento.',
			'vaultList.current' => 'Actual',
			'vaultList.newVaultOption' => 'Nueva caja fuerte…',
			'vaultList.noOtherVaultOne' => 'No hay otra caja fuerte a la que mover este elemento.',
			'vaultList.noOtherVaultMany' => 'No hay otra caja fuerte a la que mover estos elementos.',
			'vaultList.noOtherVaultDetail' => 'Una segunda caja fuerte mantiene un conjunto de elementos aparte — trabajo separado de lo personal, o lo compartido de lo privado.',
			'vaultList.createAVault' => 'Crear una caja fuerte',
			'vaultList.newVaultTitle' => 'Nueva caja fuerte',
			'vaultList.newVaultBody' => 'Una caja fuerte es un grupo aparte de elementos. A diferencia de un elemento, no hay nada más que elegir de entrada.',
			'vaultList.vaultName' => 'Nombre de la caja fuerte',
			'vaultList.duplicateVault' => 'Ya existe una caja fuerte con este nombre.',
			'vaultList.noItemsTitle' => 'Todavía no tienes ningún elemento.',
			'vaultList.noItemsBody' => 'Añade tu primer inicio de sesión, tarjeta o nota. Cada uno se cifra en este teléfono antes de guardarse.',
			'vaultList.importCsv' => 'Importar desde CSV',
			'vaultList.vaultReady' => 'Tu caja fuerte está lista. Todavía no hay nada.',
			'vaultList.savedMeta' => ({required Object storage, required Object items}) => 'Guardado en ${storage} · ${items}',
			'vaultList.vaultEmptyTitle' => 'Esta caja fuerte todavía no tiene elementos.',
			'vaultList.vaultEmptyBody' => ({required Object vault}) => 'Añade uno aquí o mueve elementos desde ${vault}.',
			'vaultList.noFavoritesTitle' => 'Todavía no tienes ningún favorito.',
			'vaultList.noFavoritesBody' => 'Toca la estrella de cualquier elemento para tenerlo aquí.',
			'vaultList.nothingRecentTitle' => 'Todavía no has usado nada',
			'vaultList.nothingRecentBody' => 'Los elementos que abres o de los que copias aparecen aquí, los más recientes primero.',
			'vaultList.noResultsTitle' => 'Tu búsqueda no coincide con ningún elemento.',
			'vaultList.noResultsBody' => 'Cada palabra tiene que coincidir. Prueba con menos palabras o revisa la ortografía.',
			'vaultList.allClearWeak' => 'Todas las contraseñas de tu caja fuerte son suficientemente seguras.',
			'vaultList.allClearReused' => 'Cada contraseña de tu caja fuerte se usa exactamente una vez.',
			'vaultList.allClearCompromised' => 'Ninguna de tus contraseñas apareció en una filtración conocida.',
			'vaultList.allClearBody' => 'Aquí no hay nada que arreglar. KeeperPass vuelve a comprobarlo cada vez que cambia una contraseña.',
			'vaultList.backToSecurity' => 'Volver a Seguridad',
			'vaultList.fieldCopied' => ({required Object field}) => '${field} copiado',
			'vaultList.copiedFrom' => ({required Object item}) => 'De ${item}',
			'vaultList.itemCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} elemento', other: '${n} elementos', ), 
			'vaultList.statusNotSaved' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} cambio sin guardar', other: '${n} cambios sin guardar', ), 
			'vaultList.searchPlaceholder' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Buscar en ${n} elemento', other: 'Buscar en ${n} elementos', ), 
			'vaultList.results' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} resultado', other: '${n} resultados', ), 
			'vaultList.selectedCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} seleccionado', other: '${n} seleccionados', ), 
			'vaultList.moveItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Mover ${n} elemento', other: 'Mover ${n} elementos', ), 
			'vaultList.moveItemsTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Mover ${n} elemento', other: 'Mover ${n} elementos', ), 
			'vaultList.deleteItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Eliminar ${n} elemento', other: 'Eliminar ${n} elementos', ), 
			'vaultList.deleteTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '¿Eliminar ${n} elemento?', other: '¿Eliminar ${n} elementos?', ), 
			'vaultList.deleteFromVault' => ({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${names} se eliminará de ${vault}. Esto no se puede deshacer.', other: '${names} se eliminarán de ${vault}. Esto no se puede deshacer.', ), 
			'vaultList.deleteFromVaults' => ({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${names} se eliminará. Esto no se puede deshacer.', other: '${names} se eliminarán. Esto no se puede deshacer.', ), 
			'vaultList.moveLine' => ({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${names} se mueve con su historial y sus etiquetas.', other: '${names} se mueven con su historial y sus etiquetas.', ), 
			'vaultList.movedTitle' => ({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${names} se movió a ${vault}', other: '${names} se movieron a ${vault}', ), 
			'vaultList.movedDetail' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Conserva su historial y sus etiquetas.', other: 'Conservan su historial y sus etiquetas.', ), 
			'vaultList.itemsOf' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${count} de ${n} elemento', other: '${count} de ${n} elementos', ), 
			'itemDetail.edit' => 'Editar',
			'itemDetail.editItem' => 'Editar elemento',
			'itemDetail.moreOptions' => 'Más opciones',
			'itemDetail.updatedAgo' => ({required Object ago}) => 'Actualizado ${ago}',
			'itemDetail.showTagged' => ({required Object tag}) => 'Mostrar elementos con la etiqueta ${tag}',
			'itemDetail.fields' => 'Campos',
			'itemDetail.noFields' => 'Este elemento no tiene campos.',
			'itemDetail.history' => 'Historial',
			'itemDetail.currentVersion' => 'Versión actual',
			'itemDetail.todayAt' => ({required Object time}) => 'Hoy, ${time}',
			'itemDetail.unnamedField' => 'Sin nombre',
			'itemDetail.copyField' => ({required Object field}) => 'Copiar ${field}',
			'itemDetail.revealValue' => 'Mostrar valor',
			'itemDetail.hideValue' => 'Ocultar valor',
			'itemDetail.hiddenValue' => ({required Object field}) => '${field}, oculto',
			'itemDetail.openSite' => ({required Object site}) => 'Abrir ${site}',
			'itemDetail.call' => 'Llamar',
			'itemDetail.message' => 'Mensaje',
			'itemDetail.checksumFail' => 'Ese número no supera su suma de comprobación — probablemente uno de los dígitos sea incorrecto.',
			'itemDetail.codeCardHint' => 'Toca para copiar · también en la pestaña Códigos',
			'itemDetail.copyAllCodes' => 'Copiar todos los códigos',
			'itemDetail.copyCodeNumber' => ({required Object n}) => 'Copiar código ${n}',
			'itemDetail.cardFace' => 'Tarjeta, número oculto',
			'itemDetail.cardFaceBrand' => ({required Object brand}) => 'Tarjeta ${brand}, número oculto',
			'itemDetail.cardExpires' => ({required Object date}) => 'caduca en ${date}',
			'itemDetail.largeTypeTurn' => 'Gira el teléfono para leerlo en una sola línea.',
			'itemDetail.largeTypeHides' => 'Se vuelve a ocultar al salir de esta pantalla.',
			'itemDetail.earlierVersion' => 'Versión anterior',
			'itemDetail.readOnly' => ({required Object ago}) => '${ago} · solo lectura',
			'itemDetail.changedSince' => 'Cambiado desde entonces',
			'itemDetail.restoreThisVersion' => 'Restaurar esta versión',
			'itemDetail.deleteVersion' => 'Eliminar versión',
			'itemDetail.restoreTitle' => '¿Restaurar esta versión?',
			'itemDetail.restoreBody' => ({required Object name, required Object date}) => '${name} vuelve a como estaba el ${date}. La versión actual se queda en su historial.',
			'itemDetail.restore' => 'Restaurar',
			'itemDetail.deleteVersionTitle' => 'Eliminar esta versión',
			'itemDetail.deleteVersionConfirm' => '¿Seguro que quieres eliminar esta versión del historial? Esto no se puede deshacer.',
			'itemDetail.delete' => 'Eliminar',
			'itemDetail.notFound' => 'Este elemento ya no existe.',
			'itemDetail.notFoundHint' => 'Puede que se haya eliminado desde otro dispositivo.',
			'itemDetail.backToVault' => 'Volver a la caja fuerte',
			'itemDetail.hiddenLines' => ({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${field}, oculto, ${n} línea', other: '${field}, oculto, ${n} líneas', ), 
			'itemDetail.largeTypeLabel' => ({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${field} en letra grande, ${n} carácter', other: '${field} en letra grande, ${n} caracteres', ), 
			'editItem.newVaultItem' => 'Nuevo elemento de la caja fuerte',
			'editItem.vault' => 'Caja fuerte',
			'editItem.template' => 'Plantilla',
			'editItem.templateNote' => 'Las plantillas son solo un punto de partida: cambia el nombre, quita o añade campos cuando quieras.',
			'editItem.templates.website' => 'Sitio web o app',
			'editItem.templates.computer' => 'Ordenador',
			'editItem.templates.creditCard' => 'Tarjeta de crédito',
			'editItem.templates.bankAccount' => 'Cuenta bancaria',
			'editItem.templates.wifi' => 'Red Wi-Fi',
			'editItem.templates.passport' => 'Pasaporte',
			'editItem.templates.note' => 'Nota',
			'editItem.templates.authenticator' => 'Autenticador',
			'editItem.templates.custom' => 'Personalizado',
			'editItem.templateHints.website' => 'Usuario, contraseña, URL',
			'editItem.templateHints.computer' => 'Usuario, contraseña',
			'editItem.templateHints.creditCard' => 'Número, titular, caducidad, CVC, PIN',
			'editItem.templateHints.bankAccount' => 'Titular, IBAN, BIC, PIN',
			'editItem.templateHints.wifi' => 'Nombre de la red, contraseña',
			'editItem.templateHints.passport' => 'Número, nombre, fechas',
			'editItem.templateHints.note' => 'Una nota con formato',
			'editItem.templateHints.authenticator' => 'Un código 2FA',
			'editItem.templateHints.custom' => 'Aún sin campos',
			'editItem.templateFields.cardholder' => 'Titular de la tarjeta',
			'editItem.templateFields.expiresOn' => 'Fecha de caducidad',
			'editItem.templateFields.cvc' => 'CVC',
			'editItem.templateFields.accountHolder' => 'Titular de la cuenta',
			'editItem.templateFields.iban' => 'IBAN',
			'editItem.templateFields.bic' => 'BIC',
			'editItem.templateFields.cardPin' => 'PIN de la tarjeta',
			'editItem.templateFields.networkName' => 'Nombre de la red',
			'editItem.templateFields.fullName' => 'Nombre completo',
			'editItem.templateFields.passportNumber' => 'Número de pasaporte',
			'editItem.templateFields.issuingCountry' => 'País de emisión',
			'editItem.templateFields.dateOfBirth' => 'Fecha de nacimiento',
			'editItem.templateFields.placeOfBirth' => 'Lugar de nacimiento',
			'editItem.templateFields.issuedOn' => 'Fecha de emisión',
			'editItem.types.username' => 'Usuario',
			'editItem.types.password' => 'Contraseña',
			'editItem.types.email' => 'Correo electrónico',
			'editItem.types.url' => 'URL',
			'editItem.types.ipHost' => 'IP / Host',
			'editItem.types.date' => 'Fecha',
			'editItem.types.month' => 'Mes',
			_ => null,
		} ?? switch (path) {
			'editItem.types.credit' => 'Número de tarjeta',
			'editItem.types.phone' => 'Teléfono',
			'editItem.types.pin' => 'PIN',
			'editItem.types.totp' => 'Código de autenticación',
			'editItem.types.certificate' => 'Certificado',
			'editItem.types.sshKey' => 'Clave SSH / privada',
			'editItem.types.recoveryCodes' => 'Códigos de recuperación',
			'editItem.types.note' => 'Nota con formato',
			'editItem.types.text' => 'Texto',
			'editItem.newItem' => 'Nuevo elemento',
			'editItem.editItem' => 'Editar elemento',
			'editItem.changeIcon' => 'Cambiar icono',
			'editItem.name' => 'Nombre',
			'editItem.namePlaceholder' => 'p. ej., GitHub',
			'editItem.tags' => 'Etiquetas',
			'editItem.addField' => 'Añadir campo',
			'editItem.addFieldTitle' => 'Añadir campo',
			'editItem.noFieldsTitle' => 'Aún no hay campos',
			'editItem.noFieldsBody' => 'Añade cualquiera de los 16 tipos de campo: un número de póliza, un número de teléfono, un PIN.',
			'editItem.fieldNamePlaceholder' => 'Nombre del campo',
			'editItem.addTag' => 'Añadir una etiqueta',
			'editItem.tagSuggestions' => 'Sugerencias de etiquetas',
			'editItem.createTag' => ({required Object name}) => 'Crear «${name}»',
			'editItem.tagTooLong' => 'Ese nombre es demasiado largo.',
			'editItem.removeFieldTitle' => '¿Seguro que quieres quitar este campo?',
			'editItem.removeFieldBody' => ({required Object field, required Object item}) => '«${field}» y su valor desaparecen de ${item} al guardar.',
			'editItem.remove' => 'Quitar',
			'editItem.discardTitle' => '¿Descartar los cambios?',
			'editItem.discardBody' => ({required Object name}) => 'Tus cambios en ${name} no se han guardado. Al descartarlos, el elemento queda como estaba.',
			'editItem.discardNewTitle' => '¿Descartar este elemento nuevo?',
			'editItem.discardNewBody' => 'No se ha guardado. Al descartarlo, se pierde.',
			'editItem.discard' => 'Descartar',
			'editItem.usernamePlaceholder' => 'Usuario o correo electrónico',
			'editItem.passwordPlaceholder' => 'Contraseña',
			'editItem.valuePlaceholder' => 'Escribe el valor aquí',
			'editItem.ipHostPlaceholder' => 'p. ej., 192.168.1.1, ::1 o db.ejemplo.com',
			'editItem.recoveryCodesPlaceholder' => 'Uno por línea — cualquier formato sirve',
			'editItem.notEmail' => 'Eso no parece una dirección de correo electrónico.',
			'editItem.phoneNumber' => 'Número de teléfono',
			'editItem.searchCountries' => 'Buscar países',
			'editItem.noCountryMatch' => 'Ningún país coincide.',
			'editItem.generate' => 'Generar',
			'editItem.generatePassword' => 'Generar una contraseña',
			'editItem.currentCode' => 'Código actual',
			'editItem.scanQr' => 'Escanear código QR',
			'editItem.enterSetupKey' => 'Introducir clave de configuración',
			'editItem.setupKeyTitle' => 'Introducir clave de configuración',
			'editItem.setupKeyBody' => 'Los sitios muestran una clave de configuración junto al código QR, a menudo en «¿No puedes escanearlo?».',
			'editItem.setupKey' => 'Clave de configuración',
			'editItem.setupKeyHint' => 'Los espacios y las mayúsculas dan igual.',
			'editItem.saveCode' => 'Guardar código',
			'editItem.chooseIcon' => 'Elegir icono',
			'editItem.searchIcons' => 'Buscar iconos — prueba «banco» o «candado»',
			'editItem.popular' => 'Populares',
			'editItem.noIcons' => ({required Object search}) => 'Ningún icono coincide con «${search}».',
			'editItem.useDefaultIcon' => 'Usar icono predeterminado',
			'editItem.iconMatches' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} resultado', other: '${n} resultados', ), 
			'generator.title' => 'Generar una contraseña',
			'generator.notFilledIn' => 'No se rellena nada hasta que lo aceptes.',
			'generator.generated' => 'Contraseña generada',
			'generator.mode' => 'Modo',
			'generator.passphrase' => 'Frase de contraseña',
			'generator.randomString' => 'Cadena aleatoria',
			'generator.words' => 'Palabras',
			'generator.fewerWords' => 'Menos palabras',
			'generator.moreWords' => 'Más palabras',
			'generator.length' => 'Longitud',
			'generator.shorter' => 'Más corta',
			'generator.longer' => 'Más larga',
			'generator.wordSeparator' => 'Separador de palabras',
			'generator.dash' => 'Guion',
			'generator.underscore' => 'Guion bajo',
			'generator.slash' => 'Barra',
			'generator.space' => 'Espacio',
			'generator.language' => 'Idioma',
			'generator.regenerate' => 'Regenerar',
			'generator.charCount' => ({required Object count}) => '${count} caracteres',
			'generator.lowercase' => 'Letras minúsculas',
			'generator.uppercase' => 'Letras mayúsculas',
			'generator.digits' => 'Dígitos',
			'generator.symbols' => 'Símbolos',
			'generator.pickOne' => 'Elige al menos un tipo de carácter.',
			'generator.use' => 'Usar esta contraseña',
			'generator.wordCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} palabra', other: '${n} palabras', ), 
			'generator.pageTitle' => 'Generador de contraseñas',
			'generator.subtitle' => 'Contraseñas y frases de contraseña aleatorias, creadas en este dispositivo',
			'generator.separatorDash' => 'Guion ( - )',
			'generator.separatorUnderscore' => 'Guion bajo ( _ )',
			'generator.separatorSlash' => 'Barra ( / )',
			'generator.separatorSpace' => 'Espacio',
			'generator.nothingToGenerate' => 'Nada que generar.',
			'generator.copyPassword' => 'Copiar contraseña',
			'generator.copied' => 'Contraseña copiada',
			'generator.fromGenerator' => 'Del generador',
			'report.title' => 'Informe de seguridad',
			'report.subtitle' => 'Qué tan seguras son tus contraseñas guardadas',
			'report.healthLabel' => 'Salud de la caja fuerte',
			'report.healthGood' => 'Sólida',
			'report.healthFair' => 'Mejorable',
			'report.healthPoor' => 'En riesgo',
			'report.allClearTitle' => 'No se encontraron problemas',
			'report.allClearDescription' => 'Todas las contraseñas de tus cajas fuertes pasaron la última auditoría.',
			'report.aboutSection' => ({required Object title}) => 'Acerca de ${title}',
			'report.nothingFound' => 'No se encontró nada',
			'report.openItem' => ({required Object name}) => 'Abrir ${name}',
			'report.checkAgain' => 'Volver a comprobar',
			'report.statWeak' => 'Débiles',
			'report.statReused' => 'Reutilizadas',
			'report.statCompromised' => 'Comprometidas',
			'report.statValue' => ({required Object label, required Object count}) => '${label}: ${count}',
			'report.statNotChecked' => ({required Object label}) => '${label}: aún sin comprobar',
			'report.healthPercent' => ({required Object title, required Object score}) => '${title} ${score} por ciento',
			'report.sameAs' => ({required Object names}) => 'Igual que en ${names}',
			'report.sameAsField' => 'Igual que otra contraseña de este elemento',
			'report.foundInBreach' => 'Encontrada en una filtración conocida',
			'report.trust' => 'La comprobación de filtraciones usa Have I Been Pwned con k-anonimato: solo los primeros 5 caracteres de un hash SHA-1 salen de este teléfono.',
			'report.lastCheckedJustNow' => 'Última comprobación: ahora mismo',
			'report.lastCheckedToday' => ({required Object time}) => 'Última comprobación: hoy a las ${time}',
			'report.lastCheckedOn' => ({required Object date}) => 'Última comprobación: ${date}',
			'report.checking' => 'Comprobando…',
			'report.checkingBreaches' => ({required Object done, required Object total}) => 'Buscando filtraciones · ${done} de ${total}',
			'report.progress' => ({required Object done, required Object total}) => '${done} de ${total}',
			'report.progressTime' => ({required Object done, required Object total, required Object time}) => '${done} de ${total} · ${time}',
			'report.offlineBody' => 'No se pudieron comprobar tus contraseñas. La comprobación necesita conexión.',
			'report.failedTitle' => 'La comprobación no pudo terminar',
			'report.failedBody' => 'Vuelve a intentarlo en un momento.',
			'report.nothingTitle' => 'Aún no hay nada que comprobar',
			'report.nothingBody' => 'Guarda un elemento con contraseña y se comprobará aquí, en este teléfono, si hay contraseñas débiles, reutilizadas o filtradas.',
			'report.howToFix' => 'Cómo solucionarlo',
			'report.stepOpen' => 'Abre el elemento',
			'report.stepGenerate' => 'Toca Editar y luego Generar en la contraseña',
			'report.stepSave' => 'Guarda: la marca desaparece sola',
			'report.stepSaveCompromised' => 'Guarda y cámbiala también en el sitio',
			'report.changePassword' => 'Cambiar contraseña',
			'report.fixedClear' => ({required Object name}) => 'Guardado · ${name} ya no está marcado',
			'report.fixedFlagged' => ({required Object name}) => 'Guardado · ${name} sigue marcado',
			'report.savedTo' => ({required Object storage}) => 'Tu caja fuerte se guardó en ${storage}',
			'report.noLongerWeak' => 'Ya no es débil',
			'report.noLongerReused' => 'Ya no está reutilizada',
			'report.noLongerWeakOrReused' => 'Ya no es débil ni está reutilizada',
			'report.hintReusedOne' => ({required Object n}) => 'Estos ${n} comparten una contraseña. Dale a cada uno la suya: abre uno, toca Editar y luego Generar.',
			'report.hintReusedSome' => 'Algunos comparten contraseña. Dale a cada uno la suya: abre uno, toca Editar y luego Generar.',
			'report.hintWeak' => 'Dale a cada uno una más segura: ábrelo, toca Editar y luego Generar.',
			'report.hintCompromised' => 'Estos aparecen en filtraciones conocidas. Cambia cada uno: ábrelo, toca Editar y luego Generar.',
			'report.itemsChecked' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} elemento con contraseña revisado', other: '${n} elementos con contraseña revisados', ), 
			'report.flagged' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} elemento marcado', other: '${n} elementos marcados', ), 
			'report.sameAsOthers' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Igual que en ${n} elemento más', other: 'Igual que en ${n} elementos más', ), 
			'report.checkingPasswords' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Comprobando ${n} contraseña', other: 'Comprobando ${n} contraseñas', ), 
			'report.aboutSeconds' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'alrededor de ${n} segundo', other: 'alrededor de ${n} segundos', ), 
			'report.aboutMinutes' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'alrededor de ${n} minuto', other: 'alrededor de ${n} minutos', ), 
			'audit.weakPassword.label' => 'Contraseñas débiles',
			'audit.weakPassword.description' => 'Una contraseña es débil cuando el espacio de búsqueda para un atacante es pequeño: es corta, usa un conjunto reducido de caracteres o se basa en una palabra, nombre o secuencia de teclado que aparece en cualquier diccionario de descifrado. Los ataques offline prueban miles de millones de combinaciones por segundo, así que cualquier contraseña en esa categoría cae rápido. Sustitúyela por una larga y generada aleatoriamente.',
			'audit.reusedPassword.label' => 'Contraseñas reutilizadas',
			'audit.reusedPassword.description' => 'Usar una misma contraseña en varios sitios significa que una sola filtración en cualquiera de ellos las compromete todas, y no tienes forma de saber cuál de esos servicios será el que se filtre. Dale a cada elemento su propia contraseña generada para que una filtración quede contenida a la cuenta de la que proviene.',
			'audit.compromisedPassword.label' => 'Contraseñas comprometidas',
			'audit.compromisedPassword.description' => 'Esta contraseña aparece en un registro público de credenciales filtradas, lo que la convierte en una de las primeras que probarán los atacantes, por fuerte que parezca. Cámbiala en todos los sitios donde la uses: una contraseña solo necesita filtrarse una vez para quedar comprometida para siempre.',
			'myVaults.title' => 'Mis cajas fuertes',
			'myVaults.subtitle' => 'Grupos separados de elementos: trabajo, familia, personal',
			'myVaults.defaultBadge' => 'Predeterminada',
			'myVaults.newVault' => 'Nueva caja fuerte',
			'myVaults.emptyTitle' => 'Solo tienes la caja fuerte predeterminada',
			'myVaults.emptyBody' => 'Una segunda caja fuerte mantiene un conjunto de elementos aparte — trabajo separado de lo personal, o lo compartido de lo privado.',
			'myVaults.createdOn' => ({required Object date}) => 'creada el ${date}',
			'myVaults.renameTitle' => 'Renombrar caja fuerte',
			'myVaults.renameBody' => 'Los elementos que contiene no se ven afectados.',
			'myVaults.duplicateRename' => ({required Object name}) => 'Ya existe una caja fuerte llamada «${name}».',
			'myVaults.deleteTitle' => ({required Object name}) => '¿Eliminar «${name}»?',
			'myVaults.deleteAction' => 'Eliminar caja fuerte',
			'myVaults.renameAria' => ({required Object name}) => 'Renombrar ${name}',
			'myVaults.deleteAria' => ({required Object name}) => 'Eliminar ${name}',
			'myVaults.itemCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} elemento', other: '${n} elementos', ), 
			'myVaults.deleteBody' => ({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Su ${n} elemento se moverá a ${vault}. Esto no se puede deshacer.', other: 'Sus ${n} elementos se moverán a ${vault}. Esto no se puede deshacer.', ), 
			'myVaults.deleteSelectedTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '¿Eliminar ${n} caja fuerte?', other: '¿Eliminar ${n} cajas fuertes?', ), 
			'myVaults.deleteSelectedBody' => ({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Todo lo que contienen — ${n} elemento — se moverá a ${vault}. Esto no se puede deshacer.', other: 'Todo lo que contienen — ${n} elementos — se moverá a ${vault}. Esto no se puede deshacer.', ), 
			'myVaults.personalSummary' => ({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${name} tiene ${n} elemento y no se puede renombrar ni eliminar.', other: '${name} tiene ${n} elementos y no se puede renombrar ni eliminar.', ), 
			'myVaults.selected' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} caja fuerte seleccionada', other: '${n} cajas fuertes seleccionadas', ), 
			'myVaults.deleteVaults' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Eliminar ${n} caja fuerte', other: 'Eliminar ${n} cajas fuertes', ), 
			'tags.title' => 'Etiquetas',
			'tags.subtitle' => 'Etiquetas que atraviesan las cajas fuertes, para encontrar todo rápido',
			'tags.since' => ({required Object date}) => 'desde ${date}',
			'tags.addTag' => 'Añadir etiqueta',
			'tags.addTitle' => 'Añadir etiqueta',
			'tags.emptyTitle' => 'Todavía no hay etiquetas',
			'tags.emptyBody' => 'Las etiquetas se crean desde un elemento o desde aquí — de cualquier forma, agrupan elementos entre cajas fuertes.',
			'tags.addBody' => 'Una etiqueta sin elementos todavía. Asígnala a un elemento desde la propia página de ese elemento.',
			'tags.tagName' => 'Nombre de la etiqueta',
			'tags.duplicate' => 'Ya existe una etiqueta con este nombre.',
			'tags.colorNote' => 'Su color sale de su nombre.',
			'tags.renameTitle' => 'Renombrar etiqueta',
			'tags.renameBody' => 'Se actualiza en todos los elementos que la llevan.',
			'tags.mergeNotice' => ({required Object name}) => '«${name}» ya existe — al renombrarla se combinarán.',
			'tags.deleteTitle' => ({required Object name}) => '¿Eliminar «${name}»?',
			'tags.deleteAction' => 'Eliminar etiqueta',
			'tags.deleteSelectedBody' => 'Cada una se quitará de todos los elementos que la lleven. Los elementos en sí se conservan. Esto no se puede deshacer.',
			'tags.footer' => 'Toca una etiqueta para ver sus elementos en la pestaña Caja fuerte.',
			'tags.renameAria' => ({required Object name}) => 'Renombrar ${name}',
			'tags.deleteAria' => ({required Object name}) => 'Eliminar ${name}',
			'tags.itemCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} elemento', other: '${n} elementos', ), 
			'tags.deleteBody' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Se quitará de ${n} elemento. Los elementos en sí se conservan. Esto no se puede deshacer.', other: 'Se quitará de ${n} elementos. Los elementos en sí se conservan. Esto no se puede deshacer.', ), 
			'tags.deleteSelectedTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '¿Eliminar ${n} etiqueta?', other: '¿Eliminar ${n} etiquetas?', ), 
			'tags.selected' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} etiqueta seleccionada', other: '${n} etiquetas seleccionadas', ), 
			'tags.deleteTags' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Eliminar ${n} etiqueta', other: 'Eliminar ${n} etiquetas', ), 
			'changeSecret.title' => 'Cambiar secreto',
			'changeSecret.intro' => 'Tu caja fuerte se vuelve a cifrar con el nuevo secreto y se sube de nuevo. No se puede recuperar si lo olvidas.',
			'changeSecret.current' => 'Secreto actual',
			'changeSecret.wrong' => 'Ese no es tu secreto actual.',
			'changeSecret.match' => 'Los dos secretos coinciden.',
			'changeSecret.otherDevices' => 'Los demás dispositivos te pedirán el nuevo secreto la próxima vez que abran tu caja fuerte.',
			'changeSecret.submit' => 'Cambiar secreto',
			'changeSecret.verifyingMeta' => 'Comprobando tu secreto actual…',
			'changeSecret.verifyingTitle' => 'Verificando tu secreto actual…',
			'changeSecret.stepVerify' => 'Verificando tu secreto actual',
			'changeSecret.stepVerifyNote' => 'Deliberadamente lento en un teléfono — eso es lo que encarece adivinarlo',
			'changeSecret.stepEncrypt' => 'Cifrando con el nuevo secreto',
			'changeSecret.stepSave' => 'Guardando tu caja fuerte',
			'changeSecret.savingMeta' => ({required Object storage}) => 'Guardando en ${storage}…',
			'changeSecret.savingTitle' => ({required Object percent}) => 'Guardando tu caja fuerte… ${percent}%',
			'changeSecret.stepVerified' => 'Secreto actual verificado',
			'changeSecret.stepEncrypted' => 'Cifrado con el nuevo secreto',
			'changeSecret.stepSaving' => ({required Object storage}) => 'Guardando en ${storage}',
			'changeSecret.keepOpen' => 'Mantén KeeperPass abierto hasta que termine.',
			'changeSecret.doneMeta' => ({required Object storage}) => 'Guardado en ${storage}',
			'changeSecret.doneTitle' => 'Tu secreto se ha cambiado',
			'changeSecret.doneBody' => 'Todos tus elementos siguen contigo. Los demás dispositivos te pedirán el nuevo secreto la próxima vez que abran tu caja fuerte.',
			'changeSecret.toast' => 'Secreto cambiado',
			'changeSecret.failTitle' => 'No se guardó tu caja fuerte',
			'changeSecret.failBody' => ({required Object storage}) => 'No se pudo conectar con ${storage}. Tu secreto no ha cambiado: la caja fuerte se sigue abriendo con el actual.',
			'storage.title' => 'Almacenamiento',
			'storage.subtitle' => 'Dónde vive tu caja fuerte y qué puede acceder a ella',
			'storage.diagram' => ({required Object storage}) => 'Cifrada en este teléfono y guardada en tu ${storage}',
			'storage.thisPhone' => 'Este teléfono',
			'storage.encryptedOnly' => 'Solo el archivo cifrado',
			'storage.googleFolder' => 'carpeta keeperpass',
			'storage.dropboxFolder' => 'carpeta Apps/keeperpass',
			'storage.savedToday' => ({required Object folder, required Object time}) => '${folder} · guardado hoy a las ${time}',
			'storage.savedOn' => ({required Object folder, required Object date}) => '${folder} · guardado el ${date}',
			'storage.access' => 'Acceso',
			'storage.googlePermissions' => 'Permisos de la cuenta de Google',
			'storage.dropboxApps' => 'Apps conectadas a Dropbox',
			'storage.accessNote' => 'KeeperPass solo puede acceder a los archivos que crea. Puedes revocar ese acceso aquí en cualquier momento; el archivo de la caja fuerte se queda donde está.',
			'moveVault.title' => 'Mover caja fuerte',
			'moveVault.diagram' => ({required Object from, required Object to}) => 'Tu caja fuerte se mueve de ${from} a ${to}',
			'moveVault.from' => 'Origen',
			'moveVault.to' => 'Destino',
			'moveVault.intro' => 'Tu caja fuerte se copia y se comprueba, y solo entonces se renombra el archivo antiguo. Si algo falla, no se cambia nada.',
			'moveVault.step1' => ({required Object storage}) => 'Inicia sesión en ${storage} para elegir adónde va la caja fuerte.',
			'moveVault.step2' => 'Confirma. Antes de este paso no cambia nada.',
			'moveVault.step3' => 'La caja fuerte se copia y se comprueba; después, el archivo antiguo se renombra, nunca se borra.',
			'moveVault.connect' => ({required Object storage}) => 'Conectar ${storage}',
			'moveVault.account' => 'Se moverá a esta cuenta',
			'moveVault.existingTitle' => ({required Object storage}) => 'Esta cuenta de ${storage} ya tiene una caja fuerte de KeeperPass',
			'moveVault.existingBody' => ({required Object storage}) => 'Si continúas, se conserva como copia de seguridad con marca de tiempo en ${storage} y se sustituye por la caja fuerte que estás moviendo.',
			'moveVault.existingConfirm' => 'Sustituirla: la caja fuerte existente se conserva como copia de seguridad',
			'moveVault.secretSection' => 'Secreto para la caja fuerte movida',
			'moveVault.keepSecret' => 'Mantener mi secreto actual',
			'moveVault.newSecret' => 'Elegir un secreto nuevo',
			'moveVault.newSecretNote' => 'Solo lo usa la caja fuerte movida',
			'moveVault.submit' => 'Mover caja fuerte',
			'moveVault.movingTitle' => 'Moviendo tu caja fuerte',
			'moveVault.stageEncrypting' => 'Cifrando tu caja fuerte',
			'moveVault.stageSaving' => ({required Object storage}) => 'Guardando en ${storage}…',
			'moveVault.stageChecking' => 'Comprobando la copia guardada',
			'moveVault.stageRenaming' => 'Renombrando el archivo antiguo',
			'moveVault.movingNote' => 'Mantén KeeperPass abierto hasta que termine. Si algo falla, no se cambia nada.',
			'moveVault.savedTo' => ({required Object storage}) => 'Guardado en ${storage}',
			'moveVault.doneTitle' => ({required Object storage}) => 'Tu caja fuerte ahora está en ${storage}',
			'moveVault.doneBody' => ({required Object provider, required Object from}) => 'Inicia sesión con ${provider} para abrirla. El archivo antiguo se conservó y se renombró en ${from}:',
			'moveVault.copyFileName' => 'Copiar nombre del archivo',
			'moveVault.fileNameCopied' => 'Nombre del archivo copiado',
			'moveVault.partlyTitle' => ({required Object storage}) => 'Tu caja fuerte se copió a ${storage}',
			'moveVault.partlyBody' => ({required Object from}) => 'Pero no se pudo renombrar el archivo antiguo en ${from}. Renómbralo o bórralo tú para que las dos copias no se desincronicen.',
			'moveVault.open' => ({required Object storage}) => 'Abrir ${storage}',
			'moveVault.unchanged' => ({required Object from}) => 'Sigue en ${from} · sin cambios',
			'moveVault.notMovedTitle' => 'Tu caja fuerte no se movió',
			'moveVault.notMovedBody' => 'La copia guardada no coincidía con tu caja fuerte, así que el archivo antiguo quedó intacto. No se perdió nada; inténtalo de nuevo.',
			'dataIo.importTitle' => 'Importar',
			'dataIo.file' => 'Archivo',
			'dataIo.fileMeta' => ({required Object size}) => '${size} · de Archivos',
			'dataIo.kilobytes' => ({required Object n}) => '${n} KB',
			'dataIo.megabytes' => ({required Object n}) => '${n} MB',
			'dataIo.change' => 'Cambiar',
			'dataIo.found' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Se encontró ${n} elemento para importar.', other: 'Se encontraron ${n} elementos para importar.', ), 
			'dataIo.addTo' => 'Añadirlos a',
			'dataIo.importNote' => 'Los elementos se añaden a la caja fuerte que elijas. No se reemplaza nada.',
			'dataIo.importButton' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Importar ${n} elemento', other: 'Importar ${n} elementos', ), 
			'dataIo.invalidCsv' => 'Este archivo no se pudo leer como CSV.',
			'dataIo.noItems' => 'No se encontraron elementos en este archivo.',
			'dataIo.notCsvNote' => 'Exporta un CSV desde tu otro gestor de contraseñas y luego elige ese archivo aquí.',
			'dataIo.chooseAnother' => 'Elegir otro archivo',
			'dataIo.exportTitle' => 'Exportar',
			'dataIo.exportIntro' => 'Genera un CSV de la caja fuerte que elijas. Los elementos exportados dejan atrás el cifrado de la caja fuerte — lo que hagas con el archivo depende de ti.',
			'dataIo.sourceVault' => 'Caja fuerte de origen',
			'dataIo.notEncryptedTitle' => 'Un archivo CSV no está cifrado',
			'dataIo.notEncryptedBody' => 'Quien lo abra podrá leer todas las contraseñas que contiene. Guárdalo en un lugar seguro y elimínalo cuando termines.',
			'dataIo.exportButton' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Exportar ${n} elemento', other: 'Exportar ${n} elementos', ), 
			'dataIo.exportNote' => 'Abre el menú de compartir para que elijas adónde va el archivo.',
			'dataIo.recentTitle' => 'Exportaciones recientes',
			'dataIo.recentRow' => ({required num n, required Object scope}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${scope} · ${n} elemento', other: '${scope} · ${n} elementos', ), 
			'dataIo.recentNote' => 'Se recuerdan las últimas 10 exportaciones, en tu caja fuerte. KeeperPass no guarda ninguna copia de los archivos.',
			'dataIo.recentEmpty' => 'Aún no hay exportaciones.',
			'archive.title' => 'Archivar caja fuerte',
			'archive.headline' => 'Archivar caja fuerte y cerrar sesión',
			'archive.body' => ({required Object storage}) => 'Tu caja fuerte es un único archivo cifrado en tu propio ${storage}. Al archivarla, se cambia el nombre del archivo para que esta app ya no lo encuentre y se cierra tu sesión. No se borra nada.',
			'archive.step1' => ({required Object oldName, required Object newName, required Object folder}) => '${oldName} se renombra a ${newName}, en la misma ${folder}.',
			'archive.step2' => ({required Object storage}) => 'Este teléfono cierra la sesión de ${storage}.',
			'archive.step3' => ({required Object storage}) => 'Para borrar los datos en sí, borra ese archivo en ${storage}.',
			'archive.typePrefix' => 'Escribe',
			'archive.typeSuffix' => 'para confirmar.',
			'archive.confirmation' => 'Confirmación',
			'archive.button' => 'Archivar y cerrar sesión',
			'archive.doneMeta' => 'Renombrado · esta app ya no lo encuentra',
			'archive.doneTitle' => 'Se ha cambiado el nombre de tu archivo de caja fuerte',
			'archive.doneBody' => ({required Object folder, required Object storage}) => 'Sigue en la ${folder} de tu ${storage}. Bórralo allí cuando quieras que los datos desaparezcan definitivamente.',
			'archive.signedOut' => 'Has cerrado sesión en este teléfono.',
			'archive.error' => 'No se ha podido cambiar el nombre del archivo. No se ha modificado nada.',
			'help.howTitle' => 'Cómo funciona KeeperPass',
			'help.howSubtitle' => 'Dónde viven tus datos y qué los mantiene privados',
			'help.whereLives' => 'Dónde viven tus datos',
			'help.diagram' => ({required Object storage}) => 'Tu caja fuerte se cifra en este teléfono y se guarda como un único archivo en tu ${storage}',
			'help.thisPhoneNote' => 'Cifra y descifra todo. Tu secreto nunca sale de él.',
			'help.fileEncrypted' => 'vault.json.enc · cifrado',
			'help.yourStorage' => ({required Object storage}) => 'Tu ${storage}',
			'help.storageNote' => 'Guarda el archivo, que es ilegible sin tu secreto.',
			'help.noServer' => 'KeeperPass nunca recibe tus datos. No hay cuenta que vulnerar ni operador que pueda leer tu caja fuerte.',
			'help.protects' => 'Qué lo protege',
			'help.secretTerm' => 'Tu secreto',
			'help.secretNote' => 'Nunca se envía ni se guarda. Solo existe en memoria mientras la app está desbloqueada.',
			'help.kdfTerm' => 'Derivación de claves',
			'help.kdfNote' => 'Deliberadamente lenta, para que cada intento de adivinar tu secreto sea costoso.',
			'help.encryptionTerm' => 'Cifrado',
			'help.encryptionNote' => 'Mantiene el archivo ilegible y muestra si alguien lo ha modificado.',
			'help.accessTerm' => 'Acceso al almacenamiento',
			'help.accessNote' => 'KeeperPass solo puede acceder a los archivos que crea.',
			'help.signingIn' => 'Inicio de sesión',
			'help.step1' => 'Conecta tu almacenamiento en la nube',
			'help.step1Note' => 'Demuestra quién es el dueño del archivo. No desbloquea nada.',
			'help.step2' => 'Introduce tu secreto',
			'help.step2Note' => 'Genera en este teléfono la clave que abre el archivo. Tu proveedor de almacenamiento nunca la ve.',
			'help.bothNeeded' => 'Quien tenga tu cuenta de almacenamiento sigue sin poder leer tu caja fuerte. Quien conozca tu secreto sigue sin poder llegar al archivo. Hacen falta las dos cosas.',
			'help.terms' => 'Términos que conviene conocer',
			'help.secretWord' => 'Secreto',
			'help.secretDef' => 'La única frase que desbloquea tu caja fuerte. No se puede recuperar.',
			'help.vaultWord' => 'Caja fuerte',
			'help.vaultDef' => 'Un grupo de elementos. Con varias, mantienes separado lo laboral de lo personal.',
			'help.tagWord' => 'Etiqueta',
			'help.tagDef' => 'Una etiqueta para encontrar elementos entre cajas fuertes, como trabajo o banca.',
			'help.reportWord' => 'Informe de seguridad',
			'help.reportDef' => 'Marca las contraseñas débiles, reutilizadas y filtradas, en este teléfono.',
			'faq.title' => 'Preguntas',
			'faq.subtitle' => 'Respuestas a preguntas frecuentes',
			'faq.forgetQ' => '¿Qué pasa si olvido mi secreto?',
			'faq.forgetA1' => 'Tu caja fuerte no se puede recuperar — ni tú ni nosotros podemos hacerlo. La clave se genera solo a partir de tu secreto, así que sin él el archivo sigue siendo ilegible. Ese es el precio de que nadie más pueda leerlo tampoco.',
			'faq.forgetA2' => ({required Object forgot, required Object file}) => 'Lo que puedes hacer es empezar de nuevo: ${forgot} en la pantalla de desbloqueo crea una caja fuerte nueva y vacía. Tu archivo antiguo no se borra — se renombra a ${file} y se conserva en tu carpeta keeperpass, así que los datos siguen ahí si recuerdas el secreto.',
			'faq.forgetA2Link' => '¿Olvidaste tu secreto?',
			'faq.forgetA3' => 'Anota tu secreto y guárdalo en un lugar seguro. Es lo único en KeeperPass que no se puede reemplazar.',
			'faq.seeQ' => '¿Puede KeeperPass ver mis contraseñas?',
			'faq.seeA' => 'No — y no es una promesa, sino una consecuencia del diseño. El cifrado ocurre en este teléfono y el texto cifrado va directo a tu propio almacenamiento. No hay ningún servidor de KeeperPass en el camino que pueda ver nada.',
			'faq.syncQ' => '¿Se sincroniza entre dispositivos?',
			'faq.syncA' => 'Sí. Todos los dispositivos leen el mismo archivo de tu almacenamiento. Inicia sesión con la misma cuenta, introduce el mismo secreto y tu caja fuerte estará ahí.',
			'faq.providerQ' => '¿Y si mi proveedor de almacenamiento lee el archivo?',
			'faq.providerA' => 'Verían bytes cifrados. La clave nunca sale de este teléfono, así que ni Google ni Dropbox ni ningún otro proveedor pueden leer el contenido.',
			'faq.importQ' => '¿Puedo importar desde otro gestor de contraseñas?',
			'faq.importA' => 'Sí — exporta a CSV desde ahí y luego usa Importar en Ajustes.',
			'faq.changeSecretQ' => '¿Cómo cambio mi secreto?',
			'faq.changeSecretA' => ({required Object action}) => 'Abre Ajustes y elige ${action}. Introduces tu secreto actual y el nuevo; tu caja fuerte se descifra, se vuelve a cifrar con el nuevo secreto y se guarda de nuevo. No se pierde nada — todos los elementos te acompañan, y el cambio se aplica en cada dispositivo la próxima vez que cargue tu caja fuerte.',
			'faq.costQ' => '¿Cuánto cuesta?',
			'faq.costA' => 'Nada. KeeperPass es gratuito y de código abierto, y guarda los datos en el espacio en la nube que ya tienes.',
			'faq.stillStuck' => '¿Sigues atascado?',
			'faq.contactBody' => '¿Preguntas, comentarios o algún problema? Escríbenos un correo.',
			'about.version' => ({required Object version, required Object build}) => 'Versión ${version} (${build})',
			'about.tagline' => 'Tu nube. Tus claves. Tu caja fuerte.',
			'about.license' => 'Gratis y de código abierto bajo AGPL-3.0',
			'about.terms' => 'Términos del servicio',
			'about.privacy' => 'Política de privacidad',
			'about.promise' => 'Gratis y sin trampa: sin planes, sin versión premium, sin ventas adicionales.',
			'clipboard.clearsIn' => ({required Object time}) => 'Se borra en ${time}',
			'clipboard.cleared' => 'Portapapeles borrado',
			'sync.savedTo' => ({required Object storage}) => 'Guardado en ${storage}',
			'sync.notSavedTitle' => 'No se guardó tu caja fuerte',
			'sync.notSavedBody' => ({required Object storage}) => 'No se pudo conectar con ${storage}. Tu cambio sigue aquí; vuelve a intentarlo antes de cerrar KeeperPass.',
			'sync.dismiss' => 'Descartar',
			'sync.retryingTitle' => 'Reintentando…',
			'sync.retryingBody' => ({required Object storage}) => 'Guardando en ${storage}.',
			'sync.reconnectTitle' => ({required Object storage}) => 'Vuelve a conectar con ${storage}',
			'sync.keepReading' => 'Puedes seguir leyendo; los cambios se guardarán cuando vuelvas a conectarte.',
			'sync.reconnect' => 'Reconectar',
			'sync.later' => 'Más tarde',
			'sync.offlineBody' => ({required Object storage}) => 'Puedes seguir leyendo y copiando. Para guardar hace falta conexión con ${storage}.',
			'sync.changedTitle' => 'Tu caja fuerte cambió',
			'sync.changedBody' => 'Se guardó una versión más reciente de tu caja fuerte desde otro dispositivo. Cárgala antes de editar para que no se sobrescriba nada.',
			'sync.twoVersions' => 'Dos versiones',
			'sync.onThisPhone' => 'En este teléfono',
			'sync.inStorage' => ({required Object storage}) => 'En ${storage}',
			'sync.loadedAt' => ({required Object time}) => 'cargada: ${time}',
			'sync.savedNewer' => ({required Object time}) => 'guardada: ${time} · más reciente',
			'sync.loadLatest' => 'Cargar la versión más reciente',
			'sync.notNow' => 'Ahora no',
			'sync.pausedNote' => 'Hasta entonces puedes leer y copiar, pero no editar.',
			'sync.upToDate' => 'Actualizada',
			'sync.loadedVersion' => ({required Object time}) => 'Se cargó la versión guardada a las ${time}',
			'scan.title' => 'Escanear código QR',
			'scan.primerTitle' => 'Añadir un código 2FA escaneando',
			'scan.primerBody' => 'Cuando un sitio activa el inicio de sesión en dos pasos, muestra un código QR. KeeperPass lo lee con la cámara y guarda la clave de configuración en tu caja fuerte, para que sus códigos aparezcan en Códigos.',
			'scan.primerPrivacy' => 'La cámara solo lee el código. No se graba nada ni se guarda ninguna imagen.',
			'scan.primerNext' => 'A continuación, tu teléfono pedirá acceso a la cámara.',
			'scan.enterInstead' => 'Introducir la clave de configuración',
			'scan.hint' => 'Apunta al código QR que muestra el sitio web\nal activar el inicio de sesión en dos pasos.',
			'scan.torch' => 'Encender la luz',
			'scan.cameraView' => 'Vista de la cámara',
			'scan.codeFound' => 'Código encontrado',
			'scan.saveTo' => 'Guardarlo en',
			'scan.existingItem' => 'Elemento existente',
			'scan.existingItemWith' => ({required Object summary}) => 'Elemento existente · ${summary}',
			'scan.newAuthenticator' => 'Nuevo elemento Autenticador',
			'scan.named' => ({required Object name}) => 'Con el nombre ${name}',
			'scan.cameraOffTitle' => 'El acceso a la cámara está desactivado',
			'scan.cameraOffBody' => 'KeeperPass solo necesita la cámara para leer códigos QR. Actívala en Ajustes o escribe la clave de configuración.',
			'scan.openSettings' => 'Abrir Ajustes',
			'scan.unsupported' => 'Este código usa ajustes que KeeperPass aún no admite',
			'scan.notACode' => 'Este no es un código QR de 2FA',
			'scan.cameraFailed' => 'No se ha podido iniciar la cámara',
			'scan.item' => 'Elemento',
			'scan.codeSettings' => '6 dígitos · cada 30 segundos · SHA-1',
			'scan.codeAdded' => ({required Object name}) => 'Código añadido a ${name}',
			'scan.tapToCopy' => 'Toca la tarjeta para copiarlo.',
			_ => null,
		};
	}
}
