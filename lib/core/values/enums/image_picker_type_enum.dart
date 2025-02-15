// ignore_for_file: constant_identifier_names

enum ImagePickerType {
  CAMERA,
  GALLERY;

  bool get isCamera => this == ImagePickerType.CAMERA;
  bool get isGallery => this == ImagePickerType.GALLERY;
}
