import 'package:flutter/material.dart';
import 'dart:math';

class Jogo extends StatefulWidget {
  const Jogo({Key? key}) : super(key: key);

  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = const AssetImage("assets/padrao.png");
  var _mensagem = "Escolha uma opção abaixo";
  var opcoes = ["pedra", "papel", "tesoura"];
  int _appCount = 0;
  int _userCount = 0;
  String _escolhaApp = "";

  String opMaquina() {
    return opcoes[Random().nextInt(3)];
  }

  bool userIsWin(var escolhaUsuario, var escolhaApp) {
    if ((escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel")) {
      return true;
    } else {
      return false;
    }
  }

  String verificaGanhador(var escolhaUsuario) {
    String resultado = "";
    if (escolhaUsuario == _escolhaApp) {
      resultado = "Empate";
      return resultado;
    }

    if (userIsWin(escolhaUsuario, _escolhaApp)) {
      resultado = "Você ganhou";
      setState(() {
        _userCount++;
      });
      return resultado;
    }

    resultado = "Você perdeu";
    setState(() {
      _appCount++;
    });
    return resultado;
  }

  void _opcaoSelecionada(String escolhaUsuario) {
    setState(() {
      _escolhaApp = opMaquina();
      _mensagem = verificaGanhador(escolhaUsuario);
    });

    // print("Escolha do App: " + _escolhaApp);
    // print("Escolha do usuario: " + escolhaUsuario);

    //Exibição da imagem escolhida pelo App
    switch (_escolhaApp) {
      case "pedra":
        setState(() {
          _imagemApp = const AssetImage("assets/pedra.png");
        });
        break;
      case "papel":
        setState(() {
          _imagemApp = const AssetImage("assets/papel.png");
        });
        break;
      case "tesoura":
        setState(() {
          _imagemApp = const AssetImage("assets/tesoura.png");
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JokenPo"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha do App",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Image(
            image: _imagemApp,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              _mensagem,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () => _opcaoSelecionada("pedra"),
                child: Image.asset(
                  "assets/pedra.png",
                  height: 100,
                ),
              ),
              GestureDetector(
                onTap: () => _opcaoSelecionada("papel"),
                child: Image.asset(
                  "assets/papel.png",
                  height: 100,
                ),
              ),
              GestureDetector(
                onTap: () => _opcaoSelecionada("tesoura"),
                child: Image.asset(
                  "assets/tesoura.png",
                  height: 100,
                ),
              )
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Você: $_userCount",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "App: $_appCount",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          GestureDetector(
            onTap: () {
              setState(() {
                _userCount = 0;
                _appCount = 0;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Colors.red,
              ),
              child: const Text(
                "Zerar pontos",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],

        // button with click clear points
      ),
    );
  }
}
