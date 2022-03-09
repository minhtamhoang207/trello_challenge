import 'package:trello_challenge/data/model/response/user_model.dart';

import '../base_provider.dart';
import '../provider/auth_provider.dart';

class AuthRepository extends BaseProvider{
  AuthRepository({required this.authProvider});
  final AuthProvider authProvider;

  Future<UserResponse> getUser() async {
    final res = await authProvider.getUser(
        '/users/1',
    );
    return UserResponse.fromJson(res.body);
  }
//
// Future<RegisterResponse?> register(RegisterRequest data) async {
//   final res = await apiProvider.register('/api/register', data);
//   if (res.statusCode == 200) {
//     return RegisterResponse.fromJson(res.body);
//   }
// }
//
// Future<UsersResponse?> getUsers() async {
//   final res = await apiProvider.getUsers('/api/users?page=1&per_page=12');
//   if (res.statusCode == 200) {
//     return UsersResponse.fromJson(res.body);
//   }
// }
}