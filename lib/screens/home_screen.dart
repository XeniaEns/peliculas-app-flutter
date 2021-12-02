import 'package:flutter/material.dart';
import 'package:peliculas/providers/menu_provider.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Películas'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Tarjetas principales
              CardSwiper(pelis: movieProvider.onDisplayMovie),
              //Slider de películas
              MovieSlider(
                  popularMoviesList: movieProvider.mostPopularMovieList),
            ],
          ),
        ));
  }
}
