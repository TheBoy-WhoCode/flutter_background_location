import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_background_location/app_notification.dart';
import 'package:flutter_background_location/constants.dart';
import 'package:flutter_background_location/location_access.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

const fetchBackground = "fetchBackground";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case Workmanager.iOSBackgroundTask:
        stderr.writeln("The iOS background fetch was triggered");
        break;
      case fetchBackground:
        final currentLocation = await LocationAccess.determinePosition();
        logger.d("The Current Location is: $currentLocation");
        AppNotification notification = AppNotification();
        notification.showNotificationWithoutSound(currentLocation);
        break;
    }
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Background Location',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Background Location'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );

    if (Platform.isAndroid) {
      logger.d("message");
      Workmanager().registerPeriodicTask(
        "1",
        fetchBackground,
        frequency: const Duration(minutes: 15),
      );
    }

    getLocation();
    super.initState();
  }

  var currentLocation;
  getLocation() async {
    currentLocation = await LocationAccess.determinePosition();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(child: Text("$currentLocation")));
  }
}
