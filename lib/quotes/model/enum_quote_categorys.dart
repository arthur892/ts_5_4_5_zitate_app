enum QuoteCategorys {
  all('all', 'alle'),
  supersecret('supersecret', 'supersecret'),
  age('age', 'alter'),
  ;

  const QuoteCategorys(this.apiCall, this.label);
  final String apiCall;
  final String label;
}
