import 'package:flutter/material.dart';
import 'package:flutter_exit_windows_ex/flutter_exit_windows_ex.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              RaisedButton(
                onPressed: () async {
                  print(await FlutterExitWindowsEx.exitWindowsEx(EWX_SHUTDOWN));
                },
                child: Text("关机 Shutdown"),
              ),
              RaisedButton(
                onPressed: () async {
                  print(await FlutterExitWindowsEx.exitWindowsEx(EWX_LOGOFF));
                },
                child: Text("注销 Logoff"),
              ),
              RaisedButton(
                onPressed: () async {
                  print(await FlutterExitWindowsEx.exitWindowsEx(EWX_REBOOT));
                },
                child: Text("重启 Reboot"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
