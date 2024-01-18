import 'package:SkillSell/auth.dart';
import 'package:SkillSell/db.dart';
import 'package:SkillSell/models/property.dart';
import 'package:SkillSell/pages/add/add_new_prop.dart';
import 'package:SkillSell/widgets/navbar.dart';
import 'package:SkillSell/widgets/property_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Auth().authStateChanges.listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  void openPanel() {
    _panelController.open();
  }

  final _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddPropertyPanel(
        controller: _panelController,
        body: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'SkillSell',
              style: TextStyle(
                color: Color(0xff3050aa),
                fontSize: 32,
              ),
            ),
            // actions: [
            //   IconButton(
            //     onPressed: () {},
            //     icon: const Icon(
            //       CupertinoIcons.search,
            //       color: Color(0xff353535),
            //     ),
            //   ),
            // ],
          ),
          bottomNavigationBar: NavBarWidget(
            controller: _panelController,
          ),
          body: Stack(children: [
            StreamBuilder(
              stream: firestoreDB().getProperties(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong\n${snapshot.error}');
                } else if (snapshot.data == null ||
                    snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No Properties found"));
                } else {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var property =
                          propConvert(snapshot.data!.docs[index].data());
                      return PropertyTile(property: property);
                    },
                  );
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
