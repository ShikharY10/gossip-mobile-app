import 'package:flutter/material.dart';

class ImageZoomExample extends StatefulWidget {
  final ImageProvider imageProvider;

  const ImageZoomExample({Key? key, required this.imageProvider}) : super(key: key);

  @override
  _ImageZoomExampleState createState() => _ImageZoomExampleState();
}

class _ImageZoomExampleState extends State<ImageZoomExample> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _offset = Offset.zero;
  Offset _previousOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Zoom Example')),
      body: GestureDetector(
        onScaleStart: (details) {
          _previousScale = _scale;
          _previousOffset = _offset;
        },
        onScaleUpdate: (details) {
          setState(() {
            _scale = _previousScale * details.scale;
            _offset = Offset(
              _previousOffset.dx + details.focalPoint.dx - _previousOffset.dx - details.focalPoint.dx,
              _previousOffset.dy + details.focalPoint.dy - _previousOffset.dy - details.focalPoint.dy,
            );
          });
        },
        child: Center(
          child: Transform(
            transform: Matrix4.identity()
              ..translate(_offset.dx, _offset.dy)
              ..scale(_scale),
            child: Image(
              image: widget.imageProvider,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ),
      ),
    );
  }
}
