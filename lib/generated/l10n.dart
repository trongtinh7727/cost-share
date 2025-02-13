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

  /// `Owed to you: `
  String get owedToYou {
    return Intl.message(
      'Owed to you: ',
      name: 'owedToYou',
      desc: '',
      args: [],
    );
  }

  /// `You owe: `
  String get youOwe {
    return Intl.message(
      'You owe: ',
      name: 'youOwe',
      desc: '',
      args: [],
    );
  }

  /// `Leave Group`
  String get leaveGroup {
    return Intl.message(
      'Leave Group',
      name: 'leaveGroup',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to leave this group? This action cannot be undone.`
  String get leaveGroupDescription {
    return Intl.message(
      'Are you sure you want to leave this group? This action cannot be undone.',
      name: 'leaveGroupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Leave`
  String get leave {
    return Intl.message(
      'Leave',
      name: 'leave',
      desc: '',
      args: [],
    );
  }

  /// `Remove Member`
  String get removeMember {
    return Intl.message(
      'Remove Member',
      name: 'removeMember',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove this member? This action cannot be undone.`
  String get removeMemberDescription {
    return Intl.message(
      'Are you sure you want to remove this member? This action cannot be undone.',
      name: 'removeMemberDescription',
      desc: '',
      args: [],
    );
  }

  /// `Group Setting`
  String get groupSetting {
    return Intl.message(
      'Group Setting',
      name: 'groupSetting',
      desc: '',
      args: [],
    );
  }

  /// `Delete Group`
  String get deleteGroup {
    return Intl.message(
      'Delete Group',
      name: 'deleteGroup',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this group? This action cannot be undone.`
  String get deleteGroupDescription {
    return Intl.message(
      'Are you sure you want to delete this group? This action cannot be undone.',
      name: 'deleteGroupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Filter Transaction`
  String get filterTransaction {
    return Intl.message(
      'Filter Transaction',
      name: 'filterTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Sort by`
  String get sortBy {
    return Intl.message(
      'Sort by',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Highest`
  String get highest {
    return Intl.message(
      'Highest',
      name: 'highest',
      desc: '',
      args: [],
    );
  }

  /// `Lowest`
  String get lowest {
    return Intl.message(
      'Lowest',
      name: 'lowest',
      desc: '',
      args: [],
    );
  }

  /// `Newest`
  String get newest {
    return Intl.message(
      'Newest',
      name: 'newest',
      desc: '',
      args: [],
    );
  }

  /// `Oldest`
  String get oldest {
    return Intl.message(
      'Oldest',
      name: 'oldest',
      desc: '',
      args: [],
    );
  }

  /// `Choose Category`
  String get chooseCategory {
    return Intl.message(
      'Choose Category',
      name: 'chooseCategory',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `New expense added`
  String get newExpenseAdded {
    return Intl.message(
      'New expense added',
      name: 'newExpenseAdded',
      desc: '',
      args: [],
    );
  }

  /// `{name} added an expense of {amount}.`
  String expenseMessage(String name, String amount) {
    return Intl.message(
      '$name added an expense of $amount.',
      name: 'expenseMessage',
      desc: '',
      args: [name, amount],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Mark as read`
  String get markAsRead {
    return Intl.message(
      'Mark as read',
      name: 'markAsRead',
      desc: '',
      args: [],
    );
  }

  /// `An expense has been updated`
  String get updatedExpense {
    return Intl.message(
      'An expense has been updated',
      name: 'updatedExpense',
      desc: '',
      args: [],
    );
  }

  /// `{name} updated an expense from {oldAmount} to {newAmount}.`
  String updatedExpenseMessage(
      String name, String oldAmount, String newAmount) {
    return Intl.message(
      '$name updated an expense from $oldAmount to $newAmount.',
      name: 'updatedExpenseMessage',
      desc: '',
      args: [name, oldAmount, newAmount],
    );
  }

  /// `An expense has been deleted`
  String get deletedExpense {
    return Intl.message(
      'An expense has been deleted',
      name: 'deletedExpense',
      desc: '',
      args: [],
    );
  }

  /// `{name} deleted an expense of {amount}.`
  String deletedExpenseMessage(String name, String amount) {
    return Intl.message(
      '$name deleted an expense of $amount.',
      name: 'deletedExpenseMessage',
      desc: '',
      args: [name, amount],
    );
  }

  /// `A memmer has been removed`
  String get removeMemberNotificate {
    return Intl.message(
      'A memmer has been removed',
      name: 'removeMemberNotificate',
      desc: '',
      args: [],
    );
  }

  /// `{name} has been removed from the group.`
  String removeMemberNotificateBody(String name) {
    return Intl.message(
      '$name has been removed from the group.',
      name: 'removeMemberNotificateBody',
      desc: '',
      args: [name],
    );
  }

  /// `A memmer has been added`
  String get newMemberAdded {
    return Intl.message(
      'A memmer has been added',
      name: 'newMemberAdded',
      desc: '',
      args: [],
    );
  }

  /// `{name} has been added to the group.`
  String newMemberAddedBody(String name) {
    return Intl.message(
      '$name has been added to the group.',
      name: 'newMemberAddedBody',
      desc: '',
      args: [name],
    );
  }

  /// `A memmer has left the group`
  String get leaveGroupNotificate {
    return Intl.message(
      'A memmer has left the group',
      name: 'leaveGroupNotificate',
      desc: '',
      args: [],
    );
  }

  /// `{name} has left the group.`
  String leaveGroupNotificateBody(String name) {
    return Intl.message(
      '$name has left the group.',
      name: 'leaveGroupNotificateBody',
      desc: '',
      args: [name],
    );
  }

  /// `Debt has been paid`
  String get debtPaid {
    return Intl.message(
      'Debt has been paid',
      name: 'debtPaid',
      desc: '',
      args: [],
    );
  }

  /// `{name} has paid the debt of {amount}.`
  String debtPaidBody(String name, String amount) {
    return Intl.message(
      '$name has paid the debt of $amount.',
      name: 'debtPaidBody',
      desc: '',
      args: [name, amount],
    );
  }

  /// `Contribute to the budget`
  String get contributeBudget {
    return Intl.message(
      'Contribute to the budget',
      name: 'contributeBudget',
      desc: '',
      args: [],
    );
  }

  /// `please contribute {amount} to the budget of {name}.`
  String contributeBudgetBody(String name, String amount) {
    return Intl.message(
      'please contribute $amount to the budget of $name.',
      name: 'contributeBudgetBody',
      desc: '',
      args: [name, amount],
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
