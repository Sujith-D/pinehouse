import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinehouse/Model/detailsModel.dart';
import 'package:pinehouse/Services/Database.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
    final  _formKey = GlobalKey<FormState>();
    bool isLoading = false;

    List<String> _dropdown = ['HR', 'Finance', 'Housekeeping and Marketing'];
    
    TextEditingController _name = TextEditingController(text: "");
    TextEditingController _age = TextEditingController();
    TextEditingController _phoneNumber = TextEditingController();
    String? getDropDownValue ;
    String? imageURL ;

    PlatformFile? pickedFile;
    UploadTask? uploadTask;

  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles();
    print(result!.names[0]);
    if(result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async{
    try{
      final path = 'files/${pickedFile!.name}';
      final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() => {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      isLoading = false;
      imageURL = urlDownload;
    });
    print('Download Link : $urlDownload');
    Database().uploadData(details(name: _name.text,phone: _phoneNumber.text,age: _age.text,imageLink: imageURL.toString(),position: getDropDownValue.toString()));
      _formKey.currentState!.reset();
    }catch(e){
      print("Error + " + e.toString());
    }
   
  }

  bool isValid(){
    if(_name.text.isNotEmpty && _phoneNumber.text.isNotEmpty && _phoneNumber.text.length == 10 && _age.text.isNotEmpty &&  _age.text.length < 3 && pickedFile != null && getDropDownValue!.isNotEmpty){
      return true;
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen 1"),elevation: 0,),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: [
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                children: [
                    TextFormField(
                    controller: _name,            
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Name",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                  ),
                  validator: (value){
                      if(value != null && value.length == 0) {
                        return "Field Cannot be Empty";
                      }else{
                        return null;
                      }
                    }
                  ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      // key: _phoneKey,
                    controller: _phoneNumber,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9+]")),],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),),
                      hintText: "Phone number",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                  ),
                    validator: (value){
                      if(value == null ) {
                        return null;
                      }else if(value != null && value.length < 10){
                        return "Enter Correct Number";
                      }
                    },
                  ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      // key: _ageKey,
                    controller: _age,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]")),],
                    decoration: InputDecoration(
                      hintText: "Age",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                  ),
                    validator: (value){
                      if(value != null && value.length >  3 || value!.length == 0) {
                        return "Enter Correct age";
                      }else{
                        return null;
                      }
                    },
                  ),
                    const SizedBox(height: 10,),
                    DropdownButtonFormField<String>(
                    // key: _dropDownKey,
                    hint: Text("Select Item"),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                      ),
                  items: _dropdown.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value));
                  }).toList(), 
                  onChanged: (value){
                    getDropDownValue = value;
                  },
                  validator: (value){
                      if(value == null){
                        return "Select one";
                      }
                    },),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: (){
                    selectFile();
                  }, child: Text(pickedFile != null ? pickedFile!.name : "Select Image")),
                    
                    ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        isLoading = true;
                        uploadFile();
                      });
                    }
                  }, child: Text('Submit')),
                    ],
              ),
            ),
                        
            isLoading?Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white60,
              child: Center(child: CircularProgressIndicator())):Container()
          ],
        ),
      ),
    );
  }
}