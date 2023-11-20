import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const HeaderBar({
    super.key,
    this.title,
    required this.leading,
    this.actions,
    this.style = YaruTitleBarStyle.normal,
    this.titleSpacing,
    this.backgroundColor = Colors.transparent,
    this.foregroundColor,
  });

  final Widget? title;
  final Widget leading;
  final List<Widget>? actions;
  final YaruTitleBarStyle style;
  final double? titleSpacing;
  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return !isMobile
        ? YaruWindowTitleBar(
            titleSpacing: titleSpacing,
            actions: actions,
            leading: leading,
            title: title,
            border: BorderSide.none,
            backgroundColor: backgroundColor,
            style: style,
          )
        : AppBar(
            centerTitle: false,
            //leading: leading,
            title: title,
            actions: [leading],
            backgroundColor: Theme.of(context).cardColor,
            elevation: 0,
            shadowColor: backgroundColor,
          );
  }

  @override
  Size get preferredSize => Size(
        0,
        isMobile
            ? (style == YaruTitleBarStyle.hidden ? 0 : kYaruTitleBarHeight)
            : kToolbarHeight,
      );
}
