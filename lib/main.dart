import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Estimator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _usertransactions = [
    // Transaction(
    //   id: 'T1',
    //   title: 'Mobile Phones',
    //   amount: 80.97,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'T2',
    //   title: 'Weekly Groceries',
    //   amount: 78.97,
    //   date: DateTime.now(),
    // ),
  ];

  void _addNewTx(String titleTx, double amountTx, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: titleTx,
        amount: amountTx,
        date: chosenDate
    );

    setState(() {
      _usertransactions.add(newTx);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTx),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTransaction {
    return _usertransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),
      ),
      );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _usertransactions.removeWhere((tx)
      {
        return tx.id==id;
      });
    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Budget Estimator App'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: () => _startNewTransaction(context),)
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Container(
              //   width: double.infinity,
              //   child: Card(
              //     color:  Theme.of(context).primaryColorDark,
              //     elevation: 15,
              //     child: Text('CHARTS'),
              //   ),
              // ),
              Chart(_recentTransaction),
              TransactionList(_usertransactions,_deleteTransaction),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              FloatingActionButton(
                tooltip: 'Increment',
                child: Icon(Icons.add),
                onPressed: () => _startNewTransaction(context),
              ),

            ]

        )

    );
  }
}
