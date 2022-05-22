import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.green,
          child: const CircleWidget(200),
        ),
      ),
    );
  }
}

// Creates a circle widget with circular hit test
class CircleWidget extends LeafRenderObjectWidget {
  final double size;

  const CircleWidget(this.size, {Key? key}) : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCircleBox(size: size);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderCircleBox renderObject) {
    renderObject.circleSize = size;
  }
}

class RenderCircleBox extends RenderBox {
  RenderCircleBox({
    required double size,
  }) : _circleSize = size;

  double _circleSize;
  double get circleSize => _circleSize;
  set circleSize(double size) {
    if (_circleSize == size) {
      return;
    }

    _circleSize = size;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    size = Size.fromRadius(circleSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    final circlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, circleSize, circleSize),
        circlePaint..color = Colors.white);

    canvas.drawCircle(
        Offset(circleSize / 2, circleSize / 2), circleSize / 2, circlePaint);

    canvas.restore();
  }
}