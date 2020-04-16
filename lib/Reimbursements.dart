import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/AppLibrary.dart';
import 'package:moneymanager/main.dart';

import 'ListExpenses.dart';
import 'NewExpense.dart';

class Reimbursements extends StatelessWidget{
  static final routeName = "reimbursements";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reimbursements'),
        leading: Icon(Icons.swap_horiz),
      ),
        endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Accounts',
                    style: Theme.of(context).textTheme.title,
                  ),
                  onTap: () {Navigator.pushReplacementNamed(context,MyHomePage.routeName);},
                ),
                ListTile(
                    title: Text(
                        'Expenses',
                        style: Theme.of(context).textTheme.title),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, ListExpenses.routeName);
                    }
                ),
                ListTile(
                  title: Text(
                    "Reimbursements",
                    style: Theme.of(context).textTheme.title,
                  ) ,
                  onTap: () {Navigator.pop(context);},
                ),
              ],
            )
        ),
        body: ReimbursementsSF(),
    );
  }
}

class ReimbursementsSF extends StatefulWidget{
  @override
  _ReimbursementState createState() => _ReimbursementState();
}

class _ReimbursementState extends State<ReimbursementsSF>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: ExpenseList.numExpenses,
          itemBuilder: (context, index){
            final expense = ExpenseList.expenses[index];
            if(expense['reimburse'])
              return ListTile(
                title: Text('${expense['date'].year}/${expense['date'].month}/${expense['date'].day}'),
                subtitle: Text(expense['account'] + ": \$${expense['amount'].toStringAsFixed(2)}"),
                trailing: Checkbox(
                  value: expense['reimburse'],
                  onChanged: (val) {setState(() {
                    expense['reimburse'] = val;
                  });},
                ),
              );
            if(ExpenseList.numReimburses == 0 && index == 0)
              return ListTile(title: Text("No outstanding reimbursements."));
            return Container();
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, NewExpense.routeName);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),

    );

  }
}

