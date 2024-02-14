import 'package:flutter/material.dart';

void showCongratulationSnackBar(BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Congratulation You WIN!'),
    ),
  );
}