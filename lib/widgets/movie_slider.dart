import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';

class MovieSlider extends StatelessWidget {
  final List<Movie> popularMoviesList;
  const MovieSlider({
    Key? key,
    required this.popularMoviesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (popularMoviesList.isEmpty) {
      return SizedBox(
          width: double.infinity,
          height: size.height * 0.5,
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.pink,
            ),
          ));
    }

    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'POPULARES',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, int index) {
                final movie = popularMoviesList[index];
                return _MoviePoster(
                  poster: movie.fullPosterImg,
                  movieTitle: movie.title,
                  instance: movie,
                );
              },
              itemCount: 20,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final String poster;
  final String movieTitle;
  final Movie instance;

  const _MoviePoster({
    Key? key,
    required this.poster,
    required this.movieTitle,
    required this.instance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: instance),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpeg'),
                image: NetworkImage(poster),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            movieTitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
