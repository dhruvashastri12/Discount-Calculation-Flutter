import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discount Calculator Demo',
      home: DiscCalculation(),
      
    );
  }

}

class DiscCalculation extends StatefulWidget {

  @override
  _DiscCalculationState createState() => _DiscCalculationState();
}

class _DiscCalculationState extends State<DiscCalculation> {
  double itemPriceValue;
  double discountPriceValue;
  double payableAmount = 0.0;
  var _itemEditController = TextEditingController();
  var _discountEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _itemEditController,
                      onChanged: (value) {
                        print('item price: $value');
                        itemPriceValue = double.parse(value);
                        print('parsed: $itemPriceValue');
                      },
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
                      onChanged: (value) {
                        print('discount amount: $value');
                        discountPriceValue = double.parse(value);
                        print('parsed: $discountPriceValue');
                      },
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
                            setState(() {
                              payableAmount = itemPriceValue - discountPriceValue;
                              print('total Flat: $payableAmount');                              
                            });
                            _itemEditController.clear();
                            _discountEditController.clear();
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: Text('Flat'),
                        ),
                        RaisedButton(
                          onPressed: () {
                            double cuttingPrice =
                                itemPriceValue * (discountPriceValue / 100);
                            print('Cutting Price: $cuttingPrice');
                            setState(() {
                              payableAmount = itemPriceValue - cuttingPrice;
                              print('Total Payable Amount: $payableAmount');                              
                            });
                            _itemEditController.clear();
                            _discountEditController.clear();
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: Text('Percentage'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    Text('Total Payable Amount', style: TextStyle(fontSize: 30.0),),
                    SizedBox(height: 10.0,),
                    Text('$payableAmount', style: TextStyle(fontSize: 45.0),)
                  ],
          ),
        ),
      );
    
  }
}
