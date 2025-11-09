import 'package:flutter/widgets.dart';
import 'package:my_template/core/utils/app_text_style.dart';
import 'package:my_template/core/widgets/app_widgets/app_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Home',
      showBackButton: false,
      showAppBar: true,
      body: Column(
        children: const [
          Text('Home',
          style: AppTextStyle.style16B,
          ),
        ],
      ),
    );
  }
}