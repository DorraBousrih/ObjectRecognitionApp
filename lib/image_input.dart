import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:stage_flutter/result.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_database/firebase_database.dart';

//import 'dart:convert';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;


  Future getProfileImage() async {
    ImagePicker picker = ImagePicker();
      await picker.pickImage(source: ImageSource.camera).then((value) {
        if(value!=null){
          setState(() {
            _selectedImage = File(value.path);
            print(_selectedImage);
          });();
        }
      }).catchError((error){
        debugPrint(error.toString());
      });

  }

  Future<String> getText() async{
FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference ref = FirebaseDatabase.instance.ref("");
DatabaseEvent event = await ref.once();
return await (event.snapshot.value).toString();
}

  Future<File?> compressImage(File file) async {
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      String targetPath = "${appDocumentsDir.path}/compressed_image.jpg";
      File? result = (await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 70,
      ));
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }


  Future uploadProfileImage() async {
    try {
      String? selectedImageUrl;
      File? file = await compressImage(_selectedImage!);

      var storageReference = FirebaseStorage.instance
          .ref()
          .child('profilePic.jpg');

      var uploadTask = storageReference.putFile(file!);
      

      await uploadTask;

      
      setState(() async {
        selectedImageUrl = await storageReference.getDownloadURL();
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }


Future<String> downloadProfileImage() async {
  final ref = FirebaseStorage.instance.ref().child("recognized.jpg");

var url = ref.getDownloadURL();
return url;
} 
 void find (BuildContext context) async {
  final imageUrl = await downloadProfileImage();
  String text= await getText();
  // ignore: use_build_context_synchronously
  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Result(imageUrl,text) ));

 }

  @override
  Widget build(context) {
    Widget content = Builder(
      builder: (context) => TextButton.icon(
        icon: const Icon(Icons.camera,
            size: 40, color: Color.fromARGB(255, 14, 95, 136)),
        label: Text(
          'Take Picture',
          style: GoogleFonts.aBeeZee(
            textStyle: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
          ),
        ),
        onPressed:() async { 
           await getProfileImage();
           print('button clicked...');
           uploadProfileImage();
          }
      ),
    );
    if (_selectedImage != null) {
      content = InkWell( 
        onTap: () {downloadProfileImage().toString();
        find(context);},
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ));
    }
   
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.white.withOpacity(0.7),
        ),
      ),
      height: 350,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
      
    );
  }
  
}
