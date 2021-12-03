part of 'list_bloc.dart';

abstract class ListState extends Equatable {
  const ListState();
}

class ListSelectSuccess extends ListState {
  final SharedList currentList;

  const ListSelectSuccess(this.currentList);

  @override
  List<Object> get props => [];
}
