
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../core/utilies.dart';
import '../auth/controller/auth_controller.dart';
import '../post/screens/commentScreen.dart';
import 'like_animation.dart';


class PostCard extends ConsumerStatefulWidget{
  final snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
    setState(() {
      commentLen = snap.docs.length;
    });

    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }

  }

  deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final width = MediaQuery.of(context).size.width;

    return Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.white,
              radius: 20,
              backgroundImage: NetworkImage(user!.profilePic),
            ),
            minLeadingWidth: 20,
            titleTextStyle: const TextStyle(color: Colors.black),
            title:  Text( widget.snap['username'].toString(),style: TextStyle(
              color: Colors.black,
            ),),
            subtitle: const HeadingText2(heading: "via Reddit"),
            trailing: Icon(Icons.more_vert,color: Colors.black,),
          ),
          GestureDetector(
            onDoubleTap: () {
              FireStoreMethods().likePost(
                widget.snap['postId'].toString(),
                user!.uid,
                widget.snap['likes'],
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
                alignment: Alignment.center,
              children:[

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['postUrl'].toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                ),
              ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: HeadingText(heading: "Top fashion designers in US. Can you guess who they are before you watch the video?"),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  LikeAnimation(
                    isAnimating: widget.snap['likes'].contains(user.uid),
                    smallLike: true,
                    child: IconButton(
                      icon: widget.snap['likes'].contains(user.uid)
                          ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                          : const Icon(
                        Icons.favorite_border,
                      ),
                      onPressed: () => FireStoreMethods().likePost(
                        widget.snap['postId'].toString(),
                        user.uid,
                        widget.snap['likes'],
                      ),
                    ),
                  ),
                  Text(
                    "${widget.snap['likes'].length.toString()} Likes",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentsScreen(
                              post: widget.snap['postId'].toString(),
                            )
                          ),
                        );
                        // MaterialPageRoute(
                        //   builder: (context) => CommentsScreen(
                        //     post: widget.snap['postId'].toString(),
                        //   ),
                        // );
                      },
                      icon: const Icon(Icons.gesture_outlined, size: 24),
                    ),
                  ),
                  Text(
                    " ${commentLen} comment${(3 == 1) ? '' : 's'}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_border_outlined),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            thickness: 1.0,
            indent: 2.0,
          ),
        ],
      );


    /////////////////////////////////////////////////////////////////////////////
    // return Container(
    //   // boundary needed for web
    //   decoration: BoxDecoration(
    //     border: Border.all(
    //       color: width > webScreenSize ? secondaryColor : mobileBackgroundColor,
    //     ),
    //     color: mobileBackgroundColor,
    //   ),
    //   padding: const EdgeInsets.symmetric(
    //     vertical: 10,
    //   ),
    //   child: Column(
    //     children: [
    //       // HEADER SECTION OF THE POST
    //       Container(
    //         padding: const EdgeInsets.symmetric(
    //           vertical: 4,
    //           horizontal: 16,
    //         ).copyWith(right: 0),
    //         child: Row(
    //           children: <Widget>[
    //             CircleAvatar(
    //               radius: 16,
    //               backgroundImage: NetworkImage(
    //                 widget.snap['profImage'].toString(),
    //               ),
    //             ),
    //             Expanded(
    //               child: Padding(
    //                 padding: const EdgeInsets.only(
    //                   left: 8,
    //                 ),
    //                 child: Column(
    //                   mainAxisSize: MainAxisSize.min,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     Text(
    //                       widget.snap['username'].toString(),
    //                       style: const TextStyle(
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             widget.snap['uid'].toString() == user.uid
    //                 ? IconButton(
    //                     onPressed: () {
    //                       showDialog(
    //                         useRootNavigator: false,
    //                         context: context,
    //                         builder: (context) {
    //                           return Dialog(
    //                             child: ListView(
    //                                 padding: const EdgeInsets.symmetric(
    //                                     vertical: 16),
    //                                 shrinkWrap: true,
    //                                 children: [
    //                                   'Delete',
    //                                 ]
    //                                     .map(
    //                                       (e) => InkWell(
    //                                           child: Container(
    //                                             padding:
    //                                                 const EdgeInsets.symmetric(
    //                                                     vertical: 12,
    //                                                     horizontal: 16),
    //                                             child: Text(e),
    //                                           ),
    //                                           onTap: () {
    //                                             deletePost(
    //                                               widget.snap['postId']
    //                                                   .toString(),
    //                                             );
    //                                             // remove the dialog box
    //                                             Navigator.of(context).pop();
    //                                           }),
    //                                     )
    //                                     .toList()),
    //                           );
    //                         },
    //                       );
    //                     },
    //                     icon: const Icon(Icons.more_vert),
    //                   )
    //                 : Container(),
    //           ],
    //         ),
    //       ),
    //       // IMAGE SECTION OF THE POST
    //       GestureDetector(
    //         onDoubleTap: () {
    //           FireStoreMethods().likePost(
    //             widget.snap['postId'].toString(),
    //             user.uid,
    //             widget.snap['likes'],
    //           );
    //           setState(() {
    //             isLikeAnimating = true;
    //           });
    //         },
    //         child: Stack(
    //           alignment: Alignment.center,
    //           children: [
    //             SizedBox(
    //               height: MediaQuery.of(context).size.height * 0.35,
    //               width: double.infinity,
    //               child: Image.network(
    //                 widget.snap['postUrl'].toString(),
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //             AnimatedOpacity(
    //               duration: const Duration(milliseconds: 200),
    //               opacity: isLikeAnimating ? 1 : 0,
    //               child: LikeAnimation(
    //                 isAnimating: isLikeAnimating,
    //                 duration: const Duration(
    //                   milliseconds: 400,
    //                 ),
    //                 onEnd: () {
    //                   setState(() {
    //                     isLikeAnimating = false;
    //                   });
    //                 },
    //                 child: const Icon(
    //                   Icons.favorite,
    //                   color: Colors.black,
    //                   size: 100,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       // LIKE, COMMENT SECTION OF THE POST
    //       Row(
    //         children: <Widget>[
    //           LikeAnimation(
    //             isAnimating: widget.snap['likes'].contains(user.uid),
    //             smallLike: true,
    //             child: IconButton(
    //               icon: widget.snap['likes'].contains(user.uid)
    //                   ? const Icon(
    //                       Icons.favorite,
    //                       color: Colors.red,
    //                     )
    //                   : const Icon(
    //                       Icons.favorite_border,
    //                     ),
    //               onPressed: () => FireStoreMethods().likePost(
    //                 widget.snap['postId'].toString(),
    //                 user.uid,
    //                 widget.snap['likes'],
    //               ),
    //             ),
    //           ),
    //           IconButton(
    //             icon: const Icon(
    //               Icons.comment_outlined,
    //             ),
    //             onPressed: () => Navigator.of(context).push(
    //               MaterialPageRoute(
    //                 builder: (context) => CommentsScreen(
    //                   postId: widget.snap['postId'].toString(),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           IconButton(
    //               icon: const Icon(
    //                 Icons.send,
    //               ),
    //               onPressed: () {}),
    //           Expanded(
    //               child: Align(
    //             alignment: Alignment.bottomRight,
    //             child: IconButton(
    //                 icon: const Icon(Icons.bookmark_border), onPressed: () {}),
    //           ))
    //         ],
    //       ),
    //       //DESCRIPTION AND NUMBER OF COMMENTS
    //       Container(
    //         padding: const EdgeInsets.symmetric(horizontal: 16),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             DefaultTextStyle(
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .titleSmall!
    //                     .copyWith(fontWeight: FontWeight.w800),
    //                 child: Text(
    //                   '${widget.snap['likes'].length} likes',
    //                   style: Theme.of(context).textTheme.bodyMedium,
    //                 )),
    //             Container(
    //               width: double.infinity,
    //               padding: const EdgeInsets.only(
    //                 top: 8,
    //               ),
    //               child: RichText(
    //                 text: TextSpan(
    //                   style: const TextStyle(color: primaryColor),
    //                   children: [
    //                     TextSpan(
    //                       text: widget.snap['username'].toString(),
    //                       style: const TextStyle(
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                     TextSpan(
    //                       text: ' ${widget.snap['description']}',
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             InkWell(
    //               child: Container(
    //                 padding: const EdgeInsets.symmetric(vertical: 4),
    //                 child: Text(
    //                   'View all $commentLen comments',
    //                   style: const TextStyle(
    //                     fontSize: 16,
    //                     color: secondaryColor,
    //                   ),
    //                 ),
    //               ),
    //               onTap: () => Navigator.of(context).push(
    //                 MaterialPageRoute(
    //                   builder: (context) => CommentsScreen(
    //                     postId: widget.snap['postId'].toString(),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               padding: const EdgeInsets.symmetric(vertical: 4),
    //               child: Text(
    //                 DateFormat.yMMMd()
    //                     .format(widget.snap['datePublished'].toDate()),
    //                 style: const TextStyle(
    //                   color: secondaryColor,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );

  }
}

class HeadingText2 extends StatelessWidget {
  const HeadingText2({Key? key,

    required this.heading,
  }) : super(key: key);
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
    );
  }
}
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class HeadingText extends StatelessWidget {
  const HeadingText({Key? key,

    required this.heading,
    this.capitalize = true,
  }) : super(key: key);
  final String heading;
  final bool capitalize;

  @override
  Widget build(BuildContext context) {
    return Text(
      capitalize ? heading.capitalize() : heading,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w300, color: Colors.black),
    );
  }
}

class SubHeadingText extends StatelessWidget {
  const SubHeadingText({Key? key,

    required this.heading,
  }) : super(key: key);
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Text(
      heading.capitalize(),
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w300, color: Colors.black),
    );
  }
}


class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<String> uploadPost(String description, Uint8List file, String uid,
  //     String username, String profImage) async {
  //   // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
  //   String res = "Some error occurred";
  //   try {
  //     String photoUrl =
  //     await StorageMethods().uploadImageToStorage('posts', file, true);
  //     String postId = const Uuid().v1(); // creates unique id based on time
  //     Post post = Post(
  //       description: description,
  //       uid: uid,
  //       username: username,
  //       likes: [],
  //       postId: postId,
  //       datePublished: DateTime.now(),
  //       postUrl: photoUrl,
  //       profImage: profImage,
  //     );
  //     _firestore.collection('posts').doc(postId).set(post.toJson());
  //     res = "success";
  //   } catch (err) {
  //     res = err.toString();
  //   }
  //   return res;
  // }

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Post comment
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
      await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }
}
