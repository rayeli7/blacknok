import 'package:blacknoks/api(s)/fetch_api.dart';
import 'package:blacknoks/models/livestockdata_model.dart';
import 'package:flutter/material.dart';

import 'buy_modal_bottom_sheet.dart';

class StocklistWidget extends StatelessWidget {


  const StocklistWidget({
    Key? key,
    required this.index,
    required this.livestockdata,
    required this.stockOrderVolumeController,
    required this.currentStockPrice,
    required this.currentStockName,
  }) : super(key: key);

  final List<LiveStockData> livestockdata;
  final TextEditingController stockOrderVolumeController;
  final double? currentStockPrice;
  final String? currentStockName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
    elevation: 5,
    child: ListTile(
      textColor: Colors.black,
      enableFeedback: true,
        
      title: Text(livestockdata[index].name!,
      style:const TextStyle(
          color: Colors.black,)
      ),
                       
      subtitle: Text(
        GSE_Companies[index],
        style:const TextStyle(
          color: Colors.grey,
        ),
      ),
                       
      trailing:SizedBox(
        width: 90,
        child: ElevatedButton(
          onPressed: ()=>showModalBottomSheet(
            context: context,
             builder: (context)=>
             ModalBottomSheet(
              stockOrderVolumeController: stockOrderVolumeController,
              currentStockPrice: currentStockPrice, 
              currentStockName: currentStockName
              ),
              ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              livestockdata[index].price!.toString(),
              style: const TextStyle(
              color: Colors.black),
              ),
            ),
          ),
        ),                
      ),
    );
  }
}
