
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practica2/auth/bloc/auth_bloc.dart';
import 'package:practica2/secrets/variables.dart';

import 'package:record/record.dart';
part 'getmusic_event.dart';
part 'getmusic_state.dart';

class GetmusicBloc extends Bloc<GetmusicEvent, GetmusicState> {
  GetmusicBloc() : super(GetmusicInitial()) {
    on<GetMusic>(_getMusic);
  }
  Future<void> _getMusic (GetmusicEvent event, Emitter emit) async {
    var song = await sendGetMusic();
    if(song['result']!=null){
    print(song);
      emit(GetmusicSuccess(Music:song));
    }
    else{
      emit(GetmusicError(error:'no se encontro la cancion'));

    }
  }

  Future sendGetMusic() async {
    Duration time = Duration(seconds: 10);
    final record = Record();
    try{

      bool result = await record.hasPermission();

      // Start recording
      await record.start(
        encoder: AudioEncoder.AAC, // by default
        bitRate: 128000, // by default
        samplingRate: 44100, // by default
      );

      await Future.delayed(time);
      var song = await record.stop();

      if(song==null)
        return;

      File file = File(song);
      final file2 = file.readAsBytesSync();
      String img_64 = base64Encode(file2);
    final String url = "https://api.audd.io/";

      // Response res = await post(Uri.parse(url),body:{
      //   'audio': img_64,
      //   'return': 'apple_music,spotify',
      //   'api_token': '0043ab4e5b9c3871591d2547d22f98a6'
      // });

      http.Response res = await http.post(Uri.parse(url), body: {
        'audio': img_64,
        'return': 'apple_music,spotify',
        'api_token': apiSong
      });
      log(jsonDecode(res.body).toString());
      if(res.statusCode == HttpStatus.ok){
        return jsonDecode(res.body);
      }

      
    }
    catch(e){
      print(e);
    }

  }


}
