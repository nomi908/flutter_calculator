import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});
  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = "";
  double result = 0;
  String operator = "";
  String input = "";
  String resultxt = "";


  void _onButtonPressed(String label){
    setState(() {
     if(label== "AC") {
       display = "";
       result = 0;
       resultxt = "";
       input = "";
       operator = "";
       return;
     }else if(label == "C"){
       if(display.isNotEmpty){
         display = display.substring(0, display.length -1);
       }
     }else if(label == "="){
        // try{
        //   final expression = Expression.parse(display);
        //   const evaluator = ExpressionEvaluator();
        //   final result = evaluator.eval(expression, {});
        //   resultxt = result.toString();
        // }catch (e){
        //   resultxt = "Error";
        //
        // }

       resultxt = calculateResult(input);

      }

     else{
       display += label;
       input += label;
     }


    });
  }

  String calculateResult(String input){
    try{
      Parser p = Parser();
      Expression exp = p.parse(input);
      ContextModel cm = ContextModel();

      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toStringAsFixed(2);
    }catch(e){
      return  "Error";
    }
  }

  // String calculateResult(String input) {
  //   try {
  //     List<String> tokens = tokenize(input);
  //
  //     // Step 1: Handle Division and Multiplication first
  //     tokens = performOperations(tokens, ['/', '*']);
  //
  //     // Step 2: Handle Addition and Subtraction
  //     tokens = performOperations(tokens, ['+', '-']);
  //
  //     // Step 3: Final result will be the remaining token
  //     return tokens.isNotEmpty ? tokens.first : "Error";
  //   } catch (e) {
  //     return "Error";
  //   }
  // }
  //
  // // Tokenizer to split input string into numbers and operators
  // List<String> tokenize(String input) {
  //   List<String> tokens = [];
  //   String currentNumber = "";
  //   for (int i = 0; i < input.length; i++) {
  //     String char = input[i];
  //
  //     if ("0123456789.".contains(char)) {
  //       // If it's a number or decimal point, keep adding to current number
  //       currentNumber += char;
  //     } else if ("+-*/".contains(char)) {
  //       // If it's an operator, save the current number and operator
  //       if (currentNumber.isNotEmpty) {
  //         tokens.add(currentNumber);
  //         currentNumber = "";
  //       }
  //       tokens.add(char);
  //     }
  //   }
  //   // Add the last number
  //   if (currentNumber.isNotEmpty) {
  //     tokens.add(currentNumber);
  //   }
  //   return tokens;
  // }
  //
  // // Method to perform a list of operations in the given precedence
  // List<String> performOperations(List<String> tokens, List<String> operators) {
  //   List<String> result = [];
  //   double currentValue = double.parse(tokens[0]);
  //
  //   for (int i = 1; i < tokens.length; i += 2) {
  //     String operator = tokens[i];
  //     double nextValue = double.parse(tokens[i + 1]);
  //
  //     if (operators.contains(operator)) {
  //       if (operator == '/') {
  //         currentValue /= nextValue;
  //       } else if (operator == '*') {
  //         currentValue *= nextValue;
  //       } else if (operator == '+') {
  //         currentValue += nextValue;
  //       } else if (operator == '-') {
  //         currentValue -= nextValue;
  //       }
  //     } else {
  //       result.add(currentValue.toString());
  //       result.add(operator);
  //       currentValue = nextValue;
  //     }
  //   }
  //   result.add(currentValue.toString());
  //   return result;
  // }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Calculator", style: TextStyle(color: Colors.white ,),),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  reverse: true, // Scrolls to the bottom
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      display,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right, // Align text to the right
                    ),
                  ),
                ),
              ),
            
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16),
              child: Text(resultxt, style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
                textAlign: TextAlign.right,),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCalculatorButton("AC"),
                  _buildCalculatorButton("C"),
                  _buildCalculatorButton("%"),
                  _buildCalculatorButton("/"),

                ],),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                _buildCalculatorButton("7"),
                _buildCalculatorButton("8"),
                _buildCalculatorButton("9"),
                _buildCalculatorButton("*"),
              ],
            ),
            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                _buildCalculatorButton("4"),
                _buildCalculatorButton("5"),
                _buildCalculatorButton("6"),
                _buildCalculatorButton("-"),
              ],
            ),
            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [

                _buildCalculatorButton("1"),
                _buildCalculatorButton("2"),
                _buildCalculatorButton("3"),
                _buildCalculatorButton("+"),
              ],
            ),
            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                       _buildCalculatorButton("0"),
                       _buildCalculatorButton("00"),
                       _buildCalculatorButton("."),
                       _buildCalculatorButton("="),
              ],
            ),
            SizedBox(height: 20,)

          ],
        ),
      ),
    );
  }

  Widget _buildCalculatorButton(String lable){
    return Container(
      height: 60, width: 80,
      child: ElevatedButton(onPressed: () =>  _onButtonPressed(lable), child: Text(lable),
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  ),
    );

  }
}




