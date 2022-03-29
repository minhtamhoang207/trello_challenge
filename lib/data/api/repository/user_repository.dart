import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trello_challenge/data/api/base_provider.dart';
import 'package:trello_challenge/data/api/provider/user_provider.dart';
import 'package:trello_challenge/data/model/request/change_password_request.dart';
import 'package:trello_challenge/data/model/request/update_profile_request.dart';
import 'package:trello_challenge/data/model/response/user_model.dart';

class UserRepository extends RestClient {
  final UserProvider userProvider;
  UserRepository({required this.userProvider});

  Future<void> updateAvatar({required XFile file}) async {
    var formData =
        FormData.fromMap({'file': await MultipartFile.fromFile(file.path)});
    await userProvider.updateAvatar(path: 'users/avatar', formData: formData);
  }

  Future<void> changePassword({required ChangePasswordRequest data}) async {
    await userProvider.changePassword(path: 'user/reset-password', data: data);
  }

  Future<UserResponseModel> getCurrentUser() async {
    final res = await userProvider.getCurrentUser(path: 'users/me');
    return UserResponseModel.fromJson(res.data);
  }

  Future<void> updateProfile({required UpdateProfileRequest data}) async {
    await userProvider.updateProfile(path: 'users', data: data);
  }
}
