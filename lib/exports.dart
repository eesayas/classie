//flutter lib
export 'dart:async';
export 'dart:convert';
export 'package:flutter/material.dart';
export 'package:flutter_dotenv/flutter_dotenv.dart';
export 'package:provider/provider.dart';
export 'package:flutter/services.dart';
export 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

//custom screens
export 'screens/login.dart';
export 'screens/register.dart';
export 'screens/class_index.dart';
export 'screens/class_show.dart';
export 'screens/no_class.dart';

//custom widgets
export 'widgets/send_alarm.dart';
export 'widgets/class_card.dart';
export 'widgets/add_class.dart';
export 'widgets/add_student.dart';
export 'widgets/student_dialog.dart';
export 'widgets/student_card.dart';
export 'widgets/checkout_dialog.dart';

//providers
export 'providers/class.dart';
export 'providers/classes.dart';
export 'providers/student.dart';
export 'providers/schedule.dart';

//helpers
export 'helpers/twilio.dart';
export 'helpers/hexcolor.dart';

//controllers
export 'controllers/twilio_sender.dart';
