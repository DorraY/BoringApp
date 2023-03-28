import 'package:boring_app/activities/bloc/activity_bloc.dart';
import 'package:boring_app/activities/models/activity.dart';
import 'package:boring_app/activities/models/activity_search_criteria.dart';
import 'package:boring_app/activities/view/error_view.dart';
import 'package:boring_app/activities/view/random_activities_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:google_fonts/google_fonts.dart';

import 'activity_filters.dart';

class ActivitySearch extends StatefulWidget {
  const ActivitySearch({Key? key}) : super(key: key);

  @override
  _ActivitySearchState createState() => _ActivitySearchState();
}

class _ActivitySearchState extends State<ActivitySearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find activity'),
      ),
      body: BlocBuilder<ActivityBloc, ActivityState>(builder: (context, state) {
        return ListView(
          children: [
            ActivityFilters(state),
            (state is ActivitySearchLoaded)
                ? SearchResultWidget(state, state.activity)
                : Container(),
            (state is ActivitySearchError)
                ? ErrorView()
                : Container(),
          ],
        );
      }),
    );
  }
}

class SearchResultWidget extends StatelessWidget {
  final ActivityState activityState;
  final Activity activity;
  const SearchResultWidget(this.activityState, this.activity);

  @override
  Widget build(BuildContext context) {
    if (activity.isValid()) {
      return ActivityItem(activity);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Text('No activity found with the given criteria',textAlign: TextAlign.center, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),

        Center(child: Image.asset("assets/no-activity-found.png",height: 200,width: 200,)),

      ],
    );
  }
}
