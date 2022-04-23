import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/auth/bloc/auth_bloc.dart';
import 'package:practica2/auth/bloc/getmusic_bloc.dart';
import 'package:practica2/auth/bloc/listfav_bloc.dart';
import 'package:practica2/itemsFavs.dart';
import 'package:practica2/uniqueSong.dart';
import 'package:avatar_glow/avatar_glow.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      "Cancelar",
      style: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text(
      "Si salir",
      style: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    onPressed: () {
      BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
      Navigator.of(context).pop();

    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Cerrar sesion"),
    content: Text("desea cerrar sesion?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _HomePageState extends State<HomePage> {
  bool active = false;
  String text = 'Toque para escuchar';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FindTrackApp'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Center(
          child: Container(
            child: Column(
              children: [
                Text(text),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: BlocConsumer<GetmusicBloc, GetmusicState>(
                    listener: (context, state) {
                      if(state is GetmusicSuccess){
                        print(state.Music['result']['title']);
                          active = false;
                          text = 'Toque para escuchar';
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => uniqueSong(nombre: state.Music['result']["title"],album: state.Music['result']["album"], img: state.Music['result']["spotify"]["album"]["images"][0]["url"], artista: state.Music['result']["artist"], apiUrl: state.Music['result']["song_link"], spotifiUrl: state.Music['result']["spotify"]["external_urls"]["spotify"], appleUrl: state.Music['result']["apple_music"]["url"], anio: state.Music['result']["release_date"])));
                          setState(() {});
                      }
                      else if(state is GetmusicError){
                          active = false;
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('No se encontro la cancion!'),
                                    action: SnackBarAction(
                                      label: 'cerrar',
                                      onPressed: () {
                                        // Code to execute.
                                      },
                                    ),
                                  ),
                                );
                        }
                      
                    },
                    builder: (context, state) {
                      return AvatarGlow(
                        glowColor: Colors.blue,
                        endRadius: 200.0,
                        duration: Duration(milliseconds: 1000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 100),
                        animate: active,
                        child: Material(     // Replace this child with your own
                          elevation: 8.0,
                          shape: CircleBorder(),
                          child: IconButton(
                        onPressed: () {
                          active = true;
                          text = 'Escuchando ...';
                          setState(() {});
                          BlocProvider.of<GetmusicBloc>(context)
                              .add(GetMusic());
                        },
                        icon: Image.asset("assets/ondas-de-audio.png"),
                        iconSize: 200,
                      )));
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<ListfavBloc>(context).add(GetListFav());
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>itemsFavs()));
                        }, icon: Icon(Icons.favorite_sharp),
                        iconSize: 75,),
                    IconButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        icon: Icon(Icons.power_settings_new_sharp), iconSize: 75,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
