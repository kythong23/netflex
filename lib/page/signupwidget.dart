import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {

  const  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  int _selectedIndex = 0;

  late final Database database;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  Widget _renderSignIn() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(60, 80, 60, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/logo.jpg', width: 200),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: _emailController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              labelText: 'Email',
              floatingLabelStyle: TextStyle(color: Colors.black),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
          Container(
            height: 0.1,
            color: Colors.black,
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              labelText: 'Password',
              floatingLabelStyle: TextStyle(color: Colors.black),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                side: const BorderSide(width: 1.0, color: Colors.grey),
              ),
              child: const Text(
                "Sign in",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0
                ),
              ),
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;

                if (email.isEmpty || password.isEmpty) {
                  showDialog(context: context, builder: (_) => AlertDialog(
                    title: const Text('Error'),
                    content: const Text('Please enter your email and password'),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () =>  Navigator.of(context, rootNavigator: true).pop('dialog'),
                      )
                    ],
                  ));

                  return;
                }
              },
            ),
          ),
          const SizedBox(height:20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Google Icon
              FaIcon(
                FontAwesomeIcons.google,
                size: 40,
                color: Colors.red,
              ),
              SizedBox(width: 40),
              // Gmail Icon
              FaIcon(
                FontAwesomeIcons.facebook,
                size: 40,
                color: Colors.red,
              ),
              SizedBox(width: 40),
              // Gmail Icon
              FaIcon(
                FontAwesomeIcons.instagram,
                size: 40,
                color: Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          MaterialButton(
            child: const Text(
              "Don't have an account? Sign up",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
          MaterialButton(
            child: const Text(
              "Forgot your password?",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _renderSignUp() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(60, 80, 60, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/logo.jpg', width: 200),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: _nameController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              labelText: 'Your name',
              floatingLabelStyle: TextStyle(color: Colors.black),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
          Container(
            height: 0.1,
            color: Colors.black,
          ),
          const SizedBox(height:20),
          TextField(
            controller: _emailController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              labelText: 'Email address',
              floatingLabelStyle: TextStyle(color: Colors.black),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
          Container(
            height: 0.1,
            color: Colors.black,
          ),
          const SizedBox(height:20),
          TextField(
            controller: _passwordController,
            obscureText: true,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              labelText: 'Password',
              floatingLabelStyle: TextStyle(color: Colors.black),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                side: const BorderSide(width: 1.0, color: Colors.grey),
              ),
              child: const Text(
                "Sign up",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0
                ),
              ),
              onPressed: () async {
                final name = _nameController.text;
                final email = _emailController.text;
                final password = _passwordController.text;

                if (email.isEmpty || password.isEmpty) {
                  showDialog(context: context, builder: (_) => AlertDialog(
                    title: const Text('Error'),
                    content: const Text('Please enter your email and password'),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () => Navigator.of(context, rootNavigator: true).pop('dialog'),
                      )
                    ],
                  ));

                  return;
                }

              },
            ),
          ),
          const SizedBox(height: 10.0),
          MaterialButton(
            child: const Text(
              "Forgot your password?",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          ),
          const SizedBox(height: 10.0),
          MaterialButton(
            child: const Text(
              "Already have an account? Sign in",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;


    _emailController.text = "";

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            _renderSignIn(),
            _renderSignUp(),
          ],
        )
    );
  }
}