// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Gain total control of your money`
  String get introTitle1 {
    return Intl.message(
      'Gain total control of your money',
      name: 'introTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Become your own money manager and make every cent count`
  String get introBody1 {
    return Intl.message(
      'Become your own money manager and make every cent count',
      name: 'introBody1',
      desc: '',
      args: [],
    );
  }

  /// `Know where your money goes`
  String get introTitle2 {
    return Intl.message(
      'Know where your money goes',
      name: 'introTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Track your transaction easily, with categories and financial report`
  String get introBody2 {
    return Intl.message(
      'Track your transaction easily, with categories and financial report',
      name: 'introBody2',
      desc: '',
      args: [],
    );
  }

  /// `Planning ahead`
  String get introTitle3 {
    return Intl.message(
      'Planning ahead',
      name: 'introTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Setup your budget for each category so you are in control`
  String get introBody3 {
    return Intl.message(
      'Setup your budget for each category so you are in control',
      name: 'introBody3',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the terms and conditions.`
  String get policy {
    return Intl.message(
      'I agree to the terms and conditions.',
      name: 'policy',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up with Google`
  String get googleSignUp {
    return Intl.message(
      'Sign Up with Google',
      name: 'googleSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `At least 8 characters, 1 number, and 1 uppercase letter`
  String get invalidPassword {
    return Intl.message(
      'At least 8 characters, 1 number, and 1 uppercase letter',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Name cannot be empty`
  String get nameCannotBeEmpty {
    return Intl.message(
      'Name cannot be empty',
      name: 'nameCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordMismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Transaction`
  String get transaction {
    return Intl.message(
      'Transaction',
      name: 'transaction',
      desc: '',
      args: [],
    );
  }

  /// `Budget`
  String get budget {
    return Intl.message(
      'Budget',
      name: 'budget',
      desc: '',
      args: [],
    );
  }

  /// `Member`
  String get member {
    return Intl.message(
      'Member',
      name: 'member',
      desc: '',
      args: [],
    );
  }

  /// `January`
  String get january {
    return Intl.message(
      'January',
      name: 'january',
      desc: '',
      args: [],
    );
  }

  /// `February`
  String get february {
    return Intl.message(
      'February',
      name: 'february',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get march {
    return Intl.message(
      'March',
      name: 'march',
      desc: '',
      args: [],
    );
  }

  /// `April`
  String get april {
    return Intl.message(
      'April',
      name: 'april',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get may {
    return Intl.message(
      'May',
      name: 'may',
      desc: '',
      args: [],
    );
  }

  /// `June`
  String get june {
    return Intl.message(
      'June',
      name: 'june',
      desc: '',
      args: [],
    );
  }

  /// `July`
  String get july {
    return Intl.message(
      'July',
      name: 'july',
      desc: '',
      args: [],
    );
  }

  /// `August`
  String get august {
    return Intl.message(
      'August',
      name: 'august',
      desc: '',
      args: [],
    );
  }

  /// `September`
  String get september {
    return Intl.message(
      'September',
      name: 'september',
      desc: '',
      args: [],
    );
  }

  /// `October`
  String get october {
    return Intl.message(
      'October',
      name: 'october',
      desc: '',
      args: [],
    );
  }

  /// `November`
  String get november {
    return Intl.message(
      'November',
      name: 'november',
      desc: '',
      args: [],
    );
  }

  /// `December`
  String get december {
    return Intl.message(
      'December',
      name: 'december',
      desc: '',
      args: [],
    );
  }

  /// `Invalid month`
  String get invalidMonth {
    return Intl.message(
      'Invalid month',
      name: 'invalidMonth',
      desc: '',
      args: [],
    );
  }

  /// `Wellcome Cost Share`
  String get wellcome {
    return Intl.message(
      'Wellcome Cost Share',
      name: 'wellcome',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Choose your group`
  String get chooseGroup {
    return Intl.message(
      'Choose your group',
      name: 'chooseGroup',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get textContinue {
    return Intl.message(
      'Continue',
      name: 'textContinue',
      desc: '',
      args: [],
    );
  }

  /// `Group Name`
  String get groupName {
    return Intl.message(
      'Group Name',
      name: 'groupName',
      desc: '',
      args: [],
    );
  }

  /// `Group Description`
  String get groupDescription {
    return Intl.message(
      'Group Description',
      name: 'groupDescription',
      desc: '',
      args: [],
    );
  }

  /// `How much?`
  String get howMuch {
    return Intl.message(
      'How much?',
      name: 'howMuch',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Budget Detail`
  String get budgetDetail {
    return Intl.message(
      'Budget Detail',
      name: 'budgetDetail',
      desc: '',
      args: [],
    );
  }

  /// `You’ve exceed the limit`
  String get exceedLimit {
    return Intl.message(
      'You’ve exceed the limit',
      name: 'exceedLimit',
      desc: '',
      args: [],
    );
  }

  /// `Contributions`
  String get contributions {
    return Intl.message(
      'Contributions',
      name: 'contributions',
      desc: '',
      args: [],
    );
  }

  /// `Contribuied: `
  String get contributied {
    return Intl.message(
      'Contribuied: ',
      name: 'contributied',
      desc: '',
      args: [],
    );
  }

  /// `Expense Spliting`
  String get expenseSpliting {
    return Intl.message(
      'Expense Spliting',
      name: 'expenseSpliting',
      desc: '',
      args: [],
    );
  }

  /// `Expense Detail`
  String get expenseDetail {
    return Intl.message(
      'Expense Detail',
      name: 'expenseDetail',
      desc: '',
      args: [],
    );
  }

  /// `Mark as paid`
  String get markAsPaid {
    return Intl.message(
      'Mark as paid',
      name: 'markAsPaid',
      desc: '',
      args: [],
    );
  }

  /// `Mark as unpaid`
  String get markAsUnpaid {
    return Intl.message(
      'Mark as unpaid',
      name: 'markAsUnpaid',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to mark this invoice as paid?`
  String get markAsPaidDescription {
    return Intl.message(
      'Are you sure you want to mark this invoice as paid?',
      name: 'markAsPaidDescription',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to mark this invoice as unpaid? This may affect the payment records.`
  String get markAsUnpaidDescription {
    return Intl.message(
      'Are you sure you want to mark this invoice as unpaid? This may affect the payment records.',
      name: 'markAsUnpaidDescription',
      desc: '',
      args: [],
    );
  }

  /// `Remove Expense`
  String get removeExpense {
    return Intl.message(
      'Remove Expense',
      name: 'removeExpense',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove this expense? This action cannot be undone.`
  String get removeExpenseDescription {
    return Intl.message(
      'Are you sure you want to remove this expense? This action cannot be undone.',
      name: 'removeExpenseDescription',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Remove Budget`
  String get removeBudget {
    return Intl.message(
      'Remove Budget',
      name: 'removeBudget',
      desc: '',
      args: [],
    );
  }

  /// `Total remaining budget`
  String get totalRemainingBudget {
    return Intl.message(
      'Total remaining budget',
      name: 'totalRemainingBudget',
      desc: '',
      args: [],
    );
  }

  /// `Total budget`
  String get totalBudget {
    return Intl.message(
      'Total budget',
      name: 'totalBudget',
      desc: '',
      args: [],
    );
  }

  /// `Total expense`
  String get totalExpense {
    return Intl.message(
      'Total expense',
      name: 'totalExpense',
      desc: '',
      args: [],
    );
  }

  /// `Add Member`
  String get addMember {
    return Intl.message(
      'Add Member',
      name: 'addMember',
      desc: '',
      args: [],
    );
  }

  /// `Scan the QR Code`
  String get scanQRCode {
    return Intl.message(
      'Scan the QR Code',
      name: 'scanQRCode',
      desc: '',
      args: [],
    );
  }

  /// `Or enter the email address`
  String get orEnterEmail {
    return Intl.message(
      'Or enter the email address',
      name: 'orEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Scan the QR Code or enter the email address to invite someone.`
  String get inviteMemberDescription {
    return Intl.message(
      'Scan the QR Code or enter the email address to invite someone.',
      name: 'inviteMemberDescription',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get userNotFound {
    return Intl.message(
      'User not found',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
