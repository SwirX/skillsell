import 'dart:async';
import 'dart:io';

import 'package:SkillSell/db.dart';
import 'package:SkillSell/models/property.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:image_picker/image_picker.dart';

class AddPropertyPanel extends StatefulWidget {
  const AddPropertyPanel(
      {super.key, required this.controller, required this.body});

  final PanelController controller;
  final Widget body;

  @override
  State<AddPropertyPanel> createState() => _AddPropertyPanelState();
}

class _AddPropertyPanelState extends State<AddPropertyPanel> {
  Timer? initTimer;
  Location location = Location();
  ScrollController controller = ScrollController();
  TextEditingController titleCrtl = TextEditingController();
  TextEditingController ownerCrtl = TextEditingController();
  TextEditingController ownerNumCrtl = TextEditingController();
  TextEditingController ownermailCrtl = TextEditingController();
  TextEditingController dealerCrtl = TextEditingController();
  TextEditingController dealerNumCrtl = TextEditingController();
  TextEditingController dealerMailCrtl = TextEditingController();
  TextEditingController typeCrtl = TextEditingController();
  TextEditingController priceCrtl = TextEditingController();
  TextEditingController areaCrtl = TextEditingController();
  TextEditingController descCrtl = TextEditingController();
  TextEditingController locationCrtl = TextEditingController();
  List<String> uploadedImagesString = [];
  List<File> uploadedImagesFiles = [];

  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  // ignore: unused_field
  LocationData? _locationData;

  @override
  void initState() {
    super.initState();
    initTimer = Timer(Duration.zero, () async {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _pickImage(ImageSource source) async {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        // imageQuality: 5,
      );

      setState(() {
        uploadedImagesFiles.add(File(pickedFile!.path));
        uploadedImagesString.add(pickedFile.path);
      });
    }

    void _showImageSourceActionSheet(BuildContext context) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: const Text('Choose picture'),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context); // Close the action sheet
                  _pickImage(ImageSource.camera); // Open camera
                },
                child: const Text(
                  'Camera',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context); // Close the action sheet
                  _pickImage(ImageSource.gallery); // Open gallery
                },
                child: const Text(
                  'Gallery',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context); // Close the action sheet
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          );
        },
      );
    }

    return SlidingUpPanel(
      backdropEnabled: true,
      margin: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      color: const Color(0xffcbcbcb),
      borderRadius: BorderRadius.circular(16),
      minHeight: 0,
      maxHeight: MediaQuery.of(context).size.height * 0.9,
      body: widget.body,
      controller: widget.controller,
      parallaxEnabled: true,
      panel: ListView(
        controller: controller,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 16),
            child: Container(
              height: 10,
              width: 50,
              decoration: BoxDecoration(
                color: const Color(0xff606060),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          const Text(
            'Add property',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xff404040),
              fontFamily: 'Lexend',
            ),
            textAlign: TextAlign.center,
            softWrap: true,
            maxLines: 2,
          ),
          TextFormField(
            controller: titleCrtl,
            decoration: const InputDecoration(
              labelText: 'Property Title',
            ),
          ),
          TextFormField(
            controller: ownerCrtl,
            decoration: const InputDecoration(
              labelText: 'Property Owner',
            ),
          ),
          TextFormField(
            controller: ownerNumCrtl,
            decoration: const InputDecoration(
              labelText: 'Property Owner\'s number',
            ),
          ),
          TextFormField(
            controller: ownermailCrtl,
            decoration: const InputDecoration(
              labelText: 'Property Owner\'s email',
            ),
          ),
          TextFormField(
            controller: dealerCrtl,
            decoration: const InputDecoration(
              labelText: 'Property Dealer',
            ),
          ),
          TextFormField(
            controller: dealerNumCrtl,
            decoration: const InputDecoration(
              labelText: 'Property Dealer\'s number',
            ),
          ),
          TextFormField(
            controller: dealerMailCrtl,
            decoration: const InputDecoration(
              labelText: 'Property Dealer\'s email',
            ),
          ),
          TextFormField(
            controller: typeCrtl,
            decoration: const InputDecoration(
              labelText: 'Property Type',
            ),
          ),
          TextFormField(
            controller: priceCrtl,
            decoration: const InputDecoration(
              labelText: 'Property Price',
            ),
          ),
          TextFormField(
            controller: areaCrtl,
            decoration: const InputDecoration(
              labelText: 'Property Area',
            ),
          ),
          TextFormField(
            controller: descCrtl,
            decoration: const InputDecoration(
              labelText: 'Property Description',
            ),
            maxLines: 3,
          ),
          TextFormField(
            controller: locationCrtl,
            decoration: const InputDecoration(
              labelText: 'Property location',
            ),
          ),
          TextButton(
            onPressed: () async {
              var loc = await location.getLocation();
              setState(() {
                _locationData = loc;
              });
              locationCrtl.text = "pos(${loc.latitude},${loc.longitude})";
            },
            child: const Text("Set to current location"),
          ),
          TextButton(
            onPressed: () {
              _showImageSourceActionSheet(context);
            },
            child: const Text("Add Pictures"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () async {
                String title = titleCrtl.text;
                String owner = ownerCrtl.text;
                String ownerNum = ownerNumCrtl.text;
                String ownerMail = ownermailCrtl.text;
                String dealer = dealerCrtl.text;
                String dealerNum = dealerNumCrtl.text;
                String dealerMail = dealerMailCrtl.text;
                String type = typeCrtl.text;
                int price =
                    priceCrtl.text.isEmpty ? 0 : int.parse(priceCrtl.text);
                int area = areaCrtl.text.isEmpty ? 0 : int.parse(areaCrtl.text);
                String desc = descCrtl.text;
                String location = locationCrtl.text;
                if (title.isEmpty ||
                    owner.isEmpty ||
                    ownerNum.isEmpty ||
                    dealer.isEmpty ||
                    dealerNum.isEmpty ||
                    type.isEmpty ||
                    desc.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text('Error'),
                        content: Text('Please fill all fields'),
                      );
                    },
                  );
                  return;
                }
                if (ownerMail.isNotEmpty && ownerMail.contains('@') == false) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text('Error'),
                        content: Text('Please enter a valid email'),
                      );
                    },
                  );
                  return;
                }
                if (dealerMail.isNotEmpty &&
                    dealerMail.contains('@') == false) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text('Error'),
                        content: Text('Please enter a valid email'),
                      );
                    },
                  );
                  return;
                }
                if (price < 0) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text('Error'),
                        content: Text('Please enter a valid price'),
                      );
                    },
                  );
                  return;
                }
                if (price < 0) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text('Error'),
                        content: Text('Please enter a valid area'),
                      );
                    },
                  );
                  return;
                }
                Property prop = Property(
                    "",
                    title,
                    desc,
                    location,
                    price,
                    uploadedImagesString,
                    type,
                    owner,
                    ownerMail,
                    ownerNum,
                    "available",
                    area,
                    dealer,
                    dealerNum,
                    dealerMail);
                firestoreDB().createProperty(prop);
              },
              child: const Text(
                "Create",
                style: TextStyle(color: Color(0xff555555)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
