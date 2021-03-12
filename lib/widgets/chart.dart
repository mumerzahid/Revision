import 'package:budget_estimator/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

   List<Map<String,Object>> get transactionValuesForChart{

     return List.generate(7, (index) {
       final weekDays= DateTime.now().subtract(Duration(days: index));
       var totalSum =0.0;
       for(var i=0; i <recentTransactions.length; i++ )
         {
           if(recentTransactions[i].date.day == weekDays.day &&
               recentTransactions[i].date.month == weekDays.month &&
                recentTransactions[i].date.year == weekDays.year)
       {
                totalSum += recentTransactions[i].amount;
       }
         }
       return{
         'day':DateFormat.E().format(weekDays).substring(0,3),
         'amount': totalSum,
       };
     }).reversed.toList();
   }

   double get maxSpending{
     return transactionValuesForChart.fold(0.0, (sum, item) {
       return sum + item['amount'];
     });
   }
  @override
  Widget build(BuildContext context) {
     print(transactionValuesForChart);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: transactionValuesForChart.map((data) {
          return Flexible(
            flex: 1,
            child: ChartBar(data['day'] ,
                data['amount'],
                maxSpending == 0.0 ? 0.0 :(data['amount'] as double) / maxSpending),
          );
        }).toList(),
      ),
    );
  }
}
