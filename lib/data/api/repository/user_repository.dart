import 'dart:io';
import 'package:dio/dio.dart';
import 'package:trello_challenge/data/api/base_provider.dart';
import 'package:trello_challenge/data/api/provider/user_provider.dart';

class UserRepository extends RestClient{

  final UserProvider userProvider;
  UserRepository({required this.userProvider});

  Future<void> updateAvatar({required File file}) async {
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile('./text.txt',filename: 'upload.txt')
    });
    final res = await userProvider.updateAvatar(path: 'users/avatar', formData: formData);
  }

}