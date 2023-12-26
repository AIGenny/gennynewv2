import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../router.dart';
import '../components/components.dart';
import 'post.dart';


class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({Key? key}) : super(key: key);

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}
const webScreenSize = 600;
class _HomeFeedScreenState extends State<HomeFeedScreen> {


  void clearImage() {
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    bool isSearch = false, showSearchField = false;
    return Scaffold(

      appBar: CustomAppBar(
        hasSearch: true,
        searchFunction: () {
          navigateTo(context, Routes.searchFriends);
        },
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {navigateTo(context, Routes.addPost,replace: false);},
        child: Icon(Icons.add), // You can use any Icon you want
        backgroundColor: Colors.blue, // Customize the background color
      ),
    );
  }
}
