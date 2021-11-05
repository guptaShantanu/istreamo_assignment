import 'package:istreamodemo/feature/repository/data/repository_response.dart';
import 'package:istreamodemo/service/interface/i_remote_db_service.dart';

class IStreamoService {
  final IRemoteDatabaseService remoteDatabaseService;

  IStreamoService(this.remoteDatabaseService,);

  Future<RepositoryResponse> loadData(int pageNumber) async{
    return await remoteDatabaseService.loadRepos(pageNumber);
  }
}
