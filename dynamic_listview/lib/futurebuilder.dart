import 'package:dynamic_listview/book.dart';
import 'package:flutter/material.dart';

class FutureBuilderScreen extends StatefulWidget {
  const FutureBuilderScreen({Key? key}) : super(key: key);

  @override
  State<FutureBuilderScreen> createState() => _FutureBuilderScreenState();
}

class _FutureBuilderScreenState extends State<FutureBuilderScreen> {
  late Future<List<Book>> options;

  @override
  void initState() {
    options = getValue();
    super.initState();
  }

  Future<List<Book>> getValue() async {
    await Future.delayed(const Duration(seconds: 2));
    return retrieveAllBooks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Elementos'),
      ),
      body: Center(
        child: FutureBuilder<List<Book>>(
          future: options,
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Book>> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                return Column(children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: TextField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Busca Acá'),
                        onChanged: filterBooks),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final book = snapshot.data![index];

                            return ListTile(
                              title: Text(book.fullName),
                            );
                          }))
                ]);
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ),
      ),
    );
  }

  void filterBooks(String value) {
    if (value.isEmpty) {
      setState(() {
        options = getValue();
      });
      return;
    }
  }
}
