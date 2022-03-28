import 'dart:io';

import 'package:dio/dio.dart';
import 'package:trello_challenge/data/api/base_provider.dart';

class UserProvider{

  final RestClient restClient;
  UserProvider({required this.restClient});

  Future<Response> updateAvatar({required String path, required FormData formData}) async {
    return restClient.request(path, Method.POST, formData);
  }

}