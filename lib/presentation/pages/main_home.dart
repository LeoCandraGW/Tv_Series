
import 'package:flutter/material.dart';

class MainHome extends StatelessWidget {
  static const ROUTE_NAME = '/mainhome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ditonton'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/hometv');
                },
                child: const Text('TV Series')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/homemovie');
                },
                child: const Text('Movies')),
          ],
        ),
      ),
    );
  }
}
