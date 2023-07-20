import 'package:flutter/material.dart';
import 'package:jogo_da_velha/screens/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
            
               
            title: 'Jogo da Velha',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.indigo,
                scaffoldBackgroundColor: const Color(0xFF1A237E),
                
                  
              ),

        home: CreateGame(),
      );
  
  }
}