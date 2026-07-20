import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:my_template/core/services/network_service.dart';
import 'package:my_template/core/widgets/connectivity_banner_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    Get.reset();
    Get.put<NetworkService>(NetworkService());
  });

  testWidgets('ConnectivityBannerWidget shows banner when offline',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              ConnectivityBannerWidget(),
              Text('App Body'),
            ],
          ),
        ),
      ),
    );

    // Initial state: connected, banner hidden
    expect(find.text('Please check your internet connection.'), findsNothing);

    // Manually trigger offline status change
    final networkService = Get.find<NetworkService>();
    networkService.isConnectedRx.value = false;
    await tester.pumpAndSettle();

    expect(find.text('Please check your internet connection.'), findsOneWidget);

    // Restore connection
    networkService.isConnectedRx.value = true;
    await tester.pumpAndSettle();

    expect(find.text('Please check your internet connection.'), findsNothing);
  });
}
