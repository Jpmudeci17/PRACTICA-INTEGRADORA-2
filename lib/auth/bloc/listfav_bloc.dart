
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'listfav_event.dart';
part 'listfav_state.dart';

class ListfavBloc extends Bloc<ListfavEvent, ListfavState> {
  ListfavBloc() : super(ListfavInitial()) {
    on<ListfavEvent>(_getListFav);
  }
}
Future<void> _getListFav(event,emit) async {
  try{
    var queryUser = await FirebaseFirestore.instance
    .collection("Usuarios")
    .doc("${FirebaseAuth.instance.currentUser!.uid}");

    var docsRef = await queryUser.get();
    List<dynamic> dataList = docsRef.data()?["Favoritos"] ?? [];


    emit(ListfavSuccess(data: dataList));


  }catch(e){
    print("Error al obtener todos los items");
    emit(ListfavError());
  }
}