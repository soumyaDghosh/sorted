import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class PlatformIconButton extends StatelessWidget {
  final Widget icon;
  final Function() onPressed;

  const PlatformIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.shape,
  });
  final String? tooltip;
  final OutlinedBorder? shape;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return IconButton(
        icon: icon,
        onPressed: onPressed,
        tooltip: tooltip,
        splashColor: Colors.white,
      );
    } else {
      return YaruIconButton(
        icon: icon,
        onPressed: onPressed,
        tooltip: tooltip,
        style: ButtonStyle(
          shape: ButtonStyleButton.allOrNull(shape ?? const CircleBorder()),
        ),
      );
    }
  }
}
