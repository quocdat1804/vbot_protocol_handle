import 'package:flutter/material.dart';
import 'package:protocol_handler/protocol_handler.dart';
import 'package:windows_single_instance/windows_single_instance.dart';
import 'dart:io';

String? _initialUrl;

Future<void> parseAppInitialArguments(List<String> args) async {
  try {
    if (Platform.isLinux) {
      _initialUrl = args.firstOrNull;
    } else if (Platform.isWindows || Platform.isMacOS) {
      _initialUrl = await protocolHandler.getInitialUrl();
    }
    print('parseAppInitialArguments _initialUrl $_initialUrl');
  } catch (error, stacktrace) {
    print('parseAppInitialArguments error $error $stacktrace');
  }
}

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await protocolHandler.register('vbotprotocol');

  await parseAppInitialArguments(args);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VBot Protocol Handler Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ProtocolListener {
  int _counter = 0;
  String _urlProtocol = '';

  @override
  void initState() {
    protocolHandler.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    protocolHandler.removeListener(this);
    super.dispose();
  }

  @override
  void onProtocolUrlReceived(String url) {
    String log = 'Url received: $url)';
    print(log);
    setState(() {
      _urlProtocol = url;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text("Initial URL: $_initialUrl"),
            Text("URL Protocol: $_urlProtocol")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
