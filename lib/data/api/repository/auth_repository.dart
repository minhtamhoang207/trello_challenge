import 'package:trello_challenge/data/model/request/login_request.dart';
import 'package:trello_challenge/data/model/request/register_request.dart';
import 'package:trello_challenge/data/model/request/verify_mail_request.dart';
import 'package:trello_challenge/data/model/response/login_response.dart';
import 'package:trello_challenge/data/model/response/register_response_model.dart';
import 'package:trello_challenge/data/model/response/user_model.dart';
import 'package:trello_challenge/data/model/response/verify_mail_response.dart';

import '../base_provider.dart';
import '../provider/auth_provider.dart';

class AuthRepository extends RestClient{
  AuthRepository({required this.authProvider});
  final AuthProvider authProvider;


  Future<RegisterResponse> register({required RegisterRequest data}) async {
    final res = await authProvider.register(path: 'auth/register', data: data);
    return RegisterResponse.fromJson(res.data);
  }

  Future<VerifyMailResponse> verifyMail({required VerifyMailRequest data}) async {
    final res = await authProvider.verifyMail(path: 'auth/request-email', data: data);
    return VerifyMailResponse.fromJson(res.data);
  }

  Future<LoginResponse> login({required LoginRequest data}) async {
    final res = await authProvider.login(path: 'auth/login', data: data);
    return LoginResponse.fromJson(res.data);
  }
}