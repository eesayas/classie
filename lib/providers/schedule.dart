import '../exports.dart';

// This is a Slot object (belongs to Spot)
class Slot {
  String schedStartTime;
  String schedEndTime;
  int span;
  int index;
  Student student;

  Slot(
      {this.schedStartTime,
      this.schedEndTime,
      this.span,
      this.index,
      this.student});

  //parse from json
  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        schedStartTime: json['schedStartTime'],
        schedEndTime: json['schedEndTime'],
        span: json['span'],
        index: json['index'],
        student: Student.fromJson(json['student']),
      );
}

// This is a Spot object (belongs to Schedule)
class Spot {
  String name;
  List<Slot> slots = [];

  //constructor for Spot
  Spot({
    this.name,
    this.slots,
  });

  //parse from json
  factory Spot.fromJson(Map<String, dynamic> jsonData) {
    final slotList = jsonData['slots'] as List;
    //use parse of Slot
    List<Slot> slotParse = slotList.map((slot) => Slot.fromJson(slot)).toList();
    return Spot(name: jsonData['name'], slots: slotParse);
  }
}

// This is a Schedule object
class Schedule {
  final String id;
  String title;
  String day;
  String startTime;
  List<Spot> spots = [];

  //constructor for Schedule
  Schedule(
      {@required this.id, this.title, this.day, this.startTime, this.spots});

  //parse from json
  factory Schedule.fromJson(Map<String, dynamic> jsonData) {
    final spotsList = jsonData['spots'] as List;
    //use parse of Spot object
    List<Spot> spotParse =
        spotsList.map((spot) => Spot.fromJson(spot)).toList();

    return Schedule(
      id: jsonData['_id'],
      title: jsonData['title'],
      day: jsonData['day'],
      startTime: jsonData['startTime'],
      spots: spotParse,
    );
  }
}
