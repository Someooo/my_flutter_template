import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:my_template/core/services/network_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    Get.reset();
  });

  test('NetworkService initializes with default online state', () {
    final service = NetworkService();
    expect(service.isConnected, isTrue);
  });
}
