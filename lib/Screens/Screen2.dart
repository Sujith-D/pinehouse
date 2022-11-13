import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinehouse/Screens/Screen3.dart';
import 'package:pinehouse/model/detailsModel.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});
  
  @override
  Widget build(BuildContext context) {
    
    var textStyle = TextStyle(fontSize: 20,fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Profile').orderBy('Name').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator(),);
          if(!snapshot.hasData || snapshot.hasError) return Center(child: Text("SomeThing Went Wrong",style: textStyle,),);

          List<details> data = [];
          for(int i =0;i<snapshot.data!.docs.length;i++){
            data.add(details(
              name: snapshot.data!.docs[i].get('Name'), 
              phone: snapshot.data!.docs[i].get('Phone Number'), 
              age: snapshot.data!.docs[i].get('Age'), 
              imageLink:snapshot.data!.docs[i].get('ImageURL'), 
              position: snapshot.data!.docs[i].get('Position')));
        }

        return data.length == 0 ? 
        Center(child: Text("No Curent Data",style: textStyle,)) :
        ListView.builder(
          itemCount: data.length,
          itemBuilder: ((context, index) {
            return     GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen3(data: data[index])),
                  );
              },
              child: Container(
              margin: EdgeInsets.all(10),
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.blue,
                // gradient: LinearGradient(
                //   colors: [Colors.blue,Colors.purple],
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomLeft
                //   ),
                boxShadow: [
                  BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10
                )],
                
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(data[index].imageLink),
                      backgroundColor: Colors.transparent,
                      radius: 40,
                    ),
                  ),
                  Text(data[index].name,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(width: 70.0)
                ],
              ),
                      ),
            );
          } ));
        },
      )
        
      
    
    );
  }
}