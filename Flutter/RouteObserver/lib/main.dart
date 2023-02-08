import 'package:flutter/material.dart';

import 'CommonRouteObserver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      navigatorObservers: [CommonRouteObserver()],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _list = const [Route1(), Route2()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UUID Example'),
      ),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text('Route - $index'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => _list[index],
                  settings: RouteSettings(name: '/Route - $index'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Route1 class
class Route1 extends StatelessWidget {
  const Route1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ElevatedButton(
            child: const Text('뒤로가기'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ));
  }
}

// Route2 class
class Route2 extends StatelessWidget {
  const Route2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ElevatedButton(
            child: const Text('뒤로가기'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ));
  }
}