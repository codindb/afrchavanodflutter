import 'package:afrchavanodflutter/widgets/FutureActivities.dart';
import 'package:afrchavanodflutter/widgets/MobileMainSectionItem.dart';
import 'package:afrchavanodflutter/widgets/TeamList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koukicons/conferenceCall.dart';
import 'package:koukicons/landscape.dart';

class MobileMainSection extends StatelessWidget {
  const MobileMainSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MobileMainSectionItem(listWidget: FutureActivities(), headerTitle: "ACTIVITES", headerIcon: KoukiconsLandscape(height: 70)),
        SizedBox(height: 20),
        MobileMainSectionItem(listWidget: TeamList(), headerTitle: "L'EQUIPE", headerIcon: KoukiconsConferenceCall(height: 70)),
      ],
    );
  }
}