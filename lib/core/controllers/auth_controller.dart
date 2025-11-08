import 'package:get/get.dart';
import 'package:my_template/core/services/storage_service.dart';

class AuthController extends GetxController {
  AuthController() : _isLoggedIn = false.obs;

  static const String _authBox = 'auth_box';
  static const String _tokenKey = 'token';

  final RxBool _isLoggedIn;

  bool get isLoggedIn => _isLoggedIn.value;

  Future<void> initialize() async {
    final token = await Get.find<StorageService>().read<String?>(_authBox, _tokenKey);
    _isLoggedIn.value = token != null;
  }

  Future<void> login(String token) async {
    await Get.find<StorageService>().write<String?>(_authBox, _tokenKey, token);
    _isLoggedIn.value = true;
  }

  Future<void> logout() async {
    await Get.find<StorageService>().clear(_authBox);
    _isLoggedIn.value = false;
  }
}
