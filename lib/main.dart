import 'package:calculadora/resultView.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final num1 = TextEditingController();
  final num2 = TextEditingController();

  String resultado = "";
  bool status = true;

  @override
  void dispose() {
    num1.dispose();
    num2.dispose();
    super.dispose();
  }

  void calculadora(String a, String b, String operador) {
    setState(() {
      try {
        double num1 = double.parse(a);
        double num2 = double.parse(b);
        double resolve = 0;
        switch (operador) {
          case "+":
            resolve = num1 + num2;
            break;
          case "-":
            resolve = num1 - num2;
            break;
          case "*":
            resolve = num1 * num2;
            break;
          case "/":
            resolve = num1 / num2;
            break;
        }
        resultado = "El resultado de la operación es: $resolve";
        status = true;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ResultView(title: "Resultado", resultado: resultado)));
      } catch (e) {
        resultado = "Error: $e";
        status = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                    child: TextField(
                        controller: num1,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Primer número'))),
                const SizedBox(width: 10),
                Expanded(
                    child: TextField(
                        controller: num2,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Segundo número'))),
              ]),
              Row(children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () => calculadora(num1.text, num2.text, "+"),
                        child: const Text("Sumar")))
              ]),
              Row(children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () => calculadora(num1.text, num2.text, "-"),
                        child: const Text("Restar")))
              ]),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () =>
                              calculadora(num1.text, num2.text, "*"),
                          child: const Text("Multiplicación")))
                ],
              ),
              Row(children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () => calculadora(num1.text, num2.text, "/"),
                        child: const Text("División")))
              ]),
              Row(
                children: [
                  Expanded(
                      child: Center(
                    child: Text(
                        status
                            ? ""
                            : "Introduce los números y selecciona una operación\nEjemplo: 5, 54, 23.5, etc...",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.red[600],
                            fontSize: 25.9)),
                  ))
                ],
              )
            ])));
  }
}
