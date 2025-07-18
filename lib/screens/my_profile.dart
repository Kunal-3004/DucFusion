import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doc_fusion/firestore_data/appointment_history_list.dart';
import 'package:doc_fusion/globals.dart';
import 'package:image_picker/image_picker.dart';
import'package:http/http.dart'as http;

import 'setting.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  final FirebaseStorage storage = FirebaseStorage.instance;

  // details
  String? email;
  String? name;
  String? phone;
  String? bio;
  String? specialization;

  // default dp
  String image =
      'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png';

  Future<void> _getUser() async {
    user = _auth.currentUser!;

    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection(isDoctor ? 'doctor' : 'patient')
        .doc(user.uid)
        .get();

    setState(() {
      var snapshot = snap.data() as Map<String, dynamic>;
      email = snapshot['email'];
      name = snapshot['name'];
      phone = snapshot['phone'];
      bio = snapshot['bio'];
      image = snapshot['profilePhoto'] ?? image;
      specialization = snapshot['specialization'];
    });
    print(snap.data());
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: ListView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.1, 0.5],
                            colors: [
                              Colors.indigo,
                              Colors.indigoAccent,
                            ],
                          ),
                        ),
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 5,
                        child: Container(
                          padding: const EdgeInsets.only(top: 10, right: 7),
                          alignment: Alignment.topRight,
                          // edit user info button
                          child: IconButton(
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UserSettings(),
                                ),
                              ).then((value) {
                                // reload page
                                _getUser();
                                setState(() {});
                              });
                            },
                          ),
                        ),
                      ),
                      // user name
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 6,
                        padding: const EdgeInsets.only(top: 75),
                        child: Text(
                          name ?? 'Name Not Added',
                          style: GoogleFonts.lato(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Text(specialization == null ? '' : '($specialization)'),
                    ],
                  ),

                  // user image
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.teal.shade50,
                          width: 5,
                        ),
                        shape: BoxShape.circle),
                    child: InkWell(
                      onTap: () {
                        _showSelectionDialog(context);
                      },
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(image),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              // user basic info
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                padding: const EdgeInsets.only(left: 20),
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 7,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey[50],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // user email
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 27,
                            width: 27,
                            color: Colors.red[900],
                            child: const Icon(
                              Icons.mail_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          user.email ?? 'Email Not Added',
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // user phone number
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 27,
                            width: 27,
                            color: Colors.blue[800],
                            child: const Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          phone ?? 'Not Added',
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // user bio
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                padding: const EdgeInsets.only(left: 20, top: 20),
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 7,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey[50],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 27,
                            width: 27,
                            color: Colors.indigo[600],
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Bio',
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    // bio
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 10, left: 40),
                      child: Text(
                        bio ?? 'Not Added',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black38,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // Appointment history
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                padding: const EdgeInsets.only(left: 20, top: 20),
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey[50],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 27,
                            width: 27,
                            color: Colors.green[900],
                            child: const Icon(
                              Icons.history,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Appointment History",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 10),
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: 30,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const AppointmentHistoryList()));
                                },
                                child: const Text('View all'),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: Container(
                          padding: const EdgeInsets.only(right: 15),
                          child: const AppointmentHistoryList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // for picking image from device
  Future selectOrTakePhoto(ImageSource imageSource) async {
    XFile? file =
    await ImagePicker().pickImage(source: imageSource, imageQuality: 12);

    if (file != null) {
      var im = await file.readAsBytes();
      // upload image to cloud
      await uploadFile(im, file.name);
      return;
    }

    print('No photo was selected or taken');
  }

  // dialog for option of take photo from
  Future _showSelectionDialog(BuildContext conntext) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select photo'),
          children: <Widget>[
            SimpleDialogOption(
              child: const Text('From gallery'),
              onPressed: () {
                selectOrTakePhoto(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: const Text('Take a photo'),
              onPressed: () {
                selectOrTakePhoto(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }




  Future uploadFile(Uint8List imgBytes, String fileName) async {
    const cloudName = 'dik3t7jpt';
    const uploadPreset = 'docfusion';

    final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload");

    try {
      final request = http.MultipartRequest('POST', url);

      request.fields['upload_preset'] =
          uploadPreset;


      request.files.add(http.MultipartFile.fromBytes(
        'file',
        imgBytes,
        filename: fileName,
      ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        final data = json.decode(res.body);
        final imageUrl = data['secure_url'];

        print("Uploaded to Cloudinary: $imageUrl");

        setState(() {
          image = imageUrl;
        });

        // Save to Firestore
        await FirebaseFirestore.instance
            .collection(isDoctor ? 'doctor' : 'patient')
            .doc(user.uid)
            .set({'profilePhoto': imageUrl}, SetOptions(merge: true));

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({'profilePhoto': imageUrl}, SetOptions(merge: true));
      } else {
        print("Failed to upload to Cloudinary: ${response.statusCode}");
      }
    } catch (e) {
      print("Cloudinary Upload Error: $e");
    }
  }
}


  // upload image
//   Future uploadFile(Uint8List img, String fileName) async {
//     final destination = 'dp/${user.displayName}-$fileName';
//     try {
//       final ref = storage.ref(destination);
//
//       UploadTask uploadTask = ref.putData(img);
//       TaskSnapshot snapshot = await uploadTask;
//
//       String downloadUrl = await snapshot.ref.getDownloadURL();
//       print('image url : $downloadUrl');
//
//       setState(() {
//         image = Uri.decodeFull(downloadUrl.toString());
//       });
//       FirebaseFirestore.instance
//           .collection(isDoctor ? 'doctor' : 'patient')
//           .doc(user.uid)
//           .set({
//         'profilePhoto': downloadUrl,
//       }, SetOptions(merge: true));
//
//       // main user data
//       FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//         'profilePhoto': downloadUrl,
//       }, SetOptions(merge: true));
//
//       print("uploaded !!!");
//     } catch (e) {
//       print(e.toString());
//       print('error occured');
//     }
//   }
// }
