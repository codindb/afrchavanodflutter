import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koukicons/layers2.dart';
import 'package:koukicons/sign.dart';

class TeamList extends StatefulWidget {
  @override
  _TeamListState createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
  @override
  Widget build(BuildContext context) {
    final listTiles = <Widget> [
      ListTile(
        leading: KoukiconsLayers2(height: 30),
        title: Text(
          "Bureau",
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: KoukiconsSign(height: 30),
        onTap: () {
          print("bureau tapped");
        },
      ),ListTile(
        leading: KoukiconsLayers2(height: 30),
        title: Text(
          "Responsables d'activités",
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: KoukiconsSign(height: 30),
        onTap: () {
          print("manager tapped");
        },
      ),
    ];
    return ListView(children:listTiles);
  }
}