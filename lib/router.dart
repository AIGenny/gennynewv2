import '../features/HomeFeed/add_post_screen.dart';
import '../features/add%20outfit/screens/add_outfit_screen.dart';
import '../features/add%20outfit/screens/preview_screen.dart';
import '../features/auth/screens/introduction_screen.dart';
import '../features/feed/FeedScreen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/my%20outfits/detailed_outfit_screen.dart';
import '../features/my%20outfits/edit_outfit_screen.dart';
import '../features/my%20outfits/my_outfits_screen.dart';
import '../features/notifications/screens/notification_screen.dart';
import '../features/post/screens/camera_folder.dart';
import '../features/post/screens/form_screen.dart';
import '../features/post/screens/image_pick_screen.dart';
import '../features/settings/screens/about_acreen.dart';
import '../features/settings/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';

import 'package:routemaster/routemaster.dart';

import 'features/Search/search_screen.dart';

//Describing routes for:
//loggedOut
//loggedIn

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: IntroductionScreen()),
  '/login': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: HomeScreen()),
    '/form-screen': (_) => const MaterialPage(child: FormScreen()),
    '/image-pick': (_) => const MaterialPage(child: ImagePick()),
    '/feed-screen': (_) => const MaterialPage(child: FeedScreen()),
    '/notification-screen': (_) =>
        const MaterialPage(child: NotificationScreen()),
    '/camera-folder': (_) => const MaterialPage(child: CameraFolderScreen()),
    '/add-outfit': (_) => const MaterialPage(child: AddOutfitScreen()),
    '/add-outfit/camera-folder': (_) =>
        const MaterialPage(child: CameraFolderScreen()),
    '/add-outfit/preview-outfit': (_) =>
        const MaterialPage(child: PreviewScreen()),
    '/my-outfits': (_) => const MaterialPage(child: MyOutfitScreen()),
    '/my-outfits/detailed-outfits': (_) =>
        MaterialPage(child: DetailedOutfitScreen()),
    '/detailed-outfits': (_) =>
        MaterialPage(child: DetailedOutfitScreen()),
    '/my-outfits/detailed-outfits/edit-outfit': (_) =>
        const MaterialPage(child: EditOutfitScreen()),
    '/detailed-outfits/edit-outfit': (_) =>
        const MaterialPage(child: EditOutfitScreen()),
    '/settings-screen': (_) => const MaterialPage(child: SettingsScreen()),
    '/about-screen':(_)=>const MaterialPage(child: AboutScreen()),
    '/add-post':(_)=>const MaterialPage(child: AddPostScreen()),
    '/search-friends': (_) => const MaterialPage(child: SearchScreen()),
  },
);

class Routes {
  static const addOutfitScreen = '/add-outfit';
  static const notificationScreen = '/notification-screen';
  static const cameraFolderScreen = '/camera-folder';
  static const feedScreen = '/feed-screen';
  static const previewScreen = 'preview-outfit';
  static const myOutfitScreen = '/my-outfits';
  static const detailedOutfitScreen = 'detailed-outfits';
  static const editOutfitScreen = 'edit-outfit';
  static const settingScreen = '/settings-screen';
  static const aboutScreen = '/about-screen';
  static const addPost='/add-post';
  static const searchFriends='/search-friends';

}

void navigateTo(BuildContext context, String route,
    {Map<String, String>? query, bool? replace}) {
  if (replace != null && replace == true) {
    Routemaster.of(context).replace(route, queryParameters: query);
  } else {
    Routemaster.of(context).push(route, queryParameters: query);
  }
}

void navigateBack(BuildContext context) {
  Routemaster.of(context).pop();
}
