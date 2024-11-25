import 'package:cost_share/service/shared_pref_services.dart';
import 'package:get_it/get_it.dart';

import 'repository/user_repository.dart';

final GetIt locator = GetIt.instance;

void setupLocators() {
  locator.registerFactory<SharedPrefService>(() => SharedPrefService());
  locator.registerFactory<UserRepository>(() => UserRepositoryImpl());
}
