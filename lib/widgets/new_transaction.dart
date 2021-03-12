import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _inputTitle = TextEditingController();
  final _inputAmount = TextEditingController();
  DateTime _selectedDate;

  void submitted(){
    final enteredTitle = _inputTitle.text;
    final enteredAmount = double.parse(_inputAmount.text);

    if(enteredTitle.isEmpty || enteredAmount<=0 || _selectedDate == null)
      {
        return;
      }

    widget.addTx(enteredTitle,
        enteredAmount,
      _selectedDate
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
  showDatePicker(
  context: context,
  initialDate: DateTime.now(),
    firstDate: DateTime(2010),
    lastDate: DateTime.now(),
  ).then((pickedDate){
    if(pickedDate==null)
      {
        return;
      }
   setState(() {
     _selectedDate=pickedDate;
   });


  });
  print('...');

}


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        height: MediaQuery.of(context).size.height /3.4,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _inputTitle,
              onSubmitted: (_) => submitted,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _inputAmount,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitted(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(child: Text(_selectedDate == null ?'No Date Chosen!':
                  'Picked Date: ${DateFormat.yMd().format(_selectedDate)}')),
                  FlatButton(onPressed: _presentDatePicker, child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold),),
                  textColor: Theme.of(context).primaryColor,)
                ],
              ),
            ),
            // onChanged: (val)=> inputAmount=val
            RaisedButton(
              child: Text('ADD Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed:submitted,
            )
          ],
        ),
      ),
    );
  }
}
