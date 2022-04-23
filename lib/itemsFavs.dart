import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/auth/bloc/listfav_bloc.dart';
import 'package:practica2/listFavs.dart';

class itemsFavs extends StatefulWidget {
  itemsFavs({Key? key}) : super(key: key);

  @override
  State<itemsFavs> createState() => _itemsFavsState();
}

class _itemsFavsState extends State<itemsFavs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Mis Favoritos'),
      ),
      body: BlocConsumer<ListfavBloc, ListfavState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if(state is ListfavSuccess){
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (BuildContext context, int index){
              return listFavs(dataList: state.data[index]);});
          }
          else if (state is ListfavError){
            return Center(child: Text('error'),);
          }
          else{
    
            return Center(
                  child:  CircularProgressIndicator());
          }
        },
      ),
    );
  }
}