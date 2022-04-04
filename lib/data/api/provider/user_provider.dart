import 'dart:io';

import 'package:dio/dio.dart';
import 'package:trello_challenge/data/api/base_provider.dart';
import 'package:trello_challenge/data/model/request/change_password_request.dart';
import 'package:trello_challenge/data/model/request/update_profile_request.dart';

class UserProvider{

  final RestClient restClient;
  UserProvider({required this.restClient});

  Future<Response> updateAvatar({required String path, required FormData formData}) async {
    return restClient.request(url: path, method: Method.PUT, params: formData);
  }

  Future<Response> changePassword({required String path, required ChangePasswordRequest data}) async {
    return restClient.request(url: path, method: Method.PUT, params: data.toJson());
  }

  Future<Response> getCurrentUser({required String path}) async {
    return restClient.request(url: path, method: Method.GET, params: null);
  }

  Future<Response> updateProfile({required String path, required UpdateProfileRequest data}) async {
    return restClient.request(url: path, method: Method.PUT, params: data);
  }

}