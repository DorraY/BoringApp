import 'package:boring_app/views/activity_search.dart';
import 'package:boring_app/views/random_activities_list.dart';
import 'package:boring_app/utils/media_query_util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget with MediaQueryUtil{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) => Stack(
          children: [
            Image.asset(
              "assets/background.png",
              fit: BoxFit.cover,
              width: screenSize(context).width,
              height: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: orientation == Orientation.portrait ? 3 : 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Flexible(
                                child: Text(
                                  'Hi! What do you want to do today?',
                                  style: TextStyle(fontSize: 26),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: orientation == Orientation.portrait
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ActivitySearch(),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                  "Find an activity"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const RandomActivitiesList(),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                  "Random activities"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Expanded(child: Container()),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const RandomActivitiesList(),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                  "Random activities"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ActivitySearch(),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                  "Find an activity"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                  ],
                                ),
                        )
                      ],
                    ),
                  )),
                  Expanded(child: Container())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
