// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  static String m0(name, amount) =>
      "vui lòng đóng góp ${amount} vào ngân sách của ${name}.";

  static String m1(name, amount) => "${name} đã thanh toán nợ ${amount}.";

  static String m2(name, amount) => "${name} đã xóa một chi tiêu ${amount}.";

  static String m3(name, amount) =>
      "${name} đã thêm một chi tiêu mới ${amount}.";

  static String m4(name) => "${name} đã rời nhóm.";

  static String m5(name) => "${name} đã được thêm vào nhóm.";

  static String m6(name) => "${name} đã bị xóa khỏi nhóm.";

  static String m7(name, oldAmount, newAmount) =>
      "${name} đã cập nhật một chi tiêu từ ${oldAmount} thành ${newAmount}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addMember": MessageLookupByLibrary.simpleMessage("Thêm thành viên"),
        "alreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Đã có tài khoản?"),
        "april": MessageLookupByLibrary.simpleMessage("Tháng 4"),
        "august": MessageLookupByLibrary.simpleMessage("Tháng 8"),
        "budget": MessageLookupByLibrary.simpleMessage("Ngân sách"),
        "budgetDetail":
            MessageLookupByLibrary.simpleMessage("Chi tiết ngân sách"),
        "cancel": MessageLookupByLibrary.simpleMessage("Hủy"),
        "category": MessageLookupByLibrary.simpleMessage("Danh mục"),
        "chooseCategory": MessageLookupByLibrary.simpleMessage("Chọn danh mục"),
        "chooseGroup":
            MessageLookupByLibrary.simpleMessage("Chọn nhóm của bạn"),
        "confirm": MessageLookupByLibrary.simpleMessage("Xác nhận"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Xác nhận mật khẩu"),
        "contributeBudget":
            MessageLookupByLibrary.simpleMessage("Đóng góp vào ngân sách"),
        "contributeBudgetBody": m0,
        "contributied": MessageLookupByLibrary.simpleMessage("Đã đóng góp: "),
        "contributions": MessageLookupByLibrary.simpleMessage("Đóng góp"),
        "debtPaid":
            MessageLookupByLibrary.simpleMessage("Nợ đã được thanh toán"),
        "debtPaidBody": m1,
        "december": MessageLookupByLibrary.simpleMessage("Tháng 12"),
        "delete": MessageLookupByLibrary.simpleMessage("Xóa"),
        "deleteGroup": MessageLookupByLibrary.simpleMessage("Xóa nhóm"),
        "deleteGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Bạn có chắc chắn muốn xóa nhóm không? Hành động này không thể hoàn tác."),
        "deletedExpense":
            MessageLookupByLibrary.simpleMessage("Một chi tiêu đã bị xóa"),
        "deletedExpenseMessage": m2,
        "description": MessageLookupByLibrary.simpleMessage("Mô tả"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "exceedLimit":
            MessageLookupByLibrary.simpleMessage("Bạn đã vượt quá giới hạn"),
        "expenseDetail":
            MessageLookupByLibrary.simpleMessage("Chi tiết chi phí"),
        "expenseMessage": m3,
        "expenseSpliting":
            MessageLookupByLibrary.simpleMessage("Chia sẻ chi phí"),
        "february": MessageLookupByLibrary.simpleMessage("Tháng 2"),
        "filterTransaction":
            MessageLookupByLibrary.simpleMessage("Lọc giao dịch"),
        "googleSignUp":
            MessageLookupByLibrary.simpleMessage("Đăng ký với Google"),
        "groupDescription": MessageLookupByLibrary.simpleMessage("Mô tả nhóm"),
        "groupName": MessageLookupByLibrary.simpleMessage("Tên nhóm"),
        "highest": MessageLookupByLibrary.simpleMessage("Cao nhất"),
        "home": MessageLookupByLibrary.simpleMessage("Trang chủ"),
        "howMuch": MessageLookupByLibrary.simpleMessage("Số tiền?"),
        "introBody1": MessageLookupByLibrary.simpleMessage(
            "Trở thành người quản lý tiền bạc của chính mình và trân trọng từng đồng chi tiêu"),
        "introBody2": MessageLookupByLibrary.simpleMessage(
            "Dễ dàng theo dõi giao dịch với danh mục rõ ràng và báo cáo tài chính chi tiết"),
        "introBody3": MessageLookupByLibrary.simpleMessage(
            "Thiết lập ngân sách cho từng danh mục để luôn kiểm soát chi tiêu"),
        "introTitle1": MessageLookupByLibrary.simpleMessage(
            "Hoàn toàn làm chủ tài chính của bạn"),
        "introTitle2":
            MessageLookupByLibrary.simpleMessage("Hiểu rõ dòng tiền của bạn"),
        "introTitle3":
            MessageLookupByLibrary.simpleMessage("Lên kế hoạch trước"),
        "invalidEmail":
            MessageLookupByLibrary.simpleMessage("Email không hợp lệ"),
        "invalidMonth":
            MessageLookupByLibrary.simpleMessage("Tháng không hợp lệ"),
        "invalidPassword": MessageLookupByLibrary.simpleMessage(
            "Ít nhất 8 ký tự, 1 số và 1 chữ in hoa"),
        "inviteMemberDescription": MessageLookupByLibrary.simpleMessage(
            "Quét mã QR hoặc nhập địa chỉ email để mời người khác."),
        "january": MessageLookupByLibrary.simpleMessage("Tháng 1"),
        "july": MessageLookupByLibrary.simpleMessage("Tháng 7"),
        "june": MessageLookupByLibrary.simpleMessage("Tháng 6"),
        "language": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
        "leave": MessageLookupByLibrary.simpleMessage("Rời"),
        "leaveGroup": MessageLookupByLibrary.simpleMessage("Rời nhóm"),
        "leaveGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Bạn có chắc chắn muốn rời nhóm không? Bạn sẽ không thể truy cập vào nhóm này nữa."),
        "leaveGroupNotificate":
            MessageLookupByLibrary.simpleMessage("Một thành viên đã rời nhóm"),
        "leaveGroupNotificateBody": m4,
        "login": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
        "logout": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
        "lowest": MessageLookupByLibrary.simpleMessage("Thấp nhất"),
        "march": MessageLookupByLibrary.simpleMessage("Tháng 3"),
        "markAsPaid":
            MessageLookupByLibrary.simpleMessage("Đánh dấu đã thanh toán"),
        "markAsPaidDescription": MessageLookupByLibrary.simpleMessage(
            "Bạn có chắc chắn muốn đánh dấu hóa đơn này đã thanh toán không?"),
        "markAsRead": MessageLookupByLibrary.simpleMessage("Đánh dấu đã đọc"),
        "markAsUnpaid":
            MessageLookupByLibrary.simpleMessage("Đánh dấu chưa thanh toán"),
        "markAsUnpaidDescription": MessageLookupByLibrary.simpleMessage(
            "Bạn có chắc chắn muốn đánh dấu hóa đơn này chưa thanh toán không? Điều này có thể ảnh hưởng đến bản ghi thanh toán."),
        "may": MessageLookupByLibrary.simpleMessage("Tháng 5"),
        "member": MessageLookupByLibrary.simpleMessage("Thành viên"),
        "name": MessageLookupByLibrary.simpleMessage("Tên"),
        "nameCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Tên không được để trống"),
        "newExpenseAdded":
            MessageLookupByLibrary.simpleMessage("Chi tiêu mới đã được thêm"),
        "newMemberAdded": MessageLookupByLibrary.simpleMessage(
            "Một thành viên mới đã được thêm"),
        "newMemberAddedBody": m5,
        "newest": MessageLookupByLibrary.simpleMessage("Mới nhất"),
        "november": MessageLookupByLibrary.simpleMessage("Tháng 11"),
        "october": MessageLookupByLibrary.simpleMessage("Tháng 10"),
        "oldest": MessageLookupByLibrary.simpleMessage("Cũ nhất"),
        "orEnterEmail": MessageLookupByLibrary.simpleMessage("Hoặc nhập email"),
        "owedToYou": MessageLookupByLibrary.simpleMessage("Nợ bạn: "),
        "password": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "passwordMismatch":
            MessageLookupByLibrary.simpleMessage("Mật khẩu không khớp"),
        "policy": MessageLookupByLibrary.simpleMessage(
            "Tôi đồng ý với các điều khoản và điều kiện."),
        "remove": MessageLookupByLibrary.simpleMessage("Xóa"),
        "removeExpense": MessageLookupByLibrary.simpleMessage("Xóa chi tiêu"),
        "removeExpenseDescription": MessageLookupByLibrary.simpleMessage(
            "Bạn có chắc chắn muốn xóa chi tiêu này không? Hành động này không thể hoàn tác."),
        "removeMember": MessageLookupByLibrary.simpleMessage("Xóa thành viên"),
        "removeMemberDescription": MessageLookupByLibrary.simpleMessage(
            "Bạn có chắc chắn muốn xóa thành viên này không? Hành động này không thể hoàn tác."),
        "removeMemberNotificate":
            MessageLookupByLibrary.simpleMessage("Một thành viên đã bị xóa"),
        "removeMemberNotificateBody": m6,
        "reset": MessageLookupByLibrary.simpleMessage("Đặt lại"),
        "scanQRCode": MessageLookupByLibrary.simpleMessage("Quét mã QR"),
        "september": MessageLookupByLibrary.simpleMessage("Tháng 9"),
        "settings": MessageLookupByLibrary.simpleMessage("Cài đặt"),
        "signUp": MessageLookupByLibrary.simpleMessage("Đăng ký"),
        "sortBy": MessageLookupByLibrary.simpleMessage("sắp xếp theo"),
        "textContinue": MessageLookupByLibrary.simpleMessage("Tiếp tục"),
        "today": MessageLookupByLibrary.simpleMessage("Hôm nay"),
        "totalBudget": MessageLookupByLibrary.simpleMessage("Tổng ngân sách"),
        "totalExpense": MessageLookupByLibrary.simpleMessage("Tổng chi tiêu"),
        "totalRemainingBudget":
            MessageLookupByLibrary.simpleMessage("Tổng ngân sách còn lại"),
        "transaction": MessageLookupByLibrary.simpleMessage("Giao dịch"),
        "updatedExpense": MessageLookupByLibrary.simpleMessage(
            "Một chi tiêu đã được cập nhật"),
        "updatedExpenseMessage": m7,
        "userNotFound":
            MessageLookupByLibrary.simpleMessage("Không tìm thấy người dùng"),
        "wellcome": MessageLookupByLibrary.simpleMessage(
            "Chào mừng đến với Cost Share"),
        "yesterday": MessageLookupByLibrary.simpleMessage("Hôm qua"),
        "youOwe": MessageLookupByLibrary.simpleMessage("Bạn nợ: ")
      };
}
