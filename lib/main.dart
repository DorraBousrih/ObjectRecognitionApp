import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stage_flutter/camera_button.dart';
import 'firebase_options.dart';
//import 'package:binder/binder.dart';

 
void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
     MaterialApp(
      home: Scaffold(
        body:
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(225, 166, 177, 82),
                      Color.fromARGB(159, 255, 241, 87)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const CameraButton(),
              ),
            )
              
         ),
  ),
  );
       
}
