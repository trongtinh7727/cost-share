import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/repository/budget_repository.dart';
import 'package:cost_share/repository/expense_repository.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/repository/notification_repository.dart';
import 'package:cost_share/service/shared_pref_services.dart';
import 'package:get_it/get_it.dart';

import 'repository/user_repository.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocators() async {
  locator.registerFactory<SharedPrefService>(() => SharedPrefService());
  locator.registerFactory<UserManager>(
      () => UserManager(locator<UserRepository>()));
  locator.registerFactory<UserRepository>(() => UserRepositoryImpl());
  locator.registerFactory<GroupRepository>(() => GroupRepositoryImpl());
  locator.registerFactory<ExpenseRepository>(() => ExpenseRepositoryImpl());
  locator.registerFactory<BudgetRepository>(() => BudgetRepositoryImpl());
  locator.registerFactory<NotificationRepository>(
      () => NotificationRepositoryImpl());
}
