import 'package:flutter/material.dart';
import 'package:flutter_calculator/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;

  void updateText(String newText) {
    setState(() {
      text = newText;
    });
  }

  double calculateFontSize() {
    const maxLength = 5;

    if (text.length > maxLength) {
      double reductionFactor =
          (text.length - maxLength) * 11.5; // Küçülme faktörü artırıldı
      double newSize = 100 - reductionFactor;

      // Yazı tipi küçültüldükten sonra bir miktar daha büyüt
      if (newSize < 90) {
        newSize += 3; // Büyütme adımı azaltıldı
      }

      return newSize.clamp(
          10.0, 100.0); // Yazı tipi boyutunu belirli bir aralıkta tut
    }

    return 100.0; // Varsayılan yazı tipi
  }

  Widget calculationButton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      width: 80,
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          calculations(btntxt);
        },
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: btncolor,
            padding: const EdgeInsets.all(20)),
        child: Text(
          '$btntxt',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Schyler',
            fontSize: 28,
            color: txtcolor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Calculator",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Schyler',
                        fontSize: calculateFontSize(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculationButton('C', Colors.grey.shade400, Colors.black),
                calculationButton('+/-', Colors.grey.shade400, Colors.black),
                calculationButton('%', Colors.grey.shade400, Colors.black),
                calculationButton('÷', Colors.amber.shade700, Colors.white)
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculationButton('7', Colors.grey.shade800, Colors.white),
                calculationButton('8', Colors.grey.shade800, Colors.white),
                calculationButton('9', Colors.grey.shade800, Colors.white),
                calculationButton('x', Colors.amber.shade700, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculationButton('4', Colors.grey.shade800, Colors.white),
                calculationButton('5', Colors.grey.shade800, Colors.white),
                calculationButton('6', Colors.grey.shade800, Colors.white),
                calculationButton('-', Colors.amber.shade700, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculationButton('1', Colors.grey.shade800, Colors.white),
                calculationButton('2', Colors.grey.shade800, Colors.white),
                calculationButton('3', Colors.grey.shade800, Colors.white),
                calculationButton('+', Colors.amber.shade700, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    calculations('0');
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(34, 20, 128, 20),
                      backgroundColor: Colors.grey.shade800),
                  child: const Text(
                    '0',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Schyler',
                        color: Colors.white),
                  ),
                ),
                calculationButton('.', Colors.grey.shade800, Colors.white),
                calculationButton('=', Colors.amber.shade700, Colors.white)
              ],
            )
          ],
        ),
      ),
    );
  }

  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculations(btnText) {
    if (btnText == 'C') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '÷') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == '÷' ||
        btnText == 'x' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '÷') {
        finalResult = div();
      }

      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      /* result = result + btnText;
      finalResult = result; */

      int maxDisplayLenght = 15;

      if (result.length + btnText.length > maxDisplayLenght) {
        int startIndex = result.length + btnText.length - maxDisplayLenght;
        result = result.substring(startIndex) + btnText;
      } else {
        result = result + btnText;
      }
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }

    return result.toString();
  }
}
