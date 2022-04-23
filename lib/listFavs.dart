import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/auth/bloc/eliminatefav_bloc.dart';
import 'package:practica2/auth/bloc/listfav_bloc.dart';
import 'package:practica2/itemsFavs.dart';
import 'package:url_launcher/url_launcher.dart';

class listFavs extends StatefulWidget {
  Map<String, dynamic> dataList;
  listFavs({Key? key, required this.dataList}) : super(key: key);

  @override
  State<listFavs> createState() => _listFavsState();
}

class _listFavsState extends State<listFavs> {
  showAlertDialogDelfav(BuildContext context) {
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
        "Si borrar",
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        BlocProvider.of<EliminatefavBloc>(context)
            .add(removeFav(mysong: widget.dataList));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Eliminar de favoritos"),
      content: Text("desea eliminar la cancion a favoritos?"),
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

  showAlertDialogGotofav(BuildContext context) {
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
        "Si ir",
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onPressed: () {
        launch(widget.dataList['apiUrl']);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Ir"),
      content: Text("desea escuchar la cancion?"),
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
    return BlocConsumer<EliminatefavBloc, EliminatefavState>(
      listener: (context, state) {
        if(state is EliminatefavSuccess){
          setState(() {
            BlocProvider.of<ListfavBloc>(context).add(GetListFav());
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>itemsFavs()));
            print('object');
          });
        }
      },
      builder: (context, state) {
        return Card(
          color: Colors.grey,
          margin: EdgeInsets.all(20),
          // shape:  OutlineInputBorder(
          //     // borderRadius: BorderRadius.circular(10),
          //     borderSide: BorderSide(color: Colors.black, width: 5)

          // ),
          child: Stack(
            children: [
              Center(
                  child: GestureDetector(
                      onTap: () => showAlertDialogGotofav(context),
                      child: Image.network(widget.dataList['img'],
                          cacheHeight: 370))),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 310, 00, 0),
                child: Center(
                  child: Container(
                    color: Colors.blue.withOpacity(0.80),
                    height: 60,
                    width: 350,

                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    showAlertDialogDelfav(context);
                  },
                  icon: Icon(Icons.favorite)),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 320, 00, 0),
                  child: Column(
                    children: [
                      Text(
                        widget.dataList['nombre'],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.dataList['artista'],
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
