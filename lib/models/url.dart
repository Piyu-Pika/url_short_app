class UrlModel {
  final String id;
  final String originalUrl;
  final String shortUrl;
  final String urlId;
  final int clicks;
  final String date;

  UrlModel({
    required this.id,
    required this.originalUrl,
    required this.shortUrl,
    required this.urlId,
    required this.clicks,
    required this.date,
  });

  factory UrlModel.fromJson(Map<String, dynamic> json) {
    return UrlModel(
      id: json['_id'] ?? '',
      originalUrl: json['originalUrl'] ?? '',
      shortUrl: json['shortUrl'] ?? '',
      urlId: json['urlId'] ?? '',
      clicks: json['clicks'] ?? 0,
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'originalUrl': originalUrl,
        'shortUrl': shortUrl,
        'urlId': urlId,
        'clicks': clicks,
        'date': date,
      };
}
