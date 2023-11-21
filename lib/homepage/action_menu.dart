import 'package:flutter/material.dart';
import 'package:sorted/common/widgets/platform_icon_button.dart';
import 'package:sorted/route.dart' as route;
import 'package:yaru/yaru.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class ActionMenu extends StatelessWidget {
  const ActionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformIconButton(
      icon: isMobile ? const Icon(Icons.menu) : const Icon(YaruIcons.menu),
      onPressed: () => Navigator.pushNamed(context, route.settingsPage),
      shape: const BeveledRectangleBorder(),
    );
  }
}
