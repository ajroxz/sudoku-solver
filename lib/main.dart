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
  String message = "good to go!";
  void set1(int ind, String val) {
    // controllers[ind].text = val;
    if (val == '') {
      nums[ind] = 0;
    } else {
      nums[ind] = int.parse(val);
    }
  }

  void initState() {
    for (int i = 0; i < 81; i++) {
      controllers.add(TextEditingController(text: ''));
      nums.add(0);
    }
    super.initState();
  }

  void solving() {
    // for (int i = 0; i < 81; i++) {
    //   // nums[i] = controllers[i].text;
    //   // controllers[i].text = i.toString();
    //   // nums[i] = i;
    // }

    // print(nums);
    Solve sol = new Solve();
    if (sol.func(nums)) {
      set2(nums);
      setState(() {
        message = sol.msg;
      });
    } else {
      setState(() {
        message = sol.msg;
      });
    }
    // sol.func(nums);
    // set2(nums);
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
      message = '';
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
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  //color: Colors.blue,
                  padding: EdgeInsets.all(10),

                  height: 400,

                  //width: double.infinity,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1 / 1, crossAxisCount: 9),
                    itemBuilder: (_, ind) => Card(
                      child: TextFormField(
                        //focusNode: focusNode,
                        //initialValue: controllers[ind].text,
                        controller: controllers[ind],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(focusColor: Colors.white),
                        onChanged: (val) => set1(ind, val),
                      ),
                    ),
                    itemCount: 81,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 0, 3, 40),
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
                            icon: Icon(Icons.restore_page),
                            label: Text("Reset"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 0, 0, 40),
                  child: Row(
                    children: [
                      Text(message),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white24,
    );
  }
}
