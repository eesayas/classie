import '../exports.dart';

class AddStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          border: Border.all(
              width: 3, color: textPurple, style: BorderStyle.solid)),
      child: Center(child: Icon(Icons.add, color: textPurple, size: 50)),
    );
  }
}
