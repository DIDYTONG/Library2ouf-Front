class Books {
  final String id;
  final String title;
  final String issueNumber;
  final String series;
  final String description;
  final String imageUrl;
  final String status;

  Books({
    required this.id,
    required this.title,
    required this.issueNumber,
    required this.series,
    required this.description,
    required this.imageUrl,
    required this.status,
  });

  factory Books.fromJson(Map<String, dynamic> json) {
    return Books(
      id: json['_id'],
      title: json['titre'],
      issueNumber: json['tome'],
      series: json['serieRef'],
      description: json['description'],
      imageUrl: json['imgUrl'],
      status: json['status'],
    );
  }
}
