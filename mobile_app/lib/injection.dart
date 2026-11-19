import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/app.dart';
import 'package:keeperpass/injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(ignoreUnregisteredTypes: <Type>[AppConfig])
Future<void> configureDependencies(AppConfig config) async {
  if (!getIt.isRegistered<AppConfig>()) {
    getIt.registerSingleton<AppConfig>(config);
  }
  await getIt.init();
}
