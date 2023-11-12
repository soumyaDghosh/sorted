import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

Widget aboutSection(BuildContext context, int width) {
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: YaruIconButton(
      icon: const Icon(YaruIcons.information),
      onPressed: () {
        showAboutDialog(
          context: context,
          applicationName: 'Sorted',
          applicationVersion: '0.1',
          children: [
            InkWell(
              child: Text(
                'Copyright by Soumyadeep Ghosh 2023 and onwards - all rights reserved',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onTap: () => launchUrl(
                Uri.parse('https://github.com/soumyaDghosh'),
              ),
            ),
            YaruIconButton(
              icon: const Icon(SimpleIcons.aboutdotme),
              onPressed: () {
                launchUrl(
                  Uri.parse('https://soumyadghosh.github.io/portfolio/'),
                );
              },
            ),
            YaruIconButton(
                icon: const Icon(SimpleIcons.github),
                onPressed: () {
                  launchUrl(
                    Uri.parse('https://github.com/soumyaDghosh/sorted'),
                  );
                }),
          ],
        );
      },
    ),
  );
}
