
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/auth/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/a/a2/Animated-GIFs-davidope-11.gif"),
            fit: BoxFit.cover
            )
            
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 250, 0, 10),
              child: Column(
                children: [
                  Text("Sign in", style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                    
                    
                  ),
                  SizedBox(height: 25,),

                  MaterialButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
                    },
                    color: Colors.red,
                    child: Text("LogIn con Google"),
                  ),
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}