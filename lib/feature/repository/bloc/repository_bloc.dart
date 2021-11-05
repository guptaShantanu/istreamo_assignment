import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istreamodemo/feature/repository/data/repository.dart';
import 'package:istreamodemo/service/core/istreamo_service.dart';

part 'repository_event.dart';
part 'repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RespositoryState> {
  final IStreamoService service;
  int currentPage = 1;
  RepositoryBloc(this.service) : super(RepositoryLoadingState());
  List<Repository> repos = [];
  @override
  Stream<RespositoryState> mapEventToState(RepositoryEvent event) async* {
    if (event is LoadRepositoryEvent) {
      yield* loadData();
    } else if (event is LoadMoreRepositoryEvent) {
      // yield* loadMoreData();
    }
  }

  Stream<RespositoryState> loadData() async* {
    var data = await service.loadData(currentPage);
    if (data.status == true) {
      currentPage += 1;
      repos = data.repos!;
      yield RepositoryLoadedState(repos: data.repos!, isAvailable: true);
      // yield
    } else {
      yield RepositoryErrorState();
    }
  }

  Future<List<Repository>> loadMoreData() async {
    var prevRepo = (state as RepositoryLoadedState).repos;
    print("Current rows ${prevRepo.length}");
    var data = await service.loadData(currentPage);
    if (data.status == true) {
      currentPage += 1;
      repos = repos + data.repos!;
      return repos;
    } else {
      return [];
    }
  }
}
