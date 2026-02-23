import 'package:draw_app/src.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final AnimationController animationController;
  final UndoRedoStack undoRedoStack;
  final ValueNotifier<List<Stroke>> allSketches;
  final bool canUndo;
  final int test;

  const CustomAppBar({
    super.key,
    required this.animationController,
    required this.undoRedoStack,
    required this.allSketches,
    required this.canUndo,
    required this.test,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                if (animationController.value == 0) {
                  animationController.forward();
                } else {
                  animationController.reverse();
                }
              },
              icon: const Icon(Icons.menu),
            ),
            const Text(
              'Let\'s Draw',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
            ListenableBuilder(
              listenable: allSketches,
              builder: (context, _) {
                if (allSketches.value.isNotEmpty) {
                  return IconButton(
                    onPressed: () => undoRedoStack.clear(),
                    icon: const Icon(Icons.delete),
                  );
                } else {
                  return const SizedBox(width: 48);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
