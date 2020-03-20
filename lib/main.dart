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
  final Color scaffoldColor = Color(0Xff8A7FED);
  final Color appbarColor = Color(0XffA4E898);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: Text('Discount Calculator', style: TextStyle(color: Colors.black87),),
      ),
      body: Container(
        child: CalcBody(),
      ),
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
  
  final Color textColor = Colors.black54;

  var _itemEditController = TextEditingController();
  var _discountEditController = TextEditingController();

  final snackbar = SnackBar(
    content: Text('Negative value not allowed'),
  );

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    _itemEditController.addListener(calculateDiscount);
    _discountEditController.addListener(calculateDiscount);
  }

  // Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  // Business Logic to calculate discount
  calculateDiscount() {
    if (_itemEditController.text.length > 0 &&
        _discountEditController.text.length > 0) {
      if (!_itemEditController.text.contains("-") &&
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
            payableAmount =
                double.parse(_itemEditController.text) - cuttingPrice;
            savingAmount = cuttingPrice.toStringAsFixed(2);
            print('Saving Amount: $savingAmount');
            print('Percentage Discount: $payableAmount');
          });
        }
      } else {
        Scaffold.of(context).showSnackBar(snackbar); // check this, snackbar shows on wrong scenario
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        // Card 1 for input data
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
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
                          FocusScope.of(context).requestFocus(FocusNode());
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
                        activeColor: Colors.black87,
                        groupValue: selectedRadio,
                        onChanged: (val) {
                          print("Radio $val");
                          setSelectedRadio(val);
                          if (!(_discountEditController.text == null)) {
                            calculateDiscount();
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                      ),
                      new Text(
                        'Flat Amount',
                        style: new TextStyle(fontSize: 16.0, color: textColor),
                      ),
                      new Radio(
                        value: 1,
                        activeColor: Colors.black,
                        groupValue: selectedRadio,
                        onChanged: (val) {
                          print("Radio $val");
                          setSelectedRadio(val);
                          if (!(_discountEditController.text == null)) {
                            calculateDiscount();
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                      ),
                      new Text(
                        'Percentage',
                        style: new TextStyle(fontSize: 16.0, color: textColor),
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
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Enter Discount',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        // Card 2 to display data
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Payable Amount',
                        style: TextStyle(fontSize: 25.0, color: textColor),
                        textAlign: TextAlign.left,
                      ),
                      Expanded(
                        child: Text(
                          '$payableAmount',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'You Save',
                        style: TextStyle(fontSize: 22.0, color: textColor),
                        textAlign: TextAlign.left,
                      ),
                      Expanded(
                        child: Text(
                          '$savingAmount',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
