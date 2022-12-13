import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  const TextIcon(
      {Key key,
      this.textSpanText,
      this.backgroundColor,
      this.icon,
      this.iconColor,
      this.alignment})
      : super(key: key);

  final String textSpanText;
  final MaterialStateProperty<Color> backgroundColor;
  final IconData icon;
  final PlaceholderAlignment alignment;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
          style: TextStyle(color: Colors.black54, fontSize: 13),
          children: [
            TextSpan(
                text: textSpanText + "                    ",
                style: TextStyle(
                    color: Color.fromARGB(255, 199, 192, 192), fontSize: 10)),
            WidgetSpan(
              child: Icon(
                icon,
                size: 20,
                color: iconColor,
              ),
              alignment: alignment ?? PlaceholderAlignment.middle,
            ),
          ]),
    );
  }
}
