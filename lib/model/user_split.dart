import 'package:cost_share/model/split.dart';
import 'package:cost_share/model/user.dart';

class UserSplit {
  String? userId;
  String? userAvatar;
  String? userName;
  double amount;
  double ratio;

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
  });

  factory UserSplit.formUser(User user) {
    return UserSplit(
      userId: user.id,
      userAvatar: user.photoUrl,
      userName: user.name,
    );
  }

  Split toSplit(String expenseId,double totalAmount) {
    return Split(
      expenseId: expenseId,
      userId: userId!,
      amount: totalAmount * ratio/100.0,
      ratio: ratio,
      isPaid: false,
    );
  }
}
