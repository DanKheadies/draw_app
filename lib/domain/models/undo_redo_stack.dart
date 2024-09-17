import 'package:draw_app/src.dart';
import 'package:flutter/material.dart';

class UndoRedoStack {
  final ValueNotifier<List<Stroke>> strokesNotifier;
  final ValueNotifier<Stroke?> currentStrokeNotifier;

  UndoRedoStack({
    required this.strokesNotifier,
    required this.currentStrokeNotifier,
  }) {
    _strokeCount = strokesNotifier.value.length;
    strokesNotifier.addListener(_strokesCountListener);
    _canRedo = ValueNotifier(_redoStack.isNotEmpty);
  }

  late int _strokeCount;
  late final ValueNotifier<bool> _canRedo;

  bool _isRedoing = false;
  List<Stroke>? _redoStackInternal;
  List<Stroke> get _redoStack => _redoStackInternal ??= [];

  ValueNotifier<bool> get canRedo => _canRedo;

  void _strokesCountListener() {
    if (!_isRedoing && strokesNotifier.value.length > _strokeCount) {
      // If a new Stroke is drawn, history is invalidated so clear redo stack.
      _redoStack.clear();
      _canRedo.value = false;
      _strokeCount = strokesNotifier.value.length;
    }
  }

  void clear() {
    _strokeCount = 0;
    strokesNotifier.value = [];
    _redoStackInternal?.clear();
    currentStrokeNotifier.value = null;
    _canRedo.value = false;
  }

  void undo() {
    if (strokesNotifier.value.isNotEmpty) {
      _strokeCount--;
      final strokes = List<Stroke>.from(strokesNotifier.value);
      _redoStack.add(strokes.removeLast());
      strokesNotifier.value = strokes;
      _canRedo.value = _redoStack.isNotEmpty;
      currentStrokeNotifier.value = null;
    }
  }

  void redo() {
    if (_redoStack.isNotEmpty) {
      _isRedoing = true;

      final strokes = List<Stroke>.from(strokesNotifier.value);
      strokes.add(_redoStack.removeLast());
      strokesNotifier.value = strokes;
      _canRedo.value = _redoStack.isNotEmpty;
      _strokeCount++;

      _isRedoing = false;
    }
  }

  void dispose() {
    strokesNotifier.removeListener(_strokesCountListener);
  }
}
