import 'package:flutter/material.dart';
import 'package:sorted/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: YaruIconButton(
        icon: const Tooltip(
          message: 'About this app',
          child: Icon(YaruIcons.information_filled),
        ),
        onPressed: () {
          showAboutDialog(
            context: context,
            applicationName: 'Sorted',
            applicationVersion: '0.1',
            applicationIcon: YaruIconButton(
              icon: Image.asset(appIcon),
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
