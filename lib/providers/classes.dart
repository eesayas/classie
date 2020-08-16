import '../exports.dart';
import 'package:http/http.dart' as http;

class Classes with ChangeNotifier {
  List<Class> _classes = [];
  Class _liveClass;

  /*
  @desc This provide all the classes to interested widgets
  */
  List<Class> get classes {
    return [..._classes];
  }

  /*
  @desc This will provide  the live class
  */
  Class get liveClass {
    return _liveClass;
  }

  /*
  @desc This will return the data of a specific class by its id
  */
  Class findById(String id) {
    return _classes.firstWhere((element) => element.id == id);
  }

  /*
  @desc This will fetch all the classes from the database 
  */
  Future<void> fetchClasses() async {
    final url = '${DotEnv().env['API_PROXY']}/class';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List;
      List<Class> classData =
          extractedData.map((data) => Class.fromJson(data)).toList();

      if (extractedData == null) return;
      final List<Class> loadedData = [];

      classData.forEach((data) {
        //filter
        Map<String, List> filterResult = filterOvertime(data.checkedInStudents);

        loadedData.add(Class(
            id: data.id,
            className: data.className,
            date: data.date,
            adherence: data.adherence,
            checkedInStudents: new List.from(filterResult['overtimeStudents'])
              ..addAll(filterResult['checkedInStudents']),
            checkedOutStudents: data.checkedOutStudents,
            overtimeStudents: filterResult['overtimeStudents']));
      });

      _classes = loadedData;
      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }

  /*
  @desc This will get the live class
  */
  Future<void> fetchLiveClass() async {
    final url = '${DotEnv().env['API_PROXY']}/class/live';
    try {
      final response = await http.get(url);
      print(response.statusCode);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) return;

      //parse json
      Class classData = Class.fromJson(extractedData);

      //filter overtimes
      Map<String, List> filterResult =
          filterOvertime(classData.checkedInStudents);

      //assign to live  class
      _liveClass = Class(
          id: classData.id,
          className: classData.className,
          date: classData.date,
          checkedInStudents: filterResult['checkedInStudents'],
          checkedOutStudents: classData.checkedOutStudents,
          overtimeStudents: filterResult['overtimeStudents']);

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
