import 'package:trello_challenge/data/api/base_provider.dart';
import 'package:trello_challenge/data/api/provider/user_provider.dart';

class UserRepository extends RestClient{

  final UserProvider userProvider;
  UserRepository({required this.userProvider});

}