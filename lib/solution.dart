class Solve {
  List<List<int>> board = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
  ];

  String msg = '';

  bool isSafe(List<List<int>> board, int row, int col, int num) {
    for (int x = 0; x <= 8; x++) if (board[row][x] == num) return false;

    for (int x = 0; x <= 8; x++) if (board[x][col] == num) return false;

    int startRow = row - row % 3, startCol = col - col % 3;

    for (int i = 0; i < 3; i++)
      for (int j = 0; j < 3; j++)
        if (board[i + startRow][j + startCol] == num) return false;

    return true;
  }

  bool solveSuduko(List<List<int>> board, int row, int col) {
    if (row == 8 && col == 9) return true;

    if (col == 9) {
      row++;
      col = 0;
    }

    if (board[row][col] > 0) return solveSuduko(board, row, col + 1);

    for (int num = 1; num <= 9; num++) {
      if (isSafe(board, row, col, num)) {
        board[row][col] = num;

        if (solveSuduko(board, row, col + 1)) return true;
      }

      board[row][col] = 0;
    }
    return false;
  }

  int k = 0;
  bool func(List nums) {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        board[i][j] = nums[k++];
      }
    }

    // print("board");
    // print(board);

    if (solveSuduko(board, 0, 0)) {
      int c = 0;

      for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
          nums[c++] = board[i][j];
        }
      }

      msg = "solved!";

      return true;
    } else {
      msg = "Solution doesn't exist";
      return false;
    }

    // for (int i = 0; i < 9; i++) {
    //   for (int j = 0; j < 9; j++) {
    //     print(board[i][j]);
    //   }
    //   print('\n');
    // }
  }
}
