import 'dart:async';

import 'constant.dart';
import 'package:flutter/foundation.dart';
import 'webpart2.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class page1 extends StatelessWidget {
 page1({@required this.file_to_search});
 final file_to_search;
 bool isLoading=true;
 final Completer<WebViewController> _controler= new Completer<WebViewController>();
 void web(WebViewController webviewcontroller)  {
   _controler.complete(webviewcontroller);
 }
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (String ch){
              if(ch==constant.google){
                Navigator.push(context, MaterialPageRoute(builder: (context) => part2(

                 url: "https://www.google.com/search?q=$file_to_search",
                )));
              }
              if(ch==constant.youtube){
                Navigator.push(context, MaterialPageRoute(builder: (context) => part2(
                  url: "https://www.youtube.com/results?search_query=$file_to_search",
                )));
                }
                    if(ch==constant.Wikipedia){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => part2(
                        url: "https://en.wikipedia.org/wiki/$file_to_search",
                      )));

                }
            },
           itemBuilder: (BuildContext context){
             return constant.listtype.map((String choise){
               return PopupMenuItem<String>(

                 value: choise,
                 child: Text(choise,
                   style: TextStyle(
                     color: Colors.yellow,
                     fontWeight: FontWeight.bold
                   ),
                 ),
               );
             }).toList();
          },
          )
        ],

        ),

      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WebView(
            initialUrl: "https://www.google.com/search?q=$file_to_search",
            onWebViewCreated: web,

       onPageFinished: (finish){
              isLoading=false;
       },
        ),
          // isLoading ? Center( child: CircularProgressIndicator(),): Stack(),
          ],
        ),
      ),
    );
  }



}
