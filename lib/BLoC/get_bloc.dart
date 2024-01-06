// ignore_for_file: avoid_print
import 'package:rxdart/rxdart.dart';
import '../Model/get_model.dart';
import '../Repository/get_repo.dart';

class GetBloc {
  final GetRepo _getRepo = GetRepo();
  final _dataSubject = BehaviorSubject<List<GetModel>>.seeded([]);

  Stream<List<GetModel>> get data => _dataSubject.stream;


  void getData() async {
    _dataSubject.add([]);
    try {
      final data = await _getRepo.fetchAPI();
      _dataSubject.add(data!);
    } catch (error) {
      print("Error fetching data: $error");
    }
  }
}
