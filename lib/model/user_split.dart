import 'package:cost_share/model/split.dart';
import 'package:cost_share/model/user.dart';

class UserSplit {
  String? userId;
  String? userAvatar;
  String? userName;
  double amount;
  double ratio;
  bool isPaid;
  String? splitId;
  String? expenseId;

  void setratio(double value) {
    if (value < 0) {
      throw Exception('Ratio cannot be negative');
    }
    ratio = value;
    print('Ratio set to $ratio');
  }

  UserSplit({
    this.userId,
    this.userAvatar,
    this.userName,
    this.amount = 0,
    this.ratio = 0,
    this.isPaid = false,
    this.splitId,
    this.expenseId,
  });

  factory UserSplit.formUser(User user) {
    return UserSplit(
      userId: user.id,
      userAvatar: user.photoUrl,
      userName: user.name,
    );
  }

  Split toSplit(String expenseId, double totalAmount) {
    return Split(
      expenseId: expenseId,
      userId: userId!,
      amount: totalAmount * ratio / 100.0,
      ratio: ratio,
      isPaid: isPaid,
      id: splitId,
    );
  }

  Split toSplitWithoutAmount() {
    return Split(
      expenseId: expenseId!,
      userId: userId!,
      amount: amount,
      ratio: ratio,
      isPaid: isPaid,
      id: splitId,
    );
  }

  UserSplit copyWith({
    String? userId,
    String? userAvatar,
    String? userName,
    double? amount,
    double? ratio,
    bool? isPaid,
    String? splitId,
    String? expenseId,
  }) {
    return UserSplit(
      userId: userId ?? this.userId,
      userAvatar: userAvatar ?? this.userAvatar,
      userName: userName ?? this.userName,
      amount: amount ?? this.amount,
      ratio: ratio ?? this.ratio,
      isPaid: isPaid ?? this.isPaid,
      splitId: splitId ?? this.splitId,
      expenseId: expenseId ?? this.expenseId,
    );
  }
}
