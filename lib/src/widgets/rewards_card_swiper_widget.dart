import 'package:cinema_mobile/src/core/app_config.dart';

import 'package:cinema_mobile/src/models/reawrds_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

class RewardsCardSwiper extends StatelessWidget {
  final List<Reward> reward;

  const RewardsCardSwiper({Key? key, required this.reward}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (reward.isEmpty) {
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
        itemCount: reward.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height,
        itemBuilder: (_, int index) {
          final rwrd = reward[index];

          return GestureDetector(
            //onTap: () => Navigator.pushNamed(context, 'detailsRewards', arguments: rwrd),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FadeInImage(
                      placeholder: const AssetImage('assets/no-image.jpg'),
                      image: NetworkImage(
                          AppConfig.CONFIG_API_URL + "" + rwrd.photoAward!),
                      fit: BoxFit.cover,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(rwrd.numberAward.toString() + " pts.",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .apply(color: Theme.of(context).primaryColor))),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
