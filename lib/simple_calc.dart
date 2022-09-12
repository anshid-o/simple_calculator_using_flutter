import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';

class SimpleCalc extends StatefulWidget {
  const SimpleCalc({Key? key}) : super(key: key);

  @override
  State<SimpleCalc> createState() => _SimpleCalcState();
}

class _SimpleCalcState extends State<SimpleCalc> {
  TextEditingController num1 = TextEditingController();
  TextEditingController num2 = TextEditingController();
  TextEditingController operator = TextEditingController();
  String ans = '';

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double txt = MediaQuery.textScaleFactorOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightGreen,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "CALCULATOR",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10 * txt),
                  width: w * 0.35,
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        color: Colors.lightGreen,
                        border: Border.all(color: Colors.black, width: 5)),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                      cursorColor: Colors.black,
                      controller: num1,
                      onChanged: (val) {
                        setState(() {
                          num1.text = val;
                          num1.selection = TextSelection.fromPosition(
                            TextPosition(offset: num1.text.length),
                          );
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '1st number',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10 * txt),
                  width: w * 0.3,
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        color: Colors.lightGreen,
                        border: Border.all(color: Colors.black, width: 5)),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      cursorColor: Colors.black,
                      controller: operator,
                      onChanged: (val) {
                        setState(() {
                          operator.text = val;
                          operator.selection = TextSelection.fromPosition(
                            TextPosition(offset: operator.text.length),
                          );
                        });
                      },
                      decoration: InputDecoration(
                        hintText: '(+,-, etc)',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10 * txt),
                  width: w * 0.35,
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        color: Colors.lightGreen,
                        border: Border.all(color: Colors.black, width: 5)),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      controller: num2,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        setState(() {
                          num2.text = val;
                          num2.selection = TextSelection.fromPosition(
                            TextPosition(offset: num2.text.length),
                          );
                        });
                      },
                      decoration: InputDecoration(
                          hintText: '2nd number',
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: h * 0.25,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                      color: Colors.lightGreen,
                      border: Border.all(color: Colors.black, width: 5)),
                  child: Text(
                    ans == '' ? 'Your Answer will be displayed here' : ans,
                    style: TextStyle(
                      height: 2.5,
                      fontSize: ans == '' ? 16 * txt : 25 * txt,
                      color: ans == '' ? Colors.grey.shade600 : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: w * 0.4,
                  height: h * 0.08,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      ans = calc();
                      setState(() {});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'CALCULATE',
                        ),
                        Icon(Icons.calculate)
                      ],
                    ),
                  ),
                ),
                Container(
                  width: w * 0.4,
                  height: h * 0.08,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      num1.clear();
                      operator.clear();
                      num2.clear();
                      ans = '';
                      setState(() {});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'CLEAR',
                        ),
                        Icon(Icons.clear_all)
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String calc() {
    Parser p = Parser();
    Expression e = p.parse('${num1.text + operator.text + num2.text}');
    ContextModel cm = ContextModel();
    num ans = e.evaluate(EvaluationType.REAL, cm);
    return ans.toString().length > 10
        ? ans.toStringAsPrecision(3)
        : ans.toString();
  }
}
