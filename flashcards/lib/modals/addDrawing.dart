import 'dart:io';

import 'package:flashcards/views/whiteBoardReview.dart';
import 'package:flutter/material.dart';

addDrawing(BuildContext context) {
  late CanvasController canvasController;
  canvasController = CanvasController();
  canvasController.strokeWidthh = 3.0;

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
                    IconButton(onPressed: () {}, icon: Icon(Icons.check)),
                  ]),
              body: Column(
                children: [
                  Expanded(
                      child: Container(
                          color: Colors.white,
                          child: canvasWidget(
                            canvasController: canvasController,
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
                              canvasController.undo();
                            },
                            icon: Icon(Icons.undo)),
                      ),
                      Container(
                        height: 56,
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: IconButton(
                            onPressed: () {
                              canvasController.redo();
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

InkWell addDrawingColorControls(
    CanvasController canvasController, Color color, BuildContext context) {
  return InkWell(
    onTap: () {
      canvasController.brushColor = color;
    },
    child: Container(
      height: 56,
      color: color,
      width: (MediaQuery.of(context).size.width - 40) / 4,
    ),
  );
}
