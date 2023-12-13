class VolumeInfo {
  final String title;
  final List<String> authors;
  final String publisher;
  final String publishedDate;
  final String description;
  final List<IndustryIdentifier> industryIdentifiers;
  final ReadingModes readingModes;
  final int pageCount;
  final String printType;
  final List<String> categories;
  final String maturityRating;
  final bool allowAnonLogging;
  final String contentVersion;
  final PanelizationSummary panelizationSummary;
  final ImageLinks imageLinks;
  final String language;
  final String previewLink;
  final String infoLink;
  final String canonicalVolumeLink;

  VolumeInfo({
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.industryIdentifiers,
    required this.readingModes,
    required this.pageCount,
    required this.printType,
    required this.categories,
    required this.maturityRating,
    required this.allowAnonLogging,
    required this.contentVersion,
    required this.panelizationSummary,
    required this.imageLinks,
    required this.language,
    required this.previewLink,
    required this.infoLink,
    required this.canonicalVolumeLink,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    return VolumeInfo(
      title: json['title'] ?? '',
      authors: (json['authors'] as List<dynamic>?)
              ?.map((author) => author.toString())
              .toList() ??
          [],
      publisher: json['publisher'] ?? '',
      publishedDate: json['publishedDate'] ?? '',
      description: json['description'] ?? '',
      industryIdentifiers: (json['industryIdentifiers'] as List<dynamic>?)
              ?.map((identifier) => IndustryIdentifier.fromJson(identifier))
              .toList() ??
          [],
      readingModes: ReadingModes.fromJson(json['readingModes'] ?? {}),
      pageCount: json['pageCount'] ?? 0,
      printType: json['printType'] ?? '',
      categories: (json['categories'] as List<dynamic>?)
              ?.map((category) => category.toString())
              .toList() ??
          [],
      maturityRating: json['maturityRating'] ?? '',
      allowAnonLogging: json['allowAnonLogging'] ?? false,
      contentVersion: json['contentVersion'] ?? '',
      panelizationSummary:
          PanelizationSummary.fromJson(json['panelizationSummary'] ?? {}),
      imageLinks: ImageLinks.fromJson(json['imageLinks'] ?? {}),
      language: json['language'] ?? '',
      previewLink: json['previewLink'] ?? '',
      infoLink: json['infoLink'] ?? '',
      canonicalVolumeLink: json['canonicalVolumeLink'] ?? '',
    );
  }
}

class IndustryIdentifier {
  final String type;
  final String identifier;

  IndustryIdentifier({
    required this.type,
    required this.identifier,
  });

  factory IndustryIdentifier.fromJson(Map<String, dynamic> json) {
    return IndustryIdentifier(
      type: json['type'] ?? '',
      identifier: json['identifier'] ?? '',
    );
  }
}

class ReadingModes {
  final bool text;
  final bool image;

  ReadingModes({
    required this.text,
    required this.image,
  });

  factory ReadingModes.fromJson(Map<String, dynamic> json) {
    return ReadingModes(
      text: json['text'] ?? false,
      image: json['image'] ?? false,
    );
  }
}

class PanelizationSummary {
  final bool containsEpubBubbles;
  final bool containsImageBubbles;

  PanelizationSummary({
    required this.containsEpubBubbles,
    required this.containsImageBubbles,
  });

  factory PanelizationSummary.fromJson(Map<String, dynamic> json) {
    return PanelizationSummary(
      containsEpubBubbles: json['containsEpubBubbles'] ?? false,
      containsImageBubbles: json['containsImageBubbles'] ?? false,
    );
  }
}

class ImageLinks {
  final String smallThumbnail;
  final String thumbnail;

  ImageLinks({
    required this.smallThumbnail,
    required this.thumbnail,
  });

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    return ImageLinks(
      smallThumbnail: json['smallThumbnail'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}
