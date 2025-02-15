// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';

// class LocationService {
//   /// Determine the current position of the device.
//   ///
//   /// When the location services are not enabled or permissions
//   /// are denied the `Future` will return an error.
//   static Future<Position?> determinePosition() async {
//     try {
//       bool serviceEnabled;
//       LocationPermission permission;

//       // Test if location services are enabled.
//       serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         // Location services are not enabled don't continue
//         // accessing the position and request users of the
//         // App to enable the location services.
//         return Future.error('Location services are disabled.');
//       }

//       permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           return Future.error('Location permissions are denied');
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         // Permissions are denied forever, handle appropriately.
//         return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.',
//         );
//       }

//       // When we reach here, permissions are granted and we can
//       // continue accessing the position of the device.
//       return await Geolocator.getCurrentPosition();
//     } catch (e, s) {
//       e.printError(info: "GET LOCATION ERROR");
//       s.printError(info: "GET LOCATION STACK TRACE");
//       return Future.error(
//         'Somthing when wrong with Location, we cannot request location.',
//       );
//     }
//   }

//   static Future<String?> determineAddress({
//     bool street = true,
//     bool subThoroughfare = true,
//     bool thoroughfare = true,
//     bool subLocality = true,
//     bool locality = true,
//     bool subAdministrativeArea = true,
//     bool administrativeArea = true,
//     bool country = true,
//   }) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
//       if (placemarks.isEmpty) return Future.error("Address not found");
//       var placemark = placemarks.first;
//       var address = "";
//       if ((placemark.street ?? "").isNotEmpty && street) address += "${placemark.street} ";
//       if ((placemark.subThoroughfare ?? "").isNotEmpty && subThoroughfare) {
//         address += "${placemark.subThoroughfare} ";
//       }
//       if ((placemark.thoroughfare ?? "").isNotEmpty && thoroughfare) {
//         address += "${placemark.thoroughfare} ";
//       }
//       if ((placemark.subLocality ?? "").isNotEmpty && subLocality) {
//         address += "${placemark.subLocality} ";
//       }
//       if ((placemark.locality ?? "").isNotEmpty && locality) address += "${placemark.locality} ";
//       if ((placemark.subAdministrativeArea ?? "").isNotEmpty && subAdministrativeArea) {
//         address += "${placemark.subAdministrativeArea} ";
//       }
//       if ((placemark.administrativeArea ?? "").isNotEmpty && administrativeArea) {
//         address += "${placemark.administrativeArea} ";
//       }
//       if ((placemark.country ?? "").isNotEmpty && country) address += "${placemark.country} ";
//       return address;
//     } catch (e,s) {
//       e.printError(info: "GET ADDRESS ERROR");
//       s.printError(info: "GET ADDRESS STACK TRACE");
//       return Future.error(
//         'Somthing when wrong with Address, we cannot request address.',
//       );
//     }
//   }
// }
