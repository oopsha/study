import 'package:flutter/material.dart';

void main() {
  final params = Uri.base.queryParameters;
  runApp(MyApp(params: params));
}

class MyApp extends StatelessWidget {
  final Map<String, String> params;

  const MyApp({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '쿼리 파라미터 표시',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('쿼리스트링 보기'),
        ),
        body: Center(
          child: params.isEmpty
              ? const Text('쿼리 파라미터가 없습니다.')
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: params.entries.map((entry) {
                    return Text(
                      '${entry.key}: ${entry.value}',
                      style: const TextStyle(fontSize: 20),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
