import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sorted/common/widgets/about_section.dart';
import 'package:sorted/common/widgets/header_bar.dart';
import 'package:sorted/common/widgets/switch_tile.dart';
import 'package:sorted/constants.dart';
import 'package:sorted/value_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //String _popupMenuTitle = 'Select Algorithm';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double fontSize;
    if (width >= 1100) {
      fontSize = 22;
    } else if (width >= 800 && width < 1100) {
      fontSize = 20;
    } else if (width >= 600 && width < 800) {
      fontSize = 18;
    } else {
      fontSize = 15;
    }
    List<String> optionSelected =
        context.watch<StringListProvider>().optionsSelected;
    String selectedAlgorithm =
        context.watch<StringListProvider>().selectedAlgorithm;
    const headerPadding = EdgeInsets.only(left: 30, top: 30, bottom: 10);
    const headerPaddingMobile = EdgeInsets.only(left: 15, bottom: 10, top: 30);

    final androidpopupMenuButton = PopupMenuButton(
      tooltip: toolTips[0],
      enableFeedback: true,
      itemBuilder: (BuildContext context) => List.generate(
        algorithms.length,
        (index) {
          return PopupMenuItem<String>(
            value: algorithms[index],
            child: Text(
              algorithms[index].capitalize(),
            ),
            onTap: () => context
                .read<StringListProvider>()
                .changedefaultAlgo(algorithms[index]),
          );
        },
      ),
      child: SizedBox(
        width: 70,
        height: 50,
        child: Row(
          children: [
            Text(
              selectedAlgorithm.capitalize(),
              style: TextStyle(fontSize: fontSize),
            ),
            const Expanded(child: Icon(Icons.arrow_drop_down))
          ],
        ),
      ),
    );

    final androidView = Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CustomScrollView(
        clipBehavior: Clip.antiAlias,
        slivers: [
          SliverAppBar(
            //title: Text('Settings'),
            pinned: true,
            floating: true,
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Settings',
                style: TextStyle(
                  color: Theme.of(context).appBarTheme.foregroundColor,
                ),
              ),
              titlePadding: const EdgeInsets.only(bottom: 20),
              centerTitle: true,
            ),
          ),
          SliverList.list(
            children: [
              Dialog(
                backgroundColor: Theme.of(context).highlightColor,
                child: Column(
                  children: [
                    alignedText(headerPaddingMobile, settingsHeaders[0]),
                    CustomSwitchTile(
                      fontsize: fontSize,
                      title: chipOptions.entries.elementAt(2).value.$1,
                      subtitle: chipOptions.entries.elementAt(2).value.$2,
                      value: optionSelected
                          .contains(chipOptions.entries.elementAt(2).key),
                      onChanged: (value) => changeValue(value, context, 2),
                    ),
                    if (optionSelected
                        .contains(chipOptions.entries.elementAt(2).key))
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          trailing: androidpopupMenuButton,
                          title: const Text('Select Algorithm'),
                          subtitle: const Text('Select the algorithm manually'),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
          SliverList.list(
            children: [
              Dialog(
                backgroundColor: Theme.of(context).highlightColor,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    alignedText(headerPaddingMobile, settingsHeaders[1]),
                    for (int i = 0; i < chipOptions.length - 1; i++)
                      CustomSwitchTile(
                        fontsize: fontSize,
                        title: chipOptions.entries.elementAt(i).value.$1,
                        subtitle: chipOptions.entries.elementAt(i).value.$2,
                        value: optionSelected
                            .contains(chipOptions.entries.elementAt(i).key),
                        onChanged: (value) {
                          setState(() {
                            changeValue(value, context, i);
                          });
                        },
                      ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              Dialog(
                backgroundColor: Theme.of(context).highlightColor,
                child: Column(
                  children: [
                    alignedText(headerPaddingMobile, 'About'),
                    const ListTile(
                      title: Text('App Info'),
                      subtitle: Text('About the app'),
                      trailing: AboutSection(),
                    ),
                    ListTile(
                      title: const Text('Source Code'),
                      subtitle: const Text('Show the source-code'),
                      trailing: IconButton(
                          onPressed: () => launchUrl(Uri.parse(githubProject)),
                          icon: const Icon(Icons.code_rounded)),
                    ),
                    ListTile(
                      title: const Text('Issues'),
                      subtitle: const Text('Report Issues'),
                      trailing: IconButton(
                          onPressed: () =>
                              launchUrl(Uri.parse('$githubProject/issues')),
                          icon: const Icon(Icons.safety_check)),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
    final yaruPopupMenuButton = YaruPopupMenuButton(
      tooltip: 'Select the Algorithm',
      enableFeedback: true,
      child: Text(
        selectedAlgorithm,
        style: TextStyle(
          fontSize: width < 600 ? 13 : fontSize - 8,
        ),
      ),
      itemBuilder: (BuildContext context) {
        return List.generate(algorithms.length, (index) {
          return PopupMenuItem<String>(
            value: algorithms[index],
            child: Text(
              algorithms[index],
              style: TextStyle(fontSize: width < 600 ? 15 : fontSize - 8),
            ),
            onTap: () => selectedAlgorithm = algorithms[index],
          );
        });
      },
      onSelected: (value) {
        context.read<StringListProvider>().changedefaultAlgo(value);
      },
    );
    final desktopView = Scaffold(
      appBar: HeaderBar(
        leading: const YaruBackButton(),
        title: Text(settingsHeaders[0]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: YaruSection(
                headline: const Text(''),
                headlinePadding: headerPadding,
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Column(
                      children: [
                        CustomSwitchTile(
                          fontsize: fontSize,
                          title: chipOptions.entries.elementAt(2).value.$1,
                          subtitle: chipOptions.entries.elementAt(2).value.$2,
                          value: optionSelected
                              .contains(chipOptions.entries.elementAt(2).key),
                          onChanged: (value) => changeValue(value, context, 2),
                        ),
                        if (optionSelected
                            .contains(chipOptions.entries.elementAt(2).key))
                          ListTile(
                            trailing: yaruPopupMenuButton,
                            title: const Text('Select Algorithm'),
                            subtitle:
                                const Text('Select the algorithm manually'),
                          ),
                        // if (!optionSelected
                        //     .contains(chipOptions.entries.elementAt(2).key))
                        //   ListTile(
                        //     trailing: yaruPopupMenuButton,
                        //     title: const Text('Default Algorithm'),
                        //     subtitle: const Text(
                        //         'Select the default algorithm manually'),
                        //   )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: YaruSection(
                  padding: EdgeInsets.zero,
                  headline: Text(settingsHeaders[1]),
                  headlinePadding: headerPadding,
                  child: Column(
                    children: [
                      for (int i = 0; i < chipOptions.length - 1; i++)
                        CustomSwitchTile(
                          fontsize: fontSize,
                          title: chipOptions.entries.elementAt(i).value.$1,
                          subtitle: chipOptions.entries.elementAt(i).value.$2,
                          value: optionSelected
                              .contains(chipOptions.entries.elementAt(i).key),
                          onChanged: (value) => changeValue(value, context, i),
                        ),
                    ],
                  )),
            ),
            const ListTile(
              title: Text('App Info'),
              subtitle: Text('About the app'),
              trailing: AboutSection(),
            ),
            ListTile(
              title: const Text('Source Code'),
              subtitle: const Text('Show the source-code'),
              trailing: IconButton(
                  onPressed: () => launchUrl(Uri.parse(githubProject)),
                  icon: const Icon(Icons.code_rounded)),
            ),
            ListTile(
              title: const Text('Issues'),
              subtitle: const Text('Report Issues'),
              trailing: IconButton(
                  onPressed: () =>
                      launchUrl(Uri.parse('$githubProject/issues')),
                  icon: const Icon(Icons.safety_check)),
            ),
          ],
        ),
      ),
    );

    return isMobile ? androidView : desktopView;
  }

  Align alignedText(EdgeInsets headerPaddingMobile, String string) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: headerPaddingMobile,
        child: Text(
          string,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void changeValue(bool value, BuildContext context, int index) {
    value
        ? context
            .read<StringListProvider>()
            .addOption(chipOptions.entries.elementAt(index).key)
        : context
            .read<StringListProvider>()
            .removeOption(chipOptions.entries.elementAt(index).key);
  }
}
