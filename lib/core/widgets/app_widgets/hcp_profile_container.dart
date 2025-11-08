import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_text_style.dart';
import '../../extension/gap_extension.dart';
import '../../utils/responsive.dart';

class HcpProfileContainer extends StatelessWidget {
  final String name;
  final String? description;
  final String? imageUrl;

  const HcpProfileContainer(
      {super.key, required this.name, this.description, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 5,
      children: [

        Container(
          height: 60,
          width: 60,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(11),
          ),
          child: imageUrl != null
              ? CacheNetworkImagePlus(imageUrl: imageUrl!,borderRadius: BorderRadius.circular(11),)
              : const Icon(
            Icons.person,
            size: 35,
            color: Colors.grey,
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name, style: AppTextStyle.bodyText.copyWith(fontSize: Responsive.isTablet? 12.sp :17)),
            if (description != null)
              Text(description!, style: AppTextStyle.subTitle.copyWith(fontSize: Responsive.isTablet? 10.sp : null)),
          ],
        ),
      ],
    );
  }
}
