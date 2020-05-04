import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/API.dart';
import 'Menu.dart';
import 'NewExpense.dart';

class Reimbursements extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reimbursements'),
        leading: Icon(Icons.swap_horiz),
      ),
        endDrawer: Menu(),
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
          itemCount: ExpenseList.getNumExpenses(),
          itemBuilder: (context, index){
            final expense = ExpenseList.getExpense(index);
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
            if(ExpenseList.getNumReimburesements() == 0 && index == 0)
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

