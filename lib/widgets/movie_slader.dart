import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pelis/models/movie.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieSlader extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextpage;

  const MovieSlader(
      {Key? key,
      required this.movies,
      required this.title,
      required this.onNextpage})
      : super(key: key);

  @override
  State<MovieSlader> createState() => _MovieSladerState();
}

class _MovieSladerState extends State<MovieSlader> {
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextpage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (this.widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                this.widget.title!,
                style: GoogleFonts.pacifico(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int index) =>
                  _MoviePosters(widget.movies[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePosters extends StatelessWidget {
  final Movie movie;

  const _MoviePosters(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, '/details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/loading.gif'),
                image: NetworkImage(
                  movie.fullPosterImg,
                ),
                height: 200,
                width: 130,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.pacifico(),
            maxLines: 1,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
