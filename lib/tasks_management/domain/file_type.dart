enum AudioChannel { mono, stereo }

class File {
  int id;
  String type;
  String source;
  FileMetadata? metadata;

  File({
    required this.id,
    required this.type,
    required this.source,
    this.metadata,
  });
}

abstract class FileMetadata {}

class CommonMetadata extends FileMetadata {
  String filename;
  int fileSize;
  String fileFormat;
  String filePath;
  String? dateCreated;
  String? dateModified;
  String? author;
  String? title;
  String? description;
  String? copyright;
  List<String>? tags;

  CommonMetadata({
    required this.filename,
    required this.fileSize,
    required this.fileFormat,
    required this.filePath,
    this.dateCreated,
    this.dateModified,
    this.author,
    this.title,
    this.description,
    this.copyright,
    this.tags,
  });
}

class AudioMetadata extends CommonMetadata {
  double? duration;
  int? bitrate;
  int? sampleRate;
  AudioChannel? channels;
  String? audioCodec;
  String? artist;
  String? album;
  int? trackNumber;

  AudioMetadata({
    required String filename,
    required int fileSize,
    required String fileFormat,
    required String filePath,
    String? dateCreated,
    String? dateModified,
    String? author,
    String? title,
    String? description,
    String? copyright,
    List<String>? tags,
    this.duration,
    this.bitrate,
    this.sampleRate,
    this.channels,
    this.audioCodec,
    this.artist,
    this.album,
    this.trackNumber,
  }) : super(
          filename: filename,
          fileSize: fileSize,
          fileFormat: fileFormat,
          filePath: filePath,
          dateCreated: dateCreated,
          dateModified: dateModified,
          author: author,
          title: title,
          description: description,
          copyright: copyright,
          tags: tags,
        );
}

class VideoMetadata extends CommonMetadata {
  double? duration;
  Resolution? resolution;
  double? frameRate;
  String? videoCodec;
  String? aspectRatio;
  String? audioCodec;

  VideoMetadata({
    required String filename,
    required int fileSize,
    required String fileFormat,
    required String filePath,
    String? dateCreated,
    String? dateModified,
    String? author,
    String? title,
    String? description,
    String? copyright,
    List<String>? tags,
    this.duration,
    this.resolution,
    this.frameRate,
    this.videoCodec,
    this.aspectRatio,
    this.audioCodec,
  }) : super(
          filename: filename,
          fileSize: fileSize,
          fileFormat: fileFormat,
          filePath: filePath,
          dateCreated: dateCreated,
          dateModified: dateModified,
          author: author,
          title: title,
          description: description,
          copyright: copyright,
          tags: tags,
        );
}

class ImageMetadata extends CommonMetadata {
  Resolution? resolution;
  String? colorSpace;
  String imageFormat;

  ImageMetadata({
    required String filename,
    required int fileSize,
    required String fileFormat,
    required String filePath,
    String? dateCreated,
    String? dateModified,
    String? author,
    String? title,
    String? description,
    String? copyright,
    List<String>? tags,
    this.resolution,
    this.colorSpace,
    required this.imageFormat,
  }) : super(
          filename: filename,
          fileSize: fileSize,
          fileFormat: fileFormat,
          filePath: filePath,
          dateCreated: dateCreated,
          dateModified: dateModified,
          author: author,
          title: title,
          description: description,
          copyright: copyright,
          tags: tags,
        );
}

class Resolution {
  int width;
  int height;

  Resolution({
    required this.width,
    required this.height,
  });
}
