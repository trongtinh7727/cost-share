import 'package:cost_share/model/split.dart';
import 'package:cost_share/model/user.dart';

class UserSplit {
  String? userId;
  String? userAvatar;
  String? userName;
  double amount;
  double ratio;
  double weight;
  bool isPaid;
  String? splitId;
  String? expenseId;
  String? FCMToken;

  void setratio(double value) {
    if (value < 0) {
      throw Exception('Ratio cannot be negative');
    }
    ratio = value;
    print('Ratio set to $ratio');
  }

  void setWeight(double value) {
    if (value < 0) {
      throw Exception('Weight cannot be negative');
    }
    weight = value;
    print('Weight set to $weight');
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
    this.weight = 0,
    this.FCMToken,
  });

  factory UserSplit.formUser(User user) {
    return UserSplit(
      userId: user.id,
      userAvatar: user.photoUrl,
      userName: user.name,
      FCMToken: user.fcmToken,
    );
  }

  Split toSplit(String expenseId, double totalAmount) {
    return Split(
      expenseId: expenseId,
      userId: userId!,
      amount: totalAmount * ratio,
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
    String? FCMToken,
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
      FCMToken: FCMToken ?? this.FCMToken,
    );
  }
}
