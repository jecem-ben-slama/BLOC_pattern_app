import 'package:flutter/material.dart';
import 'package:test/BLoC/db_bloc.dart';
import '../Model/get_model.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({super.key});

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  late DbBloc _dbBloc;

  @override
  void initState() {
    super.initState();
    _dbBloc = DbBloc();
    _dbBloc.loadDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<GetModel>>(
        stream: _dbBloc.dataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<GetModel> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].title ?? ''),
                  subtitle: Text(data[index].completed.toString()),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _dbBloc.fetchDataAndAddToDatabase();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  @override
  void dispose() {
    _dbBloc.dispose();
    super.dispose();
  }
}
