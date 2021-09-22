import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'web_part.dart';
class mainpage extends StatefulWidget {
  @override
  _mainpageState createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  TextEditingController controller = TextEditingController();
  File PickedImage;
  bool imageloader=false;
 var search_value;
  List<String>word=[];

  Future ReadText()async{
    FirebaseVisionImage myimage=FirebaseVisionImage.fromFile(PickedImage);
    TextRecognizer textRecognizer=FirebaseVision.instance.textRecognizer();
    VisionText textread=await textRecognizer.processImage(myimage);
    for(TextBlock block in textread.blocks){
      for(TextLine line in block.lines)
        //print(line.text);
        word.add(line.text.toString());
      controller.text = '$word';
      print(word);

    }
  }
  Future<void> _showMyDialog() async {

    return showDialog<void> (
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                imageloader?Center(
                  child:Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:  FileImage(PickedImage),fit: BoxFit.cover
                        )
                    ),
                  ) ,
                ):Container(    height: 200,
                  width: 200,
                  color: Colors.white,),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Approve'),
              onPressed: () {
                word.clear();
                ReadText();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future imagePicker () async{
    var imagefile= await  ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      PickedImage = imagefile as File ;
      imageloader=true;
    });
  }
  Future imagePickerbyg () async{
    ReadText();
    var imagefile= await  ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      PickedImage = imagefile as File ;
      imageloader=true;

    });
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.yellow
        ),
        title: Text('Search for Anything Using Camera',
        style: TextStyle(
          color: Colors.yellow,
            fontSize: 18
        ),),
      ),
    drawer: Drawer(

      child: ListView(
        children: <Widget>[


        ],
      ),
    ),
    body: Column(
      children: <Widget>[
        Expanded(
          child: Center(
            child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.lightBlueAccent,
            backgroundImage: AssetImage('images/earth.png'),
            ),
          ),
        ),
        SizedBox(height: 20,),
        TextField(
          onChanged: (value){

           search_value=value;
          },
        controller:controller,
        decoration: InputDecoration(

        hintText: "Search",
         fillColor: Colors.yellowAccent,

          border: OutlineInputBorder(

            borderSide:
            BorderSide(color: Colors.yellowAccent, width: 5.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),

          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.yellowAccent, width: 5.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
         suffixIcon:  IconButton(
           color: Colors.yellowAccent,
           icon: Icon(Icons.search),
        onPressed: () {
          controller.clear();
        setState(() {
           Navigator.push(context, MaterialPageRoute(builder: (context) => page1(
              file_to_search:search_value
          )

          ));

        }); },) ,

    ),
    ),
      SizedBox(height: 10,),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.camera,
                      size: 60,
                      color: Colors.blue,
                    ),
                    onPressed:(){
                      setState(() {
                       imagePicker();
                        if(word!=null){
                          _showMyDialog();
                        }
                        });
                    },
                  ),
                  SizedBox(height: 15,),
                  Text('search by camera',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 18
                  ),)
                ],
              ),
              SizedBox(width: 20,),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.image,
                      size: 60,
                      color: Colors.blue,
                    ),
                    onPressed: (){

                      setState(() {
                        imagePickerbyg();
                        if(word!=null){
                          _showMyDialog();
                        }
                      });
                    },
                  ),
                  SizedBox(height: 15,),
                  Text('selact from Gallery',
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 18
                    ),)
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 60,),

      ],
    ),
    );
  }
}
