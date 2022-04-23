import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:practica2/auth/bloc/listfav_bloc.dart';

part 'eliminatefav_event.dart';
part 'eliminatefav_state.dart';

class EliminatefavBloc extends Bloc<EliminatefavEvent, EliminatefavState> {
  EliminatefavBloc() : super(EliminatefavInitial()) {
    on<removeFav>(_deletesong);
  }
}
Future<void> _deletesong(removeFav event, Emitter emit)async {

  late Map <String,dynamic> songToDel = {
    'nombre': event.mysong['nombre'],
    'artista': event.mysong['artista'],
    'img': event.mysong['img'],
    'apiUrl': event.mysong['apiUrl']
  };
  // print(songToDel);
  try{
  var qUser = await FirebaseFirestore.instance
  .collection("Usuarios")
  .doc("${FirebaseAuth.instance.currentUser!.uid}");

  var docsRef = await qUser.get();
  List<dynamic> listIds = docsRef.data()?["Favoritos"];

  List <Map<String,dynamic>> newList=[];

        for(var song in listIds){
        if(!mapEquals(song, songToDel)){
          newList.add(song);
        }
      }
    print(newList);
    var qdelete = await FirebaseFirestore.instance
    .collection("Usuarios")
    .doc("${FirebaseAuth.instance.currentUser!.uid}")
    .update({'Favoritos':newList});
    emit(EliminatefavSuccess());

  // await qUser.update({"Favoritos": listIds}); 
  }
  catch(e){
      print("Error: $e");
  }
}