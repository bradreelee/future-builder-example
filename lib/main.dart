import 'package:future_builder/sample_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => DidRecallApiProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Future Builder Demo'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: TextButton(
        onPressed: () => setState(() {}),
        child: const Text('refetch'),
      ),
      body: FutureBuilder<String>(
        future: fetchTodo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.data!),
                  const SizedBox(height: 30),
                  Consumer<DidRecallApiProvider>(
                    builder: (context, provider, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('didRecallApi:'),
                        const SizedBox(width: 20),
                        Text('${provider.didRecallApi}'),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return const Center(
            child: Text("error while fetching todo"),
          );
        },
      ),
    );
  }

  Future<String> fetchTodo() async {
    const url = 'https://jsonplaceholder.typicode.com/todos/1';
    final response = await http.get(Uri.parse(url));
    return response.body;
  }
}
