import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/saved.dart';

class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Naming app")),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SavedList(saved: _saved)));
              },
            )
          ],
        ),
        body: buildList());
  }

  Widget buildList() {
    return ListView.builder(itemBuilder: (context, index) {
      if (index.isOdd) return Divider();

      var realIndex = index ~/ 2;

      if (realIndex >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }

      return buildRow(_suggestions[realIndex]);
    });
  }

  Widget buildRow(WordPair wordPair) {
    final bool alreadSaved = _saved.contains(wordPair);
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(alreadSaved ? Icons.favorite : Icons.favorite_border,
          color: Colors.pink),
      onTap: () {
        setState(() {
          if (alreadSaved)
            _saved.remove(wordPair);
          else
            _saved.add(wordPair);
        });
      },
    );
  }
}
