import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget{
  static final listExpensesRouteName = 'listexpenses';
  static final reimbursementsRouteName = 'reimbursements';
  static final balanceRouteName = 'balances';
  static final homeRouteName = '/';

  @override
  Widget build(BuildContext context) {
    return (Drawer(
        child: ListView(
          padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
          children: <Widget>[
            ListTile(
              title: Text(
                'Accounts',
                style: Theme.of(context).textTheme.title,
              ),
              onTap: () => onTapFunc(context, homeRouteName),
            ),
            ListTile(
              title: Text('Balance Sheet', style: Theme.of(context).textTheme.title),
              onTap: () => onTapFunc(context, balanceRouteName),
            ),
            ListTile(
              title: Text('Expenses', style: Theme.of(context).textTheme.title),
              onTap: () => onTapFunc(context, listExpensesRouteName),
            ),
            ListTile(
              title: Text(
                "Reimbursements",
                style: Theme.of(context).textTheme.title,
              ),
              onTap:  () => onTapFunc(context, reimbursementsRouteName),
            ),
          ],
        )));
  }

  onTapFunc(BuildContext context, String selected){
    bool isSame = false;
    Navigator.popUntil(context, (route) {
      if(route.settings.name == selected){
        isSame = true;
      }
      return true;
    });
    if(!isSame) {
      Navigator.pushNamed(context, selected);
    }
    else{
      Navigator.pop(context);
    }
  }
}