import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'auth/bloc/addfav_bloc.dart';

class uniqueSong extends StatefulWidget {
  uniqueSong(
      {Key? key,
      required this.nombre,
      required this.artista,
      required this.album,
      required this.anio,
      required this.img,
      required this.spotifiUrl,
      required this.apiUrl,
      required this.appleUrl})
      : super(key: key);
  String nombre;
  String artista;
  String album;
  String anio;
  String img;
  String spotifiUrl;
  String apiUrl;
  String appleUrl;
  @override
  State<uniqueSong> createState() => _uniqueSongState();
}

class _uniqueSongState extends State<uniqueSong> {
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
        "Si agregar",
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        BlocProvider.of<AddfavBloc>(context).add(addFavorite(
            nombre: widget.nombre,
            artista: widget.artista,
            img: widget.img,
            apiUrl: widget.apiUrl));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Agregar a favoritos"),
      content: Text("desea agregar la cancion a favoritos?"),
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddfavBloc, AddfavState>(
      listener: (context, state) {
        if(state is AddfavSuccess){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Se Guardo en favoritos!'),
              action: SnackBarAction(
                label: 'cerrar',
                onPressed: () {
                  // Code to execute.
                },
              ),
            ),
          );
        }
        else if(state is AddfavError){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('No Guardo en favoritos!'),
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
        return Scaffold(
            appBar: AppBar(
              title: Text('Material App Bar'),
              actions: [
                IconButton(
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    icon: Icon(Icons.favorite))
              ],
            ),
            body: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Center(
                    child: Container(
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(widget.img, cacheHeight: 340),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Column(
                        children: [
                          Text(
                            widget.nombre,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            widget.album,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            widget.artista,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            widget.anio,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            launch(widget.spotifiUrl);
                          },
                          icon: Image.asset(
                            "assets/spotify.png",
                            color: Colors.white,
                          ),
                          iconSize: 75,
                        ),
                        IconButton(
                          onPressed: () {
                            launch(widget.apiUrl);
                          },
                          icon: Icon(Icons.link),
                          iconSize: 75,
                        ),
                        IconButton(
                          onPressed: () {
                            launch(widget.appleUrl);
                          },
                          icon: Icon(Icons.apple),
                          iconSize: 75,
                        ),
                      ],
                    )
                  ],
                )))));
      },
    );
  }
}
