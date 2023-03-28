import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:google_fonts/google_fonts.dart';

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
  List<String> accessibilityLabels = [
    'Completely accessible',
    'Easily accessible',
    'Somewhat accessible',
    'Hardly accessible'
  ];
  List<int> participantsLabels = List.generate(11, (index) => index);
  double _participantsSliderValue = 2;

  double threshold1 = 0.0;
  double threshold2 = 0.4;
  double threshold3 = 0.7;
  int startIntervalPrice = 0;
  int endIntervalPrice = 1;
  int startIntervalAccessibility = 0;
  int endIntervalAccessibility = 1;
  bool priceFilter = false;
  bool accessibilityFilter = false;
  bool numberOfParticipantsFilter = false;
  bool activityTypeFilter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find activity'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GFAccordion(
              onToggleCollapsed: (value) {
                priceFilter = value;
              },
              title: 'Price range',
              contentChild: RangeSlider(
                values: _currentPriceSliderValue,
                min: 0.0,
                max: 1.0,
                divisions: 100,
                labels: RangeLabels(priceLabels[startIntervalPrice],
                    priceLabels[endIntervalPrice]),
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
              //showAccordion: priceFilter,
            ),
            GFAccordion(
              onToggleCollapsed: (value) {
                accessibilityFilter = value;
              },
              title: 'Accessibility range',
              contentChild: RangeSlider(
                values: _currentAccessibilitySliderValue,
                min: 0.0,
                max: 1.0,
                divisions: 100,
                labels: RangeLabels(
                    accessibilityLabels[startIntervalAccessibility],
                    accessibilityLabels[endIntervalAccessibility]),
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
            ),
            GFAccordion(
              onToggleCollapsed: (value) {
                numberOfParticipantsFilter = value;
              },
              title: 'Number of participants',
              contentChild: Slider(
                value: _participantsSliderValue,
                min: 0,
                max: 10,
                divisions: 10,
                label: _participantsSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _participantsSliderValue = value;
                  });
                },
              ),
            ),
            GFAccordion(
              onToggleCollapsed: (value) {
                activityTypeFilter = value;
              },
              title: 'Activity type',
              contentChild: const ActivityTypeDropDown(),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityTypeDropDown extends StatefulWidget {
  const ActivityTypeDropDown({super.key});

  @override
  State<ActivityTypeDropDown> createState() => _ActivityTypeDropDownState();
}

class _ActivityTypeDropDownState extends State<ActivityTypeDropDown> {
  List<String> activityType = [
    "education",
    "recreational",
    "social",
    "diy",
    "charity",
    "cooking",
    "relaxation",
    "music",
    "busywork"
  ];
  String selectedDropdownValue = "education";

  List<DropdownMenuItem<String>> get dropdownItems {
    return activityType
        .map((String activityType) =>
        DropdownMenuItem(value: activityType, child: SizedBox(
            child: Text(activityType,style: TextStyle(overflow: TextOverflow.ellipsis,color:
            Theme.of(context).primaryColor,),))))
        .toList();
  }


  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          fillColor:
          Colors.white,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(8))
      ),
      items: dropdownItems,
      value: selectedDropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          selectedDropdownValue = newValue!;
        });
      },
    );
  }
}
