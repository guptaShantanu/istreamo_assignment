import 'package:istreamodemo/feature/repository/data/repository.dart';

class RepositoryResponse {
  bool? status;
  List<Repository>? repos;
  String? errorMsg;

  RepositoryResponse.fromJson(List json) {
    status = true;
    repos = json.map((e) => Repository.fromJson(e)).toList();
  }

  RepositoryResponse.withError(String message) {
    status = false;
    errorMsg = message;
  }
}
