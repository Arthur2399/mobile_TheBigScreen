import 'package:cinema_mobile/src/core/app_config.dart';

import 'package:cinema_mobile/src/models/reawrds_model.dart';
import 'package:flutter/material.dart';



class RewardsDetailsScreen extends StatelessWidget {
  const RewardsDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Reward reward = ModalRoute.of(context)!.settings.arguments as Reward;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(reward),
        SliverList(
            delegate: SliverChildListDelegate(
                [_PosterAndTitle(reward),]))
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final Reward reward;

  const _CustomAppBar(this.reward);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black12,
          child: Text(
            reward.nameAward!,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image:
              NetworkImage(AppConfig.CONFIG_API_URL + "" + reward.photoAward!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Reward reward;

  const _PosterAndTitle(this.reward);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
        
          const SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reward.nameAward!,
                    style: textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Text('Costo: ' '${reward.numberAward}' ' \$',
                    style: textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1),
              
              ],
            ),
          )
        ],
      ),
    );
  }
}


