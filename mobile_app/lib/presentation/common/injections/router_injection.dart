import 'package:injectable/injectable.dart';
import 'package:keeperpass/presentation/common/routes/router.dart';

@module
abstract class RouterInjectableModule {
  @lazySingleton
  AppRouter get appRouter => AppRouter();
}
