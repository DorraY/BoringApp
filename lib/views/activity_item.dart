import 'package:boring_app/bloc/activity_bloc.dart';
import 'package:boring_app/models/activity.dart';
import 'package:boring_app/utils/media_query_util.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'activity_details.dart';

class ActivityItem extends StatelessWidget with MediaQueryUtil {
  final Activity activity;
  const ActivityItem(this.activity);

  List<ActivityInfoElement> activityInfoList() {
    return [
      ActivityInfoElement(
          Icons.star, AccessibilityExtension.values[activity.accessibility]!),
      ActivityInfoElement(
          Icons.people, activity.numberOfParticipants.toString()),
      ActivityInfoElement(Icons.euro, PriceExtension.values[activity.price]!)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Stack(children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: SizedBox(
                  height: screenOrientation(context) == Orientation.portrait
                      ? screenSize(context).height * 0.35
                      : screenSize(context).height * 0.7,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/${activity.type.name}.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  bottom: 20,
                  right: 10,
                  left: 10,
                  child: Container(
                    color: Colors.black54,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize(context).width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                activity.activityTitle,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Align(
                  alignment: Alignment.topRight,
                  child: Transform.rotate(
                    angle: math.pi / 10,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/label.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                        Text(activity.type.name),
                      ],
                    ),
                  ))
            ]),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenSize(context).height * 0.01),
              child: screenSize(context).width > 200
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: activityInfoList(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: activityInfoList(),
                    ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ActivityDetails(activity),
          ),
        );
      },
    );
  }
}

class ActivityInfoElement extends StatelessWidget with MediaQueryUtil {
  final IconData _iconData;
  final String _title;
  const ActivityInfoElement(this._iconData, this._title);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: screenSize(context).width > 200
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: <Widget>[
        Icon(_iconData),
        const SizedBox(
          width: 6,
        ),
        Text(_title),
      ],
    );
  }
}
