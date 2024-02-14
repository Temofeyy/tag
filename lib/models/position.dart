import 'package:flutter/material.dart';

class Position{
  int x;
  int y;
  Position(this.x, this.y);

  Position withOffset(Offset offset){
    return Position(x + offset.dx.toInt(), y + offset.dy.toInt());
  }

  @override
  String toString() {
    return 'Position{x: $x, y: $y}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Position &&
              runtimeType == other.runtimeType &&
              x == other.x &&
              y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
