import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_template/core/widgets/image_error_widget.dart';

void main() {
  testWidgets('ImageErrorWidget renders icon and message correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 150,
            height: 150,
            child: ImageErrorWidget(),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.wifi_off_rounded), findsOneWidget);
    expect(find.text('Please check your internet connection'), findsOneWidget);
  });
}
