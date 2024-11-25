import 'package:cost_share/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  CupertinoTextThemeData get cupertinoTextTheme =>
      CupertinoTheme.of(this).textTheme;

  Size get screenSize => MediaQuery.of(this).size;

  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;

  EdgeInsets get mediaQueryViewPadding => MediaQuery.of(this).viewPadding;

  Object? get arguments => ModalRoute.of(this)!.settings.arguments;

  void popToBottom<T>({T? result}) {
    while (Navigator.of(this).canPop()) {
      Navigator.of(this).pop(result);
    }
  }
}
