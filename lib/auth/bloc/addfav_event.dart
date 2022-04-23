part of 'addfav_bloc.dart';

abstract class AddfavEvent extends Equatable {
  const AddfavEvent();

  @override
  List<Object> get props => [];
}
class addFavorite extends AddfavEvent{
  late String nombre;
  late String artista;
  late String img;
  late String apiUrl;

  addFavorite({required this.nombre,required this.artista,required this.img,required this.apiUrl});
  @override
  List<Object> get props => [nombre,artista,img,apiUrl];

}
