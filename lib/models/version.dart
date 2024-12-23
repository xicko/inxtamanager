class Version {
  final String version;
  final String changelog;
  final String downloadLink;
  final String releaseDate;

  Version(
      {required this.version,
      required this.changelog,
      required this.downloadLink,
      required this.releaseDate});

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
        version: json['version'],
        changelog: json['changelog'],
        downloadLink: json['downloadLink'],
        releaseDate: json['releaseDate']);
  }
}
