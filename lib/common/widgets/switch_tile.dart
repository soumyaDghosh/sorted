import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class CustomSwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final Function(bool) onChanged;
  final double fontsize;
  const CustomSwitchTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    required this.subtitle,
    required this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    final desktopSwitchTile = YaruSwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(title),
      subtitle: Text(subtitle),
    );
    final mobileSwitchTile = SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        title,
        style: TextStyle(fontSize: fontsize),
      ),
      subtitle: Text(subtitle),
    );
    return isMobile ? mobileSwitchTile : desktopSwitchTile;
  }
}
