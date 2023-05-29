import 'package:dipterv/models/real_estate_model.dart';
import 'package:dipterv/route/realestate/chosen_real_estate_page.dart';
import 'package:flutter/material.dart';

class RealEstateListItem extends StatelessWidget {
  final RealEstateModel realestate;

  RealEstateListItem(this.realestate);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => ChosenRealEstatePage(realestate)));
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Hero(
                tag: realestate.id,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  foregroundDecoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x00000000),
                        Color(0xCC000000),
                      ],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Image.network(realestate.pictures[0],
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Text(
                  realestate.city,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10,)
      ],
    );
  }

}