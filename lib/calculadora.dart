import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _limpar = 'Limpar';
  String _expressao = '';
  String _resultado = '';
  final List<String> _historico = [];

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == _limpar) {
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        _calcularesultado();
      } else {
        _expressao += valor;
      }
    });
  }

  void _calcularesultado() {
    try {
      double resultado = _avaliarExpressao(_expressao);
      _resultado = resultado.toString();
      _historico.add('$_expressao = $_resultado');
    } catch (e) {
      _resultado = 'Erro';
    }
  }

  double _avaliarExpressao(String expressao) {
    expressao = expressao.replaceAll('x', '*');
    expressao = expressao.replaceAll('÷', '/');
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    double resultado = avaliador.eval(Expression.parse(expressao), {});
    return resultado;
  }

  Widget _botao(String valor) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 25),
        padding: const EdgeInsets.all(15),
      ),
      child: Text(valor),
      onPressed: () => _pressionarBotao(valor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _expressao,
                      style: const TextStyle(fontSize: 32),
                    ),
                    Text(
                      _resultado,
                      style: const TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 1.5,
                children: [
                  _botao('7'),
                  _botao('8'),
                  _botao('9'),
                  _botao('÷'),
                  _botao('4'),
                  _botao('5'),
                  _botao('6'),
                  _botao('x'),
                  _botao('1'),
                  _botao('2'),
                  _botao('3'),
                  _botao('-'),
                  _botao('0'),
                  _botao('.'),
                  _botao('='),
                  _botao('+'),
                ],
              ),
            ),
            Expanded(
              child: _botao(_limpar),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _historico.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_historico[index]),
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

void main() => runApp(const MaterialApp(home: Calculadora()));
