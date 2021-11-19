class UploadImageFormat {
  int? mediaID;
  String? content;
  String? extension;
  String? contentType;
  String? folderName;

  UploadImageFormat(
      {this.mediaID,
      this.content,
      this.extension,
      this.contentType,
      this.folderName});

  UploadImageFormat.fromJson(Map<String, dynamic> json) {
    mediaID = json['mediaID'];
    content = json['content'];
    extension = json['extension'];
    contentType = json['contentType'];
    folderName = json['folderName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mediaID'] = this.mediaID;
    data['content'] = this.content;
    data['extension'] = this.extension;
    data['contentType'] = this.contentType;
    data['folderName'] = this.folderName;
    return data;
  }
}
