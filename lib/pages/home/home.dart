import 'dart:math';

import 'package:SkillSell/db.dart';
import 'package:SkillSell/models/property.dart';
import 'package:SkillSell/widgets/property_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          TextButton(
              onPressed: () {
                var p = Property(
                  "",
                  "Test-title_${Random().nextInt(1000)}",
                  "a description",
                  "_address",
                  8000,
                  ["_image"],
                  "Villa",
                  "Ali Bouyakhsass",
                  "bouyakhsassali24@gmail.com",
                  "0707240570",
                  "_status",
                  80.0,
                  "Alae",
                  "060000000",
                  "",
                );
                firestoreDB().createProperty(p);
              },
              child: const Text("Generate test doc")),
        ],
      ),
      body: SingleChildScrollView(
          child: StreamBuilder(
        stream: firestoreDB().getProperties(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong\n${snapshot.error}');
          } else if (snapshot.data == null) {
            return const Text("No Properties found");
          } else {
            return Column(
              children: [
                for (var property in snapshot.data!.docs)
                  PropertyTile(property: propConvert(property.data()))
              ],
            );
          }
        },
      )),
    );
  }
}
