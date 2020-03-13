import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discount Calculator',
      home: DiscCalculation(),
    );
  }
}

class DiscCalculation extends StatefulWidget {
  @override
  _DiscCalculationState createState() => _DiscCalculationState();
}

class _DiscCalculationState extends State<DiscCalculation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discount Calculator'),
      ),
      body: CalcBody(),
    );
  }
}

class CalcBody extends StatefulWidget {
  @override
  _CalcBodyState createState() => _CalcBodyState();
}

class _CalcBodyState extends State<CalcBody> {
  double payableAmount = 0.0;

  var _itemEditController = TextEditingController();

  var _discountEditController = TextEditingController();
  final snackbar = SnackBar(
    content: Text('Negative value not allowed'),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          TextField(
            controller: _itemEditController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter Item Price',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _discountEditController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter Discount Amount',
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  if (!_itemEditController.text.contains("-") &&
                      !_discountEditController.text.contains("-")) {
                    setState(() {
                      payableAmount = double.parse(_itemEditController.text) -
                          double.parse(_discountEditController.text);
                      print('total Flat: $payableAmount');
                    });
                    _itemEditController.clear();
                    _discountEditController.clear();
                    FocusScope.of(context).requestFocus(FocusNode());
                  } else {
                    Scaffold.of(context).showSnackBar(snackbar);
                  }
                },
                child: Text('Flat'),
              ),
              RaisedButton(
                onPressed: () {
                  double cuttingPrice = double.parse(_itemEditController.text) *
                      (double.parse(_discountEditController.text) / 100);
                  print('Cutting Price: $cuttingPrice');
                  if (!_itemEditController.text.contains("-") &&
                      !_discountEditController.text.contains("-")) {
                    setState(() {
                      payableAmount =
                          double.parse(_itemEditController.text) - cuttingPrice;
                      print('Total Payable Amount: $payableAmount');
                    });
                    _itemEditController.clear();
                    _discountEditController.clear();
                    FocusScope.of(context).requestFocus(FocusNode());
                  } else {
                    Scaffold.of(context).showSnackBar(snackbar);
                  }
                },
                child: Text('Percentage'),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Total Payable Amount',
            style: TextStyle(fontSize: 30.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            '$payableAmount',
            style: TextStyle(fontSize: 45.0),
          )
        ],
      ),
    );
  }
}
