import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CustomColumn extends MultiChildRenderObjectWidget {
  CustomColumn({
    Key? key,
    List<Widget> children = const [],
  }) : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomColumn();
  }
}

class CustomColumnParentData extends ContainerBoxParentData<RenderBox> {
  int? flex;
}

class RenderCustomColumn extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, CustomColumnParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, CustomColumnParentData> {
  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! CustomColumnParentData) {
      child.parentData = CustomColumnParentData();
    }
  }

  Size _performLayout(BoxConstraints constraints, bool dry) {
    // Get the total height of the widget
    double height = 0, width = 0;

    // Get the first child
    RenderBox? child = firstChild;
    while (child != null) {
      // Get the childs parent data to get the siblings
      final childParentData = child.parentData as CustomColumnParentData;
      late final Size childSize;

      if (dry) {
        childSize = child.computeDryLayout(BoxConstraints(maxWidth: constraints.maxWidth));
      } else {
        child.layout(
          BoxConstraints(maxWidth: constraints.maxWidth),
          parentUsesSize: true,
        );
        childSize = child.size;
      }

      height += childSize.height;
      width = max(width, childSize.width);

      child = childParentData.nextSibling;
    }

    return Size(width, height);
  }

  @override
  void performLayout() {
    (parentData as BoxParentData).offset = const Offset(300, 300);

    size = _performLayout(constraints, false);

    RenderBox? child = firstChild;
    var childOffset = Offset.zero;

    while (child != null) {
      // Get the childs parent data to get the siblings
      final childParentData = child.parentData as CustomColumnParentData;

      //Use the former offset y axis as the new offset y child y axis
      childParentData.offset = Offset(100, childOffset.dy);
      childOffset += Offset(0, child.size.height);

      child = childParentData.nextSibling;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;

    while (child != null) {
      final CustomColumnParentData childParentData = child.parentData! as CustomColumnParentData;
      context.paintChild(child, childParentData.offset + offset);
      child = childParentData.nextSibling;
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _performLayout(constraints, true);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}
