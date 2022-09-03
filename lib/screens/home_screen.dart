import 'package:flutter/material.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:movies/search/search_delegate.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final MoviesProvider moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cine'),
        actions: [
          IconButton(
              onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: const Icon( Icons.search_outlined )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            // Tarjetas principales
            CardSwiper( movies: moviesProvider.onDisplayMovies ),
            // Slider de peliculas
            MovieSlider(
                movies: moviesProvider.popularMovies,
                onNextPage: () => moviesProvider.getPopularMovies(),
                title: 'Populares'
            ),

          ],
        ),
      )
    );
  }
}

