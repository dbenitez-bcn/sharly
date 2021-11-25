import 'package:dartz/dartz.dart';
import 'package:sharlyapp/data/repositories/users_repository.dart';
import 'package:sharlyapp/domain/aggregates/sharly_user.dart';
import 'package:sharlyapp/domain/error/failures/sign_in_failure.dart';

class AuthService {
  final UsersRepository _usersRepository;

  AuthService(UsersRepository usersRepository)
      : _usersRepository = usersRepository;

  Future<Either<SignInFailure, SharlyUser>> signIn() async {
    try {
      var user = await _usersRepository.getAnonymousUser();
      return Right(SharlyUser(user.uuid));
    } catch (_) {
      return Left(SignInFailure());
    }
  }
}
