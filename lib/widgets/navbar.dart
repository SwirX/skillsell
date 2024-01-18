import 'dart:async';

import 'package:SkillSell/auth.dart';
import 'package:SkillSell/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({super.key, this.controller});

  final PanelController? controller;

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  bool visible = true;
  Timer? timer;
  Timer? initTimer;
  bool isAdmin = false;
  String userPfp = "";

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (widget.controller != null) {
        setState(() {
          visible = widget.controller!.isPanelClosed;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    initTimer = Timer(Duration.zero, () async {
      var tempValue = await Auth().isAdmin;
      var temppfpvalue =
          await firestoreDB().getUserPfp(Auth().currentUser!.uid);
      setState(() {
        isAdmin = tempValue;
        userPfp = temppfpvalue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void openPannel() {
      widget.controller!.open();
    }

    if (visible) {
      return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(96, 0, 96, 16),
        child: Container(
          width: double.minPositive,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xff353535),
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.home,
                  color: Color(0xffcdcdcd),
                ),
              ),
              if (isAdmin)
                IconButton(
                  onPressed: openPannel,
                  icon: const Icon(
                    CupertinoIcons.add,
                    color: Color(0xffcdcdcd),
                  ),
                  tooltip: "Add a new property",
                  style: const ButtonStyle(
                    side: MaterialStatePropertyAll(
                      BorderSide(
                        color: Color(0xff353535),
                      ),
                    ),
                  ),
                ),
              IconButton(
                onPressed: () {},
                icon: ClipOval(
                  clipBehavior: Clip.hardEdge,
                  child: Auth().currentUser!.photoURL != null
                      ? Image.network(
                          Auth().currentUser!.photoURL!,
                        )
                      : ImageFade(
                          image: NetworkImage(userPfp),
                          width: 30,
                          height: 30,
                          duration: const Duration(milliseconds: 100),
                          placeholder: Container(
                            color: const Color(0xFFCFCDCA),
                            alignment: Alignment.center,
                            child:
                                const Icon(Icons.photo, color: Colors.white30),
                          ),
                          loadingBuilder: (context, progress, chunkEvent) =>
                              Center(
                                  child: CircularProgressIndicator(
                                      value: progress)),
                          errorBuilder: (context, error) => Container(
                            color: const Color(0xFF6F6D6A),
                            alignment: Alignment.center,
                            child: const Icon(Icons.warning,
                                color: Colors.black26),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    initTimer!.cancel();
    super.dispose();
  }
}
