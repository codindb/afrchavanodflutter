import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileMainSectionItemHeader extends StatelessWidget {
  MobileMainSectionItemHeader({Key key, @required this.title, @required this.icon})
      : super(key: key);
  final String title;
  final icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
             title,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}
