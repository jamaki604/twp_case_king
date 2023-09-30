import 'package:flutter/material.dart';
import 'package:twp_case_king/query_updater.dart';
import 'package:twp_case_king/wikipedia_query_parser.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Wikipedia Page Investigator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String displayedText = '';
  final wikipediaPageController = TextEditingController();
  final queryUpdater = QueryUpdater();
  final revisionParser = WikipediaRevisionParser();

  Future<void> handleButtonPress() async {
    try {
      final result = await revisionListPrinter();
      setState(() {
        displayedText = result;
      });
    } catch (error) {
      if (error is SocketException || error is HttpException) {
        setState(() {
          displayedText = "There was a network error";
        });
      } else {
        setState(() {
          displayedText = "An error occurred: $error";
        });
      }
    }
  }

  Future<String> revisionListPrinter() async {
    final pageName = wikipediaPageController.text;
    final wikipediaData = await queryUpdater.wikipediaPageURL(pageName);
    return revisionParser.allTogetherNow(wikipediaData);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView( // <-- Wrap with SingleChildScrollView
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                color: Colors.teal,
                child: const Text(
                  'Enter the wikipedia page for a user revision list',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 345,
                child: TextField(
                  controller: wikipediaPageController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Wikipedia Page Name goes here",
                  ),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: handleButtonPress,
                child: const Text('Submit'),
              ),
              Container(
                padding: const EdgeInsets.all(10),  // Optional padding for aesthetics.
                child: Text(
                  displayedText,
                  style: const TextStyle(fontSize: 24),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}

