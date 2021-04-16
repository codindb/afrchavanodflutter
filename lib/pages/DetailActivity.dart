import 'package:afrchavanodflutter/widgets/AfrAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afrchavanodflutter/widgets/FutureActivities.dart';

class DetailActivity extends StatefulWidget {
  static const routeName = '/activite';
  @override
  _DetailActivityState createState() => _DetailActivityState();
}

class _DetailActivityState extends State<DetailActivity> {
  @override
  Widget build(BuildContext context) {
    final ActivityArgs activity = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AfrAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      activity.activity.name,
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 48,
                      ),
                    ),
                  ]
                ),
              ]
            )
          )
        ]
      ),
    );
  }
}