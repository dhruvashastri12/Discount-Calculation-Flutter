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
  int selectedRadio;
  double payableAmount = 0.0;
  String savingAmount = '0.0';

  var _itemEditController = TextEditingController();
  var _discountEditController = TextEditingController();

  final snackbar = SnackBar(
    content: Text('Negative value not allowed'),
  );

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    _discountEditController.addListener(_printLatestPayableAmount);
  }

  // Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  _printLatestPayableAmount() {
    print("Second text field: ${_discountEditController.text}");
    calculateDiscount();
  }

  calculateDiscount() {
    if (_itemEditController.text.length > 0 &&
        _discountEditController.text.length > 0 &&
        !_itemEditController.text.contains("-") &&
        !_discountEditController.text.contains("-")) {
      if (selectedRadio == 0) {
        setState(() {
          payableAmount = double.parse(_itemEditController.text) -
              double.parse(_discountEditController.text);
          savingAmount = _discountEditController.text;
          print('Flat Discount: $payableAmount');
        });
      } else {
        double cuttingPrice = double.parse(_itemEditController.text) *
            (double.parse(_discountEditController.text) / 100);
        setState(() {
          payableAmount = double.parse(_itemEditController.text) - cuttingPrice;
          savingAmount = cuttingPrice.toStringAsFixed(2);
          print('Saving Amount: $savingAmount');
          print('Percentage Discount: $payableAmount');
        });
      }
      // _itemEditController.clear();
      // _discountEditController.clear();
      // FocusScope.of(context).requestFocus(FocusNode());
    } // else {
    //   Scaffold.of(context).showSnackBar(snackbar);
    // }
  }

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
              suffixIcon: IconButton(
                icon: Icon(Icons.cancel, color: Colors.grey[400]),
                onPressed: () {
                  _itemEditController.clear();
                  payableAmount = 0.0;
                  savingAmount = '0.0';
                },
              ),
              border: OutlineInputBorder(),
              labelText: 'Enter Item Price',
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Radio(
                value: 0,
                groupValue: selectedRadio,
                onChanged: (val) {
                  print("Radio $val");
                  setSelectedRadio(val);
                },
              ),
              new Text(
                'Flat Amount',
                style: new TextStyle(fontSize: 16.0),
              ),
              new Radio(
                value: 1,
                groupValue: selectedRadio,
                onChanged: (val) {
                  print("Radio $val");
                  setSelectedRadio(val);
                },
              ),
              new Text(
                'Percentage',
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          TextField(
            controller: _discountEditController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.cancel, color: Colors.grey[400]),
                onPressed: () {
                  _discountEditController.clear();
                  payableAmount = 0.0;
                  savingAmount = '0.0';
                },
              ),              
              border: OutlineInputBorder(),
              labelText: 'Enter Discount',
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            'Total Payable Amount',
            style: TextStyle(fontSize: 30.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            '$payableAmount',
            style: TextStyle(color: Colors.blue, fontSize: 40.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'You Save',
            style: TextStyle(fontSize: 30.0),
            textAlign: TextAlign.center,
          ),
          Text(
            '$savingAmount',
            style: TextStyle(color: Colors.blue, fontSize: 35.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

        ],
      ),
    );
  }
}
