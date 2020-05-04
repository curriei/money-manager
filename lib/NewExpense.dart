import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'API.dart';

class NewExpense extends StatefulWidget{
  static const routeName = '/newexpense';

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense>{
  MoneyMaskedTextController valueController = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: '',
  );
  String _accountSelected = "A";
  bool validVal = false;
  DateTime date = DateTime.now();
  bool reimbursing = false;

  @override
  Widget build(BuildContext context){    
    return(
      Scaffold(
        appBar: AppBar(
            title: Text("New Expense"),
            leading: Icon(Icons.swap_horiz),
        ),

        body: 
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Enter Date", style:  Theme.of(context).textTheme.headline,),
              FlatButton(
                child: Text(
                  "${date.year} / ${date.month} / ${date.day}",
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: (){
                  DatePicker.showDatePicker(
                    context,
                    minTime: DateTime(date.year-1,1,1),
                    maxTime: DateTime.now(),
                    onChanged: (datePicked) {
                      date = datePicked;
                    }

                  );
                },
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Text("Add Expense Amount", style: Theme.of(context).textTheme.headline,),
              _enterAmount(),
              Padding(
                child: Text(
                  "Enter Account",
                  style: Theme.of(context).textTheme.headline,
                ),
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              ),
              Row(
                children: <Widget>[
                  Text(_accountSelected),
                  DropdownButton<String>(
                    items: <String>['A','B','C','D'].map(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                                value,
                                style: Theme.of(context).textTheme.button,
                            ),
                          );
                        }
                    ).toList(),
                    onChanged: (String value) {
                      setState(() {
                        _accountSelected = value;
                      });
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Divider(thickness: 1,color: Colors.grey,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      "Expecting reimbursement:",
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Checkbox(
                    value: reimbursing,
                    onChanged: (newValue) {
                      setState(() {
                        reimbursing = newValue;
                      });
                    },
                  )
                ],
              ),
            ],
          ),
          padding: EdgeInsets.all(30),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Save",
          backgroundColor: validVal ? Theme.of(context).primaryColor : Colors.grey,
          child: Icon(Icons.check),
          onPressed: (){
            int rtn = ExpenseList.numExpenses;
            if(double.parse(valueController.text) > 0) {
              rtn = ExpenseList.addExpense(
                  double.parse(valueController.text), _accountSelected, date, reimbursing
              );
              Navigator.pop(
                  context, rtn
              );
            }
          },
        ),
      )
    );
  }

  _enterAmount(){
    return(
        TextField(
          controller: valueController,
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.title,
          onChanged: (text){
            if(double.parse(text) > 0)
              setState(() {
                validVal = true;
              });
          },
          decoration: InputDecoration(
            labelText: 'eg. \$25.40',
          ),
        )
    );
  }
}