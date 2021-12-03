part of 'list_bloc.dart';

abstract class ListEvent extends Equatable {
  const ListEvent();
}

class ListChangedEvent extends ListEvent {
  final SharedList selectedList;

  const ListChangedEvent(this.selectedList);

  @override
  List<Object?> get props => [selectedList];
}
