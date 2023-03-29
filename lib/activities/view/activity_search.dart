import 'package:boring_app/activities/bloc/activity_bloc.dart';
import 'package:boring_app/activities/models/activity.dart';
import 'package:boring_app/activities/view/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'activity_filters.dart';
import 'activity_item.dart';

class ActivitySearch extends StatelessWidget {
  const ActivitySearch({Key? key}) : super(key: key);

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
            (state is ActivitySearchError) ? const ErrorView() : Container(),
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
        const Center(
            child: Text('No activity found with the given criteria',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        Center(
            child: Image.asset(
          "assets/no-activity-found.png",
          height: 200,
          width: 200,
        )),
      ],
    );
  }
}
