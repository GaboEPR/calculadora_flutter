import 'package:flutter/material.dart';

void main() => runApp(CalculadoraApp());

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
         scaffoldBackgroundColor: const Color.fromARGB(255, 34, 23, 23) // Establece el color de fondo global
        ),
      home: Calculadora(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _resultado = '0';
  String _expresion = '0';

void _presionar(String valor) {
  setState(() {
    if (valor == 'c') {
      _expresion = '0';
      _resultado = '0';
    } else if (valor == '=') {
      try {
        _resultado = _evaluarExpresion(_expresion);
      } catch (e) {
        _resultado = 'Error';
      }
    } else {
      if (_expresion == '0') {
        _expresion = valor;
      } else {
        _expresion += valor; 
      }
    }
  });
}


  String _evaluarExpresion(String expr) {
    double resultado;
    if (expr.contains('+')) {
      var partes = expr.split('+');
      resultado = double.parse(partes[0]) + double.parse(partes[1]);
    } else if (expr.contains('-')) {
      var partes = expr.split('-');
      resultado = double.parse(partes[0]) - double.parse(partes[1]);
    } else if (expr.contains('*')) {
      var partes = expr.split('*');
      resultado = double.parse(partes[0]) * double.parse(partes[1]);
    } else if (expr.contains('/')) {
      var partes = expr.split('/');
      resultado = double.parse(partes[0]) / double.parse(partes[1]);
    } else {
      resultado = double.parse(expr);
    }
    return resultado.toString();
  }

 Widget _boton(String texto) {
  Color fondo = Colors.blueGrey;
  Color textoColor = Colors.white;

  // Cambiar estilo según el tipo de botón
  if (texto == 'c') {
    fondo = Colors.red;
  } else if (texto == '=') {
    fondo = Colors.green;
  } else if ('/*-+'.contains(texto)) {
    fondo = Colors.orange;
  }

  return ElevatedButton(
    onPressed: () => _presionar(texto),
    child: Text(
      texto,
      style: TextStyle(fontSize: 24, color: textoColor),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: fondo,
      minimumSize: Size(80, 80),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_expresion, style: TextStyle(fontSize: 32, color: Colors.white) ),
                  Text(_resultado, style: TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_boton('7'), _boton('8'), _boton('9'), _boton('/')],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_boton('4'), _boton('5'), _boton('6'), _boton('*')],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_boton('1'), _boton('2'), _boton('3'), _boton('-')],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_boton('0'), _boton('c'), _boton('='), _boton('+')],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
