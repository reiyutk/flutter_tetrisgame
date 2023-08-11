import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  var color;
  Pixel({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    // 正方形を表示する
    return Container(
      // 正方形に色をつける
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      // 正方形の周りに余白をつける
      margin: EdgeInsets.all(1),
    );
  }
}
