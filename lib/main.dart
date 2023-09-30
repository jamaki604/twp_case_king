import 'package:flutter/material.dart';
import 'package:twp_case_king/parse_result.dart';
import 'package:twp_case_king/wikipedia_query_service.dart';
import 'package:twp_case_king/revision.dart';
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
      title: 'Wikipedia Page Investigator',
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
  final queryUpdater = WikipediaQueryService();
  final revisionParser = WikipediaRevisionParser();
  bool isLoading = false;



  Future<void> handleButtonPress() async {
    try {
      setState(() {
        isLoading = true;
        displayedText = '';
      });

      final result = await revisionListPrinter();

      setState(() {
        if (!result.pageExists) {
          displayedText = "Page does not exist.";
        } else {
          if (result.redirect != null) {
            displayedText = "Redirected from \"${result.redirect!.from}\" to \"${result.redirect!.to}\".\n";
          }
          displayedText += formatRevisions(result.revisions);
        }
        isLoading = false;
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
        isLoading = false;
      }
    }
  }


  String formatRevisions(List<Revision> revisions) {
    final int length = revisions.length > 30 ? 30 : revisions.length;
    String result = '';
    for (int i = 0; i < length; i++) {
      result += "\n${i + 1}. Username: ${revisions[i].username}, \nTimestamp: ${revisions[i].timeStamp}\n";
    }
    return result;
  }
  Future<ParseResult> revisionListPrinter() async {
    final pageName = wikipediaPageController.text;
    final wikipediaData = await queryUpdater.fetchWikipediaPageData(pageName);
    return revisionParser.parseQuery(wikipediaData);
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
                  enabled: !isLoading,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Wikipedia Page Name goes here",
                  ),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : handleButtonPress,
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

