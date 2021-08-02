import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _image;
  File imageFile;
  Future cameraImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future GalleryImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Test.com'),
      ),
      body: ListView(
        children: [

          Container(
            height: 400,
            width: double.infinity,
            color: Colors.green,
            child: Flexible(
              child: _image == null
                  ? Center(child: Text("There is no Image is selected"))
                  : Image.file(_image),
            )
          ),

          Divider(thickness: 2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    cameraImage();
                  },
                  child: const Text('camera')),
              SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {
                    //GalleryImage();
                    //_getFromGallery();
                    getImage();
                  },
                  child: const Text('gallary'))
            ],
          )
        ],
      ),
    );
  }
}
