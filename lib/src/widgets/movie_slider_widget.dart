import 'package:cinema_mobile/src/core/app_config.dart';
import 'package:cinema_mobile/src/models/top5movies_model.dart';
import 'package:flutter/material.dart';

class MovieSlider extends StatefulWidget {
  final List<Top5Movies> movies;
  final String? title;


  const MovieSlider({
    Key? key,
    required this.movies,

    this.title,
  }) : super(key: key);

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50.0),
      child: SizedBox(
        width: double.infinity,
        height: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.title!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                 physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (_, int index) =>
                      _MoviePoster(widget.movies[0])),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Top5Movies movie;

  const _MoviePoster(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          GestureDetector(
            // onTap: () =>
            //     Navigator.pushNamed(context, 'detailsMovies', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(
                    AppConfig.CONFIG_API_URL + "" + movie.photoMovie!),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            movie.nameMovie!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
