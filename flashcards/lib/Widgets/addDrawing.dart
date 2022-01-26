import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flashcards/Modals/providerManager.dart';
import 'package:flashcards/Modals/smallWidgets.dart';
import 'package:flashcards/views/whiteBoardReview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/src/provider.dart';

addDrawing(BuildContext context) {
  late CanvasController canvasController;
  canvasController = CanvasController();
  canvasController.strokeWidthh = 3.0;
  final addDrawingKey = GlobalKey();

  void generateImageBytes(BuildContext context) async {
    if (canvasController.isEmpty) return;
    RenderRepaintBoundary boundary = addDrawingKey.currentContext!
        .findRenderObject()! as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    context.read<pictureBLOBControl>().sendPictureUint8List(pngBytes);
  }

  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            insetPadding: EdgeInsets.all(20),
            child: Scaffold(
              appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                  actions: [
                    IconButton(
                        onPressed: () {
                          generateImageBytes(context);
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.check)),
                  ]),
              body: Column(
                children: [
                  Expanded(
                      child: Container(
                          color: Colors.white,
                          child: RepaintBoundary(
                            key: addDrawingKey,
                            child: canvasWidget(
                              canvasController: canvasController,
                            ),
                          ))),
                  Row(
                    children: [
                      Container(
                        height: 56,
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: IconButton(
                            onPressed: () {
                              canvasController.strokeWidthh = 3.0;
                            },
                            icon: Icon(Icons.brightness_1, size: 7)),
                      ),
                      Container(
                        height: 56,
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: IconButton(
                            onPressed: () {
                              canvasController.strokeWidthh = 7.0;
                            },
                            icon: Icon(Icons.brightness_1, size: 15)),
                      ),
                      Container(
                        height: 56,
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: IconButton(
                            onPressed: () {
                              canvasController.strokeWidthh = 15.0;
                            },
                            icon: Icon(Icons.brightness_1, size: 20)),
                      ),
                      Container(
                        height: 56,
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: IconButton(
                            onPressed: () {
                              canvasController.isEraseMode = true;
                            },
                            icon: Icon(Icons.redo)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      addDrawingColorControls(
                          canvasController, Colors.purple, context),
                      addDrawingColorControls(
                          canvasController, Colors.green, context),
                      addDrawingColorControls(
                          canvasController, Colors.red, context),
                      addDrawingColorControls(
                          canvasController, Colors.yellow, context)
                    ],
                  ),
                  Row(
                    children: [
                      addDrawingColorControls(
                          canvasController, Colors.blue, context),
                      addDrawingColorControls(
                          canvasController, Colors.lightGreen, context),
                      addDrawingColorControls(
                          canvasController, Colors.red, context),
                      addDrawingColorControls(
                          canvasController, Colors.black, context)
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      });
}
