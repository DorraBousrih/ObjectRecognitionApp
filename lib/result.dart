
//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/foundation.dart';
//import 'dart:js_interop';
import 'package:flutter/material.dart';
//import 'dart:io';
import 'package:restart_app/restart_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_tts/flutter_tts.dart';

//import 'package:google_ml_kit/google_ml_kit.dart';




class Result extends StatefulWidget {
  const Result(this.image, this.text ,{super.key});
  final text;
  final image;

@override
  State<Result> createState() => _ResultState();
}


class _ResultState extends State<Result>{
/*String show(String text){
  print(text);
  return text;
}*/

  FlutterTts flutterTts = FlutterTts();

  Future<void> speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(widget.text);
  }

   makeSound() async {
   return await speak();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  void initState() {
    makeSound();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: const Color.fromARGB(184, 245, 245, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(159, 255, 241, 87),
        title: const Text('Recognition Result', style: TextStyle(color: Color.fromARGB(217, 0, 0, 0)),),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(widget.image!, fit: BoxFit.contain),
            const SizedBox(height: 30),
           Text(widget.text ),
           //Container( child : makeSound()),
            const SizedBox(height: 30),
            TextButton.icon(
              icon: const Icon(Icons.camera,
              size: 40, color: Color.fromARGB(255, 14, 95, 136)),
              label: Text(
              'Take Another Picture',
               style: GoogleFonts.aBeeZee(
               textStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),),),
              onPressed: () {
              Restart.restartApp();
              }
            )
          ],
        ),
      ),
    ));
  }
}
