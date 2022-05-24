import 'package:flutter/material.dart';
import 'package:flutter_pelis/providers/movie_providers.dart';
import 'package:flutter_pelis/search/search_delegate.dart';
import 'package:flutter_pelis/widgets/barril_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieProviders = Provider.of<MovieProviders>(context);
    print(movieProviders.OndisplayMovie);
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas En Cines'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: MovieSearchDeleagte());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TODO:cardSwiper.
            CardSwiper(
              movies: movieProviders.OndisplayMovie,
            ),

            // listado de peliculas
            MovieSlader(
              movies: movieProviders.PopularMovies,
              title: 'Populares',
              onNextpage: () => movieProviders.getPopularMovie(),
            ),
          ],
        ),
      ),
    );
  }
}
