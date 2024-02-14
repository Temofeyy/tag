import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'config.dart';
import 'enums/direction.dart';
import 'models/position.dart';
import 'utils/congratulation_stackbar.dart';
import 'widgets/tile.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  static const _fieldSize = Config.fieldSize;
  int get tileCount => _fieldSize * _fieldSize;

  final List<List<int>> _answer = [];
  List<List<int>> field = [];

  Position emptyTilePos = Position(0, 0);

  void generateTiles(){
    final nums = List.generate(tileCount - 1 , (i) => i + 1);
    nums.add(0);
    _answer.addAll(generateAnswer(nums));
    nums.shuffle();
    for(var i = 0; i < tileCount; i+= _fieldSize){
      field.add(nums.getRange(i, i + _fieldSize).toList());
    }
  }

  void replay(){
    field.clear();
    _answer.clear();
    generateTiles();
    setState(() {});
  }

  List<List<int>> generateAnswer(List<int> nums){
    final result = List.generate(_fieldSize, (_) => <int>[]);
    for(var i = 0; i < tileCount; i+= _fieldSize){
      final current = nums.getRange(i, i + _fieldSize).toList();
      for(var j = 0; j < _fieldSize; j++){
        result[j].add(current[j]);
      }
    }
    return result;
  }

  void onTileMove(Direction dir, Position pos){
    final endPoint = pos.withOffset(dir.offset);

    if(endPoint == emptyTilePos){
      final temp = field[pos.x][pos.y];
      field[endPoint.x][endPoint.y] = temp;
      field[pos.x][pos.y] = 0;
      setState(() {});
    }
    unawaited(checkAnswer());
  }

  Future<void> checkAnswer() async {
    if(const DeepCollectionEquality().equals(field, _answer)){
      showCongratulationSnackBar(context);
      await Future.delayed(const Duration(seconds: 3), replay);
    }
  }

  Widget buildTiles(BuildContext _, int index){
    final listNumber = index % _fieldSize;
    final indexInList = index ~/ _fieldSize;
    final numb = field[listNumber][indexInList];

    final pos = Position(listNumber, indexInList);

    if(numb == 0){
      emptyTilePos = pos;
      return TileWidget.empty();
    }
    return TileWidget(
      number: numb,
      position: pos,
      onMove: (dir) => onTileMove(dir, pos),
    );
  }

  @override
  void initState() {
    super.initState();
    generateTiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(160),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _fieldSize,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: buildTiles,
          itemCount: tileCount,
        ),
      ),
    );
  }
}
