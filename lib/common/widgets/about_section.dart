import 'package:flutter/material.dart';
import 'package:sorted/common/widgets/platform_icon_button.dart';
import 'package:sorted/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_icons/yaru_icons.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: PlatformIconButton(
        icon: Tooltip(
          message: 'About this app',
          child: Icon(
            isMobile ? Icons.info : YaruIcons.information_filled,
          ),
        ),
        onPressed: () {
          showAboutDialog(
            context: context,
            applicationName: 'Sorted',
            applicationVersion: '0.1',
            applicationIcon: PlatformIconButton(
              icon: Image.asset(
                appIcon,
                height: 64,
                width: 64,
              ),
              onPressed: () => launchUrl(Uri.parse(githubProject)),
            ),
            children: List.generate(
              contributors.length,
              (index) {
                final c = contributors.entries.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Text(c.key),
                    onTap: () => launchUrl(Uri.parse(c.value)),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
