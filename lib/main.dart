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
        title: Text(
          'Discount Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
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
  // String roundedPayableAmount = '0.0';
  double savingAmount = 0.0;

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
    _discountEditController.addListener(() {
      setState(() {
        print("Second text field: ${_discountEditController.text}");

        if (_discountEditController.text.length > 0) {
          print('discountValueValidator text length');
          if (int.parse(_discountEditController.text) < 100) {
            discountValueValidator = false;
            print(discountValueValidator.toString());
          } else {
            discountValueValidator = true;
            print(discountValueValidator.toString());
          }
        } else {
          print('discountValueValidator text length zero');
        }
      });
    });

    try {
      if (Foundation.kDebugMode) {
        print("App in debug mode");
      } else if (Foundation.kReleaseMode) {
        print("App in release mode");
      } else {
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
    if (_itemEditController.text.length > 0 &&
        _discountEditController.text.length > 0) {
      if ((!_itemEditController.text.contains("-")) &&
          (!_discountEditController.text.contains("-"))) {
        if (selectedRadio == 0) {
          double cuttingPrice = double.parse(_itemEditController.text) *
              (double.parse(_discountEditController.text) / 100);
          setState(() {
            payableAmount =
                (double.parse(_itemEditController.text) - cuttingPrice)
                    .roundToDouble();
            savingAmount = cuttingPrice.roundToDouble();
            // roundedPayableAmount = payableAmount.toStringAsFixed(2);
            print('Cutting Price: $cuttingPrice');
            print('Saving Amount: $savingAmount');
            print('Percentage Discount: $payableAmount');
          });
        } else {
          setState(() {
            payableAmount = (double.parse(_itemEditController.text) -
                    double.parse(_discountEditController.text))
                .roundToDouble();
            savingAmount =
                double.parse(_discountEditController.text).roundToDouble();

            print('Flat Discount: $payableAmount');
          });
        }
      } else {
        Scaffold.of(context).showSnackBar(
            snackbar); // check this, snackbar shows on wrong scenario
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Theme(
                    data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.white60,
                        disabledColor: Colors.white60),
                    // Discount type radio buttons
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Percentage discount radio button
                        ReusableRadioBtn(selectedRadio: selectedRadio, discountEditController: _discountEditController),
                        ReusableRadioBtnLabel(radioBtnLabel: 'Percentage',textColor: textColor),

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
                        ReusableRadioBtnLabel(radioBtnLabel: 'Flat Amount', textColor: textColor),
                      ],
                    ),
                  ),

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
                              savingAmount = 0.0;
                            });
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white60, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white60, width: 1.0),
                        ),
                        labelText: 'Enter Item Price',
                        labelStyle: TextStyle(
                            color: textColor,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w400)),
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
                            savingAmount = 0.0;
                          });
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white60, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white60, width: 1.0),
                      ),
                      labelText: 'Enter Discount',
                      labelStyle: TextStyle(
                          color: textColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w400),
                      errorText: discountValueValidator
                          ? 'Please enter discount value < 100%'
                          : null,
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white60, width: 1.0),
                      ),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  // Saved Amount after discount Text Display
                  ReusableDataDisplayWidget(
                      displayLabelTxt: 'You Save',
                      textColor: textColor,
                      labelFontSize: 22.0,
                      amntFontSize: 26.0,
                      amount: savingAmount),
                  SizedBox(height: 7.0),
                  // Final Payable Amount Text Display
                  ReusableDataDisplayWidget(
                      displayLabelTxt: 'Payable Amount',
                      textColor: textColor,
                      labelFontSize: 25.0,
                      amntFontSize: 30.0,
                      amount: payableAmount),
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

class ReusableRadioBtn extends StatelessWidget {
  const ReusableRadioBtn({
    Key key,
    @required this.selectedRadio,
    @required TextEditingController discountEditController,
  }) : _discountEditController = discountEditController, super(key: key);

  final int selectedRadio;
  final TextEditingController _discountEditController;

  @override
  Widget build(BuildContext context) {
    return new Radio(
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
    );
  }
}

class ReusableRadioBtnLabel extends StatelessWidget {
  const ReusableRadioBtnLabel({@required this.radioBtnLabel, @required this.textColor});

  final String radioBtnLabel;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return new Text(
      radioBtnLabel,
      style: new TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w400,
          color: textColor),
    );
  }
}

class ReusableDataDisplayWidget extends StatelessWidget {
  ReusableDataDisplayWidget(
      {@required this.displayLabelTxt,
      @required this.textColor,
      @required this.labelFontSize,
      @required this.amntFontSize,
      @required this.amount});

  final Color textColor;
  final double amount;
  final String displayLabelTxt;
  final double labelFontSize;
  final double amntFontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          displayLabelTxt,
          style: TextStyle(fontSize: labelFontSize, color: textColor),
          textAlign: TextAlign.left,
        ),
        // Expanded(
        Text(
          '$amount Rs',
          style: TextStyle(
              color: Colors.black,
              fontSize: amntFontSize,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        // ),
      ],
    );
  }
}
