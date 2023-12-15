
import '../../features/feed/FeedScreen.dart';
import '../../features/notifications/screens/notification_screen.dart';
import '../../features/post/screens/image_pick_screen.dart';

class Constants {
  static const googlePath = 'assets/images/google.png';
  static const backdrop = 'assets/images/backdrop.png';
  static const login = 'assets/images/login.png';

  static const bannerDefault =
      'https://thumbs.dreamstime.com/b/abstract-stained-pattern-rectangle-background-blue-sky-over-fiery-red-orange-color-modern-painting-art-watercolor-effe-texture-123047399.jpg';
  static const avatarDefault =
      'https://external-preview.redd.it/5kh5OreeLd85QsqYO1Xz_4XSLYwZntfjqou-8fyBFoE.png?auto=webp&s=dbdabd04c399ce9c761ff899f5d38656d1de87c2';

  static const tabWidgets = [
    ImagePick(),
    FeedScreen(),
    NotificationScreen(),
  ];
}


class AssetImages {
  static const noAlerts = "assets/images/no_alerts.png";
  static const noSearchResults = "assets/images/no_search_results.png";
  static const noOutfits = "assets/images/no_outfits.png";
  static const googleForms = "assets/images/google_forms.png";
  static const inrtoBackground = "assets/images/login_background.png";
  static const introImage = "assets/images/intro_image.png";
}
