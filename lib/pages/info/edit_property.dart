import 'package:SkillSell/models/property.dart';
import 'package:carousel_images/carousel_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PropertyInfoPage extends StatefulWidget {
  const PropertyInfoPage({super.key, required this.prop});

  final Property prop;

  @override
  State<PropertyInfoPage> createState() => _PropertyInfoPageState();
}

class _PropertyInfoPageState extends State<PropertyInfoPage> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

    final prop = widget.prop;

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
                    print("image page $index");
                  },
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(18, 26, 0, 8),
                child: TextFormField(
                  initialValue: prop.title,
                  decoration: InputDecoration(
                    hintText: prop.title,
                    hintStyle: const TextStyle(
                      color: Color(0xff808080),
                    ),
                  ),
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
                child: TextFormField(
                  initialValue: prop.category,
                  decoration: InputDecoration(
                    hintText: prop.category,
                    hintStyle: const TextStyle(
                      color: Color(0xff808080),
                    ),
                  ),
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
                child: TextFormField(
                  initialValue: prop.owner,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Color(0xff808080),
                    ),
                    hintText: prop.owner,
                  ),
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
                child: TextFormField(
                  initialValue: "${prop.price}dh/m²",
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Color(0xff808080),
                    ),
                    hintText: "${prop.price}dh/m²",
                  ),
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
                child: TextFormField(
                  initialValue: prop.description,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Color(0xff808080),
                    ),
                    hintText: prop.description,
                  ),
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
          ],
        ),
      ),
    );
  }
}
