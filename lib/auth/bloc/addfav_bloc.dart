import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

part 'addfav_event.dart';
part 'addfav_state.dart';

class AddfavBloc extends Bloc<AddfavEvent, AddfavState> {
  AddfavBloc() : super(AddfavInitial()) {
    on<addFavorite>(_setFavorite);
  }
}
Future<void> _setFavorite(addFavorite event, Emitter emit)async {

  bool res = await _saveFavorite(event.nombre, event.artista, event.img, event.apiUrl);
  if(res){
    emit(AddfavSuccess());
  }
  else{
    emit(AddfavError());
  }
}

Future<bool> _saveFavorite(String nombre,String artista,String img,String apiUrl) async {

  Map data ={
    'nombre': nombre,
    'artista': artista,
    'img': img,
    'apiUrl': apiUrl
  };
  try{
      var qUser = await FirebaseFirestore.instance
        .collection("Usuarios")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

      var docsRef = await qUser.get();
      List<dynamic> listIds = docsRef.data()?["Favoritos"];


      for(var song in listIds){
        if(mapEquals(song, data)){
          return false;
        }
      }

      listIds.add(data);

      await qUser.update({"Favoritos": listIds});
      return true;

    }catch(e){
      print("Error: $e");
      return false;
    }


}