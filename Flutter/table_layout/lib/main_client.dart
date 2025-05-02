import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // 파란색 사각형 - 왼쪽 20, 위쪽 40
            Positioned(
              left: 20,
              top: 40,
              child: Container(
                width: 100,
                height: 80,
                color: Colors.blue,
              ),
            ),

            // 주황색 원 - 왼쪽 150, 위쪽 40
            Positioned(
              left: 150,
              top: 40,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // 초록색 타원형 - 왼쪽 20, 위쪽 150
            Positioned(
              left: 20,
              top: 150,
              child: ClipOval(
                child: Container(
                  width: 120,
                  height: 80,
                  color: Colors.green,
                ),
              ),
            ),

            // 보라색 둥근 사각형 - 왼쪽 160, 위쪽 160
            Positioned(
//               left: 160,
//               top: 160,
              left: 60,
              top: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 100,
                  height: 80,
                  color: Colors.purple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
