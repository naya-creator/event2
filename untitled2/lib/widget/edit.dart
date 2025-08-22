import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import 'profile_of_user.dart';


class Edit extends StatefulWidget {
  const Edit({super.key});
  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text(
            "Edit",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 154, 149, 149),
                        backgroundImage:
                        _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? Icon(Icons.person, color: Colors.white, size: 100)
                            : null,
                        // backgroundImage:
                        //     _image == null ? null : FileImage(_image!),
                        radius: 60,
                      ),
                      GestureDetector(
                          onTap: pickImage, child: Icon(Icons.camera_alt))
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color:Colors.pink,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.pink,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pink,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        hintText: "FullName : ",
                        hintStyle: TextStyle(
                            color: const Color.fromARGB(238, 158, 158, 158)))),
              ),
            ),
            Container(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.pink,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.pink,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pink,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        hintText: "email : ",
                        hintStyle: TextStyle(
                            color: const Color.fromARGB(238, 158, 158, 158)))),
              ),
            ),
            Container(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.pink,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.pink,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pink,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        hintText: "Old Password : ",
                        prefixIcon: Icon(Icons.remove_red_eye_sharp),
                        hintStyle: TextStyle(
                            color: const Color.fromARGB(238, 158, 158, 158)))),
              ),
            ),
            Container(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.pink,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.pink,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pink,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        hintText: "New Password : ",
                        prefixIcon: Icon(Icons.remove_red_eye_sharp),
                        hintStyle: TextStyle(
                            color: const Color.fromARGB(238, 158, 158, 158)))),
              ),
            ),
            Container(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.pink,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.pink,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pink,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        hintText: "Confirm Password : ",
                        prefixIcon: Icon(Icons.password),
                        hintStyle: TextStyle(
                            color: const Color.fromARGB(238, 158, 158, 158)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.pink,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }
}