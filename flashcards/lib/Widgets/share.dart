import 'package:flutter/material.dart';

share(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
            insetPadding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width / 1.7,
                horizontal: 20),
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close)),
                title: Text('Share - Beta'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.extended(
                        onPressed: () {},
                        label: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "GENERATE SHARE LINK",
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "Pro: 7 day link expiration",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        Switch(value: false, onChanged: (changed) {}),
                      ],
                    ),
                    Row(
                      children: [
                        Opacity(
                          opacity: 0.5,
                          child: Text("* The expiration of the link is 3 days"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ));
}
