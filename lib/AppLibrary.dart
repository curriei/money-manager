class ExpenseList {
  static final expenses = List<Map<String,dynamic>>();
  static final total = Map<String,double>();
  static final accounts = List<String>();
  static double grandTotal = 0.0;
  static int numExpenses = 0;
  static int numReimburses = 0;

  static int addExpense(double amount, String account, DateTime date, bool reimburse){
    expenses.add({'account': account,'amount': amount, 'date' : date, 'reimburse' : reimburse});
    if (!total.containsKey(account)) {
      accounts.add(account);
      accounts.sort();
      total[account] = 0;
    }
    numReimburses += reimburse ? 1 : 0;
    total[account]+=amount;
    grandTotal += amount;
    return numExpenses++;
  }
}