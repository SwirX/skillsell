import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({super.key, required this.image});

  final String image;

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

var initScale = PhotoViewComputedScale.contained;
var maxScale = PhotoViewComputedScale.covered * 2.5;
var minScale = PhotoViewComputedScale.contained * 0.5;

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    String img = widget.image;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: PhotoView.customChild(
        enableRotation: false,
        heroAttributes: PhotoViewHeroAttributes(tag: img),
        minScale: minScale,
        maxScale: maxScale,
        initialScale: initScale,
        child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              img,
              width: double.maxFinite,
              height: double.maxFinite,
            )),
      )),
    );
  }
}
