import 'package:bus/notificationservice.dart';
import 'package:flutter/material.dart';
import 'package:bus/bloc/system/application_bloc.dart';
import 'route/page_name.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ApplicationBloc.getInstance().getPage(PageName.DefaultPage),
    );
  }
}
