class Version {
  final String label;
  final String version;
  final String instagramBase;
  final String changelog;
  final String downloadLink;
  final String releaseDate;

  Version(
      {required this.label,
      required this.version,
      required this.instagramBase,
      required this.changelog,
      required this.downloadLink,
      required this.releaseDate});

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
        label: json['label'],
        version: json['version'],
        instagramBase: json['instagramBase'],
        changelog: json['changelog'],
        downloadLink: json['downloadLink'],
        releaseDate: json['releaseDate']);
  }
}
