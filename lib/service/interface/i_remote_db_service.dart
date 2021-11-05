import 'package:istreamodemo/feature/repository/data/repository_response.dart';

abstract class IRemoteDatabaseService {
  Future<RepositoryResponse> loadRepos(int pageNumber);
}
