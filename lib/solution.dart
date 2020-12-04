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

  bool solveSuduko(List<List<int>> board, int row, int col) 
  {
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

  bool submatrix(List<List<int>> board) 
  {
    int n = 3, m = 3;
    List<int> a=[];
    int k = 0;
    int l = 0;
    // unordered_map<int,int> a;
    while (m > 0) {
      while (n > 0) {
        for (int i = k; i < k + 3; i++) {
          for (int j = l; j < l + 3; j++) {
            // cout<<grid[i][j];

            if (board[i][j] == 0) continue;
            if (a.contains(board[i][j])) {
              return false;
            }
            a.add(board[i][j]);
          }
        }

        a.clear();

        k += 3;
        n = n - 1;
        // cout<<endl;
      }

      l += 3;
      k = 0;

      n = 3;
      m = m - 1;
    }

    return true;
  }

  bool check(List<List<int>> board) 
  {
    List<int> a=[];

    //row
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (board[i][j] == 0) {
          continue;
        }
        if (a.contains(board[i][j])) {
          return false;
        }
        a.add(board[i][j]);
      }

      a.clear();
    }
    // a.clear();
    //col
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (board[j][i] == 0) {
          continue;
        }
        if (a.contains(board[j][i])) {
          return false;
        }
        a.add(board[j][i]);
      }

      a.clear();
    }
    // a.clear();

    //submatrix

    return submatrix(board);
  }

  int k = 0;
  bool func(List nums) 
  {
    
    
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        board[i][j] = nums[k++];
      }
    }

    // print("board");
    // print(board);

    if (check(board)&&solveSuduko(board, 0, 0) ) 
      {
        int c = 0;

        for (int i = 0; i < 9; i++) {
          for (int j = 0; j < 9; j++) {
            nums[c++] = board[i][j];
          }
        }

        msg = "solved!";

        return true;
      }  
    else 
    {
      msg = "Wrong Sudoku!";
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
