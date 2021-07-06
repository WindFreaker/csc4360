import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {

  final List<ButtonStyleButton> buttons;

  ButtonRow({required this.buttons});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    buttons.forEach((ButtonStyleButton button) {
      widgets.add(Expanded(
        flex: 1,
        child: button,
      ));
      widgets.add(SizedBox(
        width: 30,
      ));
    });

    widgets.removeLast();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }

}