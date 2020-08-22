import '../exports.dart';
import 'package:http/http.dart' as http;

import '../exports.dart';
import '../exports.dart';

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
      overtimeStudents: json['overtimeStudents'],
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

      //set values
      id = classData.id;
      className = classData.className;
      date = classData.date;
      adherence = classData.adherence;
      checkedInStudents = classData.checkedInStudents;
      overtimeStudents = classData.overtimeStudents;
      checkedOutStudents = classData.checkedOutStudents;

      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }

  // this will check in a student to a Class
  Future<void> checkInStudent(
      String classId, Map<String, dynamic> studentData) async {
    final String url = '${DotEnv().env['API_PROXY']}/class/$classId/checkin';
    final Map<String, String> headers = {"Content-type": "application/json"};

    //encode data to be sent to server
    final String jsonData = json.encode({
      'studentId': studentData['student'],
      'span': studentData['span'],
    });

    try {
      //make a put request
      final response = await http.put(url, headers: headers, body: jsonData);

      //decode server response
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        print('no response on checkInStudent action');
        return;
      }

      //edit student arrays
      checkedInStudents = extractedData['checkedInStudents'];
      overtimeStudents = extractedData['overtimeStudents'];
      checkedOutStudents = extractedData['checkedOutStudents'];

      //send check in to socket
      sendCheckIn();

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
      'status': studentData['status'],
      'startTime': studentData['startTime'],
      'expectedEnd': studentData['expectedEnd'],
      'endTime': studentData['endTime'],
      'span': studentData['span'],
      'classId': classId,
    });

    try {
      //make a put request
      final response = await http.put(url, headers: headers, body: jsonData);

      //decode response server
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        print('no response on checkOutStudent action');
        return;
      }

      //edit student arrays
      checkedInStudents = extractedData['checkedInStudents'];
      overtimeStudents = extractedData['overtimeStudents'];
      checkedOutStudents = extractedData['checkedOutStudents'];

      sendCheckOut();

      notifyListeners(); //let interested widgets know changes
    } catch (err) {
      throw (err);
    }
  }
}
