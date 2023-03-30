import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Center(child: Image.asset("assets/error.png",height: 200,width: 200,)),
        const Center(child: Text('Some error occured!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),

      ],
    );
  }
}
