class AstronomyResponse {
  final String mediaType;
  final String url;
  final String explanation;

  AstronomyResponse(this.mediaType, this.url, this.explanation);

  factory AstronomyResponse.fromJson(Map<String, dynamic> json) {
    return AstronomyResponse(
      json["media_type"],
      json["url"],
      json["explanation"],
    );
  }
}
