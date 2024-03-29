// ignore_for_file: unused_local_variable

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flashcards/Modals/providerManager.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flashcards/Widgets/addDrawing.dart';
import 'package:flashcards/database/VocabDatabase.dart';
import 'package:flashcards/main.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class write extends StatefulWidget {
  bool? editxyz;
  String? termxyz;
  String? definationxyz;
  String? examplexyz;
  VocabCardModal? vocabCard;
  String? currentSet; //TODO PROBABLY REQUIRED

  write({
    this.editxyz,
    this.termxyz,
    this.definationxyz,
    this.examplexyz,
    this.vocabCard,
    this.currentSet,
    Key? key,
  }) : super(key: key);

  @override
  _writeState createState() => _writeState();
}

class _writeState extends State<write> {
  void initState() {
    // termxy = widget.termxyz;
    if (widget.termxyz != null) {
      termController.text = widget.termxyz!;
      definationController.text = widget.definationxyz!;
      if (widget.examplexyz != null) {
        HIDDEN = true;
        exampleController.text = widget.examplexyz!;
      }
    }
    // currentSet = widget.currentSet;
    super.initState();
  }

  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  // String? currentSet;
  final node1 = FocusNode();
  bool HIDDEN = false;
  String? term;
  String? definition;
  String? example;
  String? url;
  TextEditingController termController = TextEditingController();
  TextEditingController definationController = TextEditingController();
  TextEditingController exampleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.primary;
    Color iconColor = Theme.of(context).iconTheme.color!;
    Uint8List? pic =
        Provider.of<pictureBLOBControl>(context, listen: false).uint8list;
    return WillPopScope(
      onWillPop: () async {
        context.read<pictureBLOBControl>().makeIZero();
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.clear_sharp)),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.help_outline_rounded)),
            IconButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    submitTitle(
                      context,
                      termController.text,
                      definationController.text,
                      widget.currentSet,
                      exampleControl: exampleController.text,
                      pictureControl: pic,
                      editxy: widget.editxyz,
                      ttl: widget.vocabCard,
                    );
                    HIDDEN = false;
                    context.read<pictureBLOBControl>().makeIZero();
                    setState(() {});
                    FocusScope.of(context).requestFocus(node1);
                    termController.clear();
                    definationController.clear();
                    exampleController.clear();
                  }
                },
                icon: Icon(Icons.check_outlined))
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        TextFormField(
                          focusNode: node1,
                          style: TextStyle(color: textColor),
                          validator: (val) => val!.isNotEmpty
                              ? null
                              : 'Term Should Not Be Empty',
                          controller: termController,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                              labelText: "TERM",
                              labelStyle: TextStyle(color: textColor),
                              hintText: "TERM",
                              hintStyle: TextStyle(color: textColor),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                        ),
                        SizedBox(height: 35),
                        TextFormField(
                          style: TextStyle(color: textColor),
                          validator: (val) => val!.isNotEmpty
                              ? null
                              : 'Defination Should Not Be Empty',
                          controller: definationController,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                              labelText: "DEFINITION",
                              labelStyle: TextStyle(color: textColor),
                              hintText: "DEFINITION",
                              hintStyle: TextStyle(color: textColor),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                        ),
                        ListTile(
                          leading: IconButton(
                              onPressed: () {
                                showBottomSheet();
                              },
                              icon: Icon(Icons.photo_rounded, color: iconColor),
                              iconSize: 35),
                        ),
                        pic == null
                            ? Text("Image")
                            : Image.memory(
                                pic,
                                height: 200,
                                width: 200,
                              ),
                        // )
                        Text("Tag",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            )),
                        ListTile(
                          title: Row(
                            children: [
                              Text("Advanced",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: textColor)),
                              Switch(
                                  value: HIDDEN,
                                  onChanged: (changed) {
                                    setState(() {
                                      HIDDEN = changed;
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: HIDDEN,
                      child: Column(
                        children: [
                          ListTile(
                            title: TextFormField(
                              style: TextStyle(color: textColor),
                              controller: exampleController,
                              textInputAction: TextInputAction.done,
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: (value) {
                                // example = value;
                              },
                              decoration: InputDecoration(
                                  labelText: "Examples",
                                  labelStyle: TextStyle(color: textColor),
                                  hintText: "Examples",
                                  hintStyle: TextStyle(color: textColor),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)))),
                            ),
                          ),
                          ListTile(
                              title: TextField(
                                style: TextStyle(color: textColor),
                                decoration: InputDecoration(
                                    labelText: "URL",
                                    labelStyle: TextStyle(color: textColor),
                                    hintText: "URL",
                                    hintStyle: TextStyle(color: textColor),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)))),
                              ),
                              trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.account_balance_rounded,
                                      color: iconColor))),
                        ],
                      ),
                    ),
                    FloatingActionButton.extended(
                      label: Text('ADD NEXT CARD'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          submitTitle(
                            context,
                            termController.text,
                            definationController.text,
                            widget.currentSet,
                            exampleControl: exampleController.text,
                            pictureControl: pic,
                            editxy: widget.editxyz,
                            ttl: widget.vocabCard,
                          );
                          context.read<pictureBLOBControl>().makeIZero();
                          HIDDEN = false;
                          setState(() {});
                          FocusScope.of(context).requestFocus(node1);
                          termController.clear();
                          definationController.clear();
                          exampleController.clear();
                        }

                        // await users.add({
                        //   'name': '$term',
                        //   'age': '$definition',
                        //   'Notes': '$example'
                        // }));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheet() {
    void pickImageFromGallery(ImageSource imageSource) {
      ImagePicker()
          .pickImage(source: imageSource)
          .then((XFilefromImagepicker) async {
        File? croppedFile = await ImageCropper.cropImage(
            sourcePath: XFilefromImagepicker!.path,
            aspectRatio: CropAspectRatio(ratioX: 829, ratioY: 985),
            maxWidth: 512,
            maxHeight: 512,
            compressQuality: 50);
        if (croppedFile != null) {
          Uint8List? uint8list = croppedFile.readAsBytesSync();
          context.read<pictureBLOBControl>().sendPictureUint8List(uint8list);
          print('UINT8 IS $uint8list');
        }
      });
    }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          Color textColor = Theme.of(context).colorScheme.primary;
          Color iconColor = Theme.of(context).iconTheme.color!;

          return Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
                leading: Icon(Icons.share, color: iconColor),
                title: Text(
                  'Add drawing',
                  style: TextStyle(color: textColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  addDrawing(context);
                }),
            ListTile(
                leading: Icon(Icons.photo, color: iconColor),
                title: Text(
                  'Select from gallery',
                  style: TextStyle(color: textColor),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  //TODO GALLERY PERMISSIONS
                  var status = await Permission.storage.request();
                  if (status.isDenied) {
                    SnackBar(content: Text('Gallery Access Denied'));
                  } else if (status.isGranted) {
                    pickImageFromGallery(ImageSource.gallery);
                  }
                }),
            ListTile(
                leading: Icon(Icons.camera_alt, color: iconColor),
                title: Text(
                  'Take photo',
                  style: TextStyle(color: textColor),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  var status = await Permission.camera.request();
                  if (status.isDenied) {
                    SnackBar(content: Text('Camera Access Denied'));
                  } else if (status.isGranted) {
                    pickImageFromGallery(ImageSource.camera);
                  }
                }),
            ListTile(
                leading: Icon(Icons.delete, color: iconColor),
                title: Text(
                  'Clear image',
                  style: TextStyle(color: textColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                })
          ]);
        });
  }
}

submitTitle(context, termControl, definationControl, currentSetControl,
    {exampleControl, pictureControl, bool? editxy, VocabCardModal? ttl}) {
  final VocabDatabase vocabDatabase = VocabDatabase();
  // title? TTitle;
  if (editxy == null) {
    VocabCardModal ttl = VocabCardModal(
        term: termControl,
        defination: definationControl,
        example: exampleControl,
        current_set: currentSetControl,
        picture: pictureControl);
    vocabDatabase.insertVocabCards(ttl).then((value) => null);
  } else {
    ttl!.term = termControl;
    ttl.defination = definationControl;
    ttl.example = exampleControl;
    vocabDatabase.updateTitle(ttl).then((value) => null);
  }
}
