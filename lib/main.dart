import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draw n Sich',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DrawCanvas(),
    );
  }
}

class DrawCanvas extends StatefulWidget {
  const DrawCanvas({super.key});

  @override
  State<DrawCanvas> createState() => _DrawCanvasState();
}

class _DrawCanvasState extends State<DrawCanvas> with TickerProviderStateMixin {
  int currentFrame = 0;

  // late AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanDown: (details) {
          setState(() {
            addPointsForCurrentFrame(details.globalPosition);
          });
        },
        onPanUpdate: (details) {
          setState(() {
            addPointsForCurrentFrame(details.globalPosition);
          });
        },
        onPanEnd: (details) {
          setState(() {
            _getPointsForFrame(_currentFrame).add(null);
          });
        },
        child: Center(
          child: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: frameStackHeight,
                  child: frameStack(context),
                ),
                Expanded(
                  child: Container(
                    child: buttonRow(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(
            Icons.play_arrow,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  void addPointsForCurrentFrame(Offset globalPosition) {
    final RenderBox renderBox =
        getWidgetKeyForFrame(currentFrame).currentContext.findRenderObject();
    final offset = renderBox.globalToLocal(globalPosition);

    getPointsForFrame(currentFrame).add(offset);
  }
}
