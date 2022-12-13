import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton(
      {Key key,
      this.onPressed,
      this.textSpanText,
      this.backgroundColor,
      this.icon,
      this.iconColor,
      this.alignment})
      : super(key: key);

  final VoidCallback onPressed;
  final String textSpanText;
  final MaterialStateProperty<Color> backgroundColor;
  final IconData icon;
  final PlaceholderAlignment alignment;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.only(left: 10)),
            backgroundColor: backgroundColor ??
                MaterialStateProperty.all<Color>(Colors.white)),
        onPressed: onPressed,
        child: Text.rich(
          TextSpan(
              style: TextStyle(color: Colors.black54, fontSize: 13),
              children: [
                TextSpan(
                    text: textSpanText,
                    style: TextStyle(color: Colors.black, fontSize: 25)),
                WidgetSpan(
                  child: Icon(
                    icon,
                    size: 30,
                    color: iconColor,
                  ),
                  alignment: alignment ?? PlaceholderAlignment.middle,
                ),
              ]),
        ));
  }
}
