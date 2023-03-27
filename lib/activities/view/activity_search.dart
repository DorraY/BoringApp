import 'package:flutter/material.dart';

class ActivitySearch extends StatefulWidget {
  const ActivitySearch({Key? key}) : super(key: key);

  @override
  _ActivitySearchState createState() => _ActivitySearchState();
}

class _ActivitySearchState extends State<ActivitySearch> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  RangeValues _currentPriceSliderValue = const RangeValues(0.1, 0.8);
  RangeValues _currentAccessibilitySliderValue = const RangeValues(0.1, 0.5);
  List<String> priceLabels = ['Free', 'Cheap', 'Affordable', 'Expensive'];
  List<String> accessibilityLabels = ['Completely accessible', 'Easily accessible', 'Somewhat accessible', 'Hardly accessible'];

  double threshold1 = 0.0;
  double threshold2 = 0.4;
  double threshold3 = 0.7;
  int startIntervalPrice = 0;
  int endIntervalPrice =1;
  int startIntervalAccessibility = 0;
  int endIntervalAccessibility =1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RangeSlider(
              values: _currentPriceSliderValue,
              min: 0.0,
              max: 1.0,
              divisions: 100,
              labels: RangeLabels(priceLabels[startIntervalPrice], priceLabels[endIntervalPrice]),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentPriceSliderValue = values;
                  startIntervalPrice = values.start == threshold1
                      ? 0
                      : values.start < threshold2
                      ? 1
                      : values.start < threshold3
                      ? 2
                      : 3;
                  endIntervalPrice = values.end < threshold1
                      ? 0
                      : values.end < threshold2
                      ? 1
                      : values.end < threshold3
                      ? 2
                      : 3;
                });
              },
            ),
            RangeSlider(
              values: _currentAccessibilitySliderValue,
              min: 0.0,
              max: 1.0,
              divisions: 100,
              labels: RangeLabels(accessibilityLabels[startIntervalAccessibility], accessibilityLabels[endIntervalAccessibility]),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentAccessibilitySliderValue = values;
                  startIntervalAccessibility = values.start == threshold1
                      ? 0
                      : values.start < threshold2
                      ? 1
                      : values.start < threshold3
                      ? 2
                      : 3;
                  endIntervalAccessibility = values.end < threshold1
                      ? 0
                      : values.end < threshold2
                      ? 1
                      : values.end < threshold3
                      ? 2
                      : 3;
                });
              },
            ),

          ],
        ),
      ),
    );
  }
}
