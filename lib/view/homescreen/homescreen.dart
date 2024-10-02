import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_firebase/view/Loginscreen/loginscreen.dart';
import 'package:image_picker/image_picker.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String? url;
  XFile? pickimageFile;
  var employeeDb = FirebaseFirestore.instance.collection("Employees");
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller1 = TextEditingController();
    final TextEditingController controller2 = TextEditingController();
    final _formkey = GlobalKey<FormState>();
    // bottomsheet function
    void _showModalBottomSheet(BuildContext context,
        {bool isedit = false, var docid}) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) => Padding(
                    padding: EdgeInsets.all(10),
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () async {
                                pickimageFile = await ImagePicker()
                                    .pickImage(source: ImageSource.camera);
                                setState(() {});
                                if (pickimageFile != null) {
                                  final storageRef = FirebaseStorage.instance
                                      .ref(); // careate fire storage object

                                  Reference? folderRefferance = storageRef.child(
                                      "imagepathe.jpg"); // create folder to store image
                                  await folderRefferance.putFile(File(
                                      pickimageFile!
                                          .path)); // store image in fire base

                                  url = await folderRefferance
                                      .getDownloadURL(); // getting downlode url
                                  log(url!);
                                }
                              },
                              child: CircleAvatar(
                                  radius: 100,
                                  backgroundImage: pickimageFile != null
                                      ? FileImage(File(pickimageFile!.path))
                                      : null),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value != null && value.isNotEmpty) {
                                  return null;
                                } else {
                                  return "must fill";
                                }
                              },
                              controller: controller1,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Employee Name'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value != null && value.isNotEmpty) {
                                  return null;
                                } else {
                                  return "must fill";
                                }
                              },
                              controller: controller2,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Designation'),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                // Handle the button press here
                                // final value1 = controller1.text;
                                // final value2 = controller2.text;
                                // print('Field 1: $value1, Field 2: $value2');
                                Navigator.pop(context);
                                if (isedit) {
                                  await employeeDb.doc(docid).set({
                                    "name": controller1.text,
                                    "des": controller2.text,
                                    "url": url
                                  });
                                } else {
                                  if (_formkey.currentState!.validate()) {
                                    await employeeDb.add({
                                      "name": controller1.text,
                                      "des": controller2.text,
                                      "url": url
                                    });
                                  }
                                }
                              },
                              child: Text(isedit ? "edit" : 'Add'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
        },
      );
    }

    Future<void> _deleteEmployee(String docId) async {
      await employeeDb.doc(docId).delete();
    }

    Set();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModalBottomSheet(context);
        },
      ),
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: employeeDb.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  String docId = document.id; // Get document ID
                  return Card(
                    color: Colors.grey,
                    child: ListTile(
                      title: Text(
                        data['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Text(
                        data['des'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      trailing: IconButton(
                          onPressed: () async {
                            await _deleteEmployee(docId);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.black,
                          )),
                      // leading: IconButton(
                      //     onPressed: () {
                      //       _showModalBottomSheet(context,
                      //           isedit: true, docid: docId);
                      //     },
                      //     icon: Icon(Icons.edit)),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data["url"]),
                      ),
                    ),
                  );
                })
                .toList()
                .cast(),
          );
        },
      ),
    );
  }
}
