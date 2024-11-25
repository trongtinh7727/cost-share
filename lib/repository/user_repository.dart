import 'package:cost_share/model/user_model.dart';

abstract class UserRepository{
   Future<UserModel> getUserInfor();
}

class UserRepositoryImpl extends UserRepository {
  @override
  Future<UserModel> getUserInfor() {
    throw UnimplementedError();
  }
  
}