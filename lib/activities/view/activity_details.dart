
import 'package:boring_app/activities/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityDetails extends StatelessWidget {
  final Activity activity;
  const ActivityDetails(this.activity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(text: TextSpan(
          style: const TextStyle(fontSize: 20),
          children: <TextSpan>[
            TextSpan(text: "${activity.type.name } ",style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: "activity")
          ]
        ),
          
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation)
        =>orientation==Orientation.portrait ?  PageBody(activity) :
        SingleChildScrollView(child: PageBody(activity),)
        ,
      ),
    );
  }
}

class PageBody extends StatelessWidget {
  final Activity activity;
  const PageBody(this.activity) ;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize:  MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            "assets/${activity.type.name}.jpg",
            fit: BoxFit.contain,
          ),
        ),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(activity.activityTitle,textAlign: TextAlign.center,softWrap: true,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                      activity.link!="" ? GestureDetector(
                          onTap: ()=> launchUrl(Uri.parse(activity.link)),
                          child: Text(activity.link,textAlign: TextAlign.center,softWrap: true,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.blue,decoration: TextDecoration.underline),)) : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Text('€${activity.price}',style: const TextStyle(color: Colors.grey,fontSize: 25,fontWeight: FontWeight.bold),),
        SizedBox(height: deviceHeight*0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${activity.numberOfParticipants} participant(s) ",style: const TextStyle(fontSize: 16),),
            Container(decoration: const BoxDecoration(border: Border(
                left: BorderSide(color: Colors.grey)
            )),child: const Text("",style: TextStyle(fontSize: 16))),
            Text(" ${activity.accessibility} accessibility rate",style: const TextStyle(fontSize: 16))


          ],
        ),
        SizedBox(height: deviceHeight*0.01,),

      ],

    );
  }
}

