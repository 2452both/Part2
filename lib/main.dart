import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final wordPair = WordPair.random();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Words Generator',
      home: RandomWords(),
    );
  }
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generated Name List'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
          //This is the script that bring in the list icon in the application and it is therefore added to the APP BAR because it is part of the application and not part on the context.
        ],
      ),
      body: _buildSuggestions(),
    );
  }


  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider();
          /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.purple: (null),
      ),

        onTap: (){
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else{
            _saved.add(pair);
          }
        });
        },
    );
  }

}

void _pushSaved (){
  BuildContext context;
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      // NEW lines from here...
      builder: (BuildContext context) {
        var _saved;
        final tiles = _saved.map(
              (WordPair pair) {
                var _biggerFont;
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                      style: _biggerFont,
              ),
            );
          },
        );
        final divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text('Saved Suggestions'),
          ),
          body: ListView(children: divided),
        );
      }, // ...to here.
    ),
  );
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}



//   );
// }


