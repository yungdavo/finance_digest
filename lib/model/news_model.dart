class NewsArticleModel {
  final String category;
  final int datetime;
  final String headline;
  final String image;
  final String source;
  final String  url;

  NewsArticleModel({
    required this.category,
    required this.datetime,
    required this.headline,
    required this.image,
    required this.source,
    required this.url,
   });


  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      category: json['category'] as String,
      datetime: json['datetime'] as int,
      headline: json['headline'] as String,
      image: json['image']       as String,
      source: json['source']     as String,
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'datetime': datetime,
      'headline': headline,
      'image': image,
      'source': source,
      'url' : url,
    };
  }
}
