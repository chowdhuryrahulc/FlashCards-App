import 'package:flutter/material.dart';

enum CanvasBackground { dots, vlines, hlines, grid, none }

class WhiteBoardReview extends StatefulWidget {
  String? currentSetUsedForDatabaseSearch;
  WhiteBoardReview({
    Key? key,
    this.currentSetUsedForDatabaseSearch,
  }) : super(key: key);

  @override
  _WhiteBoardReviewState createState() => _WhiteBoardReviewState();
}

class _WhiteBoardReviewState extends State<WhiteBoardReview> {
  bool vissible = true;
  late CanvasController canvasController;

  @override
  void initState() {
    super.initState();
    canvasController = CanvasController();
    canvasController.strokeWidthh = 3.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[400],
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'OSAKA',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Visibility(
        visible: !vissible,
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[400],
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'KAMAMOTO',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
      Expanded(
          // key: stickeyKey,
          child: Container(
              color: Colors.white,
              child: canvasWidget(
                canvasController: canvasController,
              ))),
      Row(
        children: [
          Container(
            height: 56,
            color: Colors.lightGreen,
            width: MediaQuery.of(context).size.width / 4,
            child: IconButton(
                onPressed: () {
                  canvasController.strokeWidthh = 3.0;
                },
                icon: Icon(Icons.brightness_1, size: 7)),
          ),
          Container(
            height: 56,
            color: Colors.lightGreen,
            width: MediaQuery.of(context).size.width / 4,
            child: IconButton(
                onPressed: () {
                  canvasController.strokeWidthh = 7.0;
                },
                icon: Icon(Icons.brightness_1, size: 15)),
          ),
          Container(
            color: Colors.lightGreen,
            height: 56,
            width: MediaQuery.of(context).size.width / 4,
            child: IconButton(
                onPressed: () {
                  canvasController.undo();
                },
                icon: Icon(Icons.undo)),
          ),
          Container(
            color: Colors.lightGreen,
            height: 56,
            width: MediaQuery.of(context).size.width / 4,
            child: IconButton(
                onPressed: () {
                  canvasController.redo();
                },
                icon: Icon(Icons.redo)),
          ),
        ],
      ),
      Visibility(
        visible: vissible,
        child: InkWell(
          onTap: () {
            setState(() {
              vissible = !vissible;
            });
          },
          child: Container(
              color: Colors.blue,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'SHOW ANSWER',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )),
        ),
      ),
      Visibility(
        visible: !vissible,
        child: Container(
          height: 56,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 56,
                width: MediaQuery.of(context).size.width / 3,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      // N = N + 1;
                    });
                  },
                  child: Text("Hard"),
                  color: Colors.red,
                ),
              ),
              Container(
                height: 56,
                width: MediaQuery.of(context).size.width / 3,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      // N = N + 1;
                    });
                  },
                  child: Text("Normal"),
                  color: Colors.blue,
                ),
              ),
              Container(
                height: 56,
                width: MediaQuery.of(context).size.width / 3,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      // N = N + 1;
                    });
                  },
                  child: Text("Easy"),
                  color: Colors.green,
                ),
              )
            ],
          ),
        ),
      ),
    ]));
  }
}

class canvasWidget extends StatefulWidget {
  final CanvasController? canvasController;
  const canvasWidget({Key? key, this.canvasController}) : super(key: key);

  @override
  _canvasWidgetState createState() => _canvasWidgetState();
}

class _canvasWidgetState extends State<canvasWidget> {
  void initState() {
    super.initState();
    if (widget.canvasController == null) {
      // Probable for 1st time. When app starts.
      canvasController = CanvasController();
      canvasController.strokeWidthh = 5.0;
      canvasController.brushColor = Colors.black;
      canvasController.backgroundColor = Colors.grey[100]!;
    } else {
      canvasController = widget.canvasController!;
    }
  }

  late CanvasController canvasController;

  void onStart(DragStartDetails startDetails) {
    final renderBox = context.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(startDetails.globalPosition);
    canvasController._pathHistory.add(localPosition);
    canvasController._notifyListeners();
  }

  void onUpdateDetails(DragUpdateDetails updateDetails) {
    final renderBox = context.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(updateDetails.globalPosition);
    canvasController._pathHistory.updateCurrent(localPosition);
    canvasController._notifyListeners();
  }

  void onEnd(DragEndDetails downDetails) {
    canvasController._notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanStart: (startDetails) => onStart(startDetails),
        onPanUpdate: (updateDetails) => onUpdateDetails(updateDetails),
        onPanEnd: (downDetails) => onEnd(downDetails),
        child: CustomPaint(
          willChange: true,
          painter: CanvasPainter(canvasController._pathHistory,
              painterModel: canvasController),
          child: Container(),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class CanvasController extends ChangeNotifier {
  Color _color = Colors.black;
  Color _backgroundColor = Colors.white;
  double _strokeWidth = 4.0;
  bool _isEraseMode = false;

  final _PathHistory _pathHistory = _PathHistory();

  bool get isEmpty => _pathHistory.isPathsEmpty;

  List<MapEntry<Path, Paint>> get paths => _pathHistory.paths;

  Color get brushColor => _color;

  bool get isEraseMode => _isEraseMode;

  bool get isUndoEmpty => _pathHistory.isUndoEmpty;

  CanvasBackground _background = CanvasBackground.none;

  CanvasBackground get background => _background;

  set background(CanvasBackground value) {
    _background = value;
    _updatePaint();
    notifyListeners();
  }

  set isEraseMode(bool value) {
    _isEraseMode = value;
    _updatePaint();
    notifyListeners();
  }

  set brushColor(Color color) {
    _color = color;
    _updatePaint();
  }

  Color get backgroundColor => _backgroundColor;

  set backgroundColor(Color color) {
    _backgroundColor = color;
    _updatePaint();
  }

  double get strokeWidthh => _strokeWidth;

  set strokeWidthh(double thickness) {
    print(thickness);
    _strokeWidth = thickness;
    _updatePaint();
  }

  void _updatePaint() {
    Paint paint = Paint();
    if (_isEraseMode) {
      paint.blendMode = BlendMode.clear;
    } else {
      paint.blendMode = BlendMode.srcOver;
    }
    paint.color = brushColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = strokeWidthh;

    Paint backGroundPaint = Paint();
    backGroundPaint.blendMode = BlendMode.dstOver;
    backGroundPaint.color = backgroundColor;

    _pathHistory._paint = paint;
    _pathHistory._backgroundPaint = backGroundPaint;
    _pathHistory.background = background;
    notifyListeners();
  }

  void undo() {
    if (isEmpty) return;
    _pathHistory.undo();
    notifyListeners();
  }

  void redo() {
    if (isUndoEmpty) return;
    _pathHistory.redo();
    notifyListeners();
  }

  void _notifyListeners() {
    // UseLess
    notifyListeners();
  }

  void clear() {
    _pathHistory.clear();
    notifyListeners();
  }
}

class CanvasPainter extends CustomPainter {
  final _PathHistory _path;

  /// if the model updates paint will repaint
  CanvasPainter(this._path, {Listenable? painterModel})
      : super(repaint: painterModel);

  @override
  void paint(Canvas canvas, Size size) {
    _path.draw(canvas, size);
  }

  @override
  bool shouldRepaint(CanvasPainter oldDelegate) => false;
}

class _PathHistory {
  final List<MapEntry<Path, Paint>> _paths;
  final List<MapEntry<Path, Paint>> _undoHistory;
  bool _isUndo = false;
  Paint _paint;
  Paint _backgroundPaint;

// enum CanvasBackground { dots, vlines, hlines, grid, none }
  CanvasBackground _background = CanvasBackground.none;

  CanvasBackground get background => _background;

  set background(CanvasBackground value) {
    _background = value;
  }

  bool get isPathsEmpty => _paths.isEmpty;

  bool get isUndo => _isUndo;

  bool get isUndoEmpty => _undoHistory.isEmpty;

  set isUndo(bool value) {
    _isUndo = value;
  }

  List<MapEntry<Path, Paint>> get paths => _paths;

  _PathHistory()
      : _paths = <MapEntry<Path, Paint>>[],
        _undoHistory = <MapEntry<Path, Paint>>[],
        _backgroundPaint = Paint()
          ..blendMode = BlendMode.dstOver
          ..color = Colors.white,
        _paint = Paint()
          ..color = Colors.black
          ..strokeWidth = 1.0
          ..style = PaintingStyle.fill;

  void setBackgroundColor(Color backgroundColor) {
    _backgroundPaint.color = backgroundColor;
  }

  void undo() {
    final removed = _paths.removeLast();
    _undoHistory.add(removed);
    isUndo = true;
  }

  void redo() {
    _paths.add(_undoHistory.removeLast());
  }

  void clear() {
    _paths.clear();
  }

// onPanStart
  void add(Offset startPoint) {
    Path path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    _paths.add(MapEntry<Path, Paint>(path, _paint));
    if (isUndo) {
      isUndo = false;
      _undoHistory.clear();
    }
  }

// onPanUpdate
  void updateCurrent(Offset nextPoint) {
    Path path = _paths.last.key;
    path.lineTo(nextPoint.dx, nextPoint.dy);
  }

// Called from CustomPainter (void paint {void shouldRepaint})
  void draw(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());
    for (MapEntry<Path, Paint> path in _paths) {
      Paint p = path.value;
      canvas.drawPath(path.key, p);
    }
    canvas.restore();
  }
}
