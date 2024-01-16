import 'package:SkillSell/models/property.dart';
import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 160.87,
        height: 200,
        decoration: ShapeDecoration(
          color: const Color(0xFF454545),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 145.22,
                height: 106.09,
                decoration: ShapeDecoration(
                  color: const Color(0xFF656565),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                ),
              ),
            ),
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
            SizedBox(
              width: 138.26,
              height: 20,
              child: Text(
                p.owner,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              width: 138.26,
              height: 20,
              child: Text(
                p.price.toString(),
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
            ),
          ],
        ),
      ),
    );
  }
}
