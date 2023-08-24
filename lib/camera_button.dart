import 'package:flutter/material.dart';
import 'package:stage_flutter/image_input.dart';
import 'package:google_fonts/google_fonts.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({super.key});

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'images/pngegg.png',
            width: 150,
          ),
          const SizedBox(height: 30),
          Text(
            'This is an Object Detection App!\n The button below is ergonomically suitable for\n the destined audience of visually impaired people. \n \n Click it to start :) ',
            style: GoogleFonts.aBeeZee(
                textStyle: const TextStyle(
              color: Color.fromARGB(212, 17, 18, 18),
              fontSize: 14,
            )),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ImageInput(),
        ],
      ),
    );
  }
}
