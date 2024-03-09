import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'no.dart';

class Calc extends StatefulWidget {
  const Calc({Key? key}) : super(key: key);

  @override
  State<Calc> createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  var entredeqn = '';

  bool isequtapped = false;

  void _resultdisplay() {
    Parser parser = Parser();
    Expression exp = parser.parse(entredeqn);

    double result = exp.evaluate(EvaluationType.REAL, ContextModel());

    print(result);

    entredeqn = result.toStringAsFixed(4); // Output: 5.0
  }

  void sqrres() {
    Parser parser = Parser();
    Expression exp = parser.parse(entredeqn);

    double result = exp.evaluate(EvaluationType.REAL, ContextModel());

    double sqrress = result * result;

    entredeqn = sqrress.toStringAsFixed(4);

    print(sqrress);
  }

  void _addsub(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Choose an option!!!'),
            content: Text('Addition or Subtraction?'),
            actions: [
              TextButton.icon(
                  onPressed: () {
                    _performOperation('+');
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.add),
                  label: Text('Addition'),),
              TextButton.icon(
                  onPressed: () {
                    _performOperation('-');
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.remove),
                  label: Text('Subtraction'))
            ],
          );
        });
  }

  void _performOperation(String operation) {
    setState(() {
      if (operation == 'DEL') {
        entredeqn = entredeqn.substring(0, entredeqn.length - 1);
      } else if (operation == 'AC') {
        isequtapped = false;
        entredeqn = '';
      } else if (operation == '=') {
        isequtapped = true;
        _resultdisplay();
      } else if (operation == '√') {
        entredeqn = 'sqrt($entredeqn)';
      } else if (operation == 'x²') {
        isequtapped = true;
        sqrres();
      } else if (operation == '0' ||
          operation == '1' ||
          operation == '2' ||
          operation == '3' ||
          operation == '4' ||
          operation == '5' ||
          operation == '6' ||
          operation == '7' ||
          operation == '8' ||
          operation == '9') {
        if (isequtapped) {
          entredeqn = operation;
          isequtapped = false;
        } else {
          entredeqn += operation;
        }
      } else if (operation == '+' ||
          operation == '-' ||
          operation == '*' ||
          operation == '/') {
        if (isequtapped) {
          isequtapped = false;
          entredeqn += operation;
        } else {
          entredeqn += operation;
        }
      } else if (operation == '.') {
        if (isequtapped) {
          isequtapped = false;
          entredeqn += operation;
        } else {
          entredeqn += operation;
        }
      } else if (operation == '+/-') {
        _addsub(context);
      } else {
        entredeqn += operation;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 135.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15, bottom: 100),
              child: Align(
                alignment: Alignment.centerRight,
                child: Flexible(
                  child: Container(
                    child: Text(
                      entredeqn,
                      style: TextStyle(
                        fontSize: (isequtapped) ? 45 : 35,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SizedBox(
                    height: constraints.maxHeight *
                        0.5, // Adjust the height as needed
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 3 / 2.3,
                      ),
                      itemCount: numbers.length,
                      itemBuilder: (ctx, index) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          child: Container(
                            height: 1,
                            width: 3,
                            decoration: BoxDecoration(
                              color: (numbers[index] == 'AC' ||
                                      numbers[index] == '+/-' ||
                                      numbers[index] == 'DEL' ||
                                      numbers[index] == '/' ||
                                      numbers[index] == '*' ||
                                      numbers[index] == '-' ||
                                      numbers[index] == '+' ||
                                      numbers[index] == '=' ||
                                      numbers[index] == '(' ||
                                      numbers[index] == ')' ||
                                      numbers[index] == '√' ||
                                      numbers[index] == 'x²')
                                  ? Color.fromARGB(255, 62, 61, 61)
                                  : Color.fromARGB(255, 29, 29, 29),
                              border: Border.all(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(
                                numbers[index],
                                style: TextStyle(
                                  color: (numbers[index] == 'AC' ||
                                          numbers[index] == '+/-' ||
                                          numbers[index] == 'DEL' ||
                                          numbers[index] == '/' ||
                                          numbers[index] == '*' ||
                                          numbers[index] == '-' ||
                                          numbers[index] == '+' ||
                                          numbers[index] == '=' ||
                                          numbers[index] == '(' ||
                                          numbers[index] == ')' ||
                                          numbers[index] == '√' ||
                                          numbers[index] == 'x²')
                                      ? Color.fromARGB(255, 255, 153, 0)
                                      : Colors.white,
                                  fontSize: 30,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _performOperation(numbers[index]);
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
