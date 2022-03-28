import 'package:dio/dio.dart';
import 'package:trello_challenge/data/api/base_provider.dart';
import 'package:trello_challenge/data/model/request/login_request.dart';
import 'package:trello_challenge/data/model/request/register_request.dart';
import 'package:trello_challenge/data/model/request/verify_mail_request.dart';

class AuthProvider{

  final RestClient restClient;
  AuthProvider({required this.restClient});


  Future<Response> register({required String path, required RegisterRequest data}) {
    return restClient.request(path, Method.POST, data.toJson());
  }

  Future<Response> verifyMail({required String path, required VerifyMailRequest data}) {
    return restClient.request(path, Method.POST, data.toJson());
  }

  Future<Response> login({required String path, required LoginRequest data}) {
    return restClient.request(path, Method.POST, data.toJson());
  }
}