import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class CustomaboutDialog extends StatelessWidget {
  /// Creates an about box.
  ///
  /// The arguments are all optional. The application name, if omitted, will be
  /// derived from the nearest [Title] widget. The version, icon, and legalese
  /// values default to the empty string.
  const CustomaboutDialog({
    super.key,
    required this.applicationName,
    required this.applicationVersion,
    required this.width,
    this.applicationIcon,
    this.applicationLegalese,
    this.children,
  });

  /// The name of the application.
  ///
  /// Defaults to the value of [Title.title], if a [Title] widget can be found.
  /// Otherwise, defaults to [Platform.resolvedExecutable].
  final String applicationName;

  /// The version of this build of the application.
  ///
  /// This string is shown under the application name.
  ///
  /// Defaults to the empty string.
  final String applicationVersion;

  /// The icon to show next to the application name.
  ///
  /// By default no icon is shown.
  ///
  /// Typically this will be an [ImageIcon] widget. It should honor the
  /// [IconTheme]'s [IconThemeData.size].
  final Widget? applicationIcon;

  /// A string to show in small print.
  ///
  /// Typically this is a copyright notice.
  ///
  /// Defaults to the empty string.
  final String? applicationLegalese;

  /// Widgets to add to the dialog box after the name, version, and legalese.
  ///
  /// This could include a link to a Web site, some descriptive text, credits,
  /// or other information to show in the about box.
  ///
  /// Defaults to nothing.
  final List<Widget>? children;
  final int width;

  @override
  Widget build(BuildContext context) {
    final String name = applicationName;
    final String version = applicationVersion;
    final Widget? icon = applicationIcon;
    final ThemeData themeData = Theme.of(context);
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    return AlertDialog(
      content: ListBody(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (icon != null)
                IconTheme(data: themeData.iconTheme, child: icon),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Column(
                        children: <Widget>[
                          Text(name, style: themeData.textTheme.headlineSmall),
                          Text(version, style: themeData.textTheme.bodyMedium),
                          const SizedBox(height: 10),
                          Text(applicationLegalese ?? '',
                              style: themeData.textTheme.bodySmall),
                        ],
                      ),
                      SizedBox(
                        width: width - 300,
                      ),
                      const YaruIconButton(icon: Icon(SimpleIcons.github))
                    ],
                  ),
                ),
              ),
            ],
          ),
          ...?children,
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(themeData.useMaterial3
              ? localizations.viewLicensesButtonLabel
              : localizations.viewLicensesButtonLabel.toUpperCase()),
          onPressed: () {
            showLicensePage(
              context: context,
              applicationName: applicationName,
              applicationVersion: applicationVersion,
              applicationIcon: applicationIcon,
              applicationLegalese: applicationLegalese,
            );
          },
        ),
        TextButton(
          child: Text(themeData.useMaterial3
              ? localizations.closeButtonLabel
              : localizations.closeButtonLabel.toUpperCase()),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      scrollable: true,
    );
  }
}
