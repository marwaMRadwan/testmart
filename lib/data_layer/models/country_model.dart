/// countries_id : "65"
/// countries_name  : "مصر"

class CountryModel {
  CountryModel({
    String? countriesId,
    String? countriesName,
  }) {
    _countriesId = countriesId;
    _countriesName = countriesName;
  }

  CountryModel.fromJson(dynamic json) {
    _countriesId = json['countries_id'];
    _countriesName = json['countries_name'];
  }
  String? _countriesId;
  String? _countriesName;

  String? get countriesId => _countriesId;
  String? get countriesName => _countriesName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['countries_id'] = _countriesId;
    map['countries_name'] = _countriesName;
    return map;
  }
}
