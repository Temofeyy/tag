import 'package:flutter/material.dart';

enum Direction{
  up(Offset(0, -1)),
  down(Offset(0, 1)),
  left(Offset(-1, 0)),
  right(Offset(1, 0));

  final Offset offset;
  const Direction(this.offset);
}
