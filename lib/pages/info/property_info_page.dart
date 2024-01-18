import 'dart:async';

import 'package:SkillSell/auth.dart';
import 'package:SkillSell/models/property.dart';
import 'package:SkillSell/pages/view/image_viewer.dart';
import 'package:carousel_images/carousel_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PropertyInfoPage extends StatefulWidget {
  const PropertyInfoPage({super.key, required this.prop});

  final Property prop;

  @override
  State<PropertyInfoPage> createState() => _PropertyInfoPageState();
}

Timer? timer;
Timer? initTimer;
bool isAdmin = false;

class _PropertyInfoPageState extends State<PropertyInfoPage> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      initTimer = Timer(Duration.zero, () async {
        var tempValue = await Auth().isAdmin;
        setState(() {
          isAdmin = tempValue;
        });
      });
    }

    final prop = widget.prop;

    void call() async {
      final url = "tel://${prop.phone}";
      try {
        launchUrlString(url);
      } catch (e) {
        print(e);
        rethrow;
      }
    }

    void sendmail() async {
      final url = "email://${prop.email}";
      try {
        launchUrlString(url);
      } catch (e) {
        print(e);
        rethrow;
      }
    }

    void openmap() async {
      try {
        MapsLauncher.launchQuery(prop.address);
      } catch (e) {
        print(e);
        rethrow;
      }
    }

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy > 10) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: AlignmentDirectional.center,
                child: CarouselImages(
                  scaleFactor: 1,
                  listImages: prop.images,
                  height: 300.0,
                  borderRadius: 30.0,
                  cachedNetworkImage: true,
                  verticalAlignment: Alignment.center,
                  onTap: (index) {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        barrierDismissible: true,
                        fullscreenDialog: true,
                        builder: (context) {
                          return ImageViewer(
                            image: prop.images[index],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(18, 26, 0, 8),
                child: Text(
                  prop.title,
                  style: const TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 36,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 16, top: 16),
                child: Text(
                  prop.category,
                  style: const TextStyle(
                    color: Color(0xFF606060),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 16, top: 16),
                child: Text(
                  prop.owner,
                  style: const TextStyle(
                    color: Color(0xFF808080),
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 16, top: 16),
                child: Text(
                  "${prop.price}dh/m²",
                  style: const TextStyle(
                    color: Color(0xFF606060),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 16, top: 16),
                child: Text(
                  prop.description,
                  style: const TextStyle(
                    color: Color(0xFF606060),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.375,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: call,
                    icon: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff35aa65),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10.0,
                            offset: const Offset(0, 10),
                            spreadRadius: 5.0,
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          CupertinoIcons.phone,
                          color: Color(0xffcdcdcd),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: openmap,
                    icon: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff3560cd),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10.0,
                            offset: const Offset(0, 10),
                            spreadRadius: 5.0,
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child:
                            Icon(CupertinoIcons.map, color: Color(0xffcdcdcd)),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffcd3065),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10.0,
                            offset: const Offset(0, 10),
                            spreadRadius: 5.0,
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          CupertinoIcons.heart,
                          color: Color(0xffcdcdcd),
                        ),
                      ),
                    ),
                  ),
                  if (isAdmin)
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff404040),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 10.0,
                              offset: const Offset(0, 10),
                              spreadRadius: 5.0,
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            CupertinoIcons.pencil,
                            color: Color(0xffcdcdcd),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer!.cancel();
    initTimer!.cancel();
    super.dispose();
  }
}
