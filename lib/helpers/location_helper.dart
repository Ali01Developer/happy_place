const GOOGLE_API_KEY = "AIzaSyBg9yn5JtQgKRFbg6FCTy4ewbF24kRuAYI";

class LocationHelper {
  static String generateLoginPreview(
      {required double latitude, required double longitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom==13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }
}
