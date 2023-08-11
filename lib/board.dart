import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tetris/piece.dart';
import 'package:flutter_tetris/pixel.dart';
import 'package:flutter_tetris/values.dart';

/*

GAME BOARD

This is a 2x2 grid with null representing an empty space.
A non empty space will have the color to represent the landed piece s
*/

// ゲームボード作成
List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

// ゲーム画面クラス
class _GameBoardState extends State<GameBoard> {
  // 現在のテトリスピース
  Piece currentPiece = Piece(type: Tetromino.I);

  // 現在のスコア
  int currentScore = 0;

  // ゲームオーバーフラグ
  bool gameOver = false;

  @override
  void initState() {
    super.initState();

    // アプリが起動したらゲームを始める
    startGame();
  }

  // ゲーム開始
  void startGame() {
    // ピースを初期化する
    currentPiece.initializePiece();

    // ゲームループ作成 指定ミリ秒ごと
    Duration frameRate = const Duration(milliseconds: 500);
    gameLoop(frameRate);
  }

  // ゲームループ
  void gameLoop(Duration frameRate) {
    Timer.periodic(
      frameRate,
      (timer) {
        setState(() {
          // クリアライン
          clearLines();
          // 最下層着地判定
          checkLanding();

          // ゲームオーバー
          if (gameOver == true) {
            // タイマーを止める
            timer.cancel();
            // ゲームオーバーダイアログ表示
            showGameOverDialog();
          }
          // ピースが下に落ち続ける
          currentPiece.movePiece(Direction.down);
        });
      },
    );
  }

  // ゲームオーバーダイアログを表示する
  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text('You Score is $currentScore'),
        actions: [
          TextButton(
              onPressed: () {
                // ゲームをリセット
                resetGame();

                Navigator.pop(context);
              },
              child: Text('Play Again')),
        ],
      ),
    );
  }

  // ゲームリセット
  void resetGame() {
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(
        rowLength,
        (j) => null,
      ),
    );

    // フラグ、スコア初期化
    gameOver = false;
    currentScore = 0;

    // ピースを新規作成
    createNewPiece();

    // ゲーム開始
    startGame();
  }

  // 衝突判定
  // return ture -> 衝突発生
  // return false -> 衝突していない
  bool checkCollision(Direction direction) {
    // ピースの現在の位置を判定する
    for (int i = 0; i < currentPiece.position.length; i++) {
      // 現在の行と列の位置を計算する
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      // 行と列の調整
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // ピースが画面外にでているか判定する
      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      }
    }
    // 衝突がなければfalse
    return false;
  }

  // 最下層位置を判定する
  void checkLanding() {
    // ピースが 最下層または他のピースに衝突したら
    if (checkCollision(Direction.down) || checkLanded()) {
      // ゲーム画面の最下層位置
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      // ピースを新規作成
      createNewPiece();
    }
  }

  // 他のピースとの衝突チェック
  bool checkLanded() {
    // 現在のピースの位置をループ
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      // ピースが移動するセルに既にピースが存在しているか？
      if (row + 1 < colLength && row >= 0 && gameBoard[row + 1][col] != null) {
        return true;
      }
    }

    // 衝突なし
    return false;
  }

  // ピースを新規作成
  void createNewPiece() {
    // ランダムタイプ
    Random rand = Random();

    // ランダムにピース作成
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    // ピース初期化
    currentPiece.initializePiece();

    // ゲームオーバー判定
    if (isGameOver()) {
      gameOver = true;
    }
  }

  // 左に移動
  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  // 右に移動
  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  // 回転
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  // クリア
  void clearLines() {
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;

      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        gameBoard[0] = List.generate(row, (index) => null);

        // スコアを追加
        currentScore++;
      }
    }
  }

  // GAME OVER
  bool isGameOver() {
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 背景を黒にする
      backgroundColor: Colors.black,
      // 本体
      body: Column(children: [
        // GAME GRID
        Expanded(
          child: GridView.builder(
            // グリッドの数
            itemCount: rowLength * colLength,
            // 画面を物理的にスクロールできないようにする
            physics: const NeverScrollableScrollPhysics(),
            // 10行分のグリッドを作成する
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rowLength),
            //
            itemBuilder: (context, index) {
              int row = (index / rowLength).floor();
              int col = index % rowLength;
              // 現在のピース
              if (currentPiece.position.contains(index)) {
                return Pixel(color: currentPiece.color);
              }
              // 着地したピース
              else if (gameBoard[row][col] != null) {
                final Tetromino? tetrominoType = gameBoard[row][col];
                return Pixel(color: tetrominoColors[tetrominoType]);
              }
              // 空白のピース
              else {
                return Pixel(color: Colors.grey[900]);
              }
            },
          ),
        ),

        // SCORE
        Text(
          'Score: $currentScore',
          style: TextStyle(color: Colors.white),
        ),

        // GAME CONTROLS
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0, top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // left
              IconButton(
                onPressed: moveLeft,
                color: Colors.white,
                icon: Icon(Icons.arrow_back_ios),
              ),

              // rotate
              IconButton(
                onPressed: rotatePiece,
                color: Colors.white,
                icon: Icon(Icons.rotate_right),
              ),

              // right
              IconButton(
                onPressed: moveRight,
                color: Colors.white,
                icon: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
