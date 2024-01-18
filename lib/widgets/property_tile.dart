import 'package:SkillSell/models/property.dart';
import 'package:SkillSell/pages/info/property_info_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';

class PropertyTile extends StatefulWidget {
  const PropertyTile({super.key, required this.property});

  final Property property;

  @override
  State<PropertyTile> createState() => _PropertyTileState();
}

class _PropertyTileState extends State<PropertyTile> {
  @override
  Widget build(BuildContext context) {
    Property p = widget.property;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            barrierDismissible: true,
            fullscreenDialog: true,
            builder: (context) {
              return PropertyInfoPage(
                prop: p,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: ShapeDecoration(
            color: const Color(0xFF454545),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(8.0),
                  child: ImageFade(
                    fit: BoxFit.fill,
                    width: 150,
                    height: 150 / (16 / 10),
                    image: NetworkImage(p.images[0]),
                    duration: const Duration(milliseconds: 100),
                    placeholder: Container(
                      color: const Color(0xFFCFCDCA),
                      alignment: Alignment.center,
                      child: const Icon(Icons.photo, color: Colors.white30),
                    ),
                    loadingBuilder: (context, progress, chunkEvent) => Center(
                        child: CircularProgressIndicator(value: progress)),
                    errorBuilder: (context, error) => Container(
                      color: const Color(0xFF6F6D6A),
                      alignment: Alignment.center,
                      child: const Icon(Icons.warning, color: Colors.black26),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                p.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              Text(
                p.owner,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "${p.price}dh/m²",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: p.status != "bought"
                        ? const Color(0xFF30AA50)
                        : const Color(0xFFE45252),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
