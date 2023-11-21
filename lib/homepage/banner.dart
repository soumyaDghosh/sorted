import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorted/common/widgets/platform_icon_button.dart';
import 'package:sorted/common/widgets/snack_bar.dart';
import 'package:sorted/constants.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class BannerWithStack extends StatefulWidget {
  const BannerWithStack({
    super.key,
    required this.lightTheme,
    required this.result,
    required this.snackbarKey,
    required this.fontSize,
    required this.width,
  });
  final bool lightTheme; //check for lightmode or darkmode
  final String result;
  final GlobalKey<ScaffoldMessengerState> snackbarKey;
  final double fontSize;
  final int width;

  @override
  State<BannerWithStack> createState() => _BannerWithStackState();
}

class _BannerWithStackState extends State<BannerWithStack> {
  bool isSnackbar = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        YaruBanner(
          surfaceTintColor: Theme.of(context).appBarTheme.foregroundColor ??
              (widget.lightTheme ? bannerBackground : bannerBackgorundDark),
          child: Column(
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: SelectableText(
                    widget.result,
                    style: TextStyle(
                      fontSize: widget.fontSize + 10,
                      fontWeight:
                          widget.lightTheme ? FontWeight.w700 : FontWeight.w100,
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20),
              //   child: SelectionArea(
              //     child: SelectableText(
              //       time,
              //       style: TextStyle(
              //         fontSize: fontSize,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Positioned(
          bottom: isMobile ? 10 : 5, // Adjust the top position as needed
          right: isMobile ? 10 : 5, // Adjust the right position as needed
          child: PlatformIconButton(
            shape: const BeveledRectangleBorder(),
            tooltip: 'Copy the result',
            icon: Icon(
              isMobile
                  ? Icons.content_copy
                  : isSnackbar
                      ? YaruIcons.copy_filled
                      : YaruIcons.copy,
              size: widget.fontSize + 5,
            ),
            onPressed: () async {
              widget.result.isNotEmpty
                  ? await Clipboard.setData(
                      ClipboardData(text: widget.result.toString()))
                  : null;
              setState(() {
                isSnackbar = !isSnackbar;
                widget.snackbarKey.currentState?.hideCurrentSnackBar();
                widget.snackbarKey.currentState
                    ?.showSnackBar(
                      snackBar(
                        widget.result.isNotEmpty
                            ? 'Copied to clipboard'
                            : 'Nothing to copy',
                        widget.fontSize,
                        widget.width,
                        widget.snackbarKey,
                      ),
                    )
                    .closed
                    .then((value) {
                  setState(() {
                    isSnackbar = !isSnackbar;
                  });
                });
              });
            },
          ),
        ),
      ],
    );
  }
}
