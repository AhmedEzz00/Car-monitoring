

                            
                            
const GOOGLE_MAP_API_KEY = 'AIzaSyC6ZZpBg__lix4Y5No7CHneb9-EQl7RFBs';

class locationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {

    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_MAP_API_KEY';
      
  }
}
