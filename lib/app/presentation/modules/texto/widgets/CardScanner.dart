import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CardScanner extends StatefulWidget {
  File image;
  CardScanner(this.image, {super.key});

  @override
  State<CardScanner> createState() => _RecognizerScreenState();
}

class _RecognizerScreenState extends State<CardScanner> {
  late TextRecognizer textRecognizer;
  late EntityExtractor entityExtractor;
  List<EntityDM> entitiesList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    entityExtractor =
        EntityExtractor(language: EntityExtractorLanguage.english);
    doTextRecognition();
  }

  String results = "";
  doTextRecognition() async {
    InputImage inputImage = InputImage.fromFile(widget.image);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    entitiesList.clear();
    results = recognizedText.text;

    final List<EntityAnnotation> annotations =
        await entityExtractor.annotateText(results);

    results = "";
    for (final annotation in annotations) {
      annotation.start;
      annotation.end;
      annotation.text;
      for (final entity in annotation.entities) {
        results += "${entity.type.name}\n${annotation.text}\n\n";
        entitiesList.add(EntityDM(entity.type.name, annotation.text));
      }
    }
    print(results);
    setState(() {
      results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Scanner',style: TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Image.file(widget.image),
              ListView.builder(
                itemBuilder: (context, position) {
                  return Card(
                    margin: const EdgeInsets.only(left:20,right: 20,top: 10),
                    color: Colors.blueAccent,
                    child: SizedBox(
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.only(left:10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(entitiesList[position].iconData,size: 25,color: Colors.white,),
                            Expanded(
                              child: Text(
                                entitiesList[position].value,
                                style: const TextStyle(color: Colors.white,fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Clipboard.setData(ClipboardData(text:
                                entitiesList[position].value));
                                SnackBar sn = const SnackBar(content: Text("Copied"));
                                ScaffoldMessenger.of(context).showSnackBar(sn);
                              },
                              child: const Icon(
                                Icons.copy,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: entitiesList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              )
              // Card(
              //     margin: EdgeInsets.all(10),
              //     color: Colors.grey.shade300,
              //     child: Column(
              //       children: [
              //         Container(
              //           color: Colors.blueAccent,
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 const Icon(
              //                   Icons.document_scanner,
              //                   color: Colors.white,
              //                 ),
              //                 const Text(
              //                   'Results',
              //                   style: TextStyle(
              //                       color: Colors.white, fontSize: 18),
              //                 ),
              //                 InkWell(
              //                   onTap: (){
              //                     Clipboard.setData(ClipboardData(text: results));
              //                     SnackBar sn = SnackBar(content: Text("Copied"));
              //                     ScaffoldMessenger.of(context).showSnackBar(sn);
              //                   },
              //                   child: const Icon(
              //                     Icons.copy,
              //                     color: Colors.white,
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //         Text(
              //           results,
              //           style: TextStyle(fontSize: 18),
              //         ),
              //       ],
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}

class EntityDM {
  String name;
  String value;
  IconData? iconData;

  EntityDM(this.name, this.value) {
    if(name == "phone"){
      iconData = Icons.phone;
    }else if(name == "address"){
      iconData = Icons.location_on;
    }else if(name == "email"){
      iconData = Icons.mail;
    }else if(name == "url"){
      iconData = Icons.web;
    }else{
      iconData = Icons.ac_unit_outlined;
    }
  }
}
