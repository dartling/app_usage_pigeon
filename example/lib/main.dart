import 'package:app_usage/app_usage_api.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:app_usage/app_usage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  List<UsedApp> _usedApps = [];

  final _appUsagePlugin = AppUsage();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    List<UsedApp> usedApps;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _appUsagePlugin.getPlatformVersion() ??
          'Unknown platform version';
      usedApps = await _appUsagePlugin.apps;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      usedApps = [];
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _usedApps = usedApps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Usage'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Running on: $_platformVersion\n'),
            ),
            ..._usedApps.map(_toAppTile)
          ],
        ),
      ),
    );
  }

  Widget _toAppTile(UsedApp app) {
    return Builder(builder: (context) {
      return UsedAppTile(
        app: app,
        onSetTimer: () async {
          // TODO: Set duration manually.
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          final result = await _appUsagePlugin.setAppTimeLimit(
              app.id, const Duration(minutes: 30));
          scaffoldMessenger
              .showSnackBar(SnackBar(content: Text(result.message)));
        },
        onBlock: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Not supported.')));
        },
      );
    });
  }
}

class UsedAppTile extends StatelessWidget {
  const UsedAppTile({
    Key? key,
    required this.app,
    required this.onSetTimer,
    required this.onBlock,
  }) : super(key: key);

  final UsedApp app;
  final VoidCallback onSetTimer;
  final VoidCallback onBlock;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(app.name),
      subtitle: Text(Duration(minutes: app.minutesUsed).toString()),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.timer_outlined),
            onPressed: onSetTimer,
          ),
          IconButton(
            icon: const Icon(Icons.app_blocking_outlined),
            onPressed: onBlock,
          ),
        ],
      ),
    );
  }
}
