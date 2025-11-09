// import 'package:flutter/material.dart';
// import '../../config/config.dart';

// class CustomSwitch extends StatelessWidget {
//   final void Function(bool)? onChanged;
//   final bool value;

//   const CustomSwitch({
//     super.key,
//     this.onChanged,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Switch(
//       value: value,
//       onChanged: onChanged,
//       inactiveThumbColor: Theme.of(context).colorScheme.error,
//      activeColor: SharedColors.darkBlue,
//       activeTrackColor: SharedColors.primaryColor.withAlpha(50),
//       trackOutlineColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primaryContainer),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:my_template/config/app_colors.dart';

class CustomSwitch extends StatelessWidget {
  final void Function(bool)? onChanged;
  final bool value;

  final Color? activeColor;
  final Color? inactiveThumbColor;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;

  const CustomSwitch({
    super.key,
    this.onChanged,
    required this.value,
    this.activeColor,
    this.inactiveThumbColor,
    this.activeTrackColor,
    this.inactiveTrackColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedActiveThumb = activeColor ?? SharedColors.darkBlue;
    final Color resolvedInactiveThumb =
        inactiveThumbColor ?? Theme.of(context).colorScheme.error;
    final Color resolvedActiveTrack =
        (activeTrackColor ?? SharedColors.primaryColor)
            .withValues(alpha: 0.5);
    final Color resolvedInactiveTrack =
        inactiveTrackColor ?? Theme.of(context).colorScheme.primaryContainer;

    return Switch(
      value: value,
      onChanged: onChanged,
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return resolvedActiveThumb;
        }
        return resolvedInactiveThumb;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return resolvedActiveTrack;
        }
        return resolvedInactiveTrack;
      }),
      trackOutlineColor: WidgetStateProperty.all(resolvedInactiveTrack),
    );
  }
}
