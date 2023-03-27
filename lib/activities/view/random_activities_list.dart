
import 'package:boring_app/activities/bloc/activity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomActivitiesList extends StatelessWidget {
  const RandomActivitiesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:  AppBar(title: Text("Random activities"),),

      body: Column(
        children: [
          BlocBuilder<ActivityBloc, ActivityState>(
            builder: (context, state) {
              if (state is ActivityLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ActivityLoaded) {
                return Expanded(child: ListView.builder(itemBuilder: (BuildContext context,int index) => Text(state.activityList[index].activityTitle),itemCount: state.activityList.length,));
              }
              return const Center(
                child: Text('Something went wrong!'),
              );
            },
          ),
        ],
      ),
    );
  }
}
