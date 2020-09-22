import 'package:flutter/material.dart';

class DCRadioButton extends StatefulWidget {
  final int selectedRadio;
  final String label_1;
  final String label_2;
  // final String radioBtnLabel;

  final Function onRadioChanged;

  DCRadioButton(
      {@required this.selectedRadio,
      @required this.label_1,
      @required this.label_2,
      // @required this.radioBtnLabel,
      @required this.onRadioChanged});

  @override
  _DCRadioButtonState createState() => _DCRadioButtonState();
}

class _DCRadioButtonState extends State<DCRadioButton> {
  int selectedValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // from blog https://medium.com/@hrishikesh.deshmukh445/working-with-reusable-radio-button-widgets-in-flutter-1ee1b912916f
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      // Percentage radio button
      Radio(
        value: 0,
        activeColor: Colors.white60,
        groupValue: widget.selectedRadio,
        onChanged: widget.onRadioChanged,
      ),
      Text(
        widget.label_1,
        style: new TextStyle(
            fontSize: 17.0, fontWeight: FontWeight.w400, color: Colors.white60),
      ),
      SizedBox(
        width: 10,
      ),

      // Flat amount radio button
      Radio(
        value: 1,
        activeColor: Colors.white60,
        groupValue: widget.selectedRadio,
        onChanged: widget.onRadioChanged,
      ),
      Text(
        widget.label_2,
        style: new TextStyle(
            fontSize: 17.0, fontWeight: FontWeight.w400, color: Colors.white60),
      )
    ]);
  }
}

// Note: madeby dhs
// Row(
//       children: <Widget>[
//         Radio(
//             value: widget.selectedRadio,
//             activeColor: Colors.white60,
//             groupValue: widget.selectedRadio,
//             onChanged: widget.onRadioChanged ?? () {}
//         ),
//         Text(
//           widget.radioBtnLabel,
//           style: new TextStyle(
//               fontSize: 17.0,
//               fontWeight: FontWeight.w400,
//               color: Colors.white60),
//         )
//       ],
//     );
