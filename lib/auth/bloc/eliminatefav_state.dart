part of 'eliminatefav_bloc.dart';

abstract class EliminatefavState extends Equatable {
  const EliminatefavState();
  
  @override
  List<Object> get props => [];
}

class EliminatefavInitial extends EliminatefavState {}
class EliminatefavSuccess extends EliminatefavState {}
class EliminatefavError extends EliminatefavState {}
