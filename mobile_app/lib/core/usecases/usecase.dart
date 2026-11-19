import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:keeperpass/core/erros/failures.dart';

abstract class Usecase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

abstract class UnawaitedUsecase<T, Params> {
  Either<Failure, T> call(Params params);
}

abstract class UsecaseStream<T, Params> {
  Stream<Either<Failure, T>> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => <Object>[];
}
