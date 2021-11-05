import 'dart:convert';

import 'package:http/http.dart';
import 'package:istreamodemo/feature/repository/data/repository_response.dart';
import 'package:istreamodemo/service/interface/i_remote_db_service.dart';

class RemoteDatabaseService extends IRemoteDatabaseService {
  @override
  Future<RepositoryResponse> loadRepos(int pageNumber) async {
    try {
      var response = await get(Uri.parse(
          'https://api.github.com/users/JakeWharton/repos?page=$pageNumber&per_page=10'));
      print(
          "Recieved rows ${jsonDecode(response.body).length} Page num $pageNumber");
      if (response.statusCode == 200) {
        return RepositoryResponse.fromJson(jsonDecode(response.body));
      } else {
        return RepositoryResponse.withError('Something went wrong');
      }
    } catch (e, st) {
      print(e);
      print(st);
      return RepositoryResponse.withError('Something went wrong');
    }
  }
}
