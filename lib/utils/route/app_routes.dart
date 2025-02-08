import 'package:cost_share/model/budget.dart';
import 'package:cost_share/model/expense.dart';
import 'package:cost_share/model/user_split.dart';
import 'package:cost_share/presentation/authentication/signin_screen.dart';
import 'package:cost_share/presentation/authentication/signup_screen.dart';
import 'package:cost_share/presentation/budget/add_budget_screen.dart';
import 'package:cost_share/presentation/budget/add_contribution_screen.dart';
import 'package:cost_share/presentation/budget/budget_detail_screen.dart';
import 'package:cost_share/presentation/group/add_group_screen.dart';
import 'package:cost_share/presentation/group/group_setting_screen.dart';
import 'package:cost_share/presentation/main/main_screen.dart';
import 'package:cost_share/presentation/intro/intro_screen.dart';
import 'package:cost_share/presentation/main/wellcome_screen.dart';
import 'package:cost_share/presentation/transaction/add_expense_screen.dart';
import 'package:cost_share/presentation/transaction/expense_detail_screen.dart';
import 'package:cost_share/presentation/transaction/update_expense_screen.dart';
import 'package:cost_share/splash_creen.dart';
import 'package:cost_share/utils/route/route_name.dart';
import 'package:flutter/material.dart';

extension GenerateRoute on RouteSettings {
  dynamic get generateRoute {
    switch (name) {
      case RouteName.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RouteName.main:
        return MaterialPageRoute(
          builder: (context) => MainScreen(),
        );
      case RouteName.intro:
        return MaterialPageRoute(
          builder: (context) => const IntroScreen(),
        );
      case RouteName.signUp:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
        );
      case RouteName.signIn:
        return MaterialPageRoute(
          builder: (_) => SignInScreen(),
        );
      case RouteName.wellCome:
        return MaterialPageRoute(builder: (context) => WellcomeScreen());
      case RouteName.addGroup:
        return MaterialPageRoute(
          builder: (context) => const AddGroupScreen(),
        );
      case RouteName.addExpense:
        return MaterialPageRoute(
          builder: (context) => const AddExpenseScreen(),
        );
      case RouteName.addBudget:
        return MaterialPageRoute(
          builder: (context) => AddBudgetScreen(),
        );
      case RouteName.budgetDetai:
        Budget budget = arguments as Budget;
        return MaterialPageRoute(
          builder: (context) => BudgetDetailScreen(budget: budget),
        );
      case RouteName.addContribute:
        Map<String, dynamic> args = arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => AddContributionScreen(
            budget: args['budget'] as Budget,
            userSplit: args['userSplit'] as UserSplit,
          ),
        );
      case RouteName.expenseDetail:
        Expense expense = arguments as Expense;
        return MaterialPageRoute(
          builder: (context) => ExpenseDetailScreen(
            expense: expense,
          ),
        );
      case RouteName.updateExpense:
        Expense expense = arguments as Expense;
        return MaterialPageRoute(
          builder: (context) => UpdateExpenseScreen(
            expense: expense,
          ),
        );
      case RouteName.groupSetting:
        return MaterialPageRoute(builder: (context) => GroupSettingScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("data"),
            ),
          ),
        );
    }
  }
}
