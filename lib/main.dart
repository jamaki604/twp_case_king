import 'package:flutter/material.dart';
import 'package:twp_case_king/query_updater.dart';
import 'package:twp_case_king/wikipedia_revision_parser.dart';

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
  final queryUpdater = QueryUpdater();
  final revisionParser = WikipediaRevisionParser();
  final wikipediaPageController = TextEditingController();

  void revisionListPrinter() async {
    final pageName = wikipediaPageController.text;
    final urlGenerator = QueryUpdater();
    final wikipediaData = await urlGenerator.wikipediaPageURL(pageName);
    final parser = WikipediaRevisionParser();
    final revisionList = parser.allTogetherNow(wikipediaData);

    return revisionList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Wikipedia Page Name goes here",
                ),
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
            ),
            const SizedBox(height: 20),
            const ElevatedButton(
              onPressed: startHammering,
              child: Text('Submit'),
            ),
            const SizedBox(height: 20,),
            const Text(
              'something will go here',
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
      ),

    );
  }

}

void startHammering() {
  print('bang bang bang');
}
