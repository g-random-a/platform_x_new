enum AudioChannel { mono, stereo }

class File {
  String id;
  String type;
  String source;
  FileMetadata? metadata;

  File({
    required this.id,
    required this.type,
    required this.source,
    this.metadata,
  });

  factory File.fromJson(Map<String, dynamic> json) {
    File file = File(
      id: json['id'],
      type: json['type'],
      source: json['source'],
      metadata: json['metadata'] != null ? FileMetadata._parseMetadata(json['metadata']) : null,
    );

    return file;
  }
  
}

abstract class FileMetadata {

  static FileMetadata? _parseMetadata(Map<String, dynamic> json) {
    switch ((json['fileFormat'] as String).toLowerCase()) {
      case 'audio':
        return AudioMetadata.fromJson(json);
      case 'video':
        return VideoMetadata.fromJson(json);
      case 'image':
        return ImageMetadata.fromJson(json);
      default:
        return CommonMetadata.fromJson(json);
    }
  }
}

class CommonMetadata extends FileMetadata {
  String filename;
  int fileSize;
  String fileFormat;
  String? filePath;
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

  factory CommonMetadata.fromJson(Map<String, dynamic> json) {
    CommonMetadata metadata = CommonMetadata(
      filename: json['filename'],
      fileSize: json['fileSize'],
      fileFormat: json['fileFormat'],
      filePath: json['filePath'],
      dateCreated: json['dateCreated'],
      dateModified: json['dateModified'],
      author: json['author'],
      title: json['title'],
      description: json['description'],
      copyright: json['copyright'],
      tags: json['tags'],
    );

    return metadata;
  }
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
    required super.filename,
    required super.fileSize,
    required super.fileFormat,
    required super.filePath,
    super.dateCreated,
    super.dateModified,
    super.author,
    super.title,
    super.description,
    super.copyright,
    super.tags,
    this.duration,
    this.bitrate,
    this.sampleRate,
    this.channels,
    this.audioCodec,
    this.artist,
    this.album,
    this.trackNumber,
  });

  factory AudioMetadata.fromJson(Map<String, dynamic> json) {
    AudioMetadata metadata = AudioMetadata(
      filename: json['filename'],
      fileSize: json['fileSize'],
      fileFormat: json['fileFormat'],
      filePath: json['filePath'],
      dateCreated: json['dateCreated'],
      dateModified: json['dateModified'],
      author: json['author'],
      title: json['title'],
      description: json['description'],
      tags: json['tags'],
      duration: json['duration'],
      bitrate: json['bitrate'],
      sampleRate: json['sampleRate'],
      channels: json['channels'],
      audioCodec: json['audioCodec'],
      artist: json['artist'],
      album: json['album'],
      trackNumber: json['trackNumber'],
    );

    return metadata;
    
    }
}

class VideoMetadata extends CommonMetadata {
  double? duration;
  Resolution? resolution;
  double? frameRate;
  String? videoCodec;
  String? aspectRatio;
  String? audioCodec;

  VideoMetadata({
    required super.filename,
    required super.fileSize,
    required super.fileFormat,
    required super.filePath,
    super.dateCreated,
    super.dateModified,
    super.author,
    super.title,
    super.description,
    super.copyright,
    super.tags,
    this.duration,
    this.resolution,
    this.frameRate,
    this.videoCodec,
    this.aspectRatio,
    this.audioCodec,
  });

  factory VideoMetadata.fromJson(Map<String, dynamic> json) {
    VideoMetadata metadata = VideoMetadata(
      filename: json['filename'],
      fileSize: json['fileSize'],
      fileFormat: json['fileFormat'],
      filePath: json['filePath'],
      dateCreated: json['dateCreated'],
      dateModified: json['dateModified'],
      author: json['author'],
      title: json['title'],
      description: json['description'],
      copyright: json['copyright'],
      tags: json['tags'],
      duration: json['duration'],
      resolution: json['resolution'],
      frameRate: json['frameRate'],
      videoCodec: json['videoCodec'],
      aspectRatio: json['aspectRatio'],
      audioCodec: json['audioCodec'],
    );

    return metadata;
  }
}

class ImageMetadata extends CommonMetadata {
  Resolution? resolution;
  String? colorSpace;
  String imageFormat;

  ImageMetadata({
    required super.filename,
    required super.fileSize,
    required super.fileFormat,
    required super.filePath,
    super.dateCreated,
    super.dateModified,
    super.author,
    super.title,
    super.description,
    super.copyright,
    super.tags,
    this.resolution,
    this.colorSpace,
    required this.imageFormat,
  });


  factory ImageMetadata.fromJson(Map<String, dynamic> json) {
    ImageMetadata metadata = ImageMetadata(
      filename: json['filename'],
      fileSize: json['fileSize'],
      fileFormat: json['fileFormat'],
      filePath: json['filePath'],
      dateCreated: json['dateCreated'],
      dateModified: json['dateModified'],
      author: json['author'],
      title: json['title'],
      description: json['description'],
      copyright: json['copyright'],
      tags: json['tags'],
      resolution: json['resolution'],
      colorSpace: json['colorSpace'],
      imageFormat: json['imageFormat']);

    return metadata;
  }
}

class Resolution {
  int width;
  int height;

  Resolution({
    required this.width,
    required this.height,
  });


  factory Resolution.fromJson(Map<String, dynamic> json) {
    Resolution resolution = Resolution(
      width: json['width'],
      height: json['height'],
    );

    return resolution;
  }
}
