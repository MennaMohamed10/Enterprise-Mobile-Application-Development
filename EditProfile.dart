import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'dbHelper.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();

}



class _EditProfileState extends State<EditProfile> {
  File? _image;
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final useridcontroller=TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });

  }

  Future<void> Imagefromcamera() async {
    final picker = ImagePicker();
    final cameraimage=await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (cameraimage != null) {
        _image = File(cameraimage.path);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Profile Photo From Gallery'),
            ),

            ElevatedButton(onPressed: Imagefromcamera, child: Text("Take an Image")),

            SizedBox(height: 20),
            _image != null
                ? Image.file(
              _image!,
              height: 200,
            )
                : Container(),

            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(color: Colors.black),),
              child: TextFormField(
                controller: useridcontroller,
                decoration: InputDecoration(
                  icon: Icon(Icons.numbers),
                  hintText: "Your ID",
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(color: Colors.black),),
              child: TextFormField(
                // Username field
                controller:nameController,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: "New User Name",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(color: Colors.black),),
              child: TextFormField(
                controller: passwordController,
                // Password field
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: "New Password",
                ),
              ),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String newName = nameController.text.trim();
                String newPassword = passwordController.text.trim();
                String userId = useridcontroller.text; // You need to get the userId of the current user here

                if (newName.isNotEmpty && newPassword.isNotEmpty && userId.isNotEmpty) {
                  await DbHelper().updateUserData(userId, newName, newPassword);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Changes saved successfully')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Name and password cannot be empty')),
                  );
                }
              },
              child: Text('Save Changes'),
            ),

          ],
        ),
      ),
    );
  }
}
