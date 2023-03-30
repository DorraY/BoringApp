import 'package:boring_app/bloc/activity_bloc.dart';
import 'package:boring_app/models/activity_search_criteria.dart';
import 'package:boring_app/models/activity_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityFilters extends StatefulWidget {
  const ActivityFilters(this.state, {Key? key}) : super(key: key);
  final ActivityState state;

  @override
  _ActivityFiltersState createState() => _ActivityFiltersState();
}

class _ActivityFiltersState extends State<ActivityFilters> {
  RangeValues _priceSliderValue = const RangeValues(0.1, 0.8);
  RangeValues _accessibilitySliderValue = const RangeValues(0.1, 0.5);
  double _participantsSliderValue = 2;

  final List<String> _priceLabels = [
    'Free',
    'Cheap',
    'Affordable',
    'Expensive'
  ];
  final List<String> _accessibilityLabels = [
    'Open for everyone',
    'Easy to achieve',
    'Requires some effort',
    'Challenging'
  ];

  bool _priceFilter = false;
  bool _accessibilityFilter = false;
  bool _numberOfParticipantsFilter = false;
  bool _activityTypeFilter = false;
  String _selectedActivityType = "";

  late ActivityBloc _activityBloc;

  @override
  void initState() {
    super.initState();
    _activityBloc = BlocProvider.of<ActivityBloc>(context);
  }

  void _onDropdownDataReceived(String data) {
    _selectedActivityType = data;
  }

  void updateFilterRangeValues(
      String filterTitle, RangeValues sliderNewValues) {
    {
      if (filterTitle.contains("Price")) {
        _priceSliderValue = sliderNewValues;
      } else {
        _accessibilitySliderValue = sliderNewValues;
      }
    }
  }

  void toggleFilterUsage(String filterTitle, bool newValue) {
    if (filterTitle.contains("Price")) {
      _priceFilter = newValue;
    } else {
      _accessibilityFilter = newValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          FilterWidgetWithRange(
            toggleFilterUsage: toggleFilterUsage,
            filterTitle: 'Price range filter',
            updateFilterRangeValues: updateFilterRangeValues,
            labels: _priceLabels,
          ),
          FilterWidgetWithRange(
            toggleFilterUsage: toggleFilterUsage,
            filterTitle: 'Accessibility range filter',
            updateFilterRangeValues: updateFilterRangeValues,
            labels: _accessibilityLabels,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Expanded(child: Text('Number of participants filter')),
              Switch.adaptive(
                  value: _numberOfParticipantsFilter,
                  onChanged: (value) {
                    setState(() {
                      _numberOfParticipantsFilter = value;
                    });
                  }),
            ],
          ),
          _numberOfParticipantsFilter
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
                  value: _activityTypeFilter,
                  onChanged: (value) {
                    setState(() {
                      _activityTypeFilter = value;
                    });
                  }),
            ],
          ),
          _activityTypeFilter
              ? ActivityTypeDropDown(_onDropdownDataReceived)
              : Container(),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: (widget.state is ActivityLoading)
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            _activityBloc.add(ActivitySearchStarted(
                                ActivitySearchCriteria(
                                    type: _activityTypeFilter
                                        ? _selectedActivityType
                                        : null,
                                    accessibilityMax: _accessibilityFilter
                                        ? _accessibilitySliderValue.end
                                            .toStringAsFixed(2)
                                        : null,
                                    accessibilityMin: _accessibilityFilter
                                        ? _accessibilitySliderValue.start
                                            .toStringAsFixed(2)
                                        : null,
                                    numberOfParticipants:
                                        _numberOfParticipantsFilter
                                            ? _participantsSliderValue.round()
                                            : null,
                                    priceMax: _priceFilter
                                        ? _priceSliderValue.end
                                            .toStringAsFixed(2)
                                        : null,
                                    priceMin: _priceFilter
                                        ? _priceSliderValue.start
                                            .toStringAsFixed(2)
                                        : null)));
                          },
                          child: const Text('Search')),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FilterWidgetWithRange extends StatefulWidget {
  final String filterTitle;

  final List<String> labels;

  final Function toggleFilterUsage;
  final Function updateFilterRangeValues;

  const FilterWidgetWithRange(
      {required this.labels,
      required this.filterTitle,
      required this.toggleFilterUsage,
      required this.updateFilterRangeValues});

  @override
  _FilterWidgetWithRangeState createState() => _FilterWidgetWithRangeState();
}

class _FilterWidgetWithRangeState extends State<FilterWidgetWithRange> {
  final List<double> threshold = [0.0, 0.4, 0.7];
  int startInterval = 0;
  int endInterval = 0;
  bool filterValue = false;
  RangeValues sliderRangeValues = const RangeValues(0.1, 0.8);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(child: Text(widget.filterTitle)),
            Switch.adaptive(
                value: filterValue,
                onChanged: (value) {
                  setState(() {
                    filterValue = value;
                  });
                  widget.toggleFilterUsage(widget.filterTitle, filterValue);
                }),
          ],
        ),
        filterValue
            ? RangeSlider(
                values: sliderRangeValues,
                min: 0.0,
                max: 1.0,
                divisions: 100,
                labels: RangeLabels(
                    widget.labels[startInterval], widget.labels[endInterval]),
                onChanged: (RangeValues values) {
                  widget.updateFilterRangeValues(
                      widget.filterTitle, sliderRangeValues);
                  setState(() {
                    sliderRangeValues = values;
                    startInterval = values.start == threshold[0]
                        ? 0
                        : values.start < threshold[1]
                            ? 1
                            : values.start < threshold[2]
                                ? 2
                                : 3;
                    endInterval = values.end < threshold[0]
                        ? 0
                        : values.end < threshold[1]
                            ? 1
                            : values.end < threshold[2]
                                ? 2
                                : 3;
                  });
                },
              )
            : Container(),
      ],
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
  List<String> activityType = ActivityType.activityType;
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
