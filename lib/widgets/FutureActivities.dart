import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afrchavanodflutter/pages/DetailActivity.dart';
import 'package:http/http.dart' as http;
import '../layout/adaptive.dart';
import 'dart:async';
import 'dart:convert';

import 'package:koukicons/layers.dart';
import 'package:koukicons/sign.dart';

class FutureActivities extends StatefulWidget {
  @override
  _FutureActivitiesState createState() => _FutureActivitiesState();
}

class _FutureActivitiesState extends State<FutureActivities> {
  Future<List<Activity>> futureActivities;
  @override
  void initState() {
    super.initState();
    futureActivities = fetchActivities();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return FutureBuilder<List<Activity>>(
      future: futureActivities,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: KoukiconsLayers(height: 30),
                title: Text(
                  snapshot.data[index].name,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  snapshot.data[index].description,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: KoukiconsSign(height: 30),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    DetailActivity.routeName,
                    arguments: ActivityArgs(snapshot.data[index])
                  );
                  print(snapshot.data[index].name + " tapped");
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
          child: isDesktop ? CupertinoActivityIndicator() : SizedBox(height: 0),
        );
      },
    );
  }
}
class ActivityArgs {
  final Activity activity;
  ActivityArgs(this.activity);
}
class Activity {
  int id;
  String name;
  String description;

  Activity({
    @required this.id,
    @required this.name,
    @required this.description,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      name: json['nom'],
      description: json['description'],
    );
  }
}

Future<List<Activity>> fetchActivities() async {
  final response =
      await http.get(Uri.https("afrchavanod.herokuapp.com", "/activites"));

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    // print(jsonResponse);
    List<Activity> activitiesList = [];
    for (var i = 0; i < jsonResponse.length; i++) {
      // print(jsonResponse[i]);
      activitiesList.add(Activity.fromJson(jsonResponse[i]));
    }
    return activitiesList;
  } else {
    throw Exception("Failed to load activities");
  }
}
