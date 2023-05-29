import 'package:dipterv/route/realestate/real_estate_bloc.dart';
import 'package:dipterv/route/realestate/real_estate_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RealEstatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RealEstateState();
}

class _RealEstateState extends State<RealEstatePage> {
  RealEstateBloc get _bloc => context.read<RealEstateBloc>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _bloc.add(RealEstateInitEvent());
      },
        child: BlocConsumer<RealEstateBloc, RealEstateState>(
            listener: (context, state) {},
            builder: (context, state) {
              var currentState = state;
              if(currentState is RealEstateLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if(currentState is RealEstateBasicState) {
                if(currentState.realEstates == null) {
                  return Center(
                    child: Text('Az ingatlanok listája üres!'),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: ListView.builder(
                        itemCount: currentState.realEstates?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RealEstateListItem(currentState.realEstates![index]);
                        }),
                  );
                }
              } else {
                return Container();
              }
            }),
    );
  }

}