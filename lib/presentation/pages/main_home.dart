import 'package:TV_Series/presentation/pages/home_movie_page.dart';
import 'package:TV_Series/presentation/pages/home_tv_page.dart';
import 'package:flutter/material.dart';

class MainHome extends StatelessWidget{
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
              onPressed: (){
                Navigator.pushNamed(context, '/hometv');
              }, 
              child: const Text('TV Series')),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/homemovie');
              }, 
              child: const Text('Movies'))
          ],
        ),
      ),
    );
  }
  
}