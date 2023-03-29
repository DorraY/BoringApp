
import 'package:boring_app/activities/bloc/activity_bloc.dart';
import 'package:boring_app/activities/models/activity.dart';
import 'package:boring_app/activities/view/activity_details.dart';
import 'package:boring_app/activities/view/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import 'activity_item.dart';
class RandomActivitiesList extends StatefulWidget {
  const RandomActivitiesList({Key? key}) : super(key: key);

  @override
  State<RandomActivitiesList> createState() => _RandomActivitiesListState();
}

class _RandomActivitiesListState extends State<RandomActivitiesList> {


  late ActivityBloc _activityBloc;

  @override
  void initState() {
    super.initState();
    _activityBloc = BlocProvider.of<ActivityBloc>(context);
    _activityBloc.add(ActivityListStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:  AppBar(title: const Text("Random activities"),),

      body: RefreshIndicator(
        onRefresh: () async{
          context.read<ActivityBloc>().add(ActivityListStarted());
        },
        child: Column(
          children: [
            BlocBuilder<ActivityBloc, ActivityState>(
              builder: (context, state) {
                if (state is ActivityLoading) {

                  return const Expanded(child: Center(child: CircularProgressIndicator()));
                }
                if (state is ActivityListLoaded) {
                  return Expanded(child: ListView.builder(itemBuilder: (BuildContext context,int index) => ActivityItem(state.activityList[index]),itemCount: state.activityList.length,));
                }
                return Expanded(
                  //this stack and empty list view are a workaround to use refreshIndicator in the error case
                  //because it only works with list views
                  child: Stack(
                    children: [
                      ListView(),
                      const ErrorView()
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

