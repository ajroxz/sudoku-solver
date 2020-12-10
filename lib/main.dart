import 'package:flutter/material.dart';
import 'package:sudokusolver/solution.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String output = "0";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controllers = <TextEditingController>[];
  var nums = [];
  Color colr;
  String message = "0 will be treated as null!";
  void set1(int ind, String val) {
    if (val == '') {
      nums[ind] = 0;
    } else if (val == '.' || val == ',' || val == '-') {
      setState(() {
        message = "Wrong Input";
      });
      return;
    } else {
      nums[ind] = int.parse(val);
    }
  }

  void getcolor() {
    colr = Colors.green;
  }

  void initState() {
    for (int i = 0; i < 81; i++) {
      controllers.add(TextEditingController(text: ''));
      nums.add(0);
    }
    super.initState();
  }

  bool check(List nums) {
    for (int i = 0; i < 81; i++) {
      if (nums[i] > 9) return true;
    }
    return false;
  }

  bool check2(List nums) {
    for (int i = 0; i < 81; i++) {
      if (nums[i] != 0) return false;
    }
    return true;
  }

  void solving() {
    Solve sol = new Solve();
    if (check(nums)) {
      setState(() {
        message = "Wrong Input";
      });
    } else if (check2(nums) && sol.func(nums)) {
      set2(nums);
      setState(() {
        message = "Default solution";
      });
    } else if (sol.func(nums)) {
      set2(nums);
      setState(() {
        message = sol.msg;
      });
    } else {
      setState(() {
        message = sol.msg;
      });
    }
  }

  void set2(List nums) {
    for (int i = 0; i < 81; i++) {
      controllers[i].text = nums[i].toString();
    }
  }

  void reset() {
    for (int i = 0; i < 81; i++) {
      controllers[i].text = '';
      nums[i] = 0;
    }
    setState(() {
      message = "0 will be treated as null!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Sudoku Solver',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Divider(
            thickness: 10,
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  height: 400,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1 / 1, crossAxisCount: 9),
                    itemBuilder: (_, ind) => Card(
                      child: TextFormField(
                        style: TextStyle(color: colr),
                        controller: controllers[ind],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(focusColor: Colors.black),
                        onChanged: (val) {
                          // getcolor();
                          set1(ind, val);
                        },
                      ),
                    ),
                    itemCount: 81,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        message,
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 4, 3, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          RaisedButton.icon(
                            color: Colors.white,
                            onPressed: () {
                              return solving();
                            },
                            icon: Icon(Icons.play_arrow),
                            label: Text('Solve!'),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        thickness: 20,
                      ),
                      Column(
                        children: [
                          RaisedButton.icon(
                            onPressed: reset,
                            icon: Icon(Icons.restore),
                            label: Text("Reset"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
