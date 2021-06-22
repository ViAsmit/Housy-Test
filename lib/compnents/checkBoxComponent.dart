import 'package:flutter/material.dart';

class CheckBoxComponent extends StatelessWidget {
  final String text;
  final bool checked;
  final Function onCheck;
  CheckBoxComponent(
      {this.text = "", this.checked = false, required this.onCheck});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: new Container(
        padding: new EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            new CheckboxListTile(
              activeColor: Colors.pink[300],
              dense: true,
              //font change
              title: new Text(
                text,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5),
              ),
              value: checked,
              onChanged: (val) {
                onCheck(val);
              },
            )
          ],
        ),
      ),
    );
  }
}
