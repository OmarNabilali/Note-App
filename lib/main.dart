import 'package:flutter/material.dart';

import 'data_base.dart';

void main(){
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'database':(context)=>DataBase(),

      },
home: DataBase(),
    );
  }
}
