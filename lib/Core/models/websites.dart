import 'package:deal_bazaar/core/utils/icons.dart';

class WebsitesModel {
  String? name;
  String? imageUrl;
  bool isAvailable;

  WebsitesModel({this.imageUrl, required this.isAvailable, this.name});
}

List<WebsitesModel> websites = [
  WebsitesModel(
      name: 'Amazon', imageUrl: MarkaIcons.amazonLogo, isAvailable: true),
  WebsitesModel(
      name: 'Ali Express', imageUrl: MarkaIcons.amazonLogo, isAvailable: false),
  WebsitesModel(
      name: 'Ali Baba', imageUrl: MarkaIcons.amazonLogo, isAvailable: false),
  WebsitesModel(
      name: 'Ebay', imageUrl: MarkaIcons.amazonLogo, isAvailable: false),
  WebsitesModel(
      name: 'Walmart', imageUrl: MarkaIcons.amazonLogo, isAvailable: false),
  WebsitesModel(
      name: 'Spotify', imageUrl: MarkaIcons.amazonLogo, isAvailable: false),
];
