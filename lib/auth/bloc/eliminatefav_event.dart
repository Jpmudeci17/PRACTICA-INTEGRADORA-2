part of 'eliminatefav_bloc.dart';

abstract class EliminatefavEvent extends Equatable {
  const EliminatefavEvent();

  @override
  List<Object> get props => [];
}
class removeFav extends EliminatefavEvent{
  late Map <String,dynamic> mysong;

  removeFav({required this.mysong});
  @override
  List<Object> get props => [mysong];

}