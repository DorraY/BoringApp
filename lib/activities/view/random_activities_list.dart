
import 'package:boring_app/activities/bloc/activity_bloc.dart';
import 'package:boring_app/activities/models/activity.dart';
import 'package:boring_app/activities/view/activity_details.dart';
import 'package:boring_app/activities/view/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;
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
                      ErrorView()
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

class ActivityItem extends StatelessWidget {
  final Activity activity;
  const ActivityItem(this.activity);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceOrientation=MediaQuery.of(context).orientation;
    return GestureDetector(
      child: Card(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:  <Widget>[
            Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius:  const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: SizedBox(
                      height: deviceOrientation ==Orientation.portrait ? deviceHeight*0.35 : deviceHeight*0.7,
                      width: double.infinity,
                      child: Image.asset("assets/${activity.type.name}.jpg",fit: BoxFit.cover,),),
                  ),
                  Positioned(
                      bottom: 20,
                      right: 10,
                      left: 10,
                      child: Container(
                        color: Colors.black54,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Text(
                                    activity.activityTitle,
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Align(
                      alignment: Alignment.topRight,
                      child:Transform.rotate(
                        angle: math.pi/10,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset('assets/label.png',height: 100,width: 100,fit: BoxFit.fill,),
                            Text(activity.type.name),
                          ],
                        ),
                      )
                  )


                ]
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical:deviceHeight*0.01),
              child: deviceWidth > 200
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ActivityInfoElement(Icons.star,AccessibilityExtension.values[activity.accessibility]!),
                  ActivityInfoElement(Icons.people,  activity.numberOfParticipants.toString()),
                  ActivityInfoElement(Icons.euro,  PriceExtension.values[activity.price]!)
                ],
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ActivityInfoElement(Icons.star, activity.accessibility.toString()),
                  ActivityInfoElement(Icons.people,  activity.numberOfParticipants.toString()),
                  ActivityInfoElement(Icons.euro,  activity.price.toString())
                ],
              ),
            ),

          ],
        ),
      ),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ActivityDetails(activity),
          ),
        );
      },
    );
  }
}

class ActivityInfoElement extends StatelessWidget {
  final IconData _iconData;
  final String _title;
  const ActivityInfoElement(this._iconData,this._title);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: deviceWidth>200 ? MainAxisAlignment.start : MainAxisAlignment.center,
      children:  <Widget>[
        Icon(_iconData),
        const SizedBox(width: 6,),
        Text(_title),
      ],
    );
  }
}
