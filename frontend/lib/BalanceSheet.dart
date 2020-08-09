import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'API.dart';
import 'Menu.dart';

class BalanceSheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return(
      Scaffold(
        appBar: AppBar(
          title: Text('Expenses'),
          leading: Icon(Icons.swap_horiz),
        ),
        endDrawer: Menu(),
        body: ListView(
          children: <Widget>[
            ExpansionTile(title: Text("Assets \$${ExpenseList.getTotalAssets()}"),
              children: <Widget>[
                ListTile(title: Text("Cash in bank: \$${ExpenseList.getCashInBank()}"),),
                ListTile(title: Text("Cash on hand: \$${ExpenseList.getCashOnHand()}")),
                ListTile(title: Text("Accounts receivable: \$${ExpenseList.getTotalReimburse()}")),
                ListTile(title: Text("Long term assets")),
              ],
            ),
            ExpansionTile(title: Text("Liabilities"),
              children: <Widget>[
                ListTile(title: Text("Accounts Payable")),
                ListTile(title: Text("Long term liabilities")),
              ],),
            ListTile(title: Text("Net Equity")),
          ],
        )
      )
    );
  }
}