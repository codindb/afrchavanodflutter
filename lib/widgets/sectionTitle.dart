import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final double titleFontSize;
  const SectionTitle({@required this.title, @required this.titleFontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.blue,
          fontSize: titleFontSize,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
