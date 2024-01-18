class Property {
  final String _id;
  final String _title;
  final String _description;
  final String _address;
  final int _price;
  final List<String> _image;
  final String _category;
  final String _owner;
  final String _email;
  final String _phone;
  final String _status;
  final int _area;
  final String _dealer;
  final String _dealerNum;
  String? _dealerMail;

  Property(
    this._id,
    this._title,
    this._description,
    this._address,
    this._price,
    this._image,
    this._category,
    this._owner,
    this._email,
    this._phone,
    this._status,
    this._area,
    this._dealer,
    this._dealerNum,
    this._dealerMail,
  );

  String get id => _id;
  String get title => _title;
  String get description => _description;
  String get address => _address;
  int get price => _price;
  List<String> get images => _image;
  String get category => _category;
  String get owner => _owner;
  String get email => _email;
  String get phone => _phone;
  String get dealer => _dealer;
  String get dealerNum => _dealerNum;
  String get dealerEmail => _dealerMail ?? "";
  String get status => _status;
  int get area => _area;
}

Property propConvert(data) {
  List<String> images =
      (data["images"] as List<dynamic>).map((e) => e.toString()).toList();
  return Property(
    data['id'],
    data['title'],
    data['description'],
    data['address'],
    data['price'],
    images,
    data['category'],
    data['owner'],
    data['email'],
    data['phone'],
    data['status'],
    data['area'],
    data['dealer'],
    data['dealer_num'],
    data['dealer_email'],
  );
}
