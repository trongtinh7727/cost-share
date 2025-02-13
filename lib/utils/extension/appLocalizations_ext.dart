import 'package:cost_share/generated/l10n.dart';
import 'package:intl/intl.dart';

extension AppLocalizationsX on AppLocalizations {
  String lookupMessage(String key, Map<String, String> args) {
    String message = Intl.message(key, name: key);
    args.forEach((key, value) {
      message = message.replaceAll('{$key}', value);
    });
    return message;
  }
}
