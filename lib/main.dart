import 'exports.dart';
import 'package:http/http.dart' as http;

//main will run the code
Future<void> main() async {
  //configure for .env file
  await DotEnv().load('.env');

  //look for live class
  final url = '${DotEnv().env['API_PROXY']}/class/live';
  final response = await http.get(url);
  // if (response.statusCode == 200) {
  //   runApp(ClassieApp('hello'));
  // } else {
  // print(response.statusCode);
  runApp(ClassieApp(null));
  // }
}

//this is the overall app widget
class ClassieApp extends StatelessWidget {
  final String liveClass;

  ClassieApp(this.liveClass);

  @override
  Widget build(BuildContext context) {
    print(liveClass);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Classes(),
          ),
        ],
        child: MaterialApp(
            title: 'Classie',
            theme: ThemeData(
              fontFamily: 'Sarabun',
              textTheme:
                  TextTheme(bodyText1: TextStyle(fontWeight: FontWeight.w900)),
            ),
            home: liveClass != null ? ClassShow() : NoClass(),
            routes: {
              ClassIndex.routeName: (ctx) => ClassIndex(),
              ClassShow.routeName: (ctx) => ClassShow(),
            }));
  }
}
