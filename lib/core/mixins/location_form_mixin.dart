mixin LocationFormMixin {
  // Future<(Position? position, String? address)> initializeLocation({
  //   bool usePosition = true,
  //   bool useAddress = true,
  // }) async {
  //   Position? position;
  //   if (usePosition) {
  //     position = await LocationService.determinePosition().then((value) {
  //       return value;
  //     }).onError((String error, stackTrace) {
  //       DialogService.closeLoading();
  //       DialogService.showProblem(message: error, errorText: stackTrace.toString());
  //       return null;
  //     });
  //   }

  //   String? address;
  //   if (useAddress) {
  //     address = await LocationService.determineAddress().then((value) {
  //       return value;
  //     }).onError((String error, stackTrace) {
  //       DialogService.closeLoading();
  //       DialogService.showProblem(message: error, errorText: stackTrace.toString());
  //       return null;
  //     });
  //   }
  //   return (position, address);
  // }
}
