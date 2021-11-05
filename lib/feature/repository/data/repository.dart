class Repository {
  int? id;
  String? name;
  String? fullName;
  String? description;
  String? language;
  int? watchersCount;
  int? openIssuesCount;

  Repository.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    fullName = json['full_name'];
    description = json['description'];
    language = json['language'];
    watchersCount = json['watchers_count'];
    openIssuesCount = json['open_issues_count'];
  }
}
