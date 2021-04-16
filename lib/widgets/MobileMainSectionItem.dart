import 'package:afrchavanodflutter/widgets/MobileMainSectionItemHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileMainSectionItem extends StatefulWidget {
  MobileMainSectionItem({@required this.listWidget, @required this.headerTitle, @required this.headerIcon});

  final Widget listWidget;
  final String headerTitle;
  final Widget headerIcon;

  @override
  _MobileMainSectionItemState createState() => _MobileMainSectionItemState();
}

class _MobileMainSectionItemState extends State<MobileMainSectionItem> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selected = !selected;
            });
          },
          child: AnimatedContainer(
            height: 100,
            width: selected
                ? MediaQuery.of(context).size.width * 0.95
                : MediaQuery.of(context).size.width * 0.8,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: selected
                  ? BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))
                  : BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey,
                  offset: Offset(0, 5.0), // (right, bottom)
                  blurRadius: 5.0,
                  // spreadRadius: 2.0,
                ),
              ],
            ),
            child: MobileMainSectionItemHeader(
                title: widget.headerTitle, icon: widget.headerIcon),
          ),
        ),
        AnimatedContainer(
          height: selected ? 200 : 0,
          width: selected
              ? MediaQuery.of(context).size.width * 0.95
              : MediaQuery.of(context).size.width * 0.78,
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey,
                offset: Offset(0, 5.0), // (right, bottom)
                blurRadius: 5.0,
              ),
            ],
          ),
          child: widget.listWidget,
        ),
      ],
    );
  }
}
