import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';

class MovieSlider extends StatelessWidget {

  const MovieSlider({
    Key? key,
    required this.movies,
    this.title
  }) : super(key: key);

  final List<Movie> movies;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // todo: si no viene el titulo, no debe mostrarse este widget
          if ( title != null )
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          const SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: ( _, int index) => _MoviePoster(movie: movies[index])
            ),
          )



        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({
    Key? key,
    required this.movie
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric( horizontal: 20),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'asd' ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox( height: 5,),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,

          )
        ],
      ),
    );
  }
}

