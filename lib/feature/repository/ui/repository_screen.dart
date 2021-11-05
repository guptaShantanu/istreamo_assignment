import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istreamodemo/feature/repository/bloc/repository_bloc.dart';
import 'package:istreamodemo/feature/repository/data/repository.dart';
import 'package:istreamodemo/feature/repository/ui/repository_tile.dart';
import 'package:istreamodemo/service/core/istreamo_service.dart';
import 'package:istreamodemo/service/core/remote_db_service.dart';

class RepositoryScreen extends StatefulWidget {
  const RepositoryScreen({Key? key}) : super(key: key);

  @override
  _RepositoryScreenState createState() => _RepositoryScreenState();
}

class _RepositoryScreenState extends State<RepositoryScreen> {
  late RepositoryBloc repositoryBloc;
  late ScrollController controller;
  bool isAvailable = true;
  List<Repository> repos = [];

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    repositoryBloc = RepositoryBloc(IStreamoService(
      RemoteDatabaseService(),
    ));
    repositoryBloc.add(LoadRepositoryEvent());

    controller.addListener(() async {
      if (controller.position.pixels >= controller.position.maxScrollExtent) {
        if (isAvailable) {
          print("New Call");
          var data = await repositoryBloc.loadMoreData();
          if (data.length - repos.length != 10) {
            isAvailable = false;
          }
          setState(() {
            repos = data;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          'Repository',
          style: TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_left_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<RepositoryBloc, RespositoryState>(
        bloc: repositoryBloc,
        builder: (context, state) {
          if (state is RepositoryLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RepositoryErrorState) {
            return const Center(
              child: Text('Something went wrong'),
            );
          } else if (state is RepositoryLoadedState) {
            if (repos.isEmpty) {
              repos = state.repos;
            }
            return ListView.separated(
                controller: controller,
                itemBuilder: (context, index) {
                  if (index == repos.length) {
                    if (isAvailable) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: Container(
                            margin: const EdgeInsets.all(10.0),
                            child: const Text("All cought up")),
                      );
                    }
                  }
                  return RepositoryTile(repository: repos[index]);
                },
                separatorBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 15.0),
                    height: 1.0,
                    color: Colors.grey,
                  );
                },
                itemCount: repos.length + 1);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
