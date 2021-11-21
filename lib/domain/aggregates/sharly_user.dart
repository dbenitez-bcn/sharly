import 'package:equatable/equatable.dart';

class SharlyUser extends Equatable{
  final String _uuid;

  SharlyUser(this._uuid);

  String get uuid => _uuid;

  @override
  List<Object?> get props => [_uuid];

}