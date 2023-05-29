import 'package:dipterv/models/real_estate_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ChosenRealEstatePage extends StatelessWidget {
  RealEstateModel realEstate;
  final PageController pageController = PageController(initialPage: 0);

  ChosenRealEstatePage(this.realEstate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 25,),
          Stack(
            children: [
              Column(
                children: [
                  Hero(
                      tag: realEstate.id,
                      child: Image.network(realEstate.pictures[0])),
                  SizedBox(height: 10,),
                  Text('Adatok', style: TextStyle(
                    fontSize: 40,
                    color: Colors.blueAccent
                  ),),
                  dataRow('Város', realEstate.city),
                  addressRow(),
                  dataRow('Értékesítés', realEstate.distributionType),
                  dataRow('Ár', priceFormat(realEstate.price)),
                  dataRow('Anyaghasználat', realEstate.buildingType),
                  dataRow('Állapot', realEstate.condition),
                  dataRow('Alapterület', realEstate.areaSize.toString()),
                  dataRow('Szobák száma', realEstate.numberOfRooms.toString()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.3)
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new),
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 220),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.3)
                      ),
                      child: IconButton(
                        icon: Icon(Icons.remove_red_eye_rounded),
                        color: Colors.white,
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GalleryWidget(realEstate.pictures))),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String priceFormat(int price) {
    return NumberFormat.currency(locale: 'en_US,', symbol: '').format(price).replaceAll('.00', ' Ft');
  }

  Widget addressRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 2),
            child: Divider(thickness: 2,),
          ),
          Row(
            children: [
              Text('Cím:', style: TextStyle(
                fontSize: 18
              ),),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: () => MapsLauncher.launchCoordinates(realEstate.latitude, realEstate.longitude),
                child: Text(realEstate.address, style: TextStyle(
                    fontSize: 18,
                  color: Colors.blue,
                  decoration: TextDecoration.underline

                )),
              )

            ],
          )
        ],
      ),
    );
  }

  Widget dataRow(String title, String data,) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 2),
            child: Divider(thickness: 2,),
          ),
          Row(
            children: [
              Text('$title:', style: TextStyle(
                  fontSize: 18
              )),
              SizedBox(width: 10,),
              Text(data, style: TextStyle(
                  fontSize: 18,
                color: Colors.grey.shade600
              ))
            ],
          )
        ],
      ),
    );
  }

}

class GalleryWidget extends StatelessWidget {
  List<String> pictureRoutes;

  GalleryWidget(this.pictureRoutes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
          itemCount: pictureRoutes.length,
          builder: (context, index) =>
      PhotoViewGalleryPageOptions(imageProvider: Image.network(pictureRoutes[index]).image)),
    );
  }

}