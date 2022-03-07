import 'package:trello_challenge/app/data/api/base_provider.dart';
import 'package:trello_challenge/app/data/api/provider/auth_provider.dart';

class AuthRepository extends BaseProvider{
  AuthRepository({required this.authProvider});
  final AuthProvider authProvider;

  Future<String> getUser() async {
    final res = await authProvider.getUser(
        '/users',
    );
    print(res.toString());
    return res.toString();
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