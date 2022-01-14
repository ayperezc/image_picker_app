import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageSelector extends StatefulWidget {
  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {

  File? imageTaken;
  final picker = ImagePicker();

  Widget widgetImage(File? imageTaken){
    if(imageTaken == null){
      return const Center();
    }else{
      return Image.file(imageTaken);
    }
  }

  Future selectImage(option) async{
    XFile? pickedFile;

    if(option == 1){
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }else{
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      if(pickedFile != null){
        imageTaken = File(pickedFile.path);
      }else{
        print("Foto no seleccionada");
      }
    });

    Navigator.of(context).pop();

  }

  opciones(context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    selectImage(1);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Tomar una foto', style: TextStyle(fontSize: 16))
                        ),
                        Icon(Icons.camera_alt, color: Colors.blue)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    selectImage(2);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Seleccionar una foto', style: TextStyle(fontSize: 16))
                        ),
                        Icon(Icons.image, color: Colors.blue)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
  
  @override
  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecciona una imagen")
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
            children: [
              ElevatedButton(onPressed: (){
                opciones(context);
              }, child: Text('Seleccione una imagen')),
              SizedBox(height: 30),
              widgetImage(imageTaken)
            ]
          )
          ),
        ],
      ),
    );
  }
}