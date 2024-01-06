// ignore_for_file: avoid_print
import 'package:rxdart/rxdart.dart';
import 'package:test/Model/get_model.dart';
import '../repository/db_repo.dart';
import '../repository/get_repo.dart';

class DbBloc {
  final DbRepo _dbRepo = DbRepo();
  final GetRepo _getRepo = GetRepo();
  final BehaviorSubject<List<GetModel>> _dataSubject =
      BehaviorSubject<List<GetModel>>.seeded([]);

  Stream<List<GetModel>> get dataStream => _dataSubject.stream;

  Future<void> fetchDataAndAddToDatabase() async {
    try {
      List<GetModel>? apiData = await _getRepo.fetchAPI();

      if (apiData != null && apiData.isNotEmpty) {
        for (final model in apiData) {
          await _dbRepo.insertData(model);
        }

        _dataSubject.add(await _dbRepo.getAllData());
      } else {
        throw Exception('API data is null or empty');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> loadDataFromDatabase() async {
    try {
      final List<GetModel> data = await _dbRepo.getAllData();
      _dataSubject.add(data);
    } catch (e) {
      print('Error: $e');
    }
  }

  void dispose() {
    _dataSubject.close();
  }
}
