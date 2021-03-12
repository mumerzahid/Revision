import 'package:flutter/material.dart';
class  ChartBar extends StatelessWidget {

  final String label;
  final double spendingAmount;
  final double pctOfAmount;

  ChartBar(this.label,this.spendingAmount,this.pctOfAmount);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
              height:20,
              child: FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ),
          ),
          SizedBox(height: 4) ,
         Container(

           height: 60,
           width: 10,
           child: Stack(
             children: <Widget>[
               Container(
                 decoration: BoxDecoration(
                     color: Color.fromRGBO(220, 220, 220, 1),
                     border: Border.all(color: Colors.grey, width: 1.0),
                     borderRadius: BorderRadius.circular(10)
                 ),
               ),
               FractionallySizedBox(
                   heightFactor: pctOfAmount,
                   child: Container( child: Container(decoration: BoxDecoration(
                     color: Theme.of(context).primaryColor,
                     borderRadius: BorderRadius.circular(10),

                   ),)

                   )
               )
             ],
           ),
         ),
          SizedBox(height: 4)
          ,
          Text(label),


        ],

      ),
    );
  }
}
