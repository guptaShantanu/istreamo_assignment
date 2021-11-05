import 'package:flutter/material.dart';
import 'package:istreamodemo/feature/repository/data/repository.dart';

class RepositoryTile extends StatelessWidget {
  final Repository repository;
  const RepositoryTile({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.book,
            size: 40.0,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    repository.name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Text(
                    repository.description ?? '',
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.code),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${repository.language}',
                        style: const TextStyle(color: Colors.green),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Icon(Icons.person),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${repository.watchersCount}',
                        style: const TextStyle(color: Colors.green),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Icon(Icons.bug_report),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${repository.openIssuesCount}',
                        style: const TextStyle(color: Colors.green),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
