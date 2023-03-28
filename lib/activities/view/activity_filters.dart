import 'package:boring_app/activities/bloc/activity_bloc.dart';
import 'package:boring_app/activities/models/activity.dart';
import 'package:boring_app/activities/models/activity_search_criteria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityFilters extends StatefulWidget {
  const ActivityFilters(this.state, {Key? key}) : super(key: key);
  final ActivityState state;

  @override
  _ActivityFiltersState createState() => _ActivityFiltersState();
}

class _ActivityFiltersState extends State<ActivityFilters> {
  RangeValues _currentPriceSliderValue = const RangeValues(0.1, 0.8);
  RangeValues _currentAccessibilitySliderValue = const RangeValues(0.1, 0.5);
  List<String> priceLabels = ['Free', 'Cheap', 'Affordable', 'Expensive'];
  List<String> accessibilityLabels = [
    'Open for everyone',
    'Easy to achieve',
    'Requires some effort',
    'Challenging'
  ];
  List<int> participantsLabels = List.generate(10, (index) => index);
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
  String selectedActivityType = "education";

  late ActivityBloc _activityBloc;


  @override
  void initState() {
    super.initState();
    _activityBloc = BlocProvider.of<ActivityBloc>(context);
    _activityBloc.emit(ActivitySearchIdle());
  }

  void _onDataReceived(String data) {
    selectedActivityType = data;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Expanded(child: Text('Price range filter')),
              Switch.adaptive(
                  value: priceFilter,
                  onChanged: (value) {
                    setState(() {
                      priceFilter = value;
                    });
                  }),
            ],
          ),
          priceFilter
              ? RangeSlider(
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
          )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Expanded(child: Text('Accessibility range filter')),
              Switch.adaptive(
                  value: accessibilityFilter,
                  onChanged: (value) {
                    setState(() {
                      accessibilityFilter = value;
                    });
                  }),
            ],
          ),
          accessibilityFilter
              ? RangeSlider(
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
          )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Expanded(child: Text('Number of participants filter')),
              Switch.adaptive(
                  value: numberOfParticipantsFilter,
                  onChanged: (value) {
                    setState(() {
                      numberOfParticipantsFilter = value;
                    });
                  }),
            ],
          ),
          numberOfParticipantsFilter
              ? Slider(
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
          )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Expanded(child: Text('Activity type filter')),
              Switch.adaptive(
                  value: activityTypeFilter,
                  onChanged: (value) {
                    setState(() {
                      activityTypeFilter = value;
                    });
                  }),
            ],
          ),
          activityTypeFilter
              ? ActivityTypeDropDown(_onDataReceived)
              : Container(),
          (widget.state is ActivitySearchLoaded || widget.state is ActivitySearchError ||widget.state is ActivitySearchIdle) ? Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      _activityBloc.add(ActivitySearchStarted(
                          ActivitySearchCriteria(
                              type: activityTypeFilter
                                  ? selectedActivityType
                                  : null,
                              accessibilityMax: accessibilityFilter
                                  ? _currentAccessibilitySliderValue.end
                                  .toStringAsFixed(2)
                                  : null,
                              accessibilityMin:
                              accessibilityFilter
                                  ? _currentAccessibilitySliderValue
                                  .start
                                  .toStringAsFixed(2)
                                  : null,
                              numberOfParticipants:
                              numberOfParticipantsFilter
                                  ? _participantsSliderValue.round()
                                  : null,
                              priceMax: priceFilter
                                  ? _currentPriceSliderValue.end.toStringAsFixed(2)
                                  : null,
                              priceMin: priceFilter
                                  ? _currentPriceSliderValue.start
                                  .toStringAsFixed(2)
                                  : null)));
                    },
                    child: const Text('Search')),
              ),
            ],
          ) : const Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
}

class ActivityTypeDropDown extends StatefulWidget {
  final Function onDataReceived;
  const ActivityTypeDropDown(this.onDataReceived);

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
        .map((String activityType) => DropdownMenuItem(
        value: activityType,
        child: SizedBox(
            child: Text(
              activityType,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Theme.of(context).primaryColor,
              ),
            ))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(8))),
      items: dropdownItems,
      value: selectedDropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          selectedDropdownValue = newValue!;
        });
        widget.onDataReceived(selectedDropdownValue);
      },
    );
  }
}