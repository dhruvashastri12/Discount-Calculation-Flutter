bool isValidNumber(double value) {
  return value != null && value > 0;
}

bool isValidDiscountNumber(double value) {
  return value != null && value > 0 && value < 101;
  print('isValidDiscount: $value');
}
