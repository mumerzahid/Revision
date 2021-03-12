import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deleteTx;
 TransactionList(this.transactions,this.deleteTx);

  Widget build(BuildContext context) {
    return  Container(
      height: 500,
      child:transactions.isEmpty? Column(
        children: <Widget>[
          Text('No Transactions yet',
            style: Theme.of(context).textTheme.title,),
          SizedBox(
            height: 10,
          ),
          Container(
              height:150
              ,child:
          Image.asset('assets/images/waiting.png' ,fit: BoxFit.cover,)),
        ],
      ) : ListView.builder(
        itemBuilder: (context,index)
    {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            elevation: 10,
            child: ListTile(
              leading: CircleAvatar(radius: 30,
                child: Padding (
                padding:EdgeInsets.all(6),
                    child: FittedBox(
                        child: Text('\$${transactions[index].amount.toStringAsFixed(1)}')
                    )
                ),
              ),
                title: Text(transactions[index].title,style: Theme.of(context).textTheme.title,),
              subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),

              trailing: IconButton(icon: Icon(Icons.delete), color:Theme.of(context).errorColor,
                onPressed: (){
                  print(transactions[index].id);
                  deleteTx(transactions[index].id);

                },
              ),
            ),
          );
        },
          itemCount: transactions.length,
          ),
    );
  }
}

//
// return Card(
// child: Row(
// children: <Widget>[
// Container(
// margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
// decoration: BoxDecoration(
// border: Border.all(
// color: Theme.of(context).primaryColorDark,
// width: 2,
// )),
// padding: EdgeInsets.all(10),
// child: Text(
// '\$${transactions[index].amount.toStringAsFixed(2)}',
// style: TextStyle(
// color:  Theme.of(context).primaryColorDark,
// fontSize: 12,
// fontWeight: FontWeight.bold),
// ),
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Text(
// transactions[index].title,
// style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// ),
// Text(
// DateFormat().format(transactions[index].date),
// style: TextStyle(color: Colors.grey),
// ),
// ],
// ),
// ],
// ));
