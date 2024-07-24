import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/const.dart';
import '../provider/provider.dart';
import 'home.dart';
import '../api/google_signin_api.dart';
import '../data/user.dart';
import '../data/user_signin.dart';
import '../config/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  int _selectedIndex = 0;

 void updateFavorProvider(User user){
   Provider.of<FavorProvider>(context, listen: false).userId = user.userId;
   Provider.of<FavorProvider>(context, listen: false).getFavorAndMoviesList();
 }
 void checkLogged() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;
    if(strUser != null){
      User user = User.fromJson(jsonDecode(pref.getString('user')!));
      updateFavorProvider(user);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHome()));
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogged();
    // new Future.delayed(const Duration(seconds: 3), () => checkLogged());
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
            child: Image.asset('assets/images/logo.png', width: 200),
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
              onPressed: signInPassword,
            ),
          ),
          const SizedBox(height:20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Google Icon
              InkWell(
                onTap: signInGoogle,
                child:
                FaIcon(
                  FontAwesomeIcons.google,
                  size: 40,
                  color: Colors.red,
                ),
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
            child: Image.asset('assets/images/logo.png', width: 200),
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
              onPressed: signUp,
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

  Future SignIn(email) async{
    User? user = await fetchUserByEmail(email);
    if(user != null){
      saveUser(user);
      updateFavorProvider(user);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHome()));
    }else{
      ShowDialog('Something wrong',context);
    }
  }

  Future<bool> saveUser(User user) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String strUser = jsonEncode(user);
      prefs.setString('user', strUser);
      return true;
    } catch(e){
      print(e);
      return false;
    }
  }

  Future signInPassword() async{
      UserSignIn user = UserSignIn();
      user.email = _emailController.text;
      user.password = _passwordController.text;

      if (user.email!.isEmpty || user.password!.isEmpty) {
        ShowDialog('Please enter your email and password',context);
        return;
      }

      bool success = await checkUser(user);
      if(success) {
        await SignIn(user.email);
      }else{
        ShowDialog('Email or password is incorrect',context);
      }
  }
  Future signInGoogle() async{
    final user = await GoogleSignInApi.login;

    bool userExists = await checkEmail(user!.email!);

    if(userExists){
      SignIn(user.email);
    }
    else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please resgister for this email')));

      _emailController.text = user!.email;
      _nameController.text = user!.displayName!;

      setState(() {
        _selectedIndex = 1;
      });
    }
  }
  Future signUp() async {
    User user = User();
    final now = DateTime.now();
    user.userId = now.microsecond*100 + now.hour + now.month + now.year * 1000 + now.day ;
    user.email = _emailController.text;
    user.username = _nameController.text;
    user.password = _passwordController.text;
    user.role = "normal";
    user.status = "active";

    bool validate = await validateUser(user);
    if(validate){
      final success = await createUser(user);
      if(success){
        SignIn(user.email);
      }else{
        ShowDialog('Something wrong',context);
      }
    }
  }
  Future<bool> validateUser(User user) async{
    if (user.username!.isEmpty) {
      ShowDialog('Please enter your user name!',context);
      return false;
    }
    if (user.email!.isEmpty || user.password!.isEmpty) {
      ShowDialog('Please enter your email and password!',context);
      return false;
    }
    bool userExists = await checkEmail(_emailController.text);
    if(userExists) {
      ShowDialog('This email is used.',context);
      return false;
    }
    return true;
  }
}