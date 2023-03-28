import 'package:boring_app/activities/bloc/activity_bloc.dart';
import 'package:boring_app/activities/services/activity_service.dart';
import 'package:boring_app/activities/view/home.dart';
import 'package:boring_app/activities/view/random_activities_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App(this.activityService);
  final ActivityService activityService;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ActivityBloc(
            activityService: activityService,
          ),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: GoogleFonts.poppins().fontFamily,
            primarySwatch: Colors.deepOrange,
          ),
          home: const HomePage()),
    );
  }
}
