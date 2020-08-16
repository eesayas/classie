import '../exports.dart';
import 'package:http/http.dart' as http;

class Class with ChangeNotifier {
  String id;
  String className;
  DateTime date;
  Schedule adherence;
  List checkedInStudents = [];
  List checkedOutStudents = [];
  List overtimeStudents = [];

  //constructor
  Class({
    this.id,
    this.className,
    this.date,
    this.adherence,
    this.checkedInStudents,
    this.checkedOutStudents,
    this.overtimeStudents,
  });

  //parse from json
  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['_id'],
      className: json['className'],
      date: DateTime.parse(json['date']),
      adherence: Schedule.fromJson(json['adherence']),
      checkedInStudents: json['checkedInStudents'],
      checkedOutStudents: json['checkedOutStudents'],
    );
  }

  //this will show a class and its details from the db
  Future<void> showClass(String classId) async {
    final url = '${DotEnv().env['API_PROXY']}/class/$classId';
    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) return;

      //parse json
      Class classData = Class.fromJson(extractedData);

      //filter overtimes
      Map<String, List> filterResult =
          filterOvertime(classData.checkedInStudents);

      //set values
      id = classData.id;
      className = classData.className;
      date = classData.date;
      adherence = classData.adherence;
      checkedInStudents = new List.from(filterResult['overtimeStudents'])
        ..addAll(filterResult['checkedInStudents']);
      checkedOutStudents = classData.checkedOutStudents;
      overtimeStudents = filterResult['overtimeStudents'];
    } catch (err) {
      throw (err);
    }
  }

  // this will check in a student to a Class
  Future<void> checkInStudent(
      String classId, Map<String, dynamic> studentData) async {
    final String url = '${DotEnv().env['API_PROXY']}/class/$classId/checkin';
    final Map<String, String> headers = {"Content-type": "application/json"};
    final String jsonData = json.encode({
      'student': studentData['student'],
      'span': studentData['span'],
      'classId': classId,
    });

    try {
      //make a put request
      final response = await http.put(url, headers: headers, body: jsonData);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        print('no response on checkInStudent action');
        return;
      }

      //use response from put request and update student arrays
      checkedOutStudents = extractedData['checkedOutStudents'];

      //filter checkedInStudents (detect overtime)
      Map<String, List> filterResult =
          filterOvertime(extractedData['checkedInStudents']);

      //assign properly
      checkedInStudents = new List.from(filterResult['overtimeStudents'])
        ..addAll(filterResult['checkedInStudents']);
      overtimeStudents = filterResult['overtimeStudents'];

      notifyListeners(); //let interested widgets know changes
    } catch (err) {
      throw (err);
    }
  }

  //this will check out a student from Class
  Future<void> checkOutStudent(
      String classId, Map<String, dynamic> studentData) async {
    final String url = '${DotEnv().env['API_PROXY']}/class/$classId/checkout';
    final Map<String, String> headers = {"Content-type": "application/json"};
    final String jsonData = json.encode({
      'student': studentData['student'],
      'span': studentData['span'],
      'classId': classId,
    });

    try {
      //make a put request
      final response = await http.put(url, headers: headers, body: jsonData);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        print('no response on checkOutStudent action');
        return;
      }

      //use response from put request and update student arrays
      checkedOutStudents = extractedData['checkedOutStudents'];

      //filter checkedInStudents (detect overtime)
      Map<String, List> filterResult =
          filterOvertime(extractedData['checkedInStudents']);

      //assign properly
      checkedInStudents = filterResult['checkedInStudents'];
      overtimeStudents = filterResult['overtimeStudents'];

      notifyListeners(); //let interested widgets know changes
    } catch (err) {
      throw (err);
    }
  }
}

//check for overtime students
Map<String, List> filterOvertime(List checkedInData) {
  //populate these arrays accordingly
  List overtimeStudents = [];
  List checkedInStudents = [];

  //temp
  List tempCheckedInData = checkedInData;

  //loop through all check ins
  tempCheckedInData.forEach((checkInData) {
    var expectedEnd = DateTime.parse(checkInData['expectedEnd']);

    //if expectedEnd is passed
    if (expectedEnd.isBefore(new DateTime.now())) {
      var modifiedData = checkInData;

      //modify data
      modifiedData['status'] = 'OVERTIME';
      overtimeStudents.add(modifiedData);

      //still within time
    } else {
      checkedInStudents.add(checkInData);
    }
  });

  //return arrays
  return ({
    'checkedInStudents': checkedInStudents,
    'overtimeStudents': overtimeStudents,
  });
}
