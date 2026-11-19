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
class TranslationsPt extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsPt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.pt,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pt>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsPt _root = this; // ignore: unused_field

	@override 
	TranslationsPt $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsPt(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$pt app = _Translations$app$pt._(_root);
	@override late final _Translations$connectivity$pt connectivity = _Translations$connectivity$pt._(_root);
	@override late final _Translations$errors$pt errors = _Translations$errors$pt._(_root);
	@override late final _Translations$common$pt common = _Translations$common$pt._(_root);
	@override late final _Translations$strength$pt strength = _Translations$strength$pt._(_root);
	@override late final _Translations$totp$pt totp = _Translations$totp$pt._(_root);
	@override late final _Translations$settings$pt settings = _Translations$settings$pt._(_root);
	@override late final _Translations$auth$pt auth = _Translations$auth$pt._(_root);
	@override late final _Translations$vaults$pt vaults = _Translations$vaults$pt._(_root);
	@override late final _Translations$welcome$pt welcome = _Translations$welcome$pt._(_root);
	@override late final _Translations$connect$pt connect = _Translations$connect$pt._(_root);
	@override late final _Translations$howItWorks$pt howItWorks = _Translations$howItWorks$pt._(_root);
	@override late final _Translations$technicalDetails$pt technicalDetails = _Translations$technicalDetails$pt._(_root);
	@override late final _Translations$createVault$pt createVault = _Translations$createVault$pt._(_root);
	@override late final _Translations$unlock$pt unlock = _Translations$unlock$pt._(_root);
	@override late final _Translations$newVault$pt newVault = _Translations$newVault$pt._(_root);
	@override late final _Translations$tabs$pt tabs = _Translations$tabs$pt._(_root);
	@override late final _Translations$codes$pt codes = _Translations$codes$pt._(_root);
	@override late final _Translations$comingSoon$pt comingSoon = _Translations$comingSoon$pt._(_root);
	@override late final _Translations$vaultList$pt vaultList = _Translations$vaultList$pt._(_root);
	@override late final _Translations$itemDetail$pt itemDetail = _Translations$itemDetail$pt._(_root);
	@override late final _Translations$editItem$pt editItem = _Translations$editItem$pt._(_root);
	@override late final _Translations$generator$pt generator = _Translations$generator$pt._(_root);
	@override late final _Translations$report$pt report = _Translations$report$pt._(_root);
	@override late final _Translations$audit$pt audit = _Translations$audit$pt._(_root);
	@override late final _Translations$myVaults$pt myVaults = _Translations$myVaults$pt._(_root);
	@override late final _Translations$tags$pt tags = _Translations$tags$pt._(_root);
	@override late final _Translations$changeSecret$pt changeSecret = _Translations$changeSecret$pt._(_root);
	@override late final _Translations$storage$pt storage = _Translations$storage$pt._(_root);
	@override late final _Translations$moveVault$pt moveVault = _Translations$moveVault$pt._(_root);
	@override late final _Translations$dataIo$pt dataIo = _Translations$dataIo$pt._(_root);
	@override late final _Translations$archive$pt archive = _Translations$archive$pt._(_root);
	@override late final _Translations$help$pt help = _Translations$help$pt._(_root);
	@override late final _Translations$faq$pt faq = _Translations$faq$pt._(_root);
	@override late final _Translations$about$pt about = _Translations$about$pt._(_root);
	@override late final _Translations$clipboard$pt clipboard = _Translations$clipboard$pt._(_root);
	@override late final _Translations$sync$pt sync = _Translations$sync$pt._(_root);
	@override late final _Translations$scan$pt scan = _Translations$scan$pt._(_root);
}

// Path: app
class _Translations$app$pt extends Translations$app$en {
	_Translations$app$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get name => 'KeeperPass';
}

// Path: connectivity
class _Translations$connectivity$pt extends Translations$connectivity$en {
	_Translations$connectivity$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get offline => 'Sem ligação à Internet';
	@override String get online => 'Novamente online';
}

// Path: errors
class _Translations$errors$pt extends Translations$errors$en {
	_Translations$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$errors$failures$pt failures = _Translations$errors$failures$pt._(_root);
	@override late final _Translations$errors$drive$pt drive = _Translations$errors$drive$pt._(_root);
	@override late final _Translations$errors$dropbox$pt dropbox = _Translations$errors$dropbox$pt._(_root);
	@override late final _Translations$errors$auth$pt auth = _Translations$errors$auth$pt._(_root);
	@override late final _Translations$errors$masterPassword$pt masterPassword = _Translations$errors$masterPassword$pt._(_root);
	@override late final _Translations$errors$vault$pt vault = _Translations$errors$vault$pt._(_root);
}

// Path: common
class _Translations$common$pt extends Translations$common$en {
	_Translations$common$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get close => 'Fechar';
	@override String get copy => 'Copiar';
	@override String get copied => 'Copiado';
	@override String get cancel => 'Cancelar';
	@override String get save => 'Guardar';
	@override String get back => 'Voltar';
	@override String get favorite => 'Favorito';
	@override String get showSecret => 'Mostrar segredo';
	@override String get hideSecret => 'Ocultar segredo';
	@override String get empty => '[vazio]';
	@override String get clearSearch => 'Limpar a pesquisa';
	@override String get chooseDate => 'Escolha uma data';
	@override String get chooseMonth => 'Escolha um mês';
	@override String get countryCode => 'Indicativo do país';
	@override String countryCodeValue({required Object country, required Object code}) => 'Indicativo do país: ${country}, ${code}';
	@override String removeTag({required Object tag}) => 'Remover a etiqueta ${tag}';
	@override String get secretChip => 'Secreto';
	@override String secretToggle({required Object field}) => 'Secreto: ${field}';
	@override String reorderField({required Object field}) => 'Reordenar ${field}';
	@override String removeField({required Object field}) => 'Remover ${field}';
	@override String changeFieldIcon({required Object field}) => 'Alterar o ícone de ${field}';
	@override String showAll({required Object count}) => 'Mostrar todos os ${count}';
	@override String get showInLargeType => 'Mostrar em letra grande';
	@override String stepOf({required Object current, required Object total}) => 'Passo ${current} de ${total}';
	@override String get next => 'Seguinte';
	@override String get continueAction => 'Continuar';
	@override String get tryAgain => 'Tentar novamente';
	@override String get retry => 'Repetir';
	@override String get show => 'Mostrar';
	@override String get hide => 'Ocultar';
	@override String get gotIt => 'Percebi';
	@override String get disconnect => 'Desligar';
	@override String get generateSecret => 'Gerar um segredo';
	@override String get useAnotherAccount => 'Usar outra conta';
	@override String get offlineTitle => 'Está offline';
	@override String savingTo({required Object provider}) => 'A guardar em ${provider}…';
	@override String get keepOpen => 'Mantenha o KeeperPass aberto até terminar.';
	@override String get typeItAgain => 'Escreva-o novamente';
	@override String get secretHiddenValue => 'Oculto';
	@override String get rename => 'Renomear';
	@override String get done => 'Concluído';
}

// Path: strength
class _Translations$strength$pt extends Translations$strength$en {
	_Translations$strength$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get veryWeak => 'Muito fraca';
	@override String get weak => 'Fraca';
	@override String get fair => 'Razoável';
	@override String get strong => 'Forte';
	@override String get veryStrong => 'Muito forte';
	@override String meter({required Object level}) => 'Força: ${level}';
}

// Path: totp
class _Translations$totp$pt extends Translations$totp$en {
	_Translations$totp$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get invalidCode => 'Código inválido';
	@override String get invalidKey => 'A chave de configuração não é válida, por isso não é possível gerar um código.';
	@override String get fixInEdit => 'Corrigir em Editar';
	@override String secondsShort({required Object count}) => '${count} s';
	@override String secondsLeft({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(count,
		one: 'Falta ${count} segundo',
		other: 'Faltam ${count} segundos',
	);
}

// Path: settings
class _Translations$settings$pt extends Translations$settings$en {
	_Translations$settings$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$settings$migrate$pt migrate = _Translations$settings$migrate$pt._(_root);
	@override String get title => 'Definições';
	@override String get subtitle => 'Conta, idioma, segurança e dados';
	@override String get account => 'Conta';
	@override String accountLine({required Object email, required Object storage}) => '${email} · ${storage}';
	@override String get accountNote => 'O nome e o e-mail são obtidos da conta com que iniciou sessão.';
	@override String get logOut => 'Terminar sessão';
	@override String get logOutTitle => 'Terminar sessão?';
	@override String logOutBody({required Object storage, required Object provider}) => 'O seu cofre continua cifrado no seu ${storage}. Para o voltar a abrir, inicie sessão com ${provider} e introduza o seu segredo.';
	@override String get security => 'Segurança';
	@override String get lockNow => 'Bloquear agora';
	@override String get autoLock => 'Bloqueio automático';
	@override String get clearClipboard => 'Limpar área de transferência';
	@override String get hideInSwitcher => 'Ocultar no seletor de apps';
	@override String get hideInSwitcherNote => 'Mostra um ecrã de privacidade em vez do seu cofre';
	@override String get changeSecret => 'Alterar segredo';
	@override String get securityNote => 'Bloquear apaga o cofre decifrado da memória deste telemóvel.';
	@override String get appearance => 'Aspeto';
	@override String get theme => 'Tema';
	@override String get themeAuto => 'Auto';
	@override String get themeLight => 'Claro';
	@override String get themeDark => 'Escuro';
	@override String get language => 'Idioma';
	@override String get storage => 'Armazenamento';
	@override String get whereItLives => 'Onde vive o seu cofre';
	@override String moveTo({required Object storage}) => 'Mover o cofre para ${storage}';
	@override String get data => 'Dados';
	@override String get importCsv => 'Importar CSV';
	@override String get exportCsv => 'Exportar CSV';
	@override String get recentExports => 'Exportações recentes';
	@override String get help => 'Ajuda';
	@override String get howItWorks => 'Como funciona o KeeperPass';
	@override String get questions => 'Perguntas';
	@override String get about => 'Acerca do KeeperPass';
	@override String get dangerZone => 'Zona de perigo';
	@override String get archive => 'Arquivar cofre e terminar sessão';
	@override String get archiveNote => 'Muda o nome do ficheiro do cofre e termina a sua sessão. Nada é apagado.';
	@override String footer({required Object version}) => 'KeeperPass ${version} · Gratuito e de código aberto sob AGPL-3.0';
	@override String get autoLockTitle => 'Bloqueio automático';
	@override String get autoLockImmediately => 'Imediatamente ao sair da app';
	@override String get autoLockImmediatelyShort => 'Imediatamente';
	@override String get after1Minute => 'Após 1 minuto';
	@override String get after5Minutes => 'Após 5 minutos';
	@override String get after10Minutes => 'Após 10 minutos';
	@override String get autoLockNote => 'O KeeperPass bloqueia-se após este tempo sem utilização. Para o desbloquear de novo, precisa do seu segredo.';
	@override String get clearClipboardTitle => 'Limpar Área de Transferência';
	@override String get after30Seconds => 'Após 30 segundos';
	@override String get after2Minutes => 'Após 2 minutos';
	@override String get never => 'Nunca';
	@override String get after30s => 'Após 30 s';
	@override String get after1Min => 'Após 1 min';
	@override String get after2Min => 'Após 2 min';
	@override String get clipboardNote => 'As palavras-passe e os códigos que copiar são apagados da área de transferência após este tempo, se não tiver copiado mais nada entretanto.';
	@override String get preview => 'Pré-visualização';
	@override String get previewFrom => 'De GitHub';
	@override String previewClears({required Object time}) => 'De GitHub · Apaga-se daqui a ${time}';
	@override String seconds({required Object n}) => '${n} s';
	@override String minutes({required Object n}) => '${n} min';
	@override String get languageTitle => 'Idioma';
	@override String get languageNote => 'Guardado apenas neste telemóvel — não faz parte do seu cofre.';
	@override String get hideInSwitcherBlocks => 'Mostra um ecrã de privacidade em vez do seu cofre e bloqueia as capturas de ecrã';
	@override String get blockScreenshots => 'Bloquear capturas de ecrã';
	@override String get blockScreenshotsNote => 'Apenas Android · também bloqueia a gravação do ecrã';
	@override String get blockScreenshotsWhileHidden => 'Ativo enquanto «Ocultar no seletor de apps» estiver ativo';
}

// Path: auth
class _Translations$auth$pt extends Translations$auth$en {
	_Translations$auth$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$auth$unlock$pt unlock = _Translations$auth$unlock$pt._(_root);
}

// Path: vaults
class _Translations$vaults$pt extends Translations$vaults$en {
	_Translations$vaults$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get defaultName => 'O Meu Cofre';
}

// Path: welcome
class _Translations$welcome$pt extends Translations$welcome$en {
	_Translations$welcome$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get howItWorks => 'Como funciona';
	@override String get badge => 'Cifrado de ponta a ponta';
	@override String get title => 'Bem-vindo ao KeeperPass';
	@override String get description => 'O seu cofre é um único ficheiro cifrado no seu próprio armazenamento na nuvem. Inicie sessão para o abrir.';
	@override String get fileTag => 'O que o seu armazenamento vê';
	@override String get fileMeta => 'Argon2id · AES-256-GCM';
	@override String get continueWithGoogle => 'Continuar com o Google';
	@override String get continueWithDropbox => 'Continuar com o Dropbox';
	@override String connecting({required Object provider}) => 'A estabelecer ligação com ${provider}…';
	@override String get factAccess => 'Acesso apenas aos ficheiros que o KeeperPass cria';
	@override String get factEncrypted => 'Cifrado neste telemóvel, com o seu próprio segredo';
	@override String get factNoServer => 'Sem servidor KeeperPass. Nada vai para mais lado nenhum.';
	@override String get footer => 'Sem conta KeeperPass — apenas a da Google ou do Dropbox que já tem. Ao iniciar sessão, o ficheiro do cofre é criado se ainda não o tiver.';
}

// Path: connect
class _Translations$connect$pt extends Translations$connect$en {
	_Translations$connect$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String lookingIn({required Object storage}) => 'A procurar no ${storage}…';
	@override String get checkingTitle => 'A verificar o seu cofre…';
	@override String checkingDetail({required Object storage}) => 'A procurar vault.json.enc no ${storage}.';
	@override String get foundTitle => 'Encontrámos o seu cofre';
	@override String get foundDetail => 'A abrir o desbloqueio…';
	@override String foundMeta({required Object storage}) => 'Encontrado no ${storage}';
	@override String foundMetaUpdated({required Object storage, required Object time}) => 'Encontrado no ${storage} · atualizado ${time}';
	@override String get canceledDetail => 'Nada foi ligado.';
	@override String get signInFailed => 'Falha ao iniciar sessão';
	@override String get offlineDetail => 'Para iniciar sessão é necessária uma ligação à Google ou ao Dropbox. Isto atualiza-se sozinho quando voltar a estar online.';
	@override String get welcomeBack => 'Olá de novo,';
	@override String expiredDetail({required Object provider}) => 'A sua sessão de ${provider} expirou. Inicie sessão novamente para desbloquear o seu cofre.';
	@override String get lastUsed => 'Última utilizada';
	@override String checkFailedMeta({required Object storage}) => 'Não foi possível lê-lo no ${storage}';
	@override String get checkFailedTitle => 'Não foi possível ler o seu cofre';
	@override String checkFailedDetail({required Object storage}) => 'O ${storage} não respondeu. Nada foi alterado.';
}

// Path: howItWorks
class _Translations$howItWorks$pt extends Translations$howItWorks$en {
	_Translations$howItWorks$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get step1Title => 'O seu cofre vive\nna sua nuvem';
	@override String get step1Body => 'O KeeperPass guarda um único ficheiro cifrado no seu Google Drive ou Dropbox. Não existe servidor KeeperPass, por isso nunca recebemos uma cópia.';
	@override String get encrypted => 'Cifrado';
	@override String get step2Title => 'Escolha um segredo';
	@override String get step2Body => 'Torna-se a chave. Nunca enviado, nunca guardado.';
	@override String get step3Title => 'São precisos os dois';
	@override String get step3Body => 'Quem tiver a sua conta de armazenamento não consegue ler o seu cofre. Quem tiver o seu segredo não lhe consegue chegar.';
	@override String get storageAccount => 'Conta de armazenamento';
	@override String get reachesFile => 'Chega ao ficheiro';
	@override String get yourSecret => 'O seu segredo';
	@override String get opensFile => 'Abre o ficheiro';
	@override String get technicalDetails => 'Detalhes técnicos';
	@override String get technicalSummary => 'Argon2id · AES-256';
}

// Path: technicalDetails
class _Translations$technicalDetails$pt extends Translations$technicalDetails$en {
	_Translations$technicalDetails$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalhes técnicos';
	@override String get keyDerivation => 'Derivação da chave';
	@override TextSpan keyDerivationValue({required InlineSpan algorithm}) => TextSpan(children: [
		algorithm,
		const TextSpan(text: ' · 64 MiB de memória · 3 iterações · paralelismo 4, gerando uma chave de 256 bits'),
	]);
	@override String get encryption => 'Cifra';
	@override TextSpan encryptionValue({required InlineSpan algorithm}) => TextSpan(children: [
		algorithm,
		const TextSpan(text: ', que também deteta qualquer alteração ao ficheiro'),
	]);
	@override String get googleDrive => 'Google Drive';
	@override TextSpan googleDriveValue({required InlineSpan scope}) => TextSpan(children: [
		const TextSpan(text: 'O âmbito '),
		scope,
		const TextSpan(text: ': apenas ficheiros criados pelo KeeperPass'),
	]);
	@override String get dropbox => 'Dropbox';
	@override TextSpan dropboxValue({required InlineSpan folder}) => TextSpan(children: [
		const TextSpan(text: 'Uma pasta da aplicação: '),
		folder,
	]);
	@override String get vaultFile => 'Ficheiro do cofre';
	@override TextSpan vaultFileValue({required InlineSpan file}) => TextSpan(children: [
		file,
		const TextSpan(text: ' — um único ficheiro, novamente cifrado e reescrito a cada gravação'),
	]);
	@override String get viewSource => 'Ver o código-fonte no GitHub';
	@override String get license => 'Gratuito e de código aberto sob AGPL-3.0, por isso tudo isto pode ser verificado.';
}

// Path: createVault
class _Translations$createVault$pt extends Translations$createVault$en {
	_Translations$createVault$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'Crie o seu cofre';
	@override String get step1Title => 'Escolha o seu segredo';
	@override String get step1Body => 'Cifra o seu cofre neste telemóvel. Tudo o que guardar fica protegido por ele.';
	@override String get settingUpFor => 'A configurar para';
	@override String get secret => 'Segredo';
	@override String get secretPlaceholder => 'O seu segredo';
	@override String get generateAnother => 'Gerar outro';
	@override String get generatedNote => 'Os segredos gerados saltam o passo de os escrever novamente.';
	@override String get weakWarning => 'Este segredo é fraco, o que torna a cifra do seu cofre mais fácil de quebrar. Pode continuar, mas recomenda-se vivamente uma frase mais longa.';
	@override String get tipsTitle => 'Escolher um bom segredo';
	@override String get tip1 => 'Várias palavras aleatórias são melhores do que uma palavra engenhosa: quanto mais longo, mais difícil de adivinhar.';
	@override String get tip2 => 'Não reutilize uma palavra-passe que use noutro lado.';
	@override String get tip3 => 'Escolha algo que consiga escrever neste telemóvel; depois anote-o e guarde-o num local seguro.';
	@override String get step2Title => 'Escreva-o novamente';
	@override String get step2Body => 'Só para garantir que não há erros. Ninguém pode repor o seu segredo mais tarde.';
	@override String get repeat => 'Repita o segredo';
	@override String get mismatch => 'Os dois segredos não coincidem.';
	@override String get step3Title => 'Anote-o';
	@override String get step3Body => 'Vai precisar dele sempre que desbloquear. Guarde-o num local seguro, longe deste telemóvel.';
	@override String secretWords({required Object count}) => 'O seu segredo · ${count} palavras';
	@override String get secretWhole => 'O seu segredo';
	@override String get secretHidden => 'O seu segredo, oculto';
	@override String get secretShown => 'O seu segredo, visível';
	@override String get readBefore => 'Leia isto antes de continuar';
	@override String get bullet1 => 'O seu segredo nunca é enviado para lado nenhum nem guardado. Ninguém — nem o KeeperPass, nem o seu fornecedor de armazenamento — o pode consultar ou repor.';
	@override String get bullet2 => 'Se o esquecer, o seu cofre não pode ser recuperado. Nenhuma ligação de reposição nem pedido de suporte o consegue abrir.';
	@override String get bullet3 => 'Anote-o e guarde-o num local seguro antes de continuar.';
	@override String get acknowledge => 'Já anotei o meu segredo';
	@override String get create => 'Criar cofre';
	@override String get progressTitle => 'A criar o seu cofre';
	@override String get encrypting => 'A cifrar o seu cofre…';
	@override String get encryptingDetail => 'Neste telemóvel. Demora alguns segundos.';
	@override String get encryptingMeta => 'A cifrar neste telemóvel…';
	@override String get savingDetail => 'Um único ficheiro cifrado, na pasta keeperpass.';
	@override String get failedTitle => 'Não foi possível guardar o seu cofre';
	@override String get notSaved => 'Não guardado';
	@override String failedDetail({required Object storage}) => 'O ${storage} não respondeu. Nada foi guardado e o seu segredo continua aqui.';
	@override String get backToSecret => 'Voltar ao seu segredo';
}

// Path: unlock
class _Translations$unlock$pt extends Translations$unlock$en {
	_Translations$unlock$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get notYou => 'Não é você?';
	@override String get secret => 'Segredo';
	@override String get placeholder => 'Introduza o seu segredo';
	@override String get unlock => 'Desbloquear';
	@override String get unlocking => 'A desbloquear…';
	@override String get unlockingStatus => 'A desbloquear neste telemóvel…';
	@override String get slowNote => 'Alguns segundos, de propósito: torna lento adivinhar o seu segredo.';
	@override String get forgot => 'Esqueceu-se do segredo?';
	@override String get leftApp => 'Bloqueado quando saiu do KeeperPass';
	@override String unreachableTitle({required Object storage}) => 'Não foi possível contactar o ${storage}';
	@override String get unreachableDetail => 'Verifique a sua ligação e tente novamente. O seu segredo continua preenchido.';
	@override String offlineDetail({required Object storage}) => 'Para desbloquear é necessária uma ligação ao ${storage}. «Desbloquear» fica ativo quando voltar a estar online.';
	@override String accountLine({required Object email, required Object storage}) => '${email} · ${storage}';
	@override String lockedInactivity({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Bloqueado após ${n} minuto de inatividade',
		other: 'Bloqueado após ${n} minutos de inatividade',
	);
}

// Path: newVault
class _Translations$newVault$pt extends Translations$newVault$en {
	_Translations$newVault$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get backLabel => 'Desbloquear';
	@override String get backToUnlock => 'Voltar ao desbloqueio';
	@override String get title => 'Começar um cofre novo';
	@override String get oldMeta => 'Cofre antigo · bloqueado com o segredo antigo';
	@override String get newMeta => 'Cofre novo · vazio';
	@override String body({required Object provider}) => 'Ninguém pode repor um segredo esquecido — nem o KeeperPass, nem ${provider}. Em vez disso, pode recomeçar com um cofre novo e vazio.';
	@override String get pointLocked => 'O seu cofre atual continua bloqueado com o segredo antigo.';
	@override TextSpan pointKept({required InlineSpan file, required InlineSpan storage}) => TextSpan(children: [
		const TextSpan(text: 'O seu ficheiro é mantido como '),
		file,
		const TextSpan(text: ' no seu '),
		storage,
		const TextSpan(text: '. Nada é apagado.'),
	]);
	@override String get pointFresh => 'Recomeça com um cofre completamente novo e vazio.';
	@override String get account => 'Conta';
	@override String get newSecret => 'Novo segredo';
	@override String get newSecretPlaceholder => 'Escolha um segredo novo';
	@override String get repeat => 'Repita o novo segredo';
	@override String get weakWarning => 'Este segredo é fraco, o que torna a cifra dos seus cofres mais fácil de quebrar. Pode continuar, mas recomenda-se vivamente uma frase mais longa.';
	@override String get warn => 'Tal como o antigo, o seu segredo novo não pode ser consultado nem reposto. Anote-o antes de continuar.';
	@override String get start => 'Começar um cofre novo';
	@override String get confirmTitle => 'Começar um cofre novo?';
	@override String confirmKept({required Object storage}) => 'O seu ficheiro é mantido como cópia de segurança datada no seu ${storage}.';
	@override String get confirmFresh => 'Recomeça com um cofre vazio protegido pelo seu segredo novo.';
	@override String get progressTitle => 'A começar um cofre novo';
	@override String get encrypting => 'A cifrar o seu cofre novo…';
	@override String get backingUp => 'A manter o seu cofre antigo como cópia de segurança…';
	@override String backingUpDetail({required Object storage}) => 'A mudar-lhe o nome no ${storage}.';
	@override String get readyMeta => 'Cifrado · pronto a guardar';
	@override String get backupFailedMeta => 'Não foi possível mudar o nome · nada mudou';
	@override String get nothingChanged => 'Nada foi alterado';
	@override String backupFailedDetail({required Object storage}) => 'Não foi possível criar uma cópia de segurança do seu cofre atual no ${storage}. Nada foi alterado.';
	@override String get doneTitle => 'Cofre novo começado';
	@override String doneDetail({required Object storage}) => 'O seu cofre antigo é mantido como cópia de segurança no ${storage}.';
}

// Path: tabs
class _Translations$tabs$pt extends Translations$tabs$en {
	_Translations$tabs$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get vault => 'Cofre';
	@override String get codes => 'Códigos';
	@override String get generator => 'Gerador';
	@override String get security => 'Segurança';
	@override String get settings => 'Definições';
	@override String securityFlagged({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Segurança, ${n} item assinalado',
		other: 'Segurança, ${n} itens assinalados',
	);
}

// Path: codes
class _Translations$codes$pt extends Translations$codes$en {
	_Translations$codes$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Códigos 2FA do seu cofre, gerados neste telemóvel';
	@override String searchPlaceholder({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Pesquisar ${n} código',
		other: 'Pesquisar ${n} códigos',
	);
	@override String codeCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${n} código',
		other: '${n} códigos',
	);
	@override String get copied => 'Código copiado';
	@override String get trust => 'Gerados neste telemóvel a partir das chaves de configuração do seu cofre. Nada de novo é guardado.';
	@override String get emptyTitle => 'Ainda não há códigos 2FA';
	@override String get emptyBody => 'Quando um site oferecer o início de sessão em dois passos, leia aqui o seu código QR ou adicione um item Autenticador.';
	@override String get createAuthenticator => 'Criar um item Autenticador';
}

// Path: comingSoon
class _Translations$comingSoon$pt extends Translations$comingSoon$en {
	_Translations$comingSoon$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String body({required Object part}) => 'Chega na parte ${part}.';
}

// Path: vaultList
class _Translations$vaultList$pt extends Translations$vaultList$en {
	_Translations$vaultList$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get lock => 'Bloquear';
	@override String get newItem => 'Novo item';
	@override String get allVaults => 'Todos os Cofres';
	@override String get favorites => 'Favoritos';
	@override String get recentlyUsed => 'Usados Recentemente';
	@override String statusSaved({required Object items, required Object storage}) => '${items} · Guardado no ${storage}';
	@override String statusInVault({required Object items, required Object vault}) => '${items} em ${vault}';
	@override String statusTagged({required Object items, required Object tag}) => '${items} com a etiqueta ${tag}';
	@override String statusReport({required Object items, required Object report}) => '${items} · ${report}';
	@override String statusNotConnected({required Object storage}) => 'Sem ligação ao ${storage}';
	@override String statusOffline({required Object items}) => 'Offline · ${items}';
	@override String get reportWeak => 'Palavras-passe fracas';
	@override String get reportReused => 'Palavras-passe reutilizadas';
	@override String get reportCompromised => 'Palavras-passe comprometidas';
	@override String get searchHint => 'Todas as palavras têm de corresponder, por qualquer ordem: nomes, etiquetas, nomes de campos e valores.';
	@override String get filterByTag => 'Filtrar por etiqueta';
	@override String get manageTags => 'Gerir etiquetas';
	@override String get clearFilter => 'Limpar filtro';
	@override String get today => 'Hoje';
	@override String get thisWeek => 'Esta semana';
	@override String get earlier => 'Anteriores';
	@override String get aToZ => 'De A a Z';
	@override String get sortHeading => 'Ordenar pela última atualização';
	@override String get newestFirst => 'Mais recentes primeiro';
	@override String get oldestFirst => 'Mais antigos primeiro';
	@override String refreshing({required Object storage}) => 'A ler o seu cofre do ${storage}…';
	@override String copyPasswordFor({required Object name}) => 'Copiar a palavra-passe de ${name}';
	@override String copyCodeFor({required Object name}) => 'Copiar o código de ${name}';
	@override String copyCardNumberFor({required Object name}) => 'Copiar o número do cartão de ${name}';
	@override String get swipePassword => 'Senha';
	@override String get swipeCode => 'Código';
	@override String get swipeCardNumber => 'Número do cartão';
	@override String get swipeUsername => 'Nome de usuário';
	@override String get swipeMore => 'Mais';
	@override String get copyPassword => 'Copiar palavra-passe';
	@override String get copyCode => 'Copiar código';
	@override String get copyCardNumber => 'Copiar número do cartão';
	@override String get copyUsername => 'Copiar nome de utilizador';
	@override String get moreActions => 'Mais ações';
	@override String get favorite => 'Favorito';
	@override String get addToFavorites => 'Adicionar aos favoritos';
	@override String get removeFromFavorites => 'Remover dos favoritos';
	@override String get findingWeak => 'Palavra-passe fraca';
	@override String get findingReused => 'Palavra-passe reutilizada';
	@override String get findingCompromised => 'Palavra-passe comprometida';
	@override String get findingWeakReused => 'Palavra-passe fraca e reutilizada';
	@override String get findingWeakCompromised => 'Palavra-passe fraca e comprometida';
	@override String get findingReusedCompromised => 'Palavra-passe reutilizada e comprometida';
	@override String get findingAll => 'Palavra-passe fraca, reutilizada e comprometida';
	@override String get unnamed => 'Novo Item';
	@override String get scopeTitle => 'Cofres';
	@override String get manageVaults => 'Gerir cofres';
	@override String scopeNote({required Object storage}) => 'Todos os seus cofres estão num único ficheiro cifrado, vault.json.enc, no seu ${storage}.';
	@override String quickActions({required Object name}) => '${name}, ações rápidas';
	@override String get openWebsite => 'Abrir site';
	@override String get moveToVault => 'Mover para um cofre…';
	@override String get select => 'Selecionar';
	@override String get delete => 'Eliminar';
	@override String get selectAll => 'Selecionar tudo';
	@override String get selectOrDeselectAll => 'Selecionar ou desmarcar tudo';
	@override String listTwo({required Object a, required Object b}) => '${a} e ${b}';
	@override String listThree({required Object a, required Object b, required Object c}) => '${a}, ${b} e ${c}';
	@override String get deleteItemTitle => 'Eliminar Item';
	@override String deleteItemConfirm({required Object name}) => 'Tem a certeza de que quer eliminar «${name}»? Esta ação não pode ser anulada.';
	@override String get deleteItemAction => 'Eliminar item';
	@override String get moveToVaultTitle => 'Mover para Cofre';
	@override String get moveDescription => 'Escolha o cofre onde este item deve ficar.';
	@override String get current => 'Atual';
	@override String get newVaultOption => 'Novo cofre…';
	@override String get noOtherVaultOne => 'Não há outro cofre para onde mover este item.';
	@override String get noOtherVaultMany => 'Não há outro cofre para onde mover estes itens.';
	@override String get noOtherVaultDetail => 'Um segundo cofre mantém um conjunto de itens separado — trabalho do pessoal, ou partilhado do privado.';
	@override String get createAVault => 'Criar um cofre';
	@override String get newVaultTitle => 'Novo Cofre';
	@override String get newVaultBody => 'Um cofre é um grupo separado de itens. Ao contrário de um item, não há mais nada a escolher à partida.';
	@override String get vaultName => 'Nome do cofre';
	@override String get duplicateVault => 'Já existe um cofre com este nome.';
	@override String get noItemsTitle => 'Ainda não tem itens.';
	@override String get noItemsBody => 'Adicione o seu primeiro início de sessão, cartão ou nota. Cada um é cifrado neste telemóvel antes de ser guardado.';
	@override String get importCsv => 'Importar de CSV';
	@override String get vaultReady => 'O seu cofre está pronto. Ainda não tem nada.';
	@override String savedMeta({required Object storage, required Object items}) => 'Guardado no ${storage} · ${items}';
	@override String get vaultEmptyTitle => 'Este cofre ainda não tem itens.';
	@override String vaultEmptyBody({required Object vault}) => 'Adicione um aqui ou mova itens de ${vault}.';
	@override String get noFavoritesTitle => 'Ainda não tem favoritos.';
	@override String get noFavoritesBody => 'Toque na estrela de qualquer item para o manter aqui.';
	@override String get nothingRecentTitle => 'Ainda não usou nada';
	@override String get nothingRecentBody => 'Os itens que abre ou de onde copia aparecem aqui, os mais recentes primeiro.';
	@override String get noResultsTitle => 'A sua pesquisa não encontrou nenhum item.';
	@override String get noResultsBody => 'Todas as palavras têm de corresponder. Experimente menos palavras ou verifique a ortografia.';
	@override String get allClearWeak => 'Todas as palavras-passe no seu cofre são suficientemente fortes.';
	@override String get allClearReused => 'Cada palavra-passe no seu cofre é usada exatamente uma vez.';
	@override String get allClearCompromised => 'Nenhuma das suas palavras-passe apareceu numa fuga de dados conhecida.';
	@override String get allClearBody => 'Nada a corrigir aqui. O KeeperPass volta a verificar sempre que uma palavra-passe muda.';
	@override String get backToSecurity => 'Voltar à Segurança';
	@override String fieldCopied({required Object field}) => '${field} copiado';
	@override String copiedFrom({required Object item}) => 'De ${item}';
	@override String itemCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${n} item',
		other: '${n} itens',
	);
	@override String statusNotSaved({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${n} alteração não guardada',
		other: '${n} alterações não guardadas',
	);
	@override String searchPlaceholder({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Pesquisar ${n} item',
		other: 'Pesquisar ${n} itens',
	);
	@override String results({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${n} resultado',
		other: '${n} resultados',
	);
	@override String selectedCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${n} selecionado',
		other: '${n} selecionados',
	);
	@override String moveItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Mover ${n} item',
		other: 'Mover ${n} itens',
	);
	@override String moveItemsTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Mover ${n} Item',
		other: 'Mover ${n} Itens',
	);
	@override String deleteItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Eliminar ${n} item',
		other: 'Eliminar ${n} itens',
	);
	@override String deleteTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Eliminar ${n} item?',
		other: 'Eliminar ${n} itens?',
	);
	@override String deleteFromVault({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${names} será eliminado de ${vault}. Esta ação não pode ser anulada.',
		other: '${names} serão eliminados de ${vault}. Esta ação não pode ser anulada.',
	);
	@override String deleteFromVaults({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${names} será eliminado. Esta ação não pode ser anulada.',
		other: '${names} serão eliminados. Esta ação não pode ser anulada.',
	);
	@override String moveLine({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${names} é movido com o seu histórico e as suas etiquetas.',
		other: '${names} são movidos com o seu histórico e as suas etiquetas.',
	);
	@override String movedTitle({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${names} movido para ${vault}',
		other: '${names} movidos para ${vault}',
	);
	@override String movedDetail({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Mantém o seu histórico e as suas etiquetas.',
		other: 'Mantêm o seu histórico e as suas etiquetas.',
	);
	@override String itemsOf({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${count} de ${n} item',
		other: '${count} de ${n} itens',
	);
}

// Path: itemDetail
class _Translations$itemDetail$pt extends Translations$itemDetail$en {
	_Translations$itemDetail$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get edit => 'Editar';
	@override String get editItem => 'Editar item';
	@override String get moreOptions => 'Mais opções';
	@override String updatedAgo({required Object ago}) => 'Atualizado ${ago}';
	@override String showTagged({required Object tag}) => 'Mostrar itens com a etiqueta ${tag}';
	@override String get fields => 'Campos';
	@override String get noFields => 'Este item não tem campos.';
	@override String get history => 'Histórico';
	@override String get currentVersion => 'Versão Atual';
	@override String todayAt({required Object time}) => 'Hoje, ${time}';
	@override String get unnamedField => 'Sem nome';
	@override String copyField({required Object field}) => 'Copiar ${field}';
	@override String get revealValue => 'Mostrar valor';
	@override String get hideValue => 'Ocultar valor';
	@override String hiddenValue({required Object field}) => '${field}, oculto';
	@override String openSite({required Object site}) => 'Abrir ${site}';
	@override String get call => 'Ligar';
	@override String get message => 'Mensagem';
	@override String get checksumFail => 'Esse número falha na soma de verificação — um dos dígitos está provavelmente errado.';
	@override String get codeCardHint => 'Toque para copiar · também no separador Códigos';
	@override String get copyAllCodes => 'Copiar todos os códigos';
	@override String copyCodeNumber({required Object n}) => 'Copiar código ${n}';
	@override String get cardFace => 'Cartão, número oculto';
	@override String cardFaceBrand({required Object brand}) => 'Cartão ${brand}, número oculto';
	@override String cardExpires({required Object date}) => 'expira em ${date}';
	@override String get largeTypeTurn => 'Rode o telemóvel para o ler numa só linha.';
	@override String get largeTypeHides => 'Volta a ficar oculto quando sair deste ecrã.';
	@override String get earlierVersion => 'Versão Anterior';
	@override String readOnly({required Object ago}) => '${ago} · só de leitura';
	@override String get changedSince => 'Alterado desde então';
	@override String get restoreThisVersion => 'Restaurar esta versão';
	@override String get deleteVersion => 'Eliminar versão';
	@override String get restoreTitle => 'Restaurar esta versão?';
	@override String restoreBody({required Object name, required Object date}) => '${name} volta ao estado de ${date}. A versão atual fica no histórico.';
	@override String get restore => 'Restaurar';
	@override String get deleteVersionTitle => 'Eliminar Esta Versão';
	@override String get deleteVersionConfirm => 'Tem a certeza de que quer eliminar esta versão do histórico? Esta ação não pode ser anulada.';
	@override String get delete => 'Eliminar';
	@override String get notFound => 'Este item já não existe.';
	@override String get notFoundHint => 'Pode ter sido eliminado a partir de outro dispositivo.';
	@override String get backToVault => 'Voltar ao cofre';
	@override String hiddenLines({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${field}, oculto, ${n} linha',
		other: '${field}, oculto, ${n} linhas',
	);
	@override String largeTypeLabel({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${field} em letra grande, ${n} carácter',
		other: '${field} em letra grande, ${n} caracteres',
	);
}

// Path: editItem
class _Translations$editItem$pt extends Translations$editItem$en {
	_Translations$editItem$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get newVaultItem => 'Novo Item do Cofre';
	@override String get vault => 'Cofre';
	@override String get template => 'Modelo';
	@override String get templateNote => 'Os modelos são só um ponto de partida: mude o nome, remova ou adicione campos a qualquer momento.';
	@override late final _Translations$editItem$templates$pt templates = _Translations$editItem$templates$pt._(_root);
	@override late final _Translations$editItem$templateHints$pt templateHints = _Translations$editItem$templateHints$pt._(_root);
	@override late final _Translations$editItem$templateFields$pt templateFields = _Translations$editItem$templateFields$pt._(_root);
	@override late final _Translations$editItem$types$pt types = _Translations$editItem$types$pt._(_root);
	@override String get newItem => 'Novo Item';
	@override String get editItem => 'Editar Item';
	@override String get changeIcon => 'Alterar ícone';
	@override String get name => 'Nome';
	@override String get namePlaceholder => 'ex.: GitHub';
	@override String get tags => 'Etiquetas';
	@override String get addField => 'Adicionar campo';
	@override String get addFieldTitle => 'Adicionar Campo';
	@override String get noFieldsTitle => 'Ainda não há campos';
	@override String get noFieldsBody => 'Adicione qualquer um dos 16 tipos de campo — um número de apólice, um número de telefone, um PIN.';
	@override String get fieldNamePlaceholder => 'Nome do campo';
	@override String get addTag => 'Adicionar uma etiqueta';
	@override String get tagSuggestions => 'Sugestões de etiquetas';
	@override String createTag({required Object name}) => 'Criar “${name}”';
	@override String get tagTooLong => 'Esse nome é demasiado longo.';
	@override String get removeFieldTitle => 'Tem a certeza de que quer remover este campo?';
	@override String removeFieldBody({required Object field, required Object item}) => '“${field}” e o respetivo valor saem de ${item} quando guardar.';
	@override String get remove => 'Remover';
	@override String get discardTitle => 'Descartar as alterações?';
	@override String discardBody({required Object name}) => 'As suas alterações a ${name} não foram guardadas. Ao descartá-las, o item fica como estava.';
	@override String get discardNewTitle => 'Descartar este novo item?';
	@override String get discardNewBody => 'Não foi guardado. Ao descartá-lo, perde-se.';
	@override String get discard => 'Descartar';
	@override String get usernamePlaceholder => 'Nome de utilizador ou e-mail';
	@override String get passwordPlaceholder => 'Senha';
	@override String get valuePlaceholder => 'Escreva o valor aqui';
	@override String get ipHostPlaceholder => 'ex.: 192.168.1.1, ::1 ou db.exemplo.com';
	@override String get recoveryCodesPlaceholder => 'Um por linha — qualquer formato funciona';
	@override String get notEmail => 'Isso não parece um endereço de e-mail.';
	@override String get phoneNumber => 'Número de telefone';
	@override String get searchCountries => 'Pesquisar países';
	@override String get noCountryMatch => 'Nenhum país corresponde.';
	@override String get generate => 'Gerar';
	@override String get generatePassword => 'Gerar uma palavra-passe';
	@override String get currentCode => 'Código atual';
	@override String get scanQr => 'Ler código QR';
	@override String get enterSetupKey => 'Introduzir chave de configuração';
	@override String get setupKeyTitle => 'Introduzir Chave de Configuração';
	@override String get setupKeyBody => 'Os sites mostram uma chave de configuração junto ao código QR, muitas vezes em “Não consegue ler?”.';
	@override String get setupKey => 'Chave de configuração';
	@override String get setupKeyHint => 'Os espaços e as maiúsculas não importam.';
	@override String get saveCode => 'Guardar código';
	@override String get chooseIcon => 'Escolher Ícone';
	@override String get searchIcons => 'Pesquisar ícones — experimente “banco” ou “cadeado”';
	@override String get popular => 'Populares';
	@override String noIcons({required Object search}) => 'Nenhum ícone corresponde a “${search}”.';
	@override String get useDefaultIcon => 'Usar ícone predefinido';
	@override String iconMatches({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${n} resultado',
		other: '${n} resultados',
	);
}

// Path: generator
class _Translations$generator$pt extends Translations$generator$en {
	_Translations$generator$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gerar uma palavra-passe';
	@override String get notFilledIn => 'Nada é preenchido até o aceitar.';
	@override String get generated => 'Palavra-passe gerada';
	@override String get mode => 'Modo';
	@override String get passphrase => 'Frase-passe';
	@override String get randomString => 'Cadeia aleatória';
	@override String get words => 'Palavras';
	@override String get fewerWords => 'Menos palavras';
	@override String get moreWords => 'Mais palavras';
	@override String get length => 'Comprimento';
	@override String get shorter => 'Mais curta';
	@override String get longer => 'Mais longa';
	@override String get wordSeparator => 'Separador de palavras';
	@override String get dash => 'Hífen';
	@override String get underscore => 'Sublinhado';
	@override String get slash => 'Barra';
	@override String get space => 'Espaço';
	@override String get language => 'Idioma';
	@override String get regenerate => 'Regenerar';
	@override String charCount({required Object count}) => '${count} caracteres';
	@override String get lowercase => 'Letras minúsculas';
	@override String get uppercase => 'Letras maiúsculas';
	@override String get digits => 'Algarismos';
	@override String get symbols => 'Símbolos';
	@override String get pickOne => 'Escolha pelo menos um tipo de carácter.';
	@override String get use => 'Usar esta palavra-passe';
	@override String wordCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${n} palavra',
		other: '${n} palavras',
	);
	@override String get pageTitle => 'Gerador de Palavras-passe';
	@override String get subtitle => 'Palavras-passe e frases-passe aleatórias, criadas neste dispositivo';
	@override String get separatorDash => 'Hífen ( - )';
	@override String get separatorUnderscore => 'Sublinhado ( _ )';
	@override String get separatorSlash => 'Barra ( / )';
	@override String get separatorSpace => 'Espaço';
	@override String get nothingToGenerate => 'Nada para gerar.';
	@override String get copyPassword => 'Copiar palavra-passe';
	@override String get copied => 'Palavra-passe copiada';
	@override String get fromGenerator => 'Do gerador';
}

// Path: report
class _Translations$report$pt extends Translations$report$en {
	_Translations$report$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Relatório de Segurança';
	@override String get subtitle => 'Quão bem as suas palavras-passe guardadas resistem';
	@override String get healthLabel => 'Saúde do cofre';
	@override String get healthGood => 'Sólida';
	@override String get healthFair => 'A melhorar';
	@override String get healthPoor => 'Em risco';
	@override String get allClearTitle => 'Nenhum problema encontrado';
	@override String get allClearDescription => 'Todas as palavras-passe nos seus cofres passaram a última auditoria.';
	@override String aboutSection({required Object title}) => 'Acerca de ${title}';
	@override String get nothingFound => 'Nada encontrado';
	@override String openItem({required Object name}) => 'Abrir ${name}';
	@override String get checkAgain => 'Verificar novamente';
	@override String get statWeak => 'Fracas';
	@override String get statReused => 'Reutilizadas';
	@override String get statCompromised => 'Comprometidas';
	@override String statValue({required Object label, required Object count}) => '${label}: ${count}';
	@override String statNotChecked({required Object label}) => '${label}: ainda não verificado';
	@override String healthPercent({required Object title, required Object score}) => '${title} ${score} por cento';
	@override String sameAs({required Object names}) => 'A mesma de ${names}';
	@override String get sameAsField => 'Igual a outra palavra-passe deste item';
	@override String get foundInBreach => 'Encontrada numa fuga de dados conhecida';
	@override String get trust => 'A verificação de fugas usa o Have I Been Pwned com k-anonimato: só os primeiros 5 carateres de um hash SHA-1 saem deste telemóvel.';
	@override String get lastCheckedJustNow => 'Última verificação: agora mesmo';
	@override String lastCheckedToday({required Object time}) => 'Última verificação: hoje às ${time}';
	@override String lastCheckedOn({required Object date}) => 'Última verificação: ${date}';
	@override String get checking => 'A verificar…';
	@override String checkingBreaches({required Object done, required Object total}) => 'A procurar fugas · ${done} de ${total}';
	@override String progress({required Object done, required Object total}) => '${done} de ${total}';
	@override String progressTime({required Object done, required Object total, required Object time}) => '${done} de ${total} · ${time}';
	@override String get offlineBody => 'Não foi possível verificar as suas palavras-passe. A verificação precisa de ligação.';
	@override String get failedTitle => 'Não foi possível concluir a verificação';
	@override String get failedBody => 'Tente novamente daqui a pouco.';
	@override String get nothingTitle => 'Ainda não há nada para verificar';
	@override String get nothingBody => 'Guarde um item com palavra-passe e ele é verificado aqui, neste telemóvel, quanto a palavras-passe fracas, reutilizadas ou expostas.';
	@override String get howToFix => 'Como resolver';
	@override String get stepOpen => 'Abra o item';
	@override String get stepGenerate => 'Toque em Editar e depois em Gerar na palavra-passe';
	@override String get stepSave => 'Guarde — o alerta desaparece sozinho';
	@override String get stepSaveCompromised => 'Guarde e altere-a também no site';
	@override String get changePassword => 'Alterar palavra-passe';
	@override String fixedClear({required Object name}) => 'Guardado · ${name} já não está assinalado';
	@override String fixedFlagged({required Object name}) => 'Guardado · ${name} continua assinalado';
	@override String savedTo({required Object storage}) => 'O seu cofre foi guardado no ${storage}';
	@override String get noLongerWeak => 'Já não é fraca';
	@override String get noLongerReused => 'Já não é reutilizada';
	@override String get noLongerWeakOrReused => 'Já não é fraca nem reutilizada';
	@override String hintReusedOne({required Object n}) => 'Estes ${n} partilham uma palavra-passe. Dê a cada um a sua: abra um, toque em Editar e depois em Gerar.';
	@override String get hintReusedSome => 'Alguns partilham uma palavra-passe. Dê a cada um a sua: abra um, toque em Editar e depois em Gerar.';
	@override String get hintWeak => 'Dê a cada um uma mais forte: abra-o, toque em Editar e depois em Gerar.';
	@override String get hintCompromised => 'Estes aparecem em fugas de dados conhecidas. Altere cada um: abra-o, toque em Editar e depois em Gerar.';
	@override String itemsChecked({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${n} item com palavra-passe verificado',
		other: '${n} itens com palavra-passe verificados',
	);
	@override String flagged({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${n} item assinalado',
		other: '${n} itens assinalados',
	);
	@override String sameAsOthers({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'A mesma de ${n} outro item',
		other: 'A mesma de ${n} outros itens',
	);
	@override String checkingPasswords({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'A verificar ${n} palavra-passe',
		other: 'A verificar ${n} palavras-passe',
	);
	@override String aboutSeconds({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'cerca de ${n} segundo',
		other: 'cerca de ${n} segundos',
	);
	@override String aboutMinutes({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'cerca de ${n} minuto',
		other: 'cerca de ${n} minutos',
	);
}

// Path: audit
class _Translations$audit$pt extends Translations$audit$en {
	_Translations$audit$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$audit$weakPassword$pt weakPassword = _Translations$audit$weakPassword$pt._(_root);
	@override late final _Translations$audit$reusedPassword$pt reusedPassword = _Translations$audit$reusedPassword$pt._(_root);
	@override late final _Translations$audit$compromisedPassword$pt compromisedPassword = _Translations$audit$compromisedPassword$pt._(_root);
}

// Path: myVaults
class _Translations$myVaults$pt extends Translations$myVaults$en {
	_Translations$myVaults$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Os Meus Cofres';
	@override String get subtitle => 'Grupos separados de itens — trabalho, família, pessoal';
	@override String get defaultBadge => 'Predefinido';
	@override String get newVault => 'Novo cofre';
	@override String get emptyTitle => 'Só tem o cofre predefinido';
	@override String get emptyBody => 'Um segundo cofre mantém um conjunto de itens separado — trabalho do pessoal, ou partilhado do privado.';
	@override String createdOn({required Object date}) => 'criado em ${date}';
	@override String get renameTitle => 'Renomear Cofre';
	@override String get renameBody => 'Os itens nele contidos não são afetados.';
	@override String duplicateRename({required Object name}) => 'Já existe um cofre chamado “${name}”.';
	@override String deleteTitle({required Object name}) => 'Eliminar “${name}”?';
	@override String get deleteAction => 'Eliminar cofre';
	@override String renameAria({required Object name}) => 'Renomear ${name}';
	@override String deleteAria({required Object name}) => 'Eliminar ${name}';
	@override String itemCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${n} item',
		other: '${n} itens',
	);
	@override String deleteBody({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'O seu ${n} item passa para ${vault}. Esta ação não pode ser anulada.',
		other: 'Os seus ${n} itens passam para ${vault}. Esta ação não pode ser anulada.',
	);
	@override String deleteSelectedTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Eliminar ${n} cofre?',
		other: 'Eliminar ${n} cofres?',
	);
	@override String deleteSelectedBody({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Tudo o que contêm — ${n} item — passa para ${vault}. Esta ação não pode ser anulada.',
		other: 'Tudo o que contêm — ${n} itens — passa para ${vault}. Esta ação não pode ser anulada.',
	);
	@override String personalSummary({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${name} contém ${n} item e não pode ser renomeado nem eliminado.',
		other: '${name} contém ${n} itens e não pode ser renomeado nem eliminado.',
	);
	@override String selected({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${n} cofre selecionado',
		other: '${n} cofres selecionados',
	);
	@override String deleteVaults({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Eliminar ${n} cofre',
		other: 'Eliminar ${n} cofres',
	);
}

// Path: tags
class _Translations$tags$pt extends Translations$tags$en {
	_Translations$tags$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Etiquetas';
	@override String get subtitle => 'Etiquetas comuns a todos os cofres, para encontrar tudo depressa';
	@override String since({required Object date}) => 'desde ${date}';
	@override String get addTag => 'Adicionar etiqueta';
	@override String get addTitle => 'Adicionar Etiqueta';
	@override String get emptyTitle => 'Ainda sem etiquetas';
	@override String get emptyBody => 'As etiquetas são criadas a partir de um item, ou aqui — de qualquer forma, agrupam itens entre cofres.';
	@override String get addBody => 'Uma etiqueta ainda sem itens. Coloque-a num item a partir da própria página desse item.';
	@override String get tagName => 'Nome da etiqueta';
	@override String get duplicate => 'Já existe uma etiqueta com este nome.';
	@override String get colorNote => 'A cor vem do nome.';
	@override String get renameTitle => 'Renomear Etiqueta';
	@override String get renameBody => 'Todos os itens que a têm são atualizados.';
	@override String mergeNotice({required Object name}) => '“${name}” já existe — ao renomear, serão fundidas.';
	@override String deleteTitle({required Object name}) => 'Eliminar “${name}”?';
	@override String get deleteAction => 'Eliminar etiqueta';
	@override String get deleteSelectedBody => 'Cada uma é removida de todos os itens que a têm. Os itens em si são mantidos. Esta ação não pode ser anulada.';
	@override String get footer => 'Toque numa etiqueta para ver os itens dela no separador Cofre.';
	@override String renameAria({required Object name}) => 'Renomear ${name}';
	@override String deleteAria({required Object name}) => 'Eliminar ${name}';
	@override String itemCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${n} item',
		other: '${n} itens',
	);
	@override String deleteBody({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Será removida de ${n} item. Os itens em si são mantidos. Esta ação não pode ser anulada.',
		other: 'Será removida de ${n} itens. Os itens em si são mantidos. Esta ação não pode ser anulada.',
	);
	@override String deleteSelectedTitle({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Eliminar ${n} etiqueta?',
		other: 'Eliminar ${n} etiquetas?',
	);
	@override String selected({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${n} etiqueta selecionada',
		other: '${n} etiquetas selecionadas',
	);
	@override String deleteTags({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Eliminar ${n} etiqueta',
		other: 'Eliminar ${n} etiquetas',
	);
}

// Path: changeSecret
class _Translations$changeSecret$pt extends Translations$changeSecret$en {
	_Translations$changeSecret$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Alterar Segredo';
	@override String get intro => 'O seu cofre é novamente cifrado com o novo segredo e carregado outra vez. Não pode ser recuperado se o esquecer.';
	@override String get current => 'Segredo atual';
	@override String get wrong => 'Esse não é o seu segredo atual.';
	@override String get match => 'Os dois segredos coincidem.';
	@override String get otherDevices => 'Os outros dispositivos pedem o novo segredo da próxima vez que abrirem o seu cofre.';
	@override String get submit => 'Alterar segredo';
	@override String get verifyingMeta => 'A verificar o seu segredo atual…';
	@override String get verifyingTitle => 'A verificar o seu segredo atual…';
	@override String get stepVerify => 'A verificar o seu segredo atual';
	@override String get stepVerifyNote => 'Deliberadamente lento num telemóvel — é isso que torna dispendioso adivinhá-lo';
	@override String get stepEncrypt => 'A cifrar com o novo segredo';
	@override String get stepSave => 'A guardar o seu cofre';
	@override String savingMeta({required Object storage}) => 'A guardar em ${storage}…';
	@override String savingTitle({required Object percent}) => 'A guardar o seu cofre… ${percent}%';
	@override String get stepVerified => 'Segredo atual verificado';
	@override String get stepEncrypted => 'Cifrado com o novo segredo';
	@override String stepSaving({required Object storage}) => 'A guardar no ${storage}';
	@override String get keepOpen => 'Mantenha o KeeperPass aberto até terminar.';
	@override String doneMeta({required Object storage}) => 'Guardado no ${storage}';
	@override String get doneTitle => 'O seu segredo foi alterado';
	@override String get doneBody => 'Todos os itens vieram consigo. Os outros dispositivos pedem o novo segredo da próxima vez que abrirem o seu cofre.';
	@override String get toast => 'Segredo alterado';
	@override String get failTitle => 'O seu cofre não foi guardado';
	@override String failBody({required Object storage}) => 'Não foi possível contactar o ${storage}. O seu segredo não foi alterado: o cofre continua a abrir com o atual.';
}

// Path: storage
class _Translations$storage$pt extends Translations$storage$en {
	_Translations$storage$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Armazenamento';
	@override String get subtitle => 'Onde vive o seu cofre e o que lhe pode aceder';
	@override String diagram({required Object storage}) => 'Cifrado neste telemóvel, guardado no seu ${storage}';
	@override String get thisPhone => 'Este telemóvel';
	@override String get encryptedOnly => 'Apenas o ficheiro cifrado';
	@override String get googleFolder => 'pasta keeperpass';
	@override String get dropboxFolder => 'pasta Apps/keeperpass';
	@override String savedToday({required Object folder, required Object time}) => '${folder} · guardado hoje às ${time}';
	@override String savedOn({required Object folder, required Object date}) => '${folder} · guardado em ${date}';
	@override String get access => 'Acesso';
	@override String get googlePermissions => 'Permissões da conta Google';
	@override String get dropboxApps => 'Aplicações ligadas ao Dropbox';
	@override String get accessNote => 'O KeeperPass só consegue aceder aos ficheiros que cria. Pode revogar esse acesso aqui a qualquer momento; o ficheiro do cofre fica onde está.';
}

// Path: moveVault
class _Translations$moveVault$pt extends Translations$moveVault$en {
	_Translations$moveVault$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mover cofre';
	@override String diagram({required Object from, required Object to}) => 'O seu cofre passa do ${from} para o ${to}';
	@override String get from => 'Origem';
	@override String get to => 'Destino';
	@override String get intro => 'O seu cofre é copiado e verificado, e só depois o ficheiro antigo é renomeado. Se algo falhar, nada é alterado.';
	@override String step1({required Object storage}) => 'Inicie sessão no ${storage} para escolher para onde vai o cofre.';
	@override String get step2 => 'Confirme. Nada muda antes deste passo.';
	@override String get step3 => 'O cofre é copiado e verificado; depois, o ficheiro antigo é renomeado, nunca eliminado.';
	@override String connect({required Object storage}) => 'Ligar ${storage}';
	@override String get account => 'A mover para esta conta';
	@override String existingTitle({required Object storage}) => 'Esta conta do ${storage} já tem um cofre KeeperPass';
	@override String existingBody({required Object storage}) => 'Se continuar, é mantido como cópia de segurança com data e hora no ${storage} e substituído pelo cofre que está a mover.';
	@override String get existingConfirm => 'Substituí-lo — o cofre existente é mantido como cópia de segurança';
	@override String get secretSection => 'Segredo do cofre movido';
	@override String get keepSecret => 'Manter o meu segredo atual';
	@override String get newSecret => 'Escolher um segredo novo';
	@override String get newSecretNote => 'Só o cofre movido o usa';
	@override String get submit => 'Mover cofre';
	@override String get movingTitle => 'A mover o seu cofre';
	@override String get stageEncrypting => 'A cifrar o seu cofre';
	@override String stageSaving({required Object storage}) => 'A guardar em ${storage}…';
	@override String get stageChecking => 'A verificar a cópia guardada';
	@override String get stageRenaming => 'A renomear o ficheiro antigo';
	@override String get movingNote => 'Mantenha o KeeperPass aberto até terminar. Se algo falhar, nada é alterado.';
	@override String savedTo({required Object storage}) => 'Guardado no ${storage}';
	@override String doneTitle({required Object storage}) => 'O seu cofre está agora em ${storage}';
	@override String doneBody({required Object provider, required Object from}) => 'Inicie sessão com ${provider} para o abrir. O ficheiro antigo foi mantido e renomeado no ${from}:';
	@override String get copyFileName => 'Copiar nome do ficheiro';
	@override String get fileNameCopied => 'Nome do ficheiro copiado';
	@override String partlyTitle({required Object storage}) => 'O seu cofre foi copiado para o ${storage}';
	@override String partlyBody({required Object from}) => 'Mas não foi possível renomear o ficheiro antigo no ${from}. Renomeie-o ou elimine-o manualmente, para que as duas cópias não divirjam.';
	@override String open({required Object storage}) => 'Abrir ${storage}';
	@override String unchanged({required Object from}) => 'Continua no ${from} · inalterado';
	@override String get notMovedTitle => 'O seu cofre não foi movido';
	@override String get notMovedBody => 'A cópia guardada não correspondia ao seu cofre, por isso o ficheiro antigo ficou intacto. Nada se perdeu — tente novamente.';
}

// Path: dataIo
class _Translations$dataIo$pt extends Translations$dataIo$en {
	_Translations$dataIo$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get importTitle => 'Importar';
	@override String get file => 'Ficheiro';
	@override String fileMeta({required Object size}) => '${size} · de Ficheiros';
	@override String kilobytes({required Object n}) => '${n} KB';
	@override String megabytes({required Object n}) => '${n} MB';
	@override String get change => 'Alterar';
	@override String found({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Foi encontrado ${n} item para importar.',
		other: 'Foram encontrados ${n} itens para importar.',
	);
	@override String get addTo => 'Adicioná-los a';
	@override String get importNote => 'Os itens são adicionados ao cofre que escolher. Nada é substituído.';
	@override String importButton({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Importar ${n} item',
		other: 'Importar ${n} itens',
	);
	@override String get invalidCsv => 'Não foi possível ler este ficheiro como CSV.';
	@override String get noItems => 'Não foram encontrados itens neste ficheiro.';
	@override String get notCsvNote => 'Exporte um CSV do seu outro gestor de palavras-passe e depois escolha esse ficheiro aqui.';
	@override String get chooseAnother => 'Escolher outro ficheiro';
	@override String get exportTitle => 'Exportar';
	@override String get exportIntro => 'Escreve um CSV do cofre que escolher. Os itens exportados deixam para trás a cifra do cofre — o que fizer com o ficheiro é consigo.';
	@override String get sourceVault => 'Cofre de origem';
	@override String get notEncryptedTitle => 'Um ficheiro CSV não está cifrado';
	@override String get notEncryptedBody => 'Quem o abrir pode ler todas as palavras-passe nele. Guarde-o num local seguro e elimine-o quando terminar.';
	@override String exportButton({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: 'Exportar ${n} item',
		other: 'Exportar ${n} itens',
	);
	@override String get exportNote => 'Abre a folha de partilha, para que escolha para onde vai o ficheiro.';
	@override String get recentTitle => 'Exportações Recentes';
	@override String recentRow({required num n, required Object scope}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n,
		one: '${scope} · ${n} item',
		other: '${scope} · ${n} itens',
	);
	@override String get recentNote => 'As últimas 10 exportações ficam registadas no seu cofre. O KeeperPass não guarda nenhuma cópia dos ficheiros em si.';
	@override String get recentEmpty => 'Ainda sem exportações.';
}

// Path: archive
class _Translations$archive$pt extends Translations$archive$en {
	_Translations$archive$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Arquivar Cofre';
	@override String get headline => 'Arquivar cofre e terminar sessão';
	@override String body({required Object storage}) => 'O seu cofre é um único ficheiro cifrado no seu próprio ${storage}. Arquivá-lo muda o nome do ficheiro para que esta aplicação deixe de o encontrar e termina a sua sessão. Nada é apagado.';
	@override String step1({required Object oldName, required Object newName, required Object folder}) => '${oldName} é renomeado para ${newName}, na mesma ${folder}.';
	@override String step2({required Object storage}) => 'Este telemóvel termina a sessão no ${storage}.';
	@override String step3({required Object storage}) => 'Para apagar os dados em si, apague esse ficheiro no ${storage}.';
	@override String get typePrefix => 'Escreva';
	@override String get typeSuffix => 'para confirmar.';
	@override String get confirmation => 'Confirmação';
	@override String get button => 'Arquivar e terminar sessão';
	@override String get doneMeta => 'Renomeado · esta aplicação já não o encontra';
	@override String get doneTitle => 'O nome do seu ficheiro de cofre foi alterado';
	@override String doneBody({required Object folder, required Object storage}) => 'Continua na ${folder} do seu ${storage}. Apague-o aí quando quiser que os dados desapareçam definitivamente.';
	@override String get signedOut => 'Terminou sessão neste telemóvel.';
	@override String get error => 'Não foi possível alterar o nome do ficheiro de cofre. Nada foi alterado.';
}

// Path: help
class _Translations$help$pt extends Translations$help$en {
	_Translations$help$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get howTitle => 'Como Funciona o KeeperPass';
	@override String get howSubtitle => 'Onde vivem os seus dados e o que os mantém privados';
	@override String get whereLives => 'Onde vivem os seus dados';
	@override String diagram({required Object storage}) => 'O seu cofre é cifrado neste telemóvel e guardado como um único ficheiro no seu ${storage}';
	@override String get thisPhoneNote => 'Cifra e decifra tudo. O seu segredo nunca sai dele.';
	@override String get fileEncrypted => 'vault.json.enc · cifrado';
	@override String yourStorage({required Object storage}) => 'O seu ${storage}';
	@override String get storageNote => 'Guarda o ficheiro, que é ilegível sem o seu segredo.';
	@override String get noServer => 'O KeeperPass nunca recebe os seus dados. Não há nenhuma conta para invadir nem operador que consiga ler o seu cofre.';
	@override String get protects => 'O que o protege';
	@override String get secretTerm => 'O seu segredo';
	@override String get secretNote => 'Nunca enviado, nunca guardado. Só existe em memória enquanto a app está desbloqueada.';
	@override String get kdfTerm => 'Derivação de chave';
	@override String get kdfNote => 'Deliberadamente lenta, para que cada tentativa de adivinhar o seu segredo seja dispendiosa.';
	@override String get encryptionTerm => 'Cifra';
	@override String get encryptionNote => 'Mantém o ficheiro ilegível e mostra se alguém o alterou.';
	@override String get accessTerm => 'Acesso ao armazenamento';
	@override String get accessNote => 'O KeeperPass só consegue aceder aos ficheiros que cria.';
	@override String get signingIn => 'Iniciar sessão';
	@override String get step1 => 'Ligue o seu armazenamento na nuvem';
	@override String get step1Note => 'Prova a quem pertence o ficheiro. Não desbloqueia nada.';
	@override String get step2 => 'Introduza o seu segredo';
	@override String get step2Note => 'Cria neste telemóvel a chave que abre o ficheiro. O seu fornecedor de armazenamento nunca a vê.';
	@override String get bothNeeded => 'Quem tiver a sua conta de armazenamento continua sem conseguir ler o seu cofre. Quem souber o seu segredo continua sem conseguir chegar ao ficheiro. São precisas as duas coisas.';
	@override String get terms => 'Termos que vale a pena conhecer';
	@override String get secretWord => 'Segredo';
	@override String get secretDef => 'A única frase que desbloqueia o seu cofre. Não pode ser recuperada.';
	@override String get vaultWord => 'Cofre';
	@override String get vaultDef => 'Um grupo de itens. Com vários, mantém o trabalho separado do pessoal.';
	@override String get tagWord => 'Etiqueta';
	@override String get tagDef => 'Uma etiqueta para encontrar itens entre cofres, como trabalho ou banco.';
	@override String get reportWord => 'Relatório de segurança';
	@override String get reportDef => 'Assinala palavras-passe fracas, reutilizadas e expostas, neste telemóvel.';
}

// Path: faq
class _Translations$faq$pt extends Translations$faq$en {
	_Translations$faq$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Perguntas';
	@override String get subtitle => 'Respostas a perguntas frequentes';
	@override String get forgetQ => 'E se eu esquecer o meu segredo?';
	@override String get forgetA1 => 'O seu cofre não pode ser recuperado — nem por si, nem por nós. A chave é criada apenas a partir do seu segredo, pelo que sem ele o ficheiro fica ilegível. Este é o preço de mais ninguém o conseguir ler também.';
	@override String forgetA2({required Object forgot, required Object file}) => 'O que pode fazer é recomeçar: ${forgot} no ecrã de desbloqueio cria um cofre novo e vazio. O seu ficheiro antigo não é eliminado — é renomeado para ${file} e mantido na sua pasta keeperpass, por isso os dados continuam lá se o segredo lhe voltar à memória.';
	@override String get forgetA2Link => 'Esqueceu-se do segredo?';
	@override String get forgetA3 => 'Anote o seu segredo e guarde-o num local seguro. É a única coisa no KeeperPass que não pode ser substituída.';
	@override String get seeQ => 'O KeeperPass consegue ver as minhas palavras-passe?';
	@override String get seeA => 'Não — e não é uma promessa, é uma consequência do design. A cifra acontece neste telemóvel e o texto cifrado vai diretamente para o seu próprio armazenamento. Não há nenhum servidor KeeperPass pelo meio que possa ver alguma coisa.';
	@override String get syncQ => 'Sincroniza entre dispositivos?';
	@override String get syncA => 'Sim. Todos os dispositivos leem o mesmo ficheiro do seu armazenamento. Inicie sessão com a mesma conta, introduza o mesmo segredo e o seu cofre está lá.';
	@override String get providerQ => 'E se o meu fornecedor de armazenamento ler o ficheiro?';
	@override String get providerA => 'Veriam bytes cifrados. A chave nunca sai deste telemóvel, por isso nem a Google, nem o Dropbox, nem outro fornecedor conseguem ler o conteúdo.';
	@override String get importQ => 'Posso importar de outro gestor de palavras-passe?';
	@override String get importA => 'Sim — exporte para CSV aí, depois use Importar nas Definições.';
	@override String get changeSecretQ => 'Como altero o meu segredo?';
	@override String changeSecretA({required Object action}) => 'Abra as Definições e escolha ${action}. Introduz o seu segredo atual e o novo; o seu cofre é decifrado, cifrado novamente com o novo segredo e guardado de volta. Nada se perde — todos os itens acompanham-no, e a alteração aplica-se em cada dispositivo da próxima vez que este carregar o seu cofre.';
	@override String get costQ => 'Quanto custa?';
	@override String get costA => 'Nada. O KeeperPass é gratuito e de código aberto, e guarda os dados no espaço na nuvem que já tem.';
	@override String get stillStuck => 'Continua sem conseguir?';
	@override String get contactBody => 'Dúvidas, comentários ou um problema? Envie-nos um email.';
}

// Path: about
class _Translations$about$pt extends Translations$about$en {
	_Translations$about$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String version({required Object version, required Object build}) => 'Versão ${version} (${build})';
	@override String get tagline => 'A sua nuvem. As suas chaves. O seu cofre.';
	@override String get license => 'Gratuito e de código aberto sob AGPL-3.0';
	@override String get terms => 'Termos de Serviço';
	@override String get privacy => 'Política de Privacidade';
	@override String get promise => 'Gratuito, sem truques: sem planos, sem versão premium, sem vendas adicionais.';
}

// Path: clipboard
class _Translations$clipboard$pt extends Translations$clipboard$en {
	_Translations$clipboard$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String clearsIn({required Object time}) => 'Limpa-se em ${time}';
	@override String get cleared => 'Área de transferência limpa';
}

// Path: sync
class _Translations$sync$pt extends Translations$sync$en {
	_Translations$sync$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String savedTo({required Object storage}) => 'Guardado no ${storage}';
	@override String get notSavedTitle => 'O seu cofre não foi guardado';
	@override String notSavedBody({required Object storage}) => 'Não foi possível ligar ao ${storage}. A sua alteração continua aqui — tente novamente antes de fechar o KeeperPass.';
	@override String get dismiss => 'Dispensar';
	@override String get retryingTitle => 'A tentar novamente…';
	@override String retryingBody({required Object storage}) => 'A guardar no ${storage}.';
	@override String reconnectTitle({required Object storage}) => 'Volte a ligar ao ${storage}';
	@override String get keepReading => 'Pode continuar a ler; as alterações são guardadas assim que voltar a ligar-se.';
	@override String get reconnect => 'Voltar a ligar';
	@override String get later => 'Mais tarde';
	@override String offlineBody({required Object storage}) => 'Pode continuar a ler e a copiar. Para guardar é necessária uma ligação ao ${storage}.';
	@override String get changedTitle => 'O Seu Cofre Foi Alterado';
	@override String get changedBody => 'Foi guardada uma versão mais recente do seu cofre noutro dispositivo. Carregue-a antes de editar, para que nada seja substituído.';
	@override String get twoVersions => 'Duas versões';
	@override String get onThisPhone => 'Neste telemóvel';
	@override String inStorage({required Object storage}) => 'No ${storage}';
	@override String loadedAt({required Object time}) => 'carregada: ${time}';
	@override String savedNewer({required Object time}) => 'guardada: ${time} · mais recente';
	@override String get loadLatest => 'Carregar a versão mais recente';
	@override String get notNow => 'Agora não';
	@override String get pausedNote => 'Até lá, pode ler e copiar, mas não editar.';
	@override String get upToDate => 'Atualizado';
	@override String loadedVersion({required Object time}) => 'Foi carregada a versão guardada às ${time}';
}

// Path: scan
class _Translations$scan$pt extends Translations$scan$en {
	_Translations$scan$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ler Código QR';
	@override String get primerTitle => 'Adicionar um código 2FA por leitura';
	@override String get primerBody => 'Quando um site ativa o início de sessão em dois passos, mostra um código QR. O KeeperPass lê-o com a câmara e guarda a chave de configuração no seu cofre, para que os códigos apareçam em Códigos.';
	@override String get primerPrivacy => 'A câmara apenas lê o código. Nada é gravado e nenhuma imagem é guardada.';
	@override String get primerNext => 'A seguir, o seu telemóvel pede acesso à câmara.';
	@override String get enterInstead => 'Introduzir antes a chave de configuração';
	@override String get hint => 'Aponte para o código QR que o site mostra\nquando ativa o início de sessão em dois passos.';
	@override String get torch => 'Ligar a luz';
	@override String get cameraView => 'Vista da câmara';
	@override String get codeFound => 'Código Encontrado';
	@override String get saveTo => 'Guardar em';
	@override String get existingItem => 'Item existente';
	@override String existingItemWith({required Object summary}) => 'Item existente · ${summary}';
	@override String get newAuthenticator => 'Novo item Autenticador';
	@override String named({required Object name}) => 'Com o nome ${name}';
	@override String get cameraOffTitle => 'O acesso à câmara está desativado';
	@override String get cameraOffBody => 'O KeeperPass só precisa da câmara para ler códigos QR. Ative-a nas Definições ou escreva antes a chave de configuração.';
	@override String get openSettings => 'Abrir Definições';
	@override String get unsupported => 'Este código usa definições que o KeeperPass ainda não suporta';
	@override String get notACode => 'Isto não é um código QR de 2FA';
	@override String get cameraFailed => 'Não foi possível iniciar a câmara';
	@override String get item => 'Item';
	@override String get codeSettings => '6 dígitos · a cada 30 segundos · SHA-1';
	@override String codeAdded({required Object name}) => 'Código adicionado a ${name}';
	@override String get tapToCopy => 'Toque no cartão para o copiar.';
}

// Path: errors.failures
class _Translations$errors$failures$pt extends Translations$errors$failures$en {
	_Translations$errors$failures$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get networkFailure => 'Algo correu mal. Tente novamente.';
	@override String get undocumentedError => 'Algo correu mal. Tente novamente.';
	@override String get platformError => 'Algo correu mal. Tente novamente.';
	@override String get notFound => 'Algo correu mal. Tente novamente.';
	@override String get formatException => 'Algo correu mal. Tente novamente.';
	@override String get unableToProcess => 'Algo correu mal. Tente novamente.';
	@override String get requestTimeout => 'Algo correu mal. Tente novamente.';
	@override String get connectionError => 'Algo correu mal. Tente novamente.';
	@override String get unexpectedError => 'Algo correu mal. Tente novamente.';
	@override String get accessTokenFailure => 'Algo correu mal. Tente novamente.';
	@override String get cacheReadFailure => 'Algo correu mal. Tente novamente.';
	@override String get cacheWriteFailure => 'Algo correu mal. Tente novamente.';
}

// Path: errors.drive
class _Translations$errors$drive$pt extends Translations$errors$drive$en {
	_Translations$errors$drive$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get authExpired => 'A sua sessão do Google expirou. Volte a ligar-se.';
	@override String get backupFailed => 'Não foi possível fazer uma cópia de segurança do seu cofre atual no Google Drive. Tente novamente.';
	@override String get renameFailed => 'Não foi possível mudar o nome do seu ficheiro de cofre no Google Drive. Nada foi alterado — tente novamente.';
	@override String get createFolderFailed => 'Não foi possível criar a pasta keeperpass no Google Drive. Tente novamente.';
	@override String get readFailed => 'Não foi possível ler o seu cofre a partir do Google Drive. Tente novamente.';
	@override String get saveFailed => 'Não foi possível guardar o seu cofre no Google Drive. Tente novamente.';
	@override String get unreachable => 'Não foi possível contactar o Google Drive. Tente novamente.';
}

// Path: errors.dropbox
class _Translations$errors$dropbox$pt extends Translations$errors$dropbox$en {
	_Translations$errors$dropbox$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get authExpired => 'A sua sessão do Dropbox expirou. Volte a ligar-se.';
	@override String get profileFailed => 'Não foi possível ler o seu perfil do Dropbox. Tente novamente.';
	@override String get unknown => 'Ocorreu um problema ao contactar o Dropbox. Tente novamente.';
	@override String get unreachable => 'Não foi possível contactar o Dropbox. Tente novamente.';
	@override String get readFailed => 'Não foi possível ler o seu cofre a partir do Dropbox. Tente novamente.';
	@override String get saveFailed => 'Não foi possível guardar o seu cofre no Dropbox. Tente novamente.';
	@override String get backupFailed => 'Não foi possível fazer uma cópia de segurança do seu cofre atual no Dropbox. Tente novamente.';
	@override String get renameFailed => 'Não foi possível mudar o nome do seu ficheiro de cofre no Dropbox. Nada foi alterado — tente novamente.';
	@override String get missingScope => 'Falta uma permissão do Dropbox ao KeeperPass. É um problema de configuração que iniciar sessão de novo não resolve.';
	@override String get rateLimited => 'O Dropbox pede para abrandarmos. Aguarde um momento e tente novamente.';
}

// Path: errors.auth
class _Translations$errors$auth$pt extends Translations$errors$auth$en {
	_Translations$errors$auth$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get profileFailed => 'Não foi possível ler o seu perfil do Google. Tente novamente.';
	@override String get unknown => 'Ocorreu um problema ao contactar o Google. Tente novamente.';
}

// Path: errors.masterPassword
class _Translations$errors$masterPassword$pt extends Translations$errors$masterPassword$en {
	_Translations$errors$masterPassword$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get vaultNotFound => 'Não foi possível encontrar o seu cofre.';
}

// Path: errors.vault
class _Translations$errors$vault$pt extends Translations$errors$vault$en {
	_Translations$errors$vault$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String accountMismatch({required Object email}) => 'Inicie sessão com ${email} para guardar as suas alterações.';
	@override String get driveAccessNotGranted => 'A Google não deu ao KeeperPass acesso aos ficheiros que cria no seu Drive. Tente novamente e permita esse acesso na página da Google.';
	@override String get conflict => 'Foi guardada uma versão mais recente do seu cofre noutro dispositivo. Carregue-a antes de editar, para que nada seja substituído.';
	@override String get signInCanceled => 'Início de sessão cancelado';
	@override String get unsupported => 'Este ficheiro de cofre não pode ser aberto por esta versão do KeeperPass.';
	@override String get corrupt => 'O ficheiro do seu cofre está danificado e não pode ser aberto.';
}

// Path: settings.migrate
class _Translations$settings$migrate$pt extends Translations$settings$migrate$en {
	_Translations$settings$migrate$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$settings$migrate$error$pt error = _Translations$settings$migrate$error$pt._(_root);
}

// Path: auth.unlock
class _Translations$auth$unlock$pt extends Translations$auth$unlock$en {
	_Translations$auth$unlock$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get incorrectSecret => 'Segredo incorreto. Tente novamente.';
}

// Path: editItem.templates
class _Translations$editItem$templates$pt extends Translations$editItem$templates$en {
	_Translations$editItem$templates$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get website => 'Site ou app';
	@override String get computer => 'Computador';
	@override String get creditCard => 'Cartão de Crédito';
	@override String get bankAccount => 'Conta Bancária';
	@override String get wifi => 'Rede Wi-Fi';
	@override String get passport => 'Passaporte';
	@override String get note => 'Nota';
	@override String get authenticator => 'Autenticador';
	@override String get custom => 'Personalizado';
}

// Path: editItem.templateHints
class _Translations$editItem$templateHints$pt extends Translations$editItem$templateHints$en {
	_Translations$editItem$templateHints$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get website => 'Nome de utilizador, palavra-passe, URL';
	@override String get computer => 'Nome de utilizador, palavra-passe';
	@override String get creditCard => 'Número, titular, validade, CVC, PIN';
	@override String get bankAccount => 'Titular, IBAN, BIC, PIN';
	@override String get wifi => 'Nome da rede, palavra-passe';
	@override String get passport => 'Número, nome, datas';
	@override String get note => 'Uma nota formatada';
	@override String get authenticator => 'Um código 2FA';
	@override String get custom => 'Ainda sem campos';
}

// Path: editItem.templateFields
class _Translations$editItem$templateFields$pt extends Translations$editItem$templateFields$en {
	_Translations$editItem$templateFields$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get cardholder => 'Titular do Cartão';
	@override String get expiresOn => 'Validade';
	@override String get cvc => 'CVC';
	@override String get accountHolder => 'Titular da Conta';
	@override String get iban => 'IBAN';
	@override String get bic => 'BIC';
	@override String get cardPin => 'PIN do Cartão';
	@override String get networkName => 'Nome da Rede';
	@override String get fullName => 'Nome Completo';
	@override String get passportNumber => 'Número do Passaporte';
	@override String get issuingCountry => 'País de Emissão';
	@override String get dateOfBirth => 'Data de Nascimento';
	@override String get placeOfBirth => 'Local de Nascimento';
	@override String get issuedOn => 'Data de Emissão';
}

// Path: editItem.types
class _Translations$editItem$types$pt extends Translations$editItem$types$en {
	_Translations$editItem$types$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get username => 'Nome de usuário';
	@override String get password => 'Senha';
	@override String get email => 'E-mail';
	@override String get url => 'URL';
	@override String get ipHost => 'IP / Host';
	@override String get date => 'Data';
	@override String get month => 'Mês';
	@override String get credit => 'Número do cartão';
	@override String get phone => 'Telefone';
	@override String get pin => 'PIN';
	@override String get totp => 'Código de autenticação';
	@override String get certificate => 'Certificado';
	@override String get sshKey => 'Chave SSH / privada';
	@override String get recoveryCodes => 'Códigos de recuperação';
	@override String get note => 'Nota formatada';
	@override String get text => 'Texto';
}

// Path: audit.weakPassword
class _Translations$audit$weakPassword$pt extends Translations$audit$weakPassword$en {
	_Translations$audit$weakPassword$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get label => 'Palavras-passe Fracas';
	@override String get description => 'Uma palavra-passe é fraca quando o espaço de pesquisa de um atacante é pequeno: é curta, usa um conjunto reduzido de carateres ou baseia-se numa palavra, nome ou sequência de teclado presente em qualquer dicionário de quebra de senhas. Ataques offline testam milhares de milhões de combinações por segundo, por isso tudo nessa categoria cai rapidamente. Substitua-a por uma palavra-passe longa e gerada aleatoriamente.';
}

// Path: audit.reusedPassword
class _Translations$audit$reusedPassword$pt extends Translations$audit$reusedPassword$en {
	_Translations$audit$reusedPassword$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get label => 'Palavras-passe Reutilizadas';
	@override String get description => 'Usar a mesma palavra-passe em vários sítios significa que uma única fuga em qualquer um deles as desbloqueia todas — e não tem controlo sobre qual desses serviços será o que sofre a fuga. Dê a cada item a sua própria palavra-passe gerada para que uma fuga fique limitada à conta de onde veio.';
}

// Path: audit.compromisedPassword
class _Translations$audit$compromisedPassword$pt extends Translations$audit$compromisedPassword$en {
	_Translations$audit$compromisedPassword$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get label => 'Palavras-passe Comprometidas';
	@override String get description => 'Esta palavra-passe aparece num registo público de credenciais comprometidas, o que a coloca entre as primeiras que os atacantes tentam, por mais forte que pareça. Altere-a em todos os locais onde é usada: uma palavra-passe só precisa de ser exposta uma vez para ficar comprometida.';
}

// Path: settings.migrate.error
class _Translations$settings$migrate$error$pt extends Translations$settings$migrate$error$en {
	_Translations$settings$migrate$error$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get sameProvider => 'O cofre já está nesse armazenamento.';
	@override String get busy => 'Ainda há uma gravação em curso. Aguarde que termine e tente novamente.';
	@override String get sourceExpired => 'A sua sessão atual expirou. Volte a iniciar sessão antes de mover o cofre.';
	@override String targetExpired({required Object provider}) => 'O seu início de sessão em ${provider} expirou. Nada foi alterado — comece de novo.';
	@override String get verifyFailed => 'A cópia guardada não correspondia ao seu cofre, por isso o ficheiro antigo ficou intacto. Nada se perdeu — tente novamente.';
}

/// The flat map containing all translations for locale <pt>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsPt {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'KeeperPass',
			'connectivity.offline' => 'Sem ligação à Internet',
			'connectivity.online' => 'Novamente online',
			'errors.failures.networkFailure' => 'Algo correu mal. Tente novamente.',
			'errors.failures.undocumentedError' => 'Algo correu mal. Tente novamente.',
			'errors.failures.platformError' => 'Algo correu mal. Tente novamente.',
			'errors.failures.notFound' => 'Algo correu mal. Tente novamente.',
			'errors.failures.formatException' => 'Algo correu mal. Tente novamente.',
			'errors.failures.unableToProcess' => 'Algo correu mal. Tente novamente.',
			'errors.failures.requestTimeout' => 'Algo correu mal. Tente novamente.',
			'errors.failures.connectionError' => 'Algo correu mal. Tente novamente.',
			'errors.failures.unexpectedError' => 'Algo correu mal. Tente novamente.',
			'errors.failures.accessTokenFailure' => 'Algo correu mal. Tente novamente.',
			'errors.failures.cacheReadFailure' => 'Algo correu mal. Tente novamente.',
			'errors.failures.cacheWriteFailure' => 'Algo correu mal. Tente novamente.',
			'errors.drive.authExpired' => 'A sua sessão do Google expirou. Volte a ligar-se.',
			'errors.drive.backupFailed' => 'Não foi possível fazer uma cópia de segurança do seu cofre atual no Google Drive. Tente novamente.',
			'errors.drive.renameFailed' => 'Não foi possível mudar o nome do seu ficheiro de cofre no Google Drive. Nada foi alterado — tente novamente.',
			'errors.drive.createFolderFailed' => 'Não foi possível criar a pasta keeperpass no Google Drive. Tente novamente.',
			'errors.drive.readFailed' => 'Não foi possível ler o seu cofre a partir do Google Drive. Tente novamente.',
			'errors.drive.saveFailed' => 'Não foi possível guardar o seu cofre no Google Drive. Tente novamente.',
			'errors.drive.unreachable' => 'Não foi possível contactar o Google Drive. Tente novamente.',
			'errors.dropbox.authExpired' => 'A sua sessão do Dropbox expirou. Volte a ligar-se.',
			'errors.dropbox.profileFailed' => 'Não foi possível ler o seu perfil do Dropbox. Tente novamente.',
			'errors.dropbox.unknown' => 'Ocorreu um problema ao contactar o Dropbox. Tente novamente.',
			'errors.dropbox.unreachable' => 'Não foi possível contactar o Dropbox. Tente novamente.',
			'errors.dropbox.readFailed' => 'Não foi possível ler o seu cofre a partir do Dropbox. Tente novamente.',
			'errors.dropbox.saveFailed' => 'Não foi possível guardar o seu cofre no Dropbox. Tente novamente.',
			'errors.dropbox.backupFailed' => 'Não foi possível fazer uma cópia de segurança do seu cofre atual no Dropbox. Tente novamente.',
			'errors.dropbox.renameFailed' => 'Não foi possível mudar o nome do seu ficheiro de cofre no Dropbox. Nada foi alterado — tente novamente.',
			'errors.dropbox.missingScope' => 'Falta uma permissão do Dropbox ao KeeperPass. É um problema de configuração que iniciar sessão de novo não resolve.',
			'errors.dropbox.rateLimited' => 'O Dropbox pede para abrandarmos. Aguarde um momento e tente novamente.',
			'errors.auth.profileFailed' => 'Não foi possível ler o seu perfil do Google. Tente novamente.',
			'errors.auth.unknown' => 'Ocorreu um problema ao contactar o Google. Tente novamente.',
			'errors.masterPassword.vaultNotFound' => 'Não foi possível encontrar o seu cofre.',
			'errors.vault.accountMismatch' => ({required Object email}) => 'Inicie sessão com ${email} para guardar as suas alterações.',
			'errors.vault.driveAccessNotGranted' => 'A Google não deu ao KeeperPass acesso aos ficheiros que cria no seu Drive. Tente novamente e permita esse acesso na página da Google.',
			'errors.vault.conflict' => 'Foi guardada uma versão mais recente do seu cofre noutro dispositivo. Carregue-a antes de editar, para que nada seja substituído.',
			'errors.vault.signInCanceled' => 'Início de sessão cancelado',
			'errors.vault.unsupported' => 'Este ficheiro de cofre não pode ser aberto por esta versão do KeeperPass.',
			'errors.vault.corrupt' => 'O ficheiro do seu cofre está danificado e não pode ser aberto.',
			'common.close' => 'Fechar',
			'common.copy' => 'Copiar',
			'common.copied' => 'Copiado',
			'common.cancel' => 'Cancelar',
			'common.save' => 'Guardar',
			'common.back' => 'Voltar',
			'common.favorite' => 'Favorito',
			'common.showSecret' => 'Mostrar segredo',
			'common.hideSecret' => 'Ocultar segredo',
			'common.empty' => '[vazio]',
			'common.clearSearch' => 'Limpar a pesquisa',
			'common.chooseDate' => 'Escolha uma data',
			'common.chooseMonth' => 'Escolha um mês',
			'common.countryCode' => 'Indicativo do país',
			'common.countryCodeValue' => ({required Object country, required Object code}) => 'Indicativo do país: ${country}, ${code}',
			'common.removeTag' => ({required Object tag}) => 'Remover a etiqueta ${tag}',
			'common.secretChip' => 'Secreto',
			'common.secretToggle' => ({required Object field}) => 'Secreto: ${field}',
			'common.reorderField' => ({required Object field}) => 'Reordenar ${field}',
			'common.removeField' => ({required Object field}) => 'Remover ${field}',
			'common.changeFieldIcon' => ({required Object field}) => 'Alterar o ícone de ${field}',
			'common.showAll' => ({required Object count}) => 'Mostrar todos os ${count}',
			'common.showInLargeType' => 'Mostrar em letra grande',
			'common.stepOf' => ({required Object current, required Object total}) => 'Passo ${current} de ${total}',
			'common.next' => 'Seguinte',
			'common.continueAction' => 'Continuar',
			'common.tryAgain' => 'Tentar novamente',
			'common.retry' => 'Repetir',
			'common.show' => 'Mostrar',
			'common.hide' => 'Ocultar',
			'common.gotIt' => 'Percebi',
			'common.disconnect' => 'Desligar',
			'common.generateSecret' => 'Gerar um segredo',
			'common.useAnotherAccount' => 'Usar outra conta',
			'common.offlineTitle' => 'Está offline',
			'common.savingTo' => ({required Object provider}) => 'A guardar em ${provider}…',
			'common.keepOpen' => 'Mantenha o KeeperPass aberto até terminar.',
			'common.typeItAgain' => 'Escreva-o novamente',
			'common.secretHiddenValue' => 'Oculto',
			'common.rename' => 'Renomear',
			'common.done' => 'Concluído',
			'strength.veryWeak' => 'Muito fraca',
			'strength.weak' => 'Fraca',
			'strength.fair' => 'Razoável',
			'strength.strong' => 'Forte',
			'strength.veryStrong' => 'Muito forte',
			'strength.meter' => ({required Object level}) => 'Força: ${level}',
			'totp.invalidCode' => 'Código inválido',
			'totp.invalidKey' => 'A chave de configuração não é válida, por isso não é possível gerar um código.',
			'totp.fixInEdit' => 'Corrigir em Editar',
			'totp.secondsShort' => ({required Object count}) => '${count} s',
			'totp.secondsLeft' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(count, one: 'Falta ${count} segundo', other: 'Faltam ${count} segundos', ), 
			'settings.migrate.error.sameProvider' => 'O cofre já está nesse armazenamento.',
			'settings.migrate.error.busy' => 'Ainda há uma gravação em curso. Aguarde que termine e tente novamente.',
			'settings.migrate.error.sourceExpired' => 'A sua sessão atual expirou. Volte a iniciar sessão antes de mover o cofre.',
			'settings.migrate.error.targetExpired' => ({required Object provider}) => 'O seu início de sessão em ${provider} expirou. Nada foi alterado — comece de novo.',
			'settings.migrate.error.verifyFailed' => 'A cópia guardada não correspondia ao seu cofre, por isso o ficheiro antigo ficou intacto. Nada se perdeu — tente novamente.',
			'settings.title' => 'Definições',
			'settings.subtitle' => 'Conta, idioma, segurança e dados',
			'settings.account' => 'Conta',
			'settings.accountLine' => ({required Object email, required Object storage}) => '${email} · ${storage}',
			'settings.accountNote' => 'O nome e o e-mail são obtidos da conta com que iniciou sessão.',
			'settings.logOut' => 'Terminar sessão',
			'settings.logOutTitle' => 'Terminar sessão?',
			'settings.logOutBody' => ({required Object storage, required Object provider}) => 'O seu cofre continua cifrado no seu ${storage}. Para o voltar a abrir, inicie sessão com ${provider} e introduza o seu segredo.',
			'settings.security' => 'Segurança',
			'settings.lockNow' => 'Bloquear agora',
			'settings.autoLock' => 'Bloqueio automático',
			'settings.clearClipboard' => 'Limpar área de transferência',
			'settings.hideInSwitcher' => 'Ocultar no seletor de apps',
			'settings.hideInSwitcherNote' => 'Mostra um ecrã de privacidade em vez do seu cofre',
			'settings.changeSecret' => 'Alterar segredo',
			'settings.securityNote' => 'Bloquear apaga o cofre decifrado da memória deste telemóvel.',
			'settings.appearance' => 'Aspeto',
			'settings.theme' => 'Tema',
			'settings.themeAuto' => 'Auto',
			'settings.themeLight' => 'Claro',
			'settings.themeDark' => 'Escuro',
			'settings.language' => 'Idioma',
			'settings.storage' => 'Armazenamento',
			'settings.whereItLives' => 'Onde vive o seu cofre',
			'settings.moveTo' => ({required Object storage}) => 'Mover o cofre para ${storage}',
			'settings.data' => 'Dados',
			'settings.importCsv' => 'Importar CSV',
			'settings.exportCsv' => 'Exportar CSV',
			'settings.recentExports' => 'Exportações recentes',
			'settings.help' => 'Ajuda',
			'settings.howItWorks' => 'Como funciona o KeeperPass',
			'settings.questions' => 'Perguntas',
			'settings.about' => 'Acerca do KeeperPass',
			'settings.dangerZone' => 'Zona de perigo',
			'settings.archive' => 'Arquivar cofre e terminar sessão',
			'settings.archiveNote' => 'Muda o nome do ficheiro do cofre e termina a sua sessão. Nada é apagado.',
			'settings.footer' => ({required Object version}) => 'KeeperPass ${version} · Gratuito e de código aberto sob AGPL-3.0',
			'settings.autoLockTitle' => 'Bloqueio automático',
			'settings.autoLockImmediately' => 'Imediatamente ao sair da app',
			'settings.autoLockImmediatelyShort' => 'Imediatamente',
			'settings.after1Minute' => 'Após 1 minuto',
			'settings.after5Minutes' => 'Após 5 minutos',
			'settings.after10Minutes' => 'Após 10 minutos',
			'settings.autoLockNote' => 'O KeeperPass bloqueia-se após este tempo sem utilização. Para o desbloquear de novo, precisa do seu segredo.',
			'settings.clearClipboardTitle' => 'Limpar Área de Transferência',
			'settings.after30Seconds' => 'Após 30 segundos',
			'settings.after2Minutes' => 'Após 2 minutos',
			'settings.never' => 'Nunca',
			'settings.after30s' => 'Após 30 s',
			'settings.after1Min' => 'Após 1 min',
			'settings.after2Min' => 'Após 2 min',
			'settings.clipboardNote' => 'As palavras-passe e os códigos que copiar são apagados da área de transferência após este tempo, se não tiver copiado mais nada entretanto.',
			'settings.preview' => 'Pré-visualização',
			'settings.previewFrom' => 'De GitHub',
			'settings.previewClears' => ({required Object time}) => 'De GitHub · Apaga-se daqui a ${time}',
			'settings.seconds' => ({required Object n}) => '${n} s',
			'settings.minutes' => ({required Object n}) => '${n} min',
			'settings.languageTitle' => 'Idioma',
			'settings.languageNote' => 'Guardado apenas neste telemóvel — não faz parte do seu cofre.',
			'settings.hideInSwitcherBlocks' => 'Mostra um ecrã de privacidade em vez do seu cofre e bloqueia as capturas de ecrã',
			'settings.blockScreenshots' => 'Bloquear capturas de ecrã',
			'settings.blockScreenshotsNote' => 'Apenas Android · também bloqueia a gravação do ecrã',
			'settings.blockScreenshotsWhileHidden' => 'Ativo enquanto «Ocultar no seletor de apps» estiver ativo',
			'auth.unlock.incorrectSecret' => 'Segredo incorreto. Tente novamente.',
			'vaults.defaultName' => 'O Meu Cofre',
			'welcome.howItWorks' => 'Como funciona',
			'welcome.badge' => 'Cifrado de ponta a ponta',
			'welcome.title' => 'Bem-vindo ao KeeperPass',
			'welcome.description' => 'O seu cofre é um único ficheiro cifrado no seu próprio armazenamento na nuvem. Inicie sessão para o abrir.',
			'welcome.fileTag' => 'O que o seu armazenamento vê',
			'welcome.fileMeta' => 'Argon2id · AES-256-GCM',
			'welcome.continueWithGoogle' => 'Continuar com o Google',
			'welcome.continueWithDropbox' => 'Continuar com o Dropbox',
			'welcome.connecting' => ({required Object provider}) => 'A estabelecer ligação com ${provider}…',
			'welcome.factAccess' => 'Acesso apenas aos ficheiros que o KeeperPass cria',
			'welcome.factEncrypted' => 'Cifrado neste telemóvel, com o seu próprio segredo',
			'welcome.factNoServer' => 'Sem servidor KeeperPass. Nada vai para mais lado nenhum.',
			'welcome.footer' => 'Sem conta KeeperPass — apenas a da Google ou do Dropbox que já tem. Ao iniciar sessão, o ficheiro do cofre é criado se ainda não o tiver.',
			'connect.lookingIn' => ({required Object storage}) => 'A procurar no ${storage}…',
			'connect.checkingTitle' => 'A verificar o seu cofre…',
			'connect.checkingDetail' => ({required Object storage}) => 'A procurar vault.json.enc no ${storage}.',
			'connect.foundTitle' => 'Encontrámos o seu cofre',
			'connect.foundDetail' => 'A abrir o desbloqueio…',
			'connect.foundMeta' => ({required Object storage}) => 'Encontrado no ${storage}',
			'connect.foundMetaUpdated' => ({required Object storage, required Object time}) => 'Encontrado no ${storage} · atualizado ${time}',
			'connect.canceledDetail' => 'Nada foi ligado.',
			'connect.signInFailed' => 'Falha ao iniciar sessão',
			'connect.offlineDetail' => 'Para iniciar sessão é necessária uma ligação à Google ou ao Dropbox. Isto atualiza-se sozinho quando voltar a estar online.',
			'connect.welcomeBack' => 'Olá de novo,',
			'connect.expiredDetail' => ({required Object provider}) => 'A sua sessão de ${provider} expirou. Inicie sessão novamente para desbloquear o seu cofre.',
			'connect.lastUsed' => 'Última utilizada',
			'connect.checkFailedMeta' => ({required Object storage}) => 'Não foi possível lê-lo no ${storage}',
			'connect.checkFailedTitle' => 'Não foi possível ler o seu cofre',
			'connect.checkFailedDetail' => ({required Object storage}) => 'O ${storage} não respondeu. Nada foi alterado.',
			'howItWorks.step1Title' => 'O seu cofre vive\nna sua nuvem',
			'howItWorks.step1Body' => 'O KeeperPass guarda um único ficheiro cifrado no seu Google Drive ou Dropbox. Não existe servidor KeeperPass, por isso nunca recebemos uma cópia.',
			'howItWorks.encrypted' => 'Cifrado',
			'howItWorks.step2Title' => 'Escolha um segredo',
			'howItWorks.step2Body' => 'Torna-se a chave. Nunca enviado, nunca guardado.',
			'howItWorks.step3Title' => 'São precisos os dois',
			'howItWorks.step3Body' => 'Quem tiver a sua conta de armazenamento não consegue ler o seu cofre. Quem tiver o seu segredo não lhe consegue chegar.',
			'howItWorks.storageAccount' => 'Conta de armazenamento',
			'howItWorks.reachesFile' => 'Chega ao ficheiro',
			'howItWorks.yourSecret' => 'O seu segredo',
			'howItWorks.opensFile' => 'Abre o ficheiro',
			'howItWorks.technicalDetails' => 'Detalhes técnicos',
			'howItWorks.technicalSummary' => 'Argon2id · AES-256',
			'technicalDetails.title' => 'Detalhes técnicos',
			'technicalDetails.keyDerivation' => 'Derivação da chave',
			'technicalDetails.keyDerivationValue' => ({required InlineSpan algorithm}) => TextSpan(children: [ algorithm, const TextSpan(text: ' · 64 MiB de memória · 3 iterações · paralelismo 4, gerando uma chave de 256 bits'), ]), 
			'technicalDetails.encryption' => 'Cifra',
			'technicalDetails.encryptionValue' => ({required InlineSpan algorithm}) => TextSpan(children: [ algorithm, const TextSpan(text: ', que também deteta qualquer alteração ao ficheiro'), ]), 
			'technicalDetails.googleDrive' => 'Google Drive',
			'technicalDetails.googleDriveValue' => ({required InlineSpan scope}) => TextSpan(children: [ const TextSpan(text: 'O âmbito '), scope, const TextSpan(text: ': apenas ficheiros criados pelo KeeperPass'), ]), 
			'technicalDetails.dropbox' => 'Dropbox',
			'technicalDetails.dropboxValue' => ({required InlineSpan folder}) => TextSpan(children: [ const TextSpan(text: 'Uma pasta da aplicação: '), folder, ]), 
			'technicalDetails.vaultFile' => 'Ficheiro do cofre',
			'technicalDetails.vaultFileValue' => ({required InlineSpan file}) => TextSpan(children: [ file, const TextSpan(text: ' — um único ficheiro, novamente cifrado e reescrito a cada gravação'), ]), 
			'technicalDetails.viewSource' => 'Ver o código-fonte no GitHub',
			'technicalDetails.license' => 'Gratuito e de código aberto sob AGPL-3.0, por isso tudo isto pode ser verificado.',
			'createVault.eyebrow' => 'Crie o seu cofre',
			'createVault.step1Title' => 'Escolha o seu segredo',
			'createVault.step1Body' => 'Cifra o seu cofre neste telemóvel. Tudo o que guardar fica protegido por ele.',
			'createVault.settingUpFor' => 'A configurar para',
			'createVault.secret' => 'Segredo',
			'createVault.secretPlaceholder' => 'O seu segredo',
			'createVault.generateAnother' => 'Gerar outro',
			'createVault.generatedNote' => 'Os segredos gerados saltam o passo de os escrever novamente.',
			'createVault.weakWarning' => 'Este segredo é fraco, o que torna a cifra do seu cofre mais fácil de quebrar. Pode continuar, mas recomenda-se vivamente uma frase mais longa.',
			'createVault.tipsTitle' => 'Escolher um bom segredo',
			'createVault.tip1' => 'Várias palavras aleatórias são melhores do que uma palavra engenhosa: quanto mais longo, mais difícil de adivinhar.',
			'createVault.tip2' => 'Não reutilize uma palavra-passe que use noutro lado.',
			'createVault.tip3' => 'Escolha algo que consiga escrever neste telemóvel; depois anote-o e guarde-o num local seguro.',
			'createVault.step2Title' => 'Escreva-o novamente',
			'createVault.step2Body' => 'Só para garantir que não há erros. Ninguém pode repor o seu segredo mais tarde.',
			'createVault.repeat' => 'Repita o segredo',
			'createVault.mismatch' => 'Os dois segredos não coincidem.',
			'createVault.step3Title' => 'Anote-o',
			'createVault.step3Body' => 'Vai precisar dele sempre que desbloquear. Guarde-o num local seguro, longe deste telemóvel.',
			'createVault.secretWords' => ({required Object count}) => 'O seu segredo · ${count} palavras',
			'createVault.secretWhole' => 'O seu segredo',
			'createVault.secretHidden' => 'O seu segredo, oculto',
			'createVault.secretShown' => 'O seu segredo, visível',
			'createVault.readBefore' => 'Leia isto antes de continuar',
			'createVault.bullet1' => 'O seu segredo nunca é enviado para lado nenhum nem guardado. Ninguém — nem o KeeperPass, nem o seu fornecedor de armazenamento — o pode consultar ou repor.',
			'createVault.bullet2' => 'Se o esquecer, o seu cofre não pode ser recuperado. Nenhuma ligação de reposição nem pedido de suporte o consegue abrir.',
			'createVault.bullet3' => 'Anote-o e guarde-o num local seguro antes de continuar.',
			'createVault.acknowledge' => 'Já anotei o meu segredo',
			'createVault.create' => 'Criar cofre',
			'createVault.progressTitle' => 'A criar o seu cofre',
			'createVault.encrypting' => 'A cifrar o seu cofre…',
			'createVault.encryptingDetail' => 'Neste telemóvel. Demora alguns segundos.',
			'createVault.encryptingMeta' => 'A cifrar neste telemóvel…',
			'createVault.savingDetail' => 'Um único ficheiro cifrado, na pasta keeperpass.',
			'createVault.failedTitle' => 'Não foi possível guardar o seu cofre',
			'createVault.notSaved' => 'Não guardado',
			'createVault.failedDetail' => ({required Object storage}) => 'O ${storage} não respondeu. Nada foi guardado e o seu segredo continua aqui.',
			'createVault.backToSecret' => 'Voltar ao seu segredo',
			'unlock.notYou' => 'Não é você?',
			'unlock.secret' => 'Segredo',
			'unlock.placeholder' => 'Introduza o seu segredo',
			'unlock.unlock' => 'Desbloquear',
			'unlock.unlocking' => 'A desbloquear…',
			'unlock.unlockingStatus' => 'A desbloquear neste telemóvel…',
			'unlock.slowNote' => 'Alguns segundos, de propósito: torna lento adivinhar o seu segredo.',
			'unlock.forgot' => 'Esqueceu-se do segredo?',
			'unlock.leftApp' => 'Bloqueado quando saiu do KeeperPass',
			'unlock.unreachableTitle' => ({required Object storage}) => 'Não foi possível contactar o ${storage}',
			'unlock.unreachableDetail' => 'Verifique a sua ligação e tente novamente. O seu segredo continua preenchido.',
			'unlock.offlineDetail' => ({required Object storage}) => 'Para desbloquear é necessária uma ligação ao ${storage}. «Desbloquear» fica ativo quando voltar a estar online.',
			'unlock.accountLine' => ({required Object email, required Object storage}) => '${email} · ${storage}',
			'unlock.lockedInactivity' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Bloqueado após ${n} minuto de inatividade', other: 'Bloqueado após ${n} minutos de inatividade', ), 
			'newVault.backLabel' => 'Desbloquear',
			'newVault.backToUnlock' => 'Voltar ao desbloqueio',
			'newVault.title' => 'Começar um cofre novo',
			'newVault.oldMeta' => 'Cofre antigo · bloqueado com o segredo antigo',
			'newVault.newMeta' => 'Cofre novo · vazio',
			'newVault.body' => ({required Object provider}) => 'Ninguém pode repor um segredo esquecido — nem o KeeperPass, nem ${provider}. Em vez disso, pode recomeçar com um cofre novo e vazio.',
			'newVault.pointLocked' => 'O seu cofre atual continua bloqueado com o segredo antigo.',
			'newVault.pointKept' => ({required InlineSpan file, required InlineSpan storage}) => TextSpan(children: [ const TextSpan(text: 'O seu ficheiro é mantido como '), file, const TextSpan(text: ' no seu '), storage, const TextSpan(text: '. Nada é apagado.'), ]), 
			'newVault.pointFresh' => 'Recomeça com um cofre completamente novo e vazio.',
			'newVault.account' => 'Conta',
			'newVault.newSecret' => 'Novo segredo',
			'newVault.newSecretPlaceholder' => 'Escolha um segredo novo',
			'newVault.repeat' => 'Repita o novo segredo',
			'newVault.weakWarning' => 'Este segredo é fraco, o que torna a cifra dos seus cofres mais fácil de quebrar. Pode continuar, mas recomenda-se vivamente uma frase mais longa.',
			'newVault.warn' => 'Tal como o antigo, o seu segredo novo não pode ser consultado nem reposto. Anote-o antes de continuar.',
			'newVault.start' => 'Começar um cofre novo',
			'newVault.confirmTitle' => 'Começar um cofre novo?',
			'newVault.confirmKept' => ({required Object storage}) => 'O seu ficheiro é mantido como cópia de segurança datada no seu ${storage}.',
			'newVault.confirmFresh' => 'Recomeça com um cofre vazio protegido pelo seu segredo novo.',
			'newVault.progressTitle' => 'A começar um cofre novo',
			'newVault.encrypting' => 'A cifrar o seu cofre novo…',
			'newVault.backingUp' => 'A manter o seu cofre antigo como cópia de segurança…',
			'newVault.backingUpDetail' => ({required Object storage}) => 'A mudar-lhe o nome no ${storage}.',
			'newVault.readyMeta' => 'Cifrado · pronto a guardar',
			'newVault.backupFailedMeta' => 'Não foi possível mudar o nome · nada mudou',
			'newVault.nothingChanged' => 'Nada foi alterado',
			'newVault.backupFailedDetail' => ({required Object storage}) => 'Não foi possível criar uma cópia de segurança do seu cofre atual no ${storage}. Nada foi alterado.',
			'newVault.doneTitle' => 'Cofre novo começado',
			'newVault.doneDetail' => ({required Object storage}) => 'O seu cofre antigo é mantido como cópia de segurança no ${storage}.',
			'tabs.vault' => 'Cofre',
			'tabs.codes' => 'Códigos',
			'tabs.generator' => 'Gerador',
			'tabs.security' => 'Segurança',
			'tabs.settings' => 'Definições',
			'tabs.securityFlagged' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Segurança, ${n} item assinalado', other: 'Segurança, ${n} itens assinalados', ), 
			'codes.subtitle' => 'Códigos 2FA do seu cofre, gerados neste telemóvel',
			'codes.searchPlaceholder' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Pesquisar ${n} código', other: 'Pesquisar ${n} códigos', ), 
			'codes.codeCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${n} código', other: '${n} códigos', ), 
			'codes.copied' => 'Código copiado',
			'codes.trust' => 'Gerados neste telemóvel a partir das chaves de configuração do seu cofre. Nada de novo é guardado.',
			'codes.emptyTitle' => 'Ainda não há códigos 2FA',
			'codes.emptyBody' => 'Quando um site oferecer o início de sessão em dois passos, leia aqui o seu código QR ou adicione um item Autenticador.',
			'codes.createAuthenticator' => 'Criar um item Autenticador',
			'comingSoon.body' => ({required Object part}) => 'Chega na parte ${part}.',
			'vaultList.lock' => 'Bloquear',
			'vaultList.newItem' => 'Novo item',
			'vaultList.allVaults' => 'Todos os Cofres',
			'vaultList.favorites' => 'Favoritos',
			'vaultList.recentlyUsed' => 'Usados Recentemente',
			'vaultList.statusSaved' => ({required Object items, required Object storage}) => '${items} · Guardado no ${storage}',
			'vaultList.statusInVault' => ({required Object items, required Object vault}) => '${items} em ${vault}',
			'vaultList.statusTagged' => ({required Object items, required Object tag}) => '${items} com a etiqueta ${tag}',
			'vaultList.statusReport' => ({required Object items, required Object report}) => '${items} · ${report}',
			'vaultList.statusNotConnected' => ({required Object storage}) => 'Sem ligação ao ${storage}',
			'vaultList.statusOffline' => ({required Object items}) => 'Offline · ${items}',
			'vaultList.reportWeak' => 'Palavras-passe fracas',
			'vaultList.reportReused' => 'Palavras-passe reutilizadas',
			'vaultList.reportCompromised' => 'Palavras-passe comprometidas',
			'vaultList.searchHint' => 'Todas as palavras têm de corresponder, por qualquer ordem: nomes, etiquetas, nomes de campos e valores.',
			'vaultList.filterByTag' => 'Filtrar por etiqueta',
			'vaultList.manageTags' => 'Gerir etiquetas',
			'vaultList.clearFilter' => 'Limpar filtro',
			'vaultList.today' => 'Hoje',
			'vaultList.thisWeek' => 'Esta semana',
			'vaultList.earlier' => 'Anteriores',
			'vaultList.aToZ' => 'De A a Z',
			'vaultList.sortHeading' => 'Ordenar pela última atualização',
			'vaultList.newestFirst' => 'Mais recentes primeiro',
			'vaultList.oldestFirst' => 'Mais antigos primeiro',
			'vaultList.refreshing' => ({required Object storage}) => 'A ler o seu cofre do ${storage}…',
			'vaultList.copyPasswordFor' => ({required Object name}) => 'Copiar a palavra-passe de ${name}',
			'vaultList.copyCodeFor' => ({required Object name}) => 'Copiar o código de ${name}',
			'vaultList.copyCardNumberFor' => ({required Object name}) => 'Copiar o número do cartão de ${name}',
			'vaultList.swipePassword' => 'Senha',
			'vaultList.swipeCode' => 'Código',
			'vaultList.swipeCardNumber' => 'Número do cartão',
			'vaultList.swipeUsername' => 'Nome de usuário',
			'vaultList.swipeMore' => 'Mais',
			'vaultList.copyPassword' => 'Copiar palavra-passe',
			'vaultList.copyCode' => 'Copiar código',
			'vaultList.copyCardNumber' => 'Copiar número do cartão',
			'vaultList.copyUsername' => 'Copiar nome de utilizador',
			'vaultList.moreActions' => 'Mais ações',
			'vaultList.favorite' => 'Favorito',
			'vaultList.addToFavorites' => 'Adicionar aos favoritos',
			'vaultList.removeFromFavorites' => 'Remover dos favoritos',
			'vaultList.findingWeak' => 'Palavra-passe fraca',
			'vaultList.findingReused' => 'Palavra-passe reutilizada',
			'vaultList.findingCompromised' => 'Palavra-passe comprometida',
			'vaultList.findingWeakReused' => 'Palavra-passe fraca e reutilizada',
			'vaultList.findingWeakCompromised' => 'Palavra-passe fraca e comprometida',
			'vaultList.findingReusedCompromised' => 'Palavra-passe reutilizada e comprometida',
			'vaultList.findingAll' => 'Palavra-passe fraca, reutilizada e comprometida',
			'vaultList.unnamed' => 'Novo Item',
			'vaultList.scopeTitle' => 'Cofres',
			'vaultList.manageVaults' => 'Gerir cofres',
			'vaultList.scopeNote' => ({required Object storage}) => 'Todos os seus cofres estão num único ficheiro cifrado, vault.json.enc, no seu ${storage}.',
			'vaultList.quickActions' => ({required Object name}) => '${name}, ações rápidas',
			'vaultList.openWebsite' => 'Abrir site',
			'vaultList.moveToVault' => 'Mover para um cofre…',
			'vaultList.select' => 'Selecionar',
			'vaultList.delete' => 'Eliminar',
			'vaultList.selectAll' => 'Selecionar tudo',
			'vaultList.selectOrDeselectAll' => 'Selecionar ou desmarcar tudo',
			'vaultList.listTwo' => ({required Object a, required Object b}) => '${a} e ${b}',
			'vaultList.listThree' => ({required Object a, required Object b, required Object c}) => '${a}, ${b} e ${c}',
			'vaultList.deleteItemTitle' => 'Eliminar Item',
			'vaultList.deleteItemConfirm' => ({required Object name}) => 'Tem a certeza de que quer eliminar «${name}»? Esta ação não pode ser anulada.',
			'vaultList.deleteItemAction' => 'Eliminar item',
			'vaultList.moveToVaultTitle' => 'Mover para Cofre',
			'vaultList.moveDescription' => 'Escolha o cofre onde este item deve ficar.',
			'vaultList.current' => 'Atual',
			'vaultList.newVaultOption' => 'Novo cofre…',
			'vaultList.noOtherVaultOne' => 'Não há outro cofre para onde mover este item.',
			'vaultList.noOtherVaultMany' => 'Não há outro cofre para onde mover estes itens.',
			'vaultList.noOtherVaultDetail' => 'Um segundo cofre mantém um conjunto de itens separado — trabalho do pessoal, ou partilhado do privado.',
			'vaultList.createAVault' => 'Criar um cofre',
			'vaultList.newVaultTitle' => 'Novo Cofre',
			'vaultList.newVaultBody' => 'Um cofre é um grupo separado de itens. Ao contrário de um item, não há mais nada a escolher à partida.',
			'vaultList.vaultName' => 'Nome do cofre',
			'vaultList.duplicateVault' => 'Já existe um cofre com este nome.',
			'vaultList.noItemsTitle' => 'Ainda não tem itens.',
			'vaultList.noItemsBody' => 'Adicione o seu primeiro início de sessão, cartão ou nota. Cada um é cifrado neste telemóvel antes de ser guardado.',
			'vaultList.importCsv' => 'Importar de CSV',
			'vaultList.vaultReady' => 'O seu cofre está pronto. Ainda não tem nada.',
			'vaultList.savedMeta' => ({required Object storage, required Object items}) => 'Guardado no ${storage} · ${items}',
			'vaultList.vaultEmptyTitle' => 'Este cofre ainda não tem itens.',
			'vaultList.vaultEmptyBody' => ({required Object vault}) => 'Adicione um aqui ou mova itens de ${vault}.',
			'vaultList.noFavoritesTitle' => 'Ainda não tem favoritos.',
			'vaultList.noFavoritesBody' => 'Toque na estrela de qualquer item para o manter aqui.',
			'vaultList.nothingRecentTitle' => 'Ainda não usou nada',
			'vaultList.nothingRecentBody' => 'Os itens que abre ou de onde copia aparecem aqui, os mais recentes primeiro.',
			'vaultList.noResultsTitle' => 'A sua pesquisa não encontrou nenhum item.',
			'vaultList.noResultsBody' => 'Todas as palavras têm de corresponder. Experimente menos palavras ou verifique a ortografia.',
			'vaultList.allClearWeak' => 'Todas as palavras-passe no seu cofre são suficientemente fortes.',
			'vaultList.allClearReused' => 'Cada palavra-passe no seu cofre é usada exatamente uma vez.',
			'vaultList.allClearCompromised' => 'Nenhuma das suas palavras-passe apareceu numa fuga de dados conhecida.',
			'vaultList.allClearBody' => 'Nada a corrigir aqui. O KeeperPass volta a verificar sempre que uma palavra-passe muda.',
			'vaultList.backToSecurity' => 'Voltar à Segurança',
			'vaultList.fieldCopied' => ({required Object field}) => '${field} copiado',
			'vaultList.copiedFrom' => ({required Object item}) => 'De ${item}',
			'vaultList.itemCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${n} item', other: '${n} itens', ), 
			'vaultList.statusNotSaved' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${n} alteração não guardada', other: '${n} alterações não guardadas', ), 
			'vaultList.searchPlaceholder' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Pesquisar ${n} item', other: 'Pesquisar ${n} itens', ), 
			'vaultList.results' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${n} resultado', other: '${n} resultados', ), 
			'vaultList.selectedCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${n} selecionado', other: '${n} selecionados', ), 
			'vaultList.moveItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Mover ${n} item', other: 'Mover ${n} itens', ), 
			'vaultList.moveItemsTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Mover ${n} Item', other: 'Mover ${n} Itens', ), 
			'vaultList.deleteItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Eliminar ${n} item', other: 'Eliminar ${n} itens', ), 
			'vaultList.deleteTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Eliminar ${n} item?', other: 'Eliminar ${n} itens?', ), 
			'vaultList.deleteFromVault' => ({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${names} será eliminado de ${vault}. Esta ação não pode ser anulada.', other: '${names} serão eliminados de ${vault}. Esta ação não pode ser anulada.', ), 
			'vaultList.deleteFromVaults' => ({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${names} será eliminado. Esta ação não pode ser anulada.', other: '${names} serão eliminados. Esta ação não pode ser anulada.', ), 
			'vaultList.moveLine' => ({required num n, required Object names}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${names} é movido com o seu histórico e as suas etiquetas.', other: '${names} são movidos com o seu histórico e as suas etiquetas.', ), 
			'vaultList.movedTitle' => ({required num n, required Object names, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${names} movido para ${vault}', other: '${names} movidos para ${vault}', ), 
			'vaultList.movedDetail' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Mantém o seu histórico e as suas etiquetas.', other: 'Mantêm o seu histórico e as suas etiquetas.', ), 
			'vaultList.itemsOf' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${count} de ${n} item', other: '${count} de ${n} itens', ), 
			'itemDetail.edit' => 'Editar',
			'itemDetail.editItem' => 'Editar item',
			'itemDetail.moreOptions' => 'Mais opções',
			'itemDetail.updatedAgo' => ({required Object ago}) => 'Atualizado ${ago}',
			'itemDetail.showTagged' => ({required Object tag}) => 'Mostrar itens com a etiqueta ${tag}',
			'itemDetail.fields' => 'Campos',
			'itemDetail.noFields' => 'Este item não tem campos.',
			'itemDetail.history' => 'Histórico',
			'itemDetail.currentVersion' => 'Versão Atual',
			'itemDetail.todayAt' => ({required Object time}) => 'Hoje, ${time}',
			'itemDetail.unnamedField' => 'Sem nome',
			'itemDetail.copyField' => ({required Object field}) => 'Copiar ${field}',
			'itemDetail.revealValue' => 'Mostrar valor',
			'itemDetail.hideValue' => 'Ocultar valor',
			'itemDetail.hiddenValue' => ({required Object field}) => '${field}, oculto',
			'itemDetail.openSite' => ({required Object site}) => 'Abrir ${site}',
			'itemDetail.call' => 'Ligar',
			'itemDetail.message' => 'Mensagem',
			'itemDetail.checksumFail' => 'Esse número falha na soma de verificação — um dos dígitos está provavelmente errado.',
			'itemDetail.codeCardHint' => 'Toque para copiar · também no separador Códigos',
			'itemDetail.copyAllCodes' => 'Copiar todos os códigos',
			'itemDetail.copyCodeNumber' => ({required Object n}) => 'Copiar código ${n}',
			'itemDetail.cardFace' => 'Cartão, número oculto',
			'itemDetail.cardFaceBrand' => ({required Object brand}) => 'Cartão ${brand}, número oculto',
			'itemDetail.cardExpires' => ({required Object date}) => 'expira em ${date}',
			'itemDetail.largeTypeTurn' => 'Rode o telemóvel para o ler numa só linha.',
			'itemDetail.largeTypeHides' => 'Volta a ficar oculto quando sair deste ecrã.',
			'itemDetail.earlierVersion' => 'Versão Anterior',
			'itemDetail.readOnly' => ({required Object ago}) => '${ago} · só de leitura',
			'itemDetail.changedSince' => 'Alterado desde então',
			'itemDetail.restoreThisVersion' => 'Restaurar esta versão',
			'itemDetail.deleteVersion' => 'Eliminar versão',
			'itemDetail.restoreTitle' => 'Restaurar esta versão?',
			'itemDetail.restoreBody' => ({required Object name, required Object date}) => '${name} volta ao estado de ${date}. A versão atual fica no histórico.',
			'itemDetail.restore' => 'Restaurar',
			'itemDetail.deleteVersionTitle' => 'Eliminar Esta Versão',
			'itemDetail.deleteVersionConfirm' => 'Tem a certeza de que quer eliminar esta versão do histórico? Esta ação não pode ser anulada.',
			'itemDetail.delete' => 'Eliminar',
			'itemDetail.notFound' => 'Este item já não existe.',
			'itemDetail.notFoundHint' => 'Pode ter sido eliminado a partir de outro dispositivo.',
			'itemDetail.backToVault' => 'Voltar ao cofre',
			'itemDetail.hiddenLines' => ({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${field}, oculto, ${n} linha', other: '${field}, oculto, ${n} linhas', ), 
			'itemDetail.largeTypeLabel' => ({required num n, required Object field}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${field} em letra grande, ${n} carácter', other: '${field} em letra grande, ${n} caracteres', ), 
			'editItem.newVaultItem' => 'Novo Item do Cofre',
			'editItem.vault' => 'Cofre',
			'editItem.template' => 'Modelo',
			'editItem.templateNote' => 'Os modelos são só um ponto de partida: mude o nome, remova ou adicione campos a qualquer momento.',
			'editItem.templates.website' => 'Site ou app',
			'editItem.templates.computer' => 'Computador',
			'editItem.templates.creditCard' => 'Cartão de Crédito',
			'editItem.templates.bankAccount' => 'Conta Bancária',
			'editItem.templates.wifi' => 'Rede Wi-Fi',
			'editItem.templates.passport' => 'Passaporte',
			'editItem.templates.note' => 'Nota',
			'editItem.templates.authenticator' => 'Autenticador',
			'editItem.templates.custom' => 'Personalizado',
			'editItem.templateHints.website' => 'Nome de utilizador, palavra-passe, URL',
			'editItem.templateHints.computer' => 'Nome de utilizador, palavra-passe',
			'editItem.templateHints.creditCard' => 'Número, titular, validade, CVC, PIN',
			'editItem.templateHints.bankAccount' => 'Titular, IBAN, BIC, PIN',
			'editItem.templateHints.wifi' => 'Nome da rede, palavra-passe',
			'editItem.templateHints.passport' => 'Número, nome, datas',
			'editItem.templateHints.note' => 'Uma nota formatada',
			'editItem.templateHints.authenticator' => 'Um código 2FA',
			'editItem.templateHints.custom' => 'Ainda sem campos',
			'editItem.templateFields.cardholder' => 'Titular do Cartão',
			'editItem.templateFields.expiresOn' => 'Validade',
			'editItem.templateFields.cvc' => 'CVC',
			'editItem.templateFields.accountHolder' => 'Titular da Conta',
			'editItem.templateFields.iban' => 'IBAN',
			'editItem.templateFields.bic' => 'BIC',
			'editItem.templateFields.cardPin' => 'PIN do Cartão',
			'editItem.templateFields.networkName' => 'Nome da Rede',
			'editItem.templateFields.fullName' => 'Nome Completo',
			'editItem.templateFields.passportNumber' => 'Número do Passaporte',
			'editItem.templateFields.issuingCountry' => 'País de Emissão',
			'editItem.templateFields.dateOfBirth' => 'Data de Nascimento',
			'editItem.templateFields.placeOfBirth' => 'Local de Nascimento',
			'editItem.templateFields.issuedOn' => 'Data de Emissão',
			'editItem.types.username' => 'Nome de usuário',
			'editItem.types.password' => 'Senha',
			'editItem.types.email' => 'E-mail',
			'editItem.types.url' => 'URL',
			'editItem.types.ipHost' => 'IP / Host',
			'editItem.types.date' => 'Data',
			'editItem.types.month' => 'Mês',
			_ => null,
		} ?? switch (path) {
			'editItem.types.credit' => 'Número do cartão',
			'editItem.types.phone' => 'Telefone',
			'editItem.types.pin' => 'PIN',
			'editItem.types.totp' => 'Código de autenticação',
			'editItem.types.certificate' => 'Certificado',
			'editItem.types.sshKey' => 'Chave SSH / privada',
			'editItem.types.recoveryCodes' => 'Códigos de recuperação',
			'editItem.types.note' => 'Nota formatada',
			'editItem.types.text' => 'Texto',
			'editItem.newItem' => 'Novo Item',
			'editItem.editItem' => 'Editar Item',
			'editItem.changeIcon' => 'Alterar ícone',
			'editItem.name' => 'Nome',
			'editItem.namePlaceholder' => 'ex.: GitHub',
			'editItem.tags' => 'Etiquetas',
			'editItem.addField' => 'Adicionar campo',
			'editItem.addFieldTitle' => 'Adicionar Campo',
			'editItem.noFieldsTitle' => 'Ainda não há campos',
			'editItem.noFieldsBody' => 'Adicione qualquer um dos 16 tipos de campo — um número de apólice, um número de telefone, um PIN.',
			'editItem.fieldNamePlaceholder' => 'Nome do campo',
			'editItem.addTag' => 'Adicionar uma etiqueta',
			'editItem.tagSuggestions' => 'Sugestões de etiquetas',
			'editItem.createTag' => ({required Object name}) => 'Criar “${name}”',
			'editItem.tagTooLong' => 'Esse nome é demasiado longo.',
			'editItem.removeFieldTitle' => 'Tem a certeza de que quer remover este campo?',
			'editItem.removeFieldBody' => ({required Object field, required Object item}) => '“${field}” e o respetivo valor saem de ${item} quando guardar.',
			'editItem.remove' => 'Remover',
			'editItem.discardTitle' => 'Descartar as alterações?',
			'editItem.discardBody' => ({required Object name}) => 'As suas alterações a ${name} não foram guardadas. Ao descartá-las, o item fica como estava.',
			'editItem.discardNewTitle' => 'Descartar este novo item?',
			'editItem.discardNewBody' => 'Não foi guardado. Ao descartá-lo, perde-se.',
			'editItem.discard' => 'Descartar',
			'editItem.usernamePlaceholder' => 'Nome de utilizador ou e-mail',
			'editItem.passwordPlaceholder' => 'Senha',
			'editItem.valuePlaceholder' => 'Escreva o valor aqui',
			'editItem.ipHostPlaceholder' => 'ex.: 192.168.1.1, ::1 ou db.exemplo.com',
			'editItem.recoveryCodesPlaceholder' => 'Um por linha — qualquer formato funciona',
			'editItem.notEmail' => 'Isso não parece um endereço de e-mail.',
			'editItem.phoneNumber' => 'Número de telefone',
			'editItem.searchCountries' => 'Pesquisar países',
			'editItem.noCountryMatch' => 'Nenhum país corresponde.',
			'editItem.generate' => 'Gerar',
			'editItem.generatePassword' => 'Gerar uma palavra-passe',
			'editItem.currentCode' => 'Código atual',
			'editItem.scanQr' => 'Ler código QR',
			'editItem.enterSetupKey' => 'Introduzir chave de configuração',
			'editItem.setupKeyTitle' => 'Introduzir Chave de Configuração',
			'editItem.setupKeyBody' => 'Os sites mostram uma chave de configuração junto ao código QR, muitas vezes em “Não consegue ler?”.',
			'editItem.setupKey' => 'Chave de configuração',
			'editItem.setupKeyHint' => 'Os espaços e as maiúsculas não importam.',
			'editItem.saveCode' => 'Guardar código',
			'editItem.chooseIcon' => 'Escolher Ícone',
			'editItem.searchIcons' => 'Pesquisar ícones — experimente “banco” ou “cadeado”',
			'editItem.popular' => 'Populares',
			'editItem.noIcons' => ({required Object search}) => 'Nenhum ícone corresponde a “${search}”.',
			'editItem.useDefaultIcon' => 'Usar ícone predefinido',
			'editItem.iconMatches' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${n} resultado', other: '${n} resultados', ), 
			'generator.title' => 'Gerar uma palavra-passe',
			'generator.notFilledIn' => 'Nada é preenchido até o aceitar.',
			'generator.generated' => 'Palavra-passe gerada',
			'generator.mode' => 'Modo',
			'generator.passphrase' => 'Frase-passe',
			'generator.randomString' => 'Cadeia aleatória',
			'generator.words' => 'Palavras',
			'generator.fewerWords' => 'Menos palavras',
			'generator.moreWords' => 'Mais palavras',
			'generator.length' => 'Comprimento',
			'generator.shorter' => 'Mais curta',
			'generator.longer' => 'Mais longa',
			'generator.wordSeparator' => 'Separador de palavras',
			'generator.dash' => 'Hífen',
			'generator.underscore' => 'Sublinhado',
			'generator.slash' => 'Barra',
			'generator.space' => 'Espaço',
			'generator.language' => 'Idioma',
			'generator.regenerate' => 'Regenerar',
			'generator.charCount' => ({required Object count}) => '${count} caracteres',
			'generator.lowercase' => 'Letras minúsculas',
			'generator.uppercase' => 'Letras maiúsculas',
			'generator.digits' => 'Algarismos',
			'generator.symbols' => 'Símbolos',
			'generator.pickOne' => 'Escolha pelo menos um tipo de carácter.',
			'generator.use' => 'Usar esta palavra-passe',
			'generator.wordCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${n} palavra', other: '${n} palavras', ), 
			'generator.pageTitle' => 'Gerador de Palavras-passe',
			'generator.subtitle' => 'Palavras-passe e frases-passe aleatórias, criadas neste dispositivo',
			'generator.separatorDash' => 'Hífen ( - )',
			'generator.separatorUnderscore' => 'Sublinhado ( _ )',
			'generator.separatorSlash' => 'Barra ( / )',
			'generator.separatorSpace' => 'Espaço',
			'generator.nothingToGenerate' => 'Nada para gerar.',
			'generator.copyPassword' => 'Copiar palavra-passe',
			'generator.copied' => 'Palavra-passe copiada',
			'generator.fromGenerator' => 'Do gerador',
			'report.title' => 'Relatório de Segurança',
			'report.subtitle' => 'Quão bem as suas palavras-passe guardadas resistem',
			'report.healthLabel' => 'Saúde do cofre',
			'report.healthGood' => 'Sólida',
			'report.healthFair' => 'A melhorar',
			'report.healthPoor' => 'Em risco',
			'report.allClearTitle' => 'Nenhum problema encontrado',
			'report.allClearDescription' => 'Todas as palavras-passe nos seus cofres passaram a última auditoria.',
			'report.aboutSection' => ({required Object title}) => 'Acerca de ${title}',
			'report.nothingFound' => 'Nada encontrado',
			'report.openItem' => ({required Object name}) => 'Abrir ${name}',
			'report.checkAgain' => 'Verificar novamente',
			'report.statWeak' => 'Fracas',
			'report.statReused' => 'Reutilizadas',
			'report.statCompromised' => 'Comprometidas',
			'report.statValue' => ({required Object label, required Object count}) => '${label}: ${count}',
			'report.statNotChecked' => ({required Object label}) => '${label}: ainda não verificado',
			'report.healthPercent' => ({required Object title, required Object score}) => '${title} ${score} por cento',
			'report.sameAs' => ({required Object names}) => 'A mesma de ${names}',
			'report.sameAsField' => 'Igual a outra palavra-passe deste item',
			'report.foundInBreach' => 'Encontrada numa fuga de dados conhecida',
			'report.trust' => 'A verificação de fugas usa o Have I Been Pwned com k-anonimato: só os primeiros 5 carateres de um hash SHA-1 saem deste telemóvel.',
			'report.lastCheckedJustNow' => 'Última verificação: agora mesmo',
			'report.lastCheckedToday' => ({required Object time}) => 'Última verificação: hoje às ${time}',
			'report.lastCheckedOn' => ({required Object date}) => 'Última verificação: ${date}',
			'report.checking' => 'A verificar…',
			'report.checkingBreaches' => ({required Object done, required Object total}) => 'A procurar fugas · ${done} de ${total}',
			'report.progress' => ({required Object done, required Object total}) => '${done} de ${total}',
			'report.progressTime' => ({required Object done, required Object total, required Object time}) => '${done} de ${total} · ${time}',
			'report.offlineBody' => 'Não foi possível verificar as suas palavras-passe. A verificação precisa de ligação.',
			'report.failedTitle' => 'Não foi possível concluir a verificação',
			'report.failedBody' => 'Tente novamente daqui a pouco.',
			'report.nothingTitle' => 'Ainda não há nada para verificar',
			'report.nothingBody' => 'Guarde um item com palavra-passe e ele é verificado aqui, neste telemóvel, quanto a palavras-passe fracas, reutilizadas ou expostas.',
			'report.howToFix' => 'Como resolver',
			'report.stepOpen' => 'Abra o item',
			'report.stepGenerate' => 'Toque em Editar e depois em Gerar na palavra-passe',
			'report.stepSave' => 'Guarde — o alerta desaparece sozinho',
			'report.stepSaveCompromised' => 'Guarde e altere-a também no site',
			'report.changePassword' => 'Alterar palavra-passe',
			'report.fixedClear' => ({required Object name}) => 'Guardado · ${name} já não está assinalado',
			'report.fixedFlagged' => ({required Object name}) => 'Guardado · ${name} continua assinalado',
			'report.savedTo' => ({required Object storage}) => 'O seu cofre foi guardado no ${storage}',
			'report.noLongerWeak' => 'Já não é fraca',
			'report.noLongerReused' => 'Já não é reutilizada',
			'report.noLongerWeakOrReused' => 'Já não é fraca nem reutilizada',
			'report.hintReusedOne' => ({required Object n}) => 'Estes ${n} partilham uma palavra-passe. Dê a cada um a sua: abra um, toque em Editar e depois em Gerar.',
			'report.hintReusedSome' => 'Alguns partilham uma palavra-passe. Dê a cada um a sua: abra um, toque em Editar e depois em Gerar.',
			'report.hintWeak' => 'Dê a cada um uma mais forte: abra-o, toque em Editar e depois em Gerar.',
			'report.hintCompromised' => 'Estes aparecem em fugas de dados conhecidas. Altere cada um: abra-o, toque em Editar e depois em Gerar.',
			'report.itemsChecked' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${n} item com palavra-passe verificado', other: '${n} itens com palavra-passe verificados', ), 
			'report.flagged' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${n} item assinalado', other: '${n} itens assinalados', ), 
			'report.sameAsOthers' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'A mesma de ${n} outro item', other: 'A mesma de ${n} outros itens', ), 
			'report.checkingPasswords' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'A verificar ${n} palavra-passe', other: 'A verificar ${n} palavras-passe', ), 
			'report.aboutSeconds' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'cerca de ${n} segundo', other: 'cerca de ${n} segundos', ), 
			'report.aboutMinutes' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'cerca de ${n} minuto', other: 'cerca de ${n} minutos', ), 
			'audit.weakPassword.label' => 'Palavras-passe Fracas',
			'audit.weakPassword.description' => 'Uma palavra-passe é fraca quando o espaço de pesquisa de um atacante é pequeno: é curta, usa um conjunto reduzido de carateres ou baseia-se numa palavra, nome ou sequência de teclado presente em qualquer dicionário de quebra de senhas. Ataques offline testam milhares de milhões de combinações por segundo, por isso tudo nessa categoria cai rapidamente. Substitua-a por uma palavra-passe longa e gerada aleatoriamente.',
			'audit.reusedPassword.label' => 'Palavras-passe Reutilizadas',
			'audit.reusedPassword.description' => 'Usar a mesma palavra-passe em vários sítios significa que uma única fuga em qualquer um deles as desbloqueia todas — e não tem controlo sobre qual desses serviços será o que sofre a fuga. Dê a cada item a sua própria palavra-passe gerada para que uma fuga fique limitada à conta de onde veio.',
			'audit.compromisedPassword.label' => 'Palavras-passe Comprometidas',
			'audit.compromisedPassword.description' => 'Esta palavra-passe aparece num registo público de credenciais comprometidas, o que a coloca entre as primeiras que os atacantes tentam, por mais forte que pareça. Altere-a em todos os locais onde é usada: uma palavra-passe só precisa de ser exposta uma vez para ficar comprometida.',
			'myVaults.title' => 'Os Meus Cofres',
			'myVaults.subtitle' => 'Grupos separados de itens — trabalho, família, pessoal',
			'myVaults.defaultBadge' => 'Predefinido',
			'myVaults.newVault' => 'Novo cofre',
			'myVaults.emptyTitle' => 'Só tem o cofre predefinido',
			'myVaults.emptyBody' => 'Um segundo cofre mantém um conjunto de itens separado — trabalho do pessoal, ou partilhado do privado.',
			'myVaults.createdOn' => ({required Object date}) => 'criado em ${date}',
			'myVaults.renameTitle' => 'Renomear Cofre',
			'myVaults.renameBody' => 'Os itens nele contidos não são afetados.',
			'myVaults.duplicateRename' => ({required Object name}) => 'Já existe um cofre chamado “${name}”.',
			'myVaults.deleteTitle' => ({required Object name}) => 'Eliminar “${name}”?',
			'myVaults.deleteAction' => 'Eliminar cofre',
			'myVaults.renameAria' => ({required Object name}) => 'Renomear ${name}',
			'myVaults.deleteAria' => ({required Object name}) => 'Eliminar ${name}',
			'myVaults.itemCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${n} item', other: '${n} itens', ), 
			'myVaults.deleteBody' => ({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'O seu ${n} item passa para ${vault}. Esta ação não pode ser anulada.', other: 'Os seus ${n} itens passam para ${vault}. Esta ação não pode ser anulada.', ), 
			'myVaults.deleteSelectedTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Eliminar ${n} cofre?', other: 'Eliminar ${n} cofres?', ), 
			'myVaults.deleteSelectedBody' => ({required num n, required Object vault}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Tudo o que contêm — ${n} item — passa para ${vault}. Esta ação não pode ser anulada.', other: 'Tudo o que contêm — ${n} itens — passa para ${vault}. Esta ação não pode ser anulada.', ), 
			'myVaults.personalSummary' => ({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${name} contém ${n} item e não pode ser renomeado nem eliminado.', other: '${name} contém ${n} itens e não pode ser renomeado nem eliminado.', ), 
			'myVaults.selected' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${n} cofre selecionado', other: '${n} cofres selecionados', ), 
			'myVaults.deleteVaults' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Eliminar ${n} cofre', other: 'Eliminar ${n} cofres', ), 
			'tags.title' => 'Etiquetas',
			'tags.subtitle' => 'Etiquetas comuns a todos os cofres, para encontrar tudo depressa',
			'tags.since' => ({required Object date}) => 'desde ${date}',
			'tags.addTag' => 'Adicionar etiqueta',
			'tags.addTitle' => 'Adicionar Etiqueta',
			'tags.emptyTitle' => 'Ainda sem etiquetas',
			'tags.emptyBody' => 'As etiquetas são criadas a partir de um item, ou aqui — de qualquer forma, agrupam itens entre cofres.',
			'tags.addBody' => 'Uma etiqueta ainda sem itens. Coloque-a num item a partir da própria página desse item.',
			'tags.tagName' => 'Nome da etiqueta',
			'tags.duplicate' => 'Já existe uma etiqueta com este nome.',
			'tags.colorNote' => 'A cor vem do nome.',
			'tags.renameTitle' => 'Renomear Etiqueta',
			'tags.renameBody' => 'Todos os itens que a têm são atualizados.',
			'tags.mergeNotice' => ({required Object name}) => '“${name}” já existe — ao renomear, serão fundidas.',
			'tags.deleteTitle' => ({required Object name}) => 'Eliminar “${name}”?',
			'tags.deleteAction' => 'Eliminar etiqueta',
			'tags.deleteSelectedBody' => 'Cada uma é removida de todos os itens que a têm. Os itens em si são mantidos. Esta ação não pode ser anulada.',
			'tags.footer' => 'Toque numa etiqueta para ver os itens dela no separador Cofre.',
			'tags.renameAria' => ({required Object name}) => 'Renomear ${name}',
			'tags.deleteAria' => ({required Object name}) => 'Eliminar ${name}',
			'tags.itemCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${n} item', other: '${n} itens', ), 
			'tags.deleteBody' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Será removida de ${n} item. Os itens em si são mantidos. Esta ação não pode ser anulada.', other: 'Será removida de ${n} itens. Os itens em si são mantidos. Esta ação não pode ser anulada.', ), 
			'tags.deleteSelectedTitle' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Eliminar ${n} etiqueta?', other: 'Eliminar ${n} etiquetas?', ), 
			'tags.selected' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${n} etiqueta selecionada', other: '${n} etiquetas selecionadas', ), 
			'tags.deleteTags' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Eliminar ${n} etiqueta', other: 'Eliminar ${n} etiquetas', ), 
			'changeSecret.title' => 'Alterar Segredo',
			'changeSecret.intro' => 'O seu cofre é novamente cifrado com o novo segredo e carregado outra vez. Não pode ser recuperado se o esquecer.',
			'changeSecret.current' => 'Segredo atual',
			'changeSecret.wrong' => 'Esse não é o seu segredo atual.',
			'changeSecret.match' => 'Os dois segredos coincidem.',
			'changeSecret.otherDevices' => 'Os outros dispositivos pedem o novo segredo da próxima vez que abrirem o seu cofre.',
			'changeSecret.submit' => 'Alterar segredo',
			'changeSecret.verifyingMeta' => 'A verificar o seu segredo atual…',
			'changeSecret.verifyingTitle' => 'A verificar o seu segredo atual…',
			'changeSecret.stepVerify' => 'A verificar o seu segredo atual',
			'changeSecret.stepVerifyNote' => 'Deliberadamente lento num telemóvel — é isso que torna dispendioso adivinhá-lo',
			'changeSecret.stepEncrypt' => 'A cifrar com o novo segredo',
			'changeSecret.stepSave' => 'A guardar o seu cofre',
			'changeSecret.savingMeta' => ({required Object storage}) => 'A guardar em ${storage}…',
			'changeSecret.savingTitle' => ({required Object percent}) => 'A guardar o seu cofre… ${percent}%',
			'changeSecret.stepVerified' => 'Segredo atual verificado',
			'changeSecret.stepEncrypted' => 'Cifrado com o novo segredo',
			'changeSecret.stepSaving' => ({required Object storage}) => 'A guardar no ${storage}',
			'changeSecret.keepOpen' => 'Mantenha o KeeperPass aberto até terminar.',
			'changeSecret.doneMeta' => ({required Object storage}) => 'Guardado no ${storage}',
			'changeSecret.doneTitle' => 'O seu segredo foi alterado',
			'changeSecret.doneBody' => 'Todos os itens vieram consigo. Os outros dispositivos pedem o novo segredo da próxima vez que abrirem o seu cofre.',
			'changeSecret.toast' => 'Segredo alterado',
			'changeSecret.failTitle' => 'O seu cofre não foi guardado',
			'changeSecret.failBody' => ({required Object storage}) => 'Não foi possível contactar o ${storage}. O seu segredo não foi alterado: o cofre continua a abrir com o atual.',
			'storage.title' => 'Armazenamento',
			'storage.subtitle' => 'Onde vive o seu cofre e o que lhe pode aceder',
			'storage.diagram' => ({required Object storage}) => 'Cifrado neste telemóvel, guardado no seu ${storage}',
			'storage.thisPhone' => 'Este telemóvel',
			'storage.encryptedOnly' => 'Apenas o ficheiro cifrado',
			'storage.googleFolder' => 'pasta keeperpass',
			'storage.dropboxFolder' => 'pasta Apps/keeperpass',
			'storage.savedToday' => ({required Object folder, required Object time}) => '${folder} · guardado hoje às ${time}',
			'storage.savedOn' => ({required Object folder, required Object date}) => '${folder} · guardado em ${date}',
			'storage.access' => 'Acesso',
			'storage.googlePermissions' => 'Permissões da conta Google',
			'storage.dropboxApps' => 'Aplicações ligadas ao Dropbox',
			'storage.accessNote' => 'O KeeperPass só consegue aceder aos ficheiros que cria. Pode revogar esse acesso aqui a qualquer momento; o ficheiro do cofre fica onde está.',
			'moveVault.title' => 'Mover cofre',
			'moveVault.diagram' => ({required Object from, required Object to}) => 'O seu cofre passa do ${from} para o ${to}',
			'moveVault.from' => 'Origem',
			'moveVault.to' => 'Destino',
			'moveVault.intro' => 'O seu cofre é copiado e verificado, e só depois o ficheiro antigo é renomeado. Se algo falhar, nada é alterado.',
			'moveVault.step1' => ({required Object storage}) => 'Inicie sessão no ${storage} para escolher para onde vai o cofre.',
			'moveVault.step2' => 'Confirme. Nada muda antes deste passo.',
			'moveVault.step3' => 'O cofre é copiado e verificado; depois, o ficheiro antigo é renomeado, nunca eliminado.',
			'moveVault.connect' => ({required Object storage}) => 'Ligar ${storage}',
			'moveVault.account' => 'A mover para esta conta',
			'moveVault.existingTitle' => ({required Object storage}) => 'Esta conta do ${storage} já tem um cofre KeeperPass',
			'moveVault.existingBody' => ({required Object storage}) => 'Se continuar, é mantido como cópia de segurança com data e hora no ${storage} e substituído pelo cofre que está a mover.',
			'moveVault.existingConfirm' => 'Substituí-lo — o cofre existente é mantido como cópia de segurança',
			'moveVault.secretSection' => 'Segredo do cofre movido',
			'moveVault.keepSecret' => 'Manter o meu segredo atual',
			'moveVault.newSecret' => 'Escolher um segredo novo',
			'moveVault.newSecretNote' => 'Só o cofre movido o usa',
			'moveVault.submit' => 'Mover cofre',
			'moveVault.movingTitle' => 'A mover o seu cofre',
			'moveVault.stageEncrypting' => 'A cifrar o seu cofre',
			'moveVault.stageSaving' => ({required Object storage}) => 'A guardar em ${storage}…',
			'moveVault.stageChecking' => 'A verificar a cópia guardada',
			'moveVault.stageRenaming' => 'A renomear o ficheiro antigo',
			'moveVault.movingNote' => 'Mantenha o KeeperPass aberto até terminar. Se algo falhar, nada é alterado.',
			'moveVault.savedTo' => ({required Object storage}) => 'Guardado no ${storage}',
			'moveVault.doneTitle' => ({required Object storage}) => 'O seu cofre está agora em ${storage}',
			'moveVault.doneBody' => ({required Object provider, required Object from}) => 'Inicie sessão com ${provider} para o abrir. O ficheiro antigo foi mantido e renomeado no ${from}:',
			'moveVault.copyFileName' => 'Copiar nome do ficheiro',
			'moveVault.fileNameCopied' => 'Nome do ficheiro copiado',
			'moveVault.partlyTitle' => ({required Object storage}) => 'O seu cofre foi copiado para o ${storage}',
			'moveVault.partlyBody' => ({required Object from}) => 'Mas não foi possível renomear o ficheiro antigo no ${from}. Renomeie-o ou elimine-o manualmente, para que as duas cópias não divirjam.',
			'moveVault.open' => ({required Object storage}) => 'Abrir ${storage}',
			'moveVault.unchanged' => ({required Object from}) => 'Continua no ${from} · inalterado',
			'moveVault.notMovedTitle' => 'O seu cofre não foi movido',
			'moveVault.notMovedBody' => 'A cópia guardada não correspondia ao seu cofre, por isso o ficheiro antigo ficou intacto. Nada se perdeu — tente novamente.',
			'dataIo.importTitle' => 'Importar',
			'dataIo.file' => 'Ficheiro',
			'dataIo.fileMeta' => ({required Object size}) => '${size} · de Ficheiros',
			'dataIo.kilobytes' => ({required Object n}) => '${n} KB',
			'dataIo.megabytes' => ({required Object n}) => '${n} MB',
			'dataIo.change' => 'Alterar',
			'dataIo.found' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Foi encontrado ${n} item para importar.', other: 'Foram encontrados ${n} itens para importar.', ), 
			'dataIo.addTo' => 'Adicioná-los a',
			'dataIo.importNote' => 'Os itens são adicionados ao cofre que escolher. Nada é substituído.',
			'dataIo.importButton' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Importar ${n} item', other: 'Importar ${n} itens', ), 
			'dataIo.invalidCsv' => 'Não foi possível ler este ficheiro como CSV.',
			'dataIo.noItems' => 'Não foram encontrados itens neste ficheiro.',
			'dataIo.notCsvNote' => 'Exporte um CSV do seu outro gestor de palavras-passe e depois escolha esse ficheiro aqui.',
			'dataIo.chooseAnother' => 'Escolher outro ficheiro',
			'dataIo.exportTitle' => 'Exportar',
			'dataIo.exportIntro' => 'Escreve um CSV do cofre que escolher. Os itens exportados deixam para trás a cifra do cofre — o que fizer com o ficheiro é consigo.',
			'dataIo.sourceVault' => 'Cofre de origem',
			'dataIo.notEncryptedTitle' => 'Um ficheiro CSV não está cifrado',
			'dataIo.notEncryptedBody' => 'Quem o abrir pode ler todas as palavras-passe nele. Guarde-o num local seguro e elimine-o quando terminar.',
			'dataIo.exportButton' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: 'Exportar ${n} item', other: 'Exportar ${n} itens', ), 
			'dataIo.exportNote' => 'Abre a folha de partilha, para que escolha para onde vai o ficheiro.',
			'dataIo.recentTitle' => 'Exportações Recentes',
			'dataIo.recentRow' => ({required num n, required Object scope}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(n, one: '${scope} · ${n} item', other: '${scope} · ${n} itens', ), 
			'dataIo.recentNote' => 'As últimas 10 exportações ficam registadas no seu cofre. O KeeperPass não guarda nenhuma cópia dos ficheiros em si.',
			'dataIo.recentEmpty' => 'Ainda sem exportações.',
			'archive.title' => 'Arquivar Cofre',
			'archive.headline' => 'Arquivar cofre e terminar sessão',
			'archive.body' => ({required Object storage}) => 'O seu cofre é um único ficheiro cifrado no seu próprio ${storage}. Arquivá-lo muda o nome do ficheiro para que esta aplicação deixe de o encontrar e termina a sua sessão. Nada é apagado.',
			'archive.step1' => ({required Object oldName, required Object newName, required Object folder}) => '${oldName} é renomeado para ${newName}, na mesma ${folder}.',
			'archive.step2' => ({required Object storage}) => 'Este telemóvel termina a sessão no ${storage}.',
			'archive.step3' => ({required Object storage}) => 'Para apagar os dados em si, apague esse ficheiro no ${storage}.',
			'archive.typePrefix' => 'Escreva',
			'archive.typeSuffix' => 'para confirmar.',
			'archive.confirmation' => 'Confirmação',
			'archive.button' => 'Arquivar e terminar sessão',
			'archive.doneMeta' => 'Renomeado · esta aplicação já não o encontra',
			'archive.doneTitle' => 'O nome do seu ficheiro de cofre foi alterado',
			'archive.doneBody' => ({required Object folder, required Object storage}) => 'Continua na ${folder} do seu ${storage}. Apague-o aí quando quiser que os dados desapareçam definitivamente.',
			'archive.signedOut' => 'Terminou sessão neste telemóvel.',
			'archive.error' => 'Não foi possível alterar o nome do ficheiro de cofre. Nada foi alterado.',
			'help.howTitle' => 'Como Funciona o KeeperPass',
			'help.howSubtitle' => 'Onde vivem os seus dados e o que os mantém privados',
			'help.whereLives' => 'Onde vivem os seus dados',
			'help.diagram' => ({required Object storage}) => 'O seu cofre é cifrado neste telemóvel e guardado como um único ficheiro no seu ${storage}',
			'help.thisPhoneNote' => 'Cifra e decifra tudo. O seu segredo nunca sai dele.',
			'help.fileEncrypted' => 'vault.json.enc · cifrado',
			'help.yourStorage' => ({required Object storage}) => 'O seu ${storage}',
			'help.storageNote' => 'Guarda o ficheiro, que é ilegível sem o seu segredo.',
			'help.noServer' => 'O KeeperPass nunca recebe os seus dados. Não há nenhuma conta para invadir nem operador que consiga ler o seu cofre.',
			'help.protects' => 'O que o protege',
			'help.secretTerm' => 'O seu segredo',
			'help.secretNote' => 'Nunca enviado, nunca guardado. Só existe em memória enquanto a app está desbloqueada.',
			'help.kdfTerm' => 'Derivação de chave',
			'help.kdfNote' => 'Deliberadamente lenta, para que cada tentativa de adivinhar o seu segredo seja dispendiosa.',
			'help.encryptionTerm' => 'Cifra',
			'help.encryptionNote' => 'Mantém o ficheiro ilegível e mostra se alguém o alterou.',
			'help.accessTerm' => 'Acesso ao armazenamento',
			'help.accessNote' => 'O KeeperPass só consegue aceder aos ficheiros que cria.',
			'help.signingIn' => 'Iniciar sessão',
			'help.step1' => 'Ligue o seu armazenamento na nuvem',
			'help.step1Note' => 'Prova a quem pertence o ficheiro. Não desbloqueia nada.',
			'help.step2' => 'Introduza o seu segredo',
			'help.step2Note' => 'Cria neste telemóvel a chave que abre o ficheiro. O seu fornecedor de armazenamento nunca a vê.',
			'help.bothNeeded' => 'Quem tiver a sua conta de armazenamento continua sem conseguir ler o seu cofre. Quem souber o seu segredo continua sem conseguir chegar ao ficheiro. São precisas as duas coisas.',
			'help.terms' => 'Termos que vale a pena conhecer',
			'help.secretWord' => 'Segredo',
			'help.secretDef' => 'A única frase que desbloqueia o seu cofre. Não pode ser recuperada.',
			'help.vaultWord' => 'Cofre',
			'help.vaultDef' => 'Um grupo de itens. Com vários, mantém o trabalho separado do pessoal.',
			'help.tagWord' => 'Etiqueta',
			'help.tagDef' => 'Uma etiqueta para encontrar itens entre cofres, como trabalho ou banco.',
			'help.reportWord' => 'Relatório de segurança',
			'help.reportDef' => 'Assinala palavras-passe fracas, reutilizadas e expostas, neste telemóvel.',
			'faq.title' => 'Perguntas',
			'faq.subtitle' => 'Respostas a perguntas frequentes',
			'faq.forgetQ' => 'E se eu esquecer o meu segredo?',
			'faq.forgetA1' => 'O seu cofre não pode ser recuperado — nem por si, nem por nós. A chave é criada apenas a partir do seu segredo, pelo que sem ele o ficheiro fica ilegível. Este é o preço de mais ninguém o conseguir ler também.',
			'faq.forgetA2' => ({required Object forgot, required Object file}) => 'O que pode fazer é recomeçar: ${forgot} no ecrã de desbloqueio cria um cofre novo e vazio. O seu ficheiro antigo não é eliminado — é renomeado para ${file} e mantido na sua pasta keeperpass, por isso os dados continuam lá se o segredo lhe voltar à memória.',
			'faq.forgetA2Link' => 'Esqueceu-se do segredo?',
			'faq.forgetA3' => 'Anote o seu segredo e guarde-o num local seguro. É a única coisa no KeeperPass que não pode ser substituída.',
			'faq.seeQ' => 'O KeeperPass consegue ver as minhas palavras-passe?',
			'faq.seeA' => 'Não — e não é uma promessa, é uma consequência do design. A cifra acontece neste telemóvel e o texto cifrado vai diretamente para o seu próprio armazenamento. Não há nenhum servidor KeeperPass pelo meio que possa ver alguma coisa.',
			'faq.syncQ' => 'Sincroniza entre dispositivos?',
			'faq.syncA' => 'Sim. Todos os dispositivos leem o mesmo ficheiro do seu armazenamento. Inicie sessão com a mesma conta, introduza o mesmo segredo e o seu cofre está lá.',
			'faq.providerQ' => 'E se o meu fornecedor de armazenamento ler o ficheiro?',
			'faq.providerA' => 'Veriam bytes cifrados. A chave nunca sai deste telemóvel, por isso nem a Google, nem o Dropbox, nem outro fornecedor conseguem ler o conteúdo.',
			'faq.importQ' => 'Posso importar de outro gestor de palavras-passe?',
			'faq.importA' => 'Sim — exporte para CSV aí, depois use Importar nas Definições.',
			'faq.changeSecretQ' => 'Como altero o meu segredo?',
			'faq.changeSecretA' => ({required Object action}) => 'Abra as Definições e escolha ${action}. Introduz o seu segredo atual e o novo; o seu cofre é decifrado, cifrado novamente com o novo segredo e guardado de volta. Nada se perde — todos os itens acompanham-no, e a alteração aplica-se em cada dispositivo da próxima vez que este carregar o seu cofre.',
			'faq.costQ' => 'Quanto custa?',
			'faq.costA' => 'Nada. O KeeperPass é gratuito e de código aberto, e guarda os dados no espaço na nuvem que já tem.',
			'faq.stillStuck' => 'Continua sem conseguir?',
			'faq.contactBody' => 'Dúvidas, comentários ou um problema? Envie-nos um email.',
			'about.version' => ({required Object version, required Object build}) => 'Versão ${version} (${build})',
			'about.tagline' => 'A sua nuvem. As suas chaves. O seu cofre.',
			'about.license' => 'Gratuito e de código aberto sob AGPL-3.0',
			'about.terms' => 'Termos de Serviço',
			'about.privacy' => 'Política de Privacidade',
			'about.promise' => 'Gratuito, sem truques: sem planos, sem versão premium, sem vendas adicionais.',
			'clipboard.clearsIn' => ({required Object time}) => 'Limpa-se em ${time}',
			'clipboard.cleared' => 'Área de transferência limpa',
			'sync.savedTo' => ({required Object storage}) => 'Guardado no ${storage}',
			'sync.notSavedTitle' => 'O seu cofre não foi guardado',
			'sync.notSavedBody' => ({required Object storage}) => 'Não foi possível ligar ao ${storage}. A sua alteração continua aqui — tente novamente antes de fechar o KeeperPass.',
			'sync.dismiss' => 'Dispensar',
			'sync.retryingTitle' => 'A tentar novamente…',
			'sync.retryingBody' => ({required Object storage}) => 'A guardar no ${storage}.',
			'sync.reconnectTitle' => ({required Object storage}) => 'Volte a ligar ao ${storage}',
			'sync.keepReading' => 'Pode continuar a ler; as alterações são guardadas assim que voltar a ligar-se.',
			'sync.reconnect' => 'Voltar a ligar',
			'sync.later' => 'Mais tarde',
			'sync.offlineBody' => ({required Object storage}) => 'Pode continuar a ler e a copiar. Para guardar é necessária uma ligação ao ${storage}.',
			'sync.changedTitle' => 'O Seu Cofre Foi Alterado',
			'sync.changedBody' => 'Foi guardada uma versão mais recente do seu cofre noutro dispositivo. Carregue-a antes de editar, para que nada seja substituído.',
			'sync.twoVersions' => 'Duas versões',
			'sync.onThisPhone' => 'Neste telemóvel',
			'sync.inStorage' => ({required Object storage}) => 'No ${storage}',
			'sync.loadedAt' => ({required Object time}) => 'carregada: ${time}',
			'sync.savedNewer' => ({required Object time}) => 'guardada: ${time} · mais recente',
			'sync.loadLatest' => 'Carregar a versão mais recente',
			'sync.notNow' => 'Agora não',
			'sync.pausedNote' => 'Até lá, pode ler e copiar, mas não editar.',
			'sync.upToDate' => 'Atualizado',
			'sync.loadedVersion' => ({required Object time}) => 'Foi carregada a versão guardada às ${time}',
			'scan.title' => 'Ler Código QR',
			'scan.primerTitle' => 'Adicionar um código 2FA por leitura',
			'scan.primerBody' => 'Quando um site ativa o início de sessão em dois passos, mostra um código QR. O KeeperPass lê-o com a câmara e guarda a chave de configuração no seu cofre, para que os códigos apareçam em Códigos.',
			'scan.primerPrivacy' => 'A câmara apenas lê o código. Nada é gravado e nenhuma imagem é guardada.',
			'scan.primerNext' => 'A seguir, o seu telemóvel pede acesso à câmara.',
			'scan.enterInstead' => 'Introduzir antes a chave de configuração',
			'scan.hint' => 'Aponte para o código QR que o site mostra\nquando ativa o início de sessão em dois passos.',
			'scan.torch' => 'Ligar a luz',
			'scan.cameraView' => 'Vista da câmara',
			'scan.codeFound' => 'Código Encontrado',
			'scan.saveTo' => 'Guardar em',
			'scan.existingItem' => 'Item existente',
			'scan.existingItemWith' => ({required Object summary}) => 'Item existente · ${summary}',
			'scan.newAuthenticator' => 'Novo item Autenticador',
			'scan.named' => ({required Object name}) => 'Com o nome ${name}',
			'scan.cameraOffTitle' => 'O acesso à câmara está desativado',
			'scan.cameraOffBody' => 'O KeeperPass só precisa da câmara para ler códigos QR. Ative-a nas Definições ou escreva antes a chave de configuração.',
			'scan.openSettings' => 'Abrir Definições',
			'scan.unsupported' => 'Este código usa definições que o KeeperPass ainda não suporta',
			'scan.notACode' => 'Isto não é um código QR de 2FA',
			'scan.cameraFailed' => 'Não foi possível iniciar a câmara',
			'scan.item' => 'Item',
			'scan.codeSettings' => '6 dígitos · a cada 30 segundos · SHA-1',
			'scan.codeAdded' => ({required Object name}) => 'Código adicionado a ${name}',
			'scan.tapToCopy' => 'Toque no cartão para o copiar.',
			_ => null,
		};
	}
}
