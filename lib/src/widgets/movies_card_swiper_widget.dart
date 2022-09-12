import 'package:cinema_mobile/src/core/app_config.dart';
import 'package:cinema_mobile/src/models/movies_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';



class MoviesCardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const MoviesCardSwiper({
    Key? key, 
    required this.movies
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    if( movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

  

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: ( _ , int index ) {

          final movie = movies[index];

        

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'detailsMovies', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(  AppConfig.CONFIG_API_URL+""+movie.photoMovie! ),
                fit: BoxFit.cover,
              ),
            ),
          );

        },
      ),
    );
  }
}