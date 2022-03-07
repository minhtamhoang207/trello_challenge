import 'package:trello_challenge/app/data/api/rest_client.dart';

class AuthRepository extends RestClient{


  Future<String> login(String userName, String password) async {
    final res = await request(
        'url',
        Method.post,
        {
          'userName': userName,
          'password': password
        }
    );
    return res.toString();
  }
  
  Future<String> getUser()async{
    final res = await request(
        'https://jsonplaceholder.typicode.com/users',
        Method.get,
        {}
    );
    print("hehehehehehehehehehehehehe");
    print(res);
    print("hehehehehehehehehehehehehe");
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