class HomepageModel {
  HomepageModel({
    int? page,
    int? perPage,
    List<Photos>? photos,
    int? totalResults,
    String? nextPage,
  }) {
    _page = page;
    _perPage = perPage;
    _photos = photos;
    _totalResults = totalResults;
    _nextPage = nextPage;
  }

  HomepageModel.fromJson(dynamic json) {
    _page = json['page'];
    _perPage = json['per_page'];
    if (json['photos'] != null) {
      _photos = [];
      json['photos'].forEach((v) {
        _photos?.add(Photos.fromJson(v));
      });
    }
    _totalResults = json['total_results'];
    _nextPage = json['next_page'];
  }
  int? _page;
  int? _perPage;
  List<Photos>? _photos;
  int? _totalResults;
  String? _nextPage;
  HomepageModel copyWith({
    int? page,
    int? perPage,
    List<Photos>? photos,
    int? totalResults,
    String? nextPage,
  }) =>
      HomepageModel(
        page: page ?? _page,
        perPage: perPage ?? _perPage,
        photos: photos ?? _photos,
        totalResults: totalResults ?? _totalResults,
        nextPage: nextPage ?? _nextPage,
      );
  int? get page => _page;
  int? get perPage => _perPage;
  List<Photos>? get photos => _photos;
  int? get totalResults => _totalResults;
  String? get nextPage => _nextPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = _page;
    map['per_page'] = _perPage;
    if (_photos != null) {
      map['photos'] = _photos?.map((v) => v.toJson()).toList();
    }
    map['total_results'] = _totalResults;
    map['next_page'] = _nextPage;
    return map;
  }
}

class Photos {
  Photos({
    int? id,
    int? width,
    int? height,
    String? url,
    String? photographer,
    String? photographerUrl,
    int? photographerId,
    String? avgColor,
    Src? src,
    bool? liked,
    String? alt,
  }) {
    _id = id;
    _width = width;
    _height = height;
    _url = url;
    _photographer = photographer;
    _photographerUrl = photographerUrl;
    _photographerId = photographerId;
    _avgColor = avgColor;
    _src = src;
    _liked = liked;
    _alt = alt;
  }

  Photos.fromJson(dynamic json) {
    _id = json['id'];
    _width = json['width'];
    _height = json['height'];
    _url = json['url'];
    _photographer = json['photographer'];
    _photographerUrl = json['photographer_url'];
    _photographerId = json['photographer_id'];
    _avgColor = json['avg_color'];
    _src = json['src'] != null ? Src.fromJson(json['src']) : null;
    _liked = json['liked'];
    _alt = json['alt'];
  }
  int? _id;
  int? _width;
  int? _height;
  String? _url;
  String? _photographer;
  String? _photographerUrl;
  int? _photographerId;
  String? _avgColor;
  Src? _src;
  bool? _liked;
  String? _alt;
  Photos copyWith({
    int? id,
    int? width,
    int? height,
    String? url,
    String? photographer,
    String? photographerUrl,
    int? photographerId,
    String? avgColor,
    Src? src,
    bool? liked,
    String? alt,
  }) =>
      Photos(
        id: id ?? _id,
        width: width ?? _width,
        height: height ?? _height,
        url: url ?? _url,
        photographer: photographer ?? _photographer,
        photographerUrl: photographerUrl ?? _photographerUrl,
        photographerId: photographerId ?? _photographerId,
        avgColor: avgColor ?? _avgColor,
        src: src ?? _src,
        liked: liked ?? _liked,
        alt: alt ?? _alt,
      );
  int? get id => _id;
  int? get width => _width;
  int? get height => _height;
  String? get url => _url;
  String? get photographer => _photographer;
  String? get photographerUrl => _photographerUrl;
  int? get photographerId => _photographerId;
  String? get avgColor => _avgColor;
  Src? get src => _src;
  bool? get liked => _liked;
  String? get alt => _alt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['width'] = _width;
    map['height'] = _height;
    map['url'] = _url;
    map['photographer'] = _photographer;
    map['photographer_url'] = _photographerUrl;
    map['photographer_id'] = _photographerId;
    map['avg_color'] = _avgColor;
    if (_src != null) {
      map['src'] = _src?.toJson();
    }
    map['liked'] = _liked;
    map['alt'] = _alt;
    return map;
  }
}

class Src {
  Src({
    String? original,
    String? large2x,
    String? large,
    String? medium,
    String? small,
    String? portrait,
    String? landscape,
    String? tiny,
  }) {
    _original = original;
    _large2x = large2x;
    _large = large;
    _medium = medium;
    _small = small;
    _portrait = portrait;
    _landscape = landscape;
    _tiny = tiny;
  }

  Src.fromJson(dynamic json) {
    _original = json['original'];
    _large2x = json['large2x'];
    _large = json['large'];
    _medium = json['medium'];
    _small = json['small'];
    _portrait = json['portrait'];
    _landscape = json['landscape'];
    _tiny = json['tiny'];
  }
  String? _original;
  String? _large2x;
  String? _large;
  String? _medium;
  String? _small;
  String? _portrait;
  String? _landscape;
  String? _tiny;
  Src copyWith({
    String? original,
    String? large2x,
    String? large,
    String? medium,
    String? small,
    String? portrait,
    String? landscape,
    String? tiny,
  }) =>
      Src(
        original: original ?? _original,
        large2x: large2x ?? _large2x,
        large: large ?? _large,
        medium: medium ?? _medium,
        small: small ?? _small,
        portrait: portrait ?? _portrait,
        landscape: landscape ?? _landscape,
        tiny: tiny ?? _tiny,
      );
  String? get original => _original;
  String? get large2x => _large2x;
  String? get large => _large;
  String? get medium => _medium;
  String? get small => _small;
  String? get portrait => _portrait;
  String? get landscape => _landscape;
  String? get tiny => _tiny;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['original'] = _original;
    map['large2x'] = _large2x;
    map['large'] = _large;
    map['medium'] = _medium;
    map['small'] = _small;
    map['portrait'] = _portrait;
    map['landscape'] = _landscape;
    map['tiny'] = _tiny;
    return map;
  }
}
