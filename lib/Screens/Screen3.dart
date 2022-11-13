import 'package:flutter/material.dart';
import 'package:pinehouse/model/detailsModel.dart';

class Screen3 extends StatelessWidget {
   Screen3({required this.data});
  details data;
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 20,fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 3"),
        elevation: 0,
      ),
      body: Container(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: 10,),
              CircleAvatar(
                backgroundImage: NetworkImage(data.imageLink),
                radius: 70,
              ),
              Center(child: Text("${data.name}",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),),
              SizedBox(height: 15,),
              Card(
                child: ListTile(
                  title: Center(child: Text('Age : ${data.age}',style: textStyle,)),
                ),
              ),
              Card(
                child: ListTile(
                  title: Center(child: Text('Mobile : ${data.phone}',style: textStyle,)),
                ),
              ),
             Card(
                child: ListTile(
                  title: Center(child: Text('Department : ${data.position}',style: textStyle,)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}