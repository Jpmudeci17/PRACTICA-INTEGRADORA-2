part of 'listfav_bloc.dart';

abstract class ListfavEvent extends Equatable {
  const ListfavEvent();

  @override
  List<Object> get props => [];
}
class GetListFav extends ListfavEvent{}
