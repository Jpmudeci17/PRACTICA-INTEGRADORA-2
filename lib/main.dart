import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/auth/bloc/auth_bloc.dart';
import 'package:practica2/auth/bloc/eliminatefav_bloc.dart';
import 'package:practica2/auth/bloc/getmusic_bloc.dart';
import 'package:practica2/auth/bloc/listfav_bloc.dart';
import 'package:practica2/homepage.dart';
import 'package:practica2/login/login_page.dart';

import 'auth/bloc/addfav_bloc.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
runApp(
  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(VerifyAuthEvent()),
        ),
        BlocProvider(
          create: (context) => GetmusicBloc(),
        ),
        BlocProvider(
          create: (context) => AddfavBloc(),
        ),
        BlocProvider(
          create: (context) => EliminatefavBloc(),
        ),
        BlocProvider(
          create: (context) => ListfavBloc()..add(GetListFav()),
        ),
      ],
      child: MyApp(),
    ),


); }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.indigo),
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Favor de autenticarse"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthSuccessState) {
            return HomePage();
          } else if (state is UnAuthState || state is AuthErrorState || state is SignOutSuccessState) {
            return LoginPage();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}