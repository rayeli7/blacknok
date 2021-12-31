import 'dart:convert';
import 'dart:core';

import 'package:blacknoks/api(s)/fetch_api.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomeState();
}

class _HomeState extends State<Homepage> {
  final TextEditingController stockOrderVolumeController= TextEditingController(text: '100');
  var livestockdata = <LiveStockData>[];

  int _selectedIndex = 0; 

  void _onItemTapped(int index) {
              setState(() {
                _selectedIndex = index;
              });
            }
   
  _getLiveStockData() {
    API.getLiveStockData().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        livestockdata = list.map((model) => LiveStockData.fromJson(model)).toList();
      });
    });
  }


  @override
  initState() {
    super.initState();
    _getLiveStockData();
  }

  @override
  dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Home'),
                actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
                ]
      ), 
      drawer: Container(
      height: MediaQuery.of(context).size.height,
        ),
      backgroundColor: Colors.white70,
      body: 
          ListView.builder(
              itemCount: livestockdata.length,
              itemBuilder: (context, index) {                
                double? currentStockPrice = livestockdata[index].price!;
                String? currentStockName = livestockdata[index].name!;
                return Card(
                  elevation: 2,
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
                
                    trailing:Column(
                      children: [
                        SizedBox(
                          width: 90,
                          child: ElevatedButton(
                            onPressed: ()=>showModalBottomSheet(
                              context: context,
                               builder: (context)=>
                               Container(
                                  height: MediaQuery.of(context).size.height,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                  child: ListView(
                                    children: <Widget>[
                                      const ListTile(),
                                      TextField(
                                        controller: stockOrderVolumeController,
                                        keyboardType: TextInputType.number,
                                        style: Theme.of(context).textTheme.headline4,
                                        decoration: const InputDecoration(
                                          labelText: 'Enter Volume',
                                          //errorText: ,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          ), 
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        onChanged:(String stockOrderVolumeController){
                                        },
                                      ),
                                      const SizedBox(height:8),
                                      Container(
                                        height: 20,
                                        alignment: Alignment.center,
                                        child: const Text('Deposit atleast GHS50.00 to start trading',
                                        style: TextStyle(
                                          color: Colors.grey,
                        
                                        ),
                                        ),//remember to add condition to remove ifthe user has already done this
                                      ),
                                      //const SizedBox(height:8),
                                      Center(
                                        heightFactor: 3.5,
                                        child: 
                                        Text('GHS ${double.parse(((currentStockPrice*int.parse(stockOrderVolumeController.text)).toStringAsFixed(2)))} of $currentStockName Stocks',
                                        style: const TextStyle(
                                          fontSize: 25,),
                                         )
                                        ),
                                      //const SizedBox(height:8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding:const EdgeInsets.symmetric(horizontal: 4,),
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                minimumSize: const Size(150, 100),
                                                maximumSize: const Size(150, 100),
                                              ),
                                              onPressed: ()=>Navigator.pop(context), 
                                              child:const Text('Buy',
                                              textScaleFactor: 2.0,
                                              ),
                                              ),
                                          ),
          
                                          Container(
                                            padding:const EdgeInsets.symmetric(horizontal: 4,),
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                minimumSize: const Size(150, 100),
                                                maximumSize: const Size(150, 100),
                                                primary: Colors.red,),
                                              onPressed: ()=>Navigator.pop(context), 
                                              child:const Text('Sell',
                                              textScaleFactor: 2.0,
                                              ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
                        ],
                      ),                
                    ),
                  );}
          ),
       
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.verified_user_rounded),
                label: 'User',
              ),
            ],
            currentIndex: _selectedIndex, 
            onTap: _onItemTapped,      
      ),
    );
  }
}



