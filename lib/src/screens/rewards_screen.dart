import 'dart:developer';

import 'package:cinema_mobile/src/core/api_connector.dart';

import 'package:cinema_mobile/src/models/api_response.dart';
import 'package:cinema_mobile/src/models/reawrds_model.dart';
import 'package:cinema_mobile/src/screens/home/drawer_widget.dart';
import 'package:cinema_mobile/src/util/local_object_util.dart';
import 'package:cinema_mobile/src/widgets/rewards_card_swiper_widget.dart';
import 'package:flutter/material.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

final ApiConnector _apiConnector = ApiConnector();
List<Reward> arrayRewards = [];

class _RewardsPageState extends State<RewardsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _apiConnector.fetchRewards(),
        builder: (context, AsyncSnapshot<ApiResponse> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            arrayRewards = snapshot.data!.response;
            log(arrayRewards.toList().toString());
          } else if (snapshot.hasError) {
            ApiResponse error = snapshot.error as ApiResponse;
            return Center(
              child: Text("${error.message}"),
            );
          }
          return SafeArea(
            child: Scaffold(
              drawer: const DrawerWidget(
                selectedOption: MenuOptions.rewards,
              ),
              appBar: AppBar(
                title: const Text(
                  "Premios",
                  textAlign: TextAlign.center,
                ),
              ),
              body: Column(children: [
                SizedBox(
                  height: size.height * 0.15,
                ),
                RewardsCardSwiper(reward: arrayRewards),
              ]),
            ),
          );
        });
  }
}
