import 'package:flutter/material.dart';
import '../BLoC/get_bloc.dart';
import '../Model/get_model.dart';

class GetPage extends StatefulWidget {
  const GetPage({Key? key}) : super(key: key);

  @override
  State<GetPage> createState() => _GetPageState();
}

class _GetPageState extends State<GetPage> {
  final bloc = GetBloc();

  @override
  void initState() {
    super.initState();
    bloc.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<List<GetModel>>(
          stream: bloc.data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data![index];
                        return Card(
                          child: ListTile(
                            textColor: const Color.fromARGB(255, 7, 29, 46),
                            leading: Text(post.userId.toString()),
                            title: Text(post.title.toString()),
                            subtitle: Text(post.id.toString()),
                            trailing: Text(post.completed.toString()),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return const Center(child: Text('No posts yet'));
            }
          },
        ),
      ),
    );
  }

}
