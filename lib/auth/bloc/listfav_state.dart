part of 'listfav_bloc.dart';

abstract class ListfavState extends Equatable {
  const ListfavState();
  
  @override
  List<Object> get props => [];
}

class ListfavInitial extends ListfavState {}
class ListfavLoad extends ListfavState {}
class ListfavError extends ListfavState {}
class ListfavSuccess extends ListfavState {
  
  final List<dynamic> data;
  ListfavSuccess({required this.data});
  @override
  List<Object> get props => [data];
}
