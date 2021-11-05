part of 'repository_bloc.dart';

abstract class RepositoryEvent extends Equatable {
  const RepositoryEvent();
}

class LoadRepositoryEvent extends RepositoryEvent{
  @override
  List<Object?> get props => [];
}

class LoadMoreRepositoryEvent extends RepositoryEvent{
  @override
  List<Object?> get props => [];
}
