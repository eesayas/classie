import '../exports.dart';

//This is a Student Object
class Student {
  final String id;
  String firstName, lastName, barcodeId;
  bool checkedIn;

  //constructor
  Student({
    @required this.id,
    this.firstName,
    this.lastName,
    this.barcodeId,
    this.checkedIn,
  });

  //parse from json
  factory Student.fromJson(Map<String, dynamic> jsonData) {
    return Student(
      id: jsonData['_id'],
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      barcodeId: jsonData['barcodeId'],
      checkedIn: jsonData['checkedIn'],
    );
  }
}
