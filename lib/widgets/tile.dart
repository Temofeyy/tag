import 'package:flutter/material.dart';

import '../enums/direction.dart';
import '../models/position.dart';

class TileWidget extends StatefulWidget {

  final int number;
  final Position position;
  final void Function(Direction) onMove;

  const TileWidget({
    super.key,
    required this.number,
    required this.position,
    required this.onMove,
  });

  static Widget empty(){
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.limeAccent,
      ),
    );
  }

  @override
  State<TileWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> {
  late Position position = widget.position;

  void onDragEnd(DragEndDetails details) {
    final vel = details.velocity.pixelsPerSecond;
    if(vel == Offset.zero) return;
    late Direction direction;
    if(vel.dx > 0){
      direction = Direction.right;
    } else if(vel.dx < 0){
      direction = Direction.left;
    }
    if(vel.dy > 0){
      direction = Direction.down;
    } else if(vel.dy < 0){
      direction = Direction.up;
    }
    widget.onMove(direction);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: onDragEnd,
      onHorizontalDragEnd: onDragEnd,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.lightGreenAccent,
          border: Border.all(width: 3),
        ),
        child: Center(
          child: Text('${widget.number}'),
        ),
      ),
    );
  }
}
