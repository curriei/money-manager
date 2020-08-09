class ExpenseList {
  static final expenses = List<Map<String,dynamic>>();
  static final total = Map<String,double>();
  static final accounts = List<String>();
  static double grandTotal = 0.0;
  static int numExpenses = 0;
  static int numReimburses = 0;
  static double totalReimburse = 0.0;
  static double startingBankBalance = 500;
  static double startingCashBalance = 20;


  static int addExpense(double amount, String account, DateTime date, bool reimburse){
    expenses.add({'account': account,'amount': amount, 'date' : date, 'reimburse' : reimburse});
    if (!total.containsKey(account)) {
      accounts.add(account);
      accounts.sort();
      total[account] = 0;
    }
    numReimburses += reimburse ? 1 : 0;
    totalReimburse += reimburse ? amount : 0;
    total[account]+=amount;
    grandTotal += amount;
    return numExpenses++;
  }

  static String getGrandTotal(){
    return _toPrintDollar(grandTotal);
  }

  static int getNumAccounts(){
    return accounts.length;
  }

  static String getAccountName(int index){
    return accounts[index];
  }

  static String getAccountTotal(String accountName){
    return _toPrintDollar(total[accountName]);
  }

  static int getNumExpenses(){
    return expenses.length;
  }

  static Map<String,dynamic> getExpense(int index){
    return expenses[index];
  }

  static int getNumReimbursements(){
    return numReimburses;
  }
  static String getTotalReimburse(){
    return _toPrintDollar(totalReimburse);
  }
  static String getTotalAssets(){
    return _toPrintDollar(totalReimburse+startingBankBalance+startingCashBalance-grandTotal);
  }
  static String getCashInBank(){
    return _toPrintDollar(startingCashBalance-grandTotal);
  }
  static String getCashOnHand(){
    return _toPrintDollar(startingCashBalance);
  }
  static String _toPrintDollar(double amount){
    return amount.toStringAsFixed(2);
  }
}