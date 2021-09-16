import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calcilator());
}

class Calcilator extends StatelessWidget {
  const Calcilator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primaryColor: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if(buttonText == "⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(buttonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }

      else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String btnTxt, double btnHight, Color btnColor) {
    return InkWell(
      onTap: ()=> buttonPressed(btnTxt),
      child: Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: btnColor,
    borderRadius:  BorderRadius.all(Radius.circular(200.0))
        ),
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * btnHight,
        child: Text(
          btnTxt,
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bilal Calculator"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: 48),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: 48),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 0.1, Colors.red),
                      buildButton("⌫", 0.1, Colors.redAccent),
                      buildButton("÷", 0.1, Colors.blueAccent),
                    ]),
                    TableRow(children: [
                      buildButton("7 ", 0.1, Colors.black54),
                      buildButton("8", 0.1, Colors.black54),
                      buildButton("9", 0.1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("4 ", 0.1, Colors.black54),
                      buildButton("5", 0.1, Colors.black54),
                      buildButton("6", 0.1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("1 ", 0.1, Colors.black54),
                      buildButton("2", 0.1, Colors.black54),
                      buildButton("3", 0.1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("0 ", 0.1, Colors.black54),
                      buildButton(".", 0.1, Colors.black54),
                      buildButton("00", 0.1, Colors.black54),
                    ])
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(children: [
                    TableRow(children: [
                      buildButton("×", 0.1, Colors.blueAccent),
                    ]),
                    TableRow(children: [
                      buildButton("+", 0.1, Colors.blueAccent),
                    ]),
                    TableRow(children: [
                      buildButton("-", 0.1, Colors.blueAccent),
                    ]), TableRow(children: [
                      buildButton("=", 0.2, Colors.blueAccent),
                    ]),

                  ]))
            ],
          )
        ],
      ),
    );
  }
}
