class DocumentFile {
  String? id;
  String? name;
  String? file;
  String? fileType;
  String? url;

  DocumentFile._({
    this.id,
    this.name,
    this.file,
    this.fileType,
    this.url,
  });

  factory DocumentFile.request({
    required String name,
    required String file,
    required String fileType,
  }) {
    return DocumentFile._(name: name, file: file, fileType: fileType);
  }

  factory DocumentFile.fromJson(Map<String, dynamic> json) => DocumentFile._(
        id: json["id"],
        name: json["name"],
        file: json["file"],
        fileType: json["file_type"],
        url: json["url"],
      );

  Map<String, dynamic> toRequestJson() => {
        "name": name,
        "file": file,
        "file_type": fileType,
      };
  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "name": name,
        "file": file,
        "file_type": fileType,
      };
}
