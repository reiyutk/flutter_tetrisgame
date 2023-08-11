import 'package:flutter/material.dart';
import 'package:flutter_tetris/board.dart';
import 'package:flutter_tetris/values.dart';

// テトリミノのピースクラス
class Piece {
  // テトリミノのタイプ
  Tetromino type;

  Piece({required this.type});

  // 数値リスト
  List<int> position = [];

  // ピースに色をつける
  Color get color {
    return tetrominoColors[type] ?? const Color(0xFFFFFFFF);
  }

  // 数値作成
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
      default:
    }
  }

  // ピースを移動する
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  // 回転
  int rotationState = 1;
  void rotatePiece() {
    // 新しい位置
    List<int> newPosition = [];

    // 回転パターン
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            /*
                O
                O
              O O
            */
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*
              O
              O O O
            */
            newPosition = [
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*
              O O
              O 
              O
            */
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*
              O O O
                  O
            */
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLength + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            /*
              O O O O
            */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*
              O 
              O 
              O 
              O
            */
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*
              O O O O
            */
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*
              O 
              O 
              O 
              O
            */
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.O:
        /*
          O O 
          O O
        */
        break;
      case Tetromino.S:
        switch (rotationState) {
          case 0:
            /*
                O O 
              O O
            */
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*
              O 
              O O 
                O
            */
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*
                O O 
              O O
            */
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*
                O 
                O O
                  O
            */
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            /*
              O O 
                O O
            */
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*
                O 
              O O
              O
            */
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*
              O O 
                O O
            */
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*
                O 
              O O 
              O
            */
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            /*
              O 
              O O 
              O
            */
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            /*
              O O O 
                O
            */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            /*
                O 
              O O 
                O
            */
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            /*
                O 
              O O O
            */
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              // 位置を更新
              position = newPosition;
              // 回転状態を更新
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      default:
    }
  }

  // 位置判定
  bool positionIsValid(int position) {
    // 行と列の位置を取得
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  // ピースの位置判定
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      if (!positionIsValid(pos)) {
        return false;
      }

      int col = pos % rowLength;

      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }

    return !(firstColOccupied && lastColOccupied);
  }
}
