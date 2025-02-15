class SvgConverter {
  // static Future<BitmapDescriptor> getBitmapDescriptorFromImageAsset(
  //   String assetName, [
  //   Size? size = const Size(128, 128),
  // ]) async {
  //   var imageConfiguration = ImageConfiguration(size: size);
  //   return await BitmapDescriptor.fromAssetImage(imageConfiguration, assetName);
  // }

  // static Future<BitmapDescriptor> getBitmapDescriptorFromSvgAsset(
  //   String assetName, [
  //   Size? size,
  // ]) async {
  //   final pictureInfo = await vg.loadPicture(SvgAssetLoader(assetName), null);

  //   var tSize = size ?? Size(48.w, 48.w);
  //   // ignore: deprecated_member_use
  //   double devicePixelRatio = ui.window.devicePixelRatio;
  //   int width = (tSize.width * devicePixelRatio).toInt();
  //   int height = (tSize.height * devicePixelRatio).toInt();

  //   final scaleFactor = math.min(
  //     width / pictureInfo.size.width,
  //     height / pictureInfo.size.height,
  //   );

  //   final recorder = ui.PictureRecorder();

  //   ui.Canvas(recorder)
  //     ..scale(scaleFactor)
  //     ..drawPicture(pictureInfo.picture);

  //   final rasterPicture = recorder.endRecording();

  //   final image = rasterPicture.toImageSync(width, height);
  //   final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!;

  //   return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  // }
}
