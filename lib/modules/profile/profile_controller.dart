import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trello_challenge/data/api/repository/user_repository.dart';
import 'package:trello_challenge/data/model/response/user_model.dart';
import 'package:trello_challenge/routes/app_pages.dart';
import 'package:trello_challenge/shared/constants/storage.dart';
import 'package:trello_challenge/shared/enums/dialog_type.dart';
import 'package:trello_challenge/shared/utils/common_widget.dart';
import 'package:trello_challenge/shared/widgets/custom_dialog.dart';

class ProfileController extends GetxController
    with StateMixin<UserResponseModel> {
  final UserRepository userRepository;
  final ImagePicker _imagePicker = ImagePicker();
  ProfileController({required this.userRepository});

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void loadUser() async {
    CommonWidget.showLoading();
    try {
      final user = await userRepository.getCurrentUser();
      await Future.delayed(const Duration(milliseconds: 300));
      change(user, status: RxStatus.success());
      CommonWidget.hideLoading();
    } catch (e) {
      CommonWidget.hideLoading();
      change(UserResponseModel(), status: RxStatus.error(e.toString()));
    }
  }

  void updateAvatar() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      CommonWidget.showLoading();
      try {
        await userRepository.updateAvatar(file: image);
        CommonWidget.hideLoading();
        loadUser();
      } catch (e) {
        CommonWidget.hideLoading();
        Get.dialog(
            CustomDialog(dialogType: DialogType.failed, message: e.toString()));
      }
    }
  }

  Future<dynamic> logout() async {
    await Get.find<SharedPreferences>().remove(StorageConstants.token);
    Get.offAllNamed(Routes.login);
  }
}
