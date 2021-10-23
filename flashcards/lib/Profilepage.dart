//! if Error :- endlessLoadingScrean || API exception 10
//! means Firebase not set up correctly. Check both SHA1 & SHA 256
//! if Error :- Google sign In working in Developement phase but not in Production
//! means SHA 256 not included

//TODO USER WILL BE SIGNED IN EVEN IF WE CLOSE OUR APP

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards/google.dart';
import 'package:flashcards/views/Firstpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:startgoogle/GoogleAuthJM/Home.dart';
// import 'package:startgoogle/GoogleAuthJM/google_sign_in.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            // Everytime user Sign In or Sign Out, this widget will be rebuild
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Something is Wrong'),
                );
              } else if (snapshot.hasData) {
                return Firstpage();
              } else {
                return google();
              }
            }),
      ),
    );
  }
}

// class LoggedInWidget extends StatelessWidget {
//   const LoggedInWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //Accessing the Data of current user that is Signed In
//     final user = FirebaseAuth.instance.currentUser!; //TODO SAVE THIS SHIT IN SP
//     // We can use user to access all info of the User
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('LoggedIn'),
//         centerTitle: true,
//         actions: [
//           TextButton(
//               onPressed: () {
//                 Provider.of<GoogleSignInProvider>(context, listen: false)
//                     .logout();
//               },
//               child: Text('Logout'))
//         ],
//       ),
//       body: Container(
//         color: Colors.black87,
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Profile',
//               style: TextStyle(color: Colors.white, fontSize: 24),
//             ),
//             SizedBox(
//               height: 32,
//             ),
//             CircleAvatar(
//               radius: 40,
//               backgroundImage: NetworkImage(user.photoURL!),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Name: ' + user.displayName!,
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Email: ' + user.email!,
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
