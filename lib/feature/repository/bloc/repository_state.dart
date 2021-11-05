part of 'repository_bloc.dart';

abstract class RespositoryState extends Equatable {
  const RespositoryState();
}

class RepositoryLoadingState extends RespositoryState {
  @override
  List<Object?> get props => [];
}

class RepositoryLoadedState extends RespositoryState {
  final List<Repository> repos;
  final bool isAvailable;

  const RepositoryLoadedState({required this.repos,required this.isAvailable});
  @override
  List<Object?> get props => [];
}

class RepositoryErrorState extends RespositoryState {
  @override
  List<Object?> get props => [];
}
