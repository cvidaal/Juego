import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class Micanvas extends PositionComponent{
  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(100, 100), 50, BasicPalette.blue.paint());
    super.render(canvas);
  }
}