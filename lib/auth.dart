import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:test_app/home_page.dart';
import 'package:test_app/video_list.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  final TextEditingController  _login =
  TextEditingController();
  final TextEditingController  _password =
  TextEditingController();
  final authUrl = Uri.parse('https://api2.tehnologia.com/api/v1/token');
  final client = RetryClient(http.Client());
  var _err = '';
  var token = '';

  void tap(index, context) {
    if (index == 0) {
      Navigator.pop(context);
    }
  }

  Future getConnect() async {
    try {
      final userAuthRes = await client.get(authUrl, headers: {
        'Content-Type': 'application/json; charset=utf-8',
      });
      setState(() {
        _err = userAuthRes.statusCode.toString();
      });
    } on Exception catch (err) {
      setState(() {
        _err = err.toString();
      });

      Timer(const Duration(seconds: 3), () {
        setState(() {
          _err = '';
        });
      });
    }
  }

  Future getAuth(userData, context) async {
    try {
      final userAuthRes = await client.get(authUrl, headers: {
        'Content-Type': 'application/json; charset=utf-8',
      });

      if (userAuthRes.statusCode == 200) {
        setState(() {
          token = jsonDecode(userAuthRes.body);
        });
        Navigator.push(context,  MaterialPageRoute(builder: (BuildContext context) => HomePage(token: '"123"')));
      } else {
        Navigator.push(context,  MaterialPageRoute(builder: (BuildContext context) => HomePage(token: '"123"')));

        setState(() {
          _err = userAuthRes.statusCode.toString();
        });
      }
    } on Exception catch (_) {
      setState(() {
        _err = 'Проблемы с сервером';
      });

      Timer(const Duration(seconds: 3), () {
        setState(() {
          _err = '';
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child:  Form (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 60,
                child: Text(_err, style: const TextStyle(color: Colors.red)),
              ),
              SizedBox(
                width: 250,
                child: TextFormField (
                  decoration: const InputDecoration (
                    hintText: 'Введите логин',
                  ),
                  controller: _login,
                ),
              ),
              SizedBox(
                width: 250,
                child: TextFormField (
                  decoration: const InputDecoration (
                    hintText: 'Введите пароль',
                  ),
                  controller: _password,
                ),
              ),
              const SizedBox(
                height: 50
              ),
              ElevatedButton(
                onPressed: () {
                  final userData = {'login': _login.text, 'password': _password.text};
                  getAuth(userData, context);
                },
                child: const Text('Войти'),
              ),
              ElevatedButton(
                onPressed: () {
                  getConnect();
                },
                child: const Text('Тест'),
              ),
            ],
          )
        ),
      ),
    );
  }
}
