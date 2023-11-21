import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:sorted/common/widgets/platform_icon_button.dart';
import 'package:sorted/common/widgets/snack_bar.dart';
import 'package:sorted/constants.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_icons/yaru_icons.dart';

class TextFieldBar extends StatefulWidget {
  final FocusNode f1;
  final TextEditingController controller;
  final GlobalKey<ScaffoldMessengerState> snackbarKey;
  final VoidCallback clearValues;
  final double fontSize;
  final int width;
  final XTypeGroup typeGroup;
  const TextFieldBar({
    super.key,
    required this.f1,
    required this.controller,
    required this.snackbarKey,
    required this.fontSize,
    required this.width,
    required this.typeGroup,
    required this.clearValues,
  });

  @override
  State<TextFieldBar> createState() => _TextFieldBarState();
}

class _TextFieldBarState extends State<TextFieldBar> {
  bool cleared = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 2,
      focusNode: widget.f1,
      autofocus: true,
      controller: widget.controller,
      decoration: InputDecoration(
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            PlatformIconButton(
              icon: Icon(
                isMobile ? Icons.file_open_outlined : YaruIcons.document_new,
              ),
              onPressed: () async {
                setState(() {});
                final XFile? file = await openFile(
                    acceptedTypeGroups: [widget.typeGroup],
                    confirmButtonText: 'Select File');

                file != null
                    ? widget.controller.text = await file.readAsString()
                    : widget.snackbarKey.currentState?.showSnackBar(
                        snackBar(errorMessages[2], widget.fontSize,
                            widget.width, widget.snackbarKey,
                            seconds: 3),
                      );
              },
            ),
            PlatformIconButton(
              icon: Icon(
                cleared
                    ? isMobile
                        ? Icons.backspace
                        : YaruIcons.edit_clear_filled
                    : isMobile
                        ? Icons.backspace_outlined
                        : YaruIcons.edit_clear,
              ),
              tooltip: 'Clear',
              onPressed: () {
                widget.snackbarKey.currentState?.hideCurrentSnackBar();
                widget.snackbarKey.currentState
                    ?.showSnackBar(snackBar('Clearing...', widget.fontSize,
                        widget.width, widget.snackbarKey,
                        seconds: 0, microseconds: 1, isClosable: false))
                    .closed
                    .then((value) {
                  setState(() {
                    cleared = !cleared;
                    widget.controller.clear();
                    widget.clearValues();
                  });
                });
                setState(() {
                  cleared = !cleared;
                });
              },
            ),
          ],
        ),
        hintText: 'Enter the values to sort, separated by commas',
        filled: true,
      ),
    );
  }
}
