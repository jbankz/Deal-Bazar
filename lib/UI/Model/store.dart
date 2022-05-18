class StoreModel {
  final String? storeImage;
  final String? storeName;
  final String? storeURL;
  final String? storeScript;

  StoreModel(
      {required this.storeImage,
      required this.storeName,
      required this.storeURL,
      required this.storeScript});

  static List<StoreModel> storeList() {
    List<StoreModel> _stores = [];
    StoreModel _storeModel = StoreModel(
        storeImage: 'assets/images/brandlogo1.png',
        storeName: 'Michaelkors',
        storeURL: 'https://www.michaelkors.com',
        storeScript: '');
    _stores.add(_storeModel);

    _storeModel = StoreModel(
        storeImage: 'assets/images/brandlogo2.png',
        storeName: 'Addidas',
        storeURL: 'https://www.adidas.com/us',
        storeScript: '');
    _stores.add(_storeModel);

    _storeModel = StoreModel(
        storeImage: 'assets/images/brandlogo3.png',
        storeName: 'Amazon',
        storeURL: 'https://www.amazon.com',
        storeScript: '');
    _stores.add(_storeModel);

    _storeModel = StoreModel(
        storeImage: 'assets/images/brandlogo4.png',
        storeName: 'Marcys',
        storeURL: '',
        storeScript: '');
    _stores.add(_storeModel);

    _storeModel = StoreModel(
        storeImage: 'assets/images/brandlogo5.png',
        storeName: 'Nike',
        storeURL: 'https://www.nike.com',
        storeScript: '');
    _stores.add(_storeModel);

    _storeModel = StoreModel(
        storeImage: 'assets/images/brandlogo6.png',
        storeName: 'Carters',
        storeURL: 'https://www.carters.com',
        storeScript: '');
    _stores.add(_storeModel);

    _storeModel = StoreModel(
        storeImage: 'assets/images/brandlogo9.png',
        storeName: 'Michaelkors',
        storeURL: 'https://www.michaelkors.com',
        storeScript: '');
    _stores.add(_storeModel);

    _storeModel = StoreModel(
        storeImage: 'assets/images/brandlogo7.png',
        storeName: 'Steve Madden',
        storeURL: 'https://www.stevemadden.com',
        storeScript: '');
    _stores.add(_storeModel);

    _storeModel = StoreModel(
        storeImage: 'assets/images/brandlogo8.png',
        storeName: 'NordStorm',
        storeURL: '',
        storeScript: '');
    _stores.add(_storeModel);

    return _stores;
  }
}
