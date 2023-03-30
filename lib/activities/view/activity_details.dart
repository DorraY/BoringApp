import 'package:boring_app/activities/models/activity.dart';
import 'package:boring_app/utils/media_query_util.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityDetails extends StatelessWidget {
  final Activity activity;
  const ActivityDetails(this.activity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
              style: const TextStyle(fontSize: 20),
              children: <TextSpan>[
                TextSpan(
                    text: "${activity.type.name} ",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const TextSpan(text: "activity")
              ]),
        ),
      ),
      body: PageBody(activity),
    );
  }
}

class PageBody extends StatelessWidget with MediaQueryUtil {
  final Activity activity;
  const PageBody(this.activity);

  @override
  Widget build(BuildContext context) {
    return screenOrientation(context) == Orientation.portrait
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    "assets/${activity.type.name}.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.loose,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                        child: Text(
                                      activity.activityTitle,
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                  ],
                                ),
                                activity.link != ""
                                    ? GestureDetector(
                                        onTap: () =>
                                            launchUrl(Uri.parse(activity.link)),
                                        child: Text(
                                          activity.link,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline),
                                        ))
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    PriceExtension.values[activity.price]!,
                    style: TextStyle(
                        color: EnumIndexToColor.values[activity.price.index],
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${activity.numberOfParticipants} participant(s) ",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Container(
                          decoration: const BoxDecoration(
                              border:
                                  Border(left: BorderSide(color: Colors.grey))),
                          child:
                              const Text("", style: TextStyle(fontSize: 16))),
                      Text.rich(
                        TextSpan(
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      " ${AccessibilityExtension.values[activity.accessibility]} ",
                                  style: TextStyle(
                                      color: EnumIndexToColor
                                          .values[activity.accessibility.index])),
                            ]),
                      )
                    ],
                  ),
                ],
              ))
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SizedBox(
                  height: double.infinity,
                  child: Image.asset(
                    "assets/${activity.type.name}.jpg",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.loose,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                        child: Text(
                                      activity.activityTitle,
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                  ],
                                ),
                                activity.link != ""
                                    ? GestureDetector(
                                        onTap: () =>
                                            launchUrl(Uri.parse(activity.link)),
                                        child: Text(
                                          activity.link,
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    PriceExtension.values[activity.price]!,
                    style: TextStyle(
                        color: EnumIndexToColor.values[activity.price.index],
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${activity.numberOfParticipants} participant(s) ",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Container(
                          decoration: const BoxDecoration(
                              border:
                                  Border(left: BorderSide(color: Colors.grey))),
                          child:
                              const Text("", style: TextStyle(fontSize: 16))),
                      Text.rich(
                        TextSpan(
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      " ${AccessibilityExtension.values[activity.accessibility.index]} ",
                                  style: TextStyle(
                                      color: EnumIndexToColor
                                          .values[activity.accessibility.index])),
                            ]),
                      )
                    ],
                  ),
                ],
              ))
            ],
          );
  }
}

extension EnumIndexToColor on int {
  static final values = {
    0: Colors.pinkAccent,
    1: Colors.green,
    2: Colors.deepOrange,
    3: Colors.red,
  };
}
