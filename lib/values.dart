// 行の数
import 'package:flutter/material.dart';

int rowLength = 10;
// 列の数
int colLength = 15;

enum Direction {
  left,
  right,
  down,
}

// テトリミノ作成
enum Tetromino {
  L,
  J,
  I,
  O,
  S,
  Z,
  T,

  /*
    O
    O
    O O

      O
      O
    O O

    O
    O
    O
    O

    O O
    O O

      O O
    O O

    O O
      O O

    O O O
      O
      O  
  */
}

const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color(0xFFFFA500),
  Tetromino.J: Color.fromARGB(255, 0, 102, 255),
  Tetromino.I: Color.fromARGB(255, 242, 0, 255),
  Tetromino.O: Color(0xFFFFFF00),
  Tetromino.S: Color(0xFF00B000),
  Tetromino.Z: Color(0xFFFF0000),
  Tetromino.T: Color.fromARGB(255, 144, 0, 255),
};
