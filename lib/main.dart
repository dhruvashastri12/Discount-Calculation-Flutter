import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as Foundation;

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
  
  final Color scaffoldColor = Color(262834);
  final Color appbarColor = Color(0Xff5a91a0);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: Text('Discount Calculator', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
        bottom: PreferredSize(
          child: Container(
            color: Color(0Xff5a91a0),
            height: 1.0,
          ),
        preferredSize: Size.fromHeight(0.0)),
   
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
  bool discountValueValidator;
  double payableAmount = 0.0;
  String savingAmount = '0.0';
  
  final Color textColor = Colors.white60;
  final Color cardColor = Color(0Xff5a91a0);

  var _itemEditController = TextEditingController();
  var _discountEditController = TextEditingController();

  final snackbar = SnackBar(
    content: Text('Negative value not allowed'),
  );

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    discountValueValidator = false;
    _itemEditController.addListener(calculateDiscount);
    _discountEditController.addListener(calculateDiscount);

      try {
        if(Foundation.kDebugMode) {
          print("App in debug mode");
        }else if(Foundation.kReleaseMode){
          print("App in release mode");
        }else{
          print("App in profile mode");
        }
      } on Exception catch (e) {
            e.toString();
      }
  }

  // Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  // Business Logic to calculate discount
  calculateDiscount() {
    if (_itemEditController.text.length > 0 && _discountEditController.text.length > 0 ){
        if (int.parse(_discountEditController.text) < 100) {
          discountValueValidator = false;
          print(discountValueValidator.toString());
          if (!_itemEditController.text.contains("-") &&
              !_discountEditController.text.contains("-")) {
              
            if (selectedRadio == 0) {
              double cuttingPrice = double.parse(_itemEditController.text) *
                  (double.parse(_discountEditController.text) / 100);
              setState(() {
                payableAmount =
                    double.parse(_itemEditController.text) - cuttingPrice;
                savingAmount = cuttingPrice.toStringAsFixed(2);
                print('Cutting Price: $cuttingPrice');
                print('Saving Amount: $savingAmount');
                print('Percentage Discount: $payableAmount');
              });
            } 
            else {
              setState(() {
                payableAmount = double.parse(_itemEditController.text) -
                    double.parse(_discountEditController.text);
                savingAmount = _discountEditController.text;
                print('Flat Discount: $payableAmount');
              });
            }
          } else {
            Scaffold.of(context).showSnackBar(snackbar); // check this, snackbar shows on wrong scenario
          }
        }else{
          discountValueValidator = true;
          print(discountValueValidator.toString());
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
            color: cardColor,
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Theme(data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.white60, disabledColor: Colors.white60),
                  // Discount type radio buttons
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,                    
                    children: <Widget>[
                      // Percentage discount radio button
                      new Radio(
                        value: 0,
                        activeColor: Colors.white60,
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
                        style: new TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400, color: textColor),
                      ),

                      // Flat discount radio button
                      new Radio(
                        value: 1,
                        activeColor: Colors.white60,
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
                        style: new TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400, color: textColor),
                      ),
                    ],
                  ),),

                  SizedBox(height: 10.0),

                  // Item Price TextField Widget
                  TextField(
                    cursorColor: textColor,
                    controller: _itemEditController,
                    style: TextStyle(color: textColor),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.cancel, color: Colors.white24),
                        onPressed: () {
                          _itemEditController.clear();
                          setState(() {
                            payableAmount = 0.0;
                            savingAmount = '0.0';                          
                          });
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                      focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white60, width: 1.0),),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60, width: 1.0),),
                      labelText: 'Enter Item Price',
                      labelStyle: TextStyle(color: textColor, fontSize: 17.0, fontWeight: FontWeight.w400)
                    ),
                  ),

                  SizedBox(height: 15.0),

                  // Discount Amount TextField Widget
                  TextField(
                    cursorColor: textColor,
                    controller: _discountEditController,
                    style: TextStyle(color: textColor),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.cancel, color: Colors.white24),
                        onPressed: () {
                          _discountEditController.clear();
                          setState(() {
                            payableAmount = 0.0;
                            savingAmount = '0.0';                            
                          });
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                      focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white60, width: 1.0),),                      
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60, width: 1.0),),
                      labelText: 'Enter Discount',
                      labelStyle: TextStyle(color: textColor, fontSize: 17.0, fontWeight: FontWeight.w400),
                      errorText: discountValueValidator ? 'Please enter discount value < 100%' : null
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 3.0,
        ),

        // Card 2 to display data
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: cardColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  // Saved Amount after discount Text Display
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'You Save',
                        style: TextStyle(fontSize: 22.0, color: textColor),
                        textAlign: TextAlign.left,
                      ),
                      // Expanded(
                        Text(
                          '$savingAmount Rs',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                      // ),
                    ],
                  ),

                  SizedBox(height:7.0),
                  // Final Payable Amount Text Display
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Payable Amount',
                        style: TextStyle(fontSize: 25.0, color: textColor),
                        textAlign: TextAlign.left,
                      ),
                      // Expanded(
                        Text(
                          '$payableAmount Rs',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
