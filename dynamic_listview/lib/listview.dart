import 'package:dynamic_listview/book.dart';
import 'package:flutter/material.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({Key? key}) : super(key: key);

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  List<Book> options = [];

  @override
  void initState() {
    options = retrieveAllBooks;
    super.initState();
  }

  void filterBooks(String value) {
    if (value.isEmpty) {
      setState(() {
        options = retrieveAllBooks;
      });
      return;
    }

    final suggestions = options.where((element) {
      final billTitle = element.fullName.toLowerCase();
      final input = value.toLowerCase();
      return billTitle.contains(input);
    }).toList();
    setState(() {
      options = suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Elementos'),
      ),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          child: TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Busca Acá'),
              onChanged: filterBooks),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final book = options[index];

                  return ListTile(
                    title: Text(book.fullName),
                  );
                }))
      ]),
    );
  }
}
