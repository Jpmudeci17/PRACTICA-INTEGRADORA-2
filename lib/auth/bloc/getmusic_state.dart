part of 'getmusic_bloc.dart';

abstract class GetmusicState extends Equatable {
  const GetmusicState();
  
  @override
  List<Object> get props => [];
}

class GetmusicInitial extends GetmusicState {}

class GetmusicSuccess extends GetmusicState {
  final Map Music;
  GetmusicSuccess({required this.Music});
  @override
  List<Object> get props => [Music];
}

class GetmusicError extends GetmusicState {
  final String error;
  GetmusicError({required this.error});

  @override
  List<Object> get props => [error];
}
