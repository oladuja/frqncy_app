import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frqncy_app/src/models/user.dart';
import 'package:frqncy_app/src/screens/sign_in.dart';
import 'package:frqncy_app/src/services/auth_service.dart';
import 'package:frqncy_app/src/services/firestore_service.dart';
import 'package:frqncy_app/src/utils/logger.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

  static Widget _buildMiniCard({
    required String title,
    required String subtitle,
    required String assetName,
  }) {
    return Container(
      width: 160.w,
      margin: EdgeInsets.only(right: 12.w),
      padding: const EdgeInsets.all(12).w,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(assetName), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(8.w),
          Text(
            subtitle,
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<UserModel?> _user;
  final _firestoreService = FirestoreService();

  final settings = [
    "Account",
    "Notifications",
    // "Language",
    // "Downloads",
    // "Google Fit",
    // "My Data",
    "Support",
    "Terms & Conditions",
    "Privacy Policy",
  ];

  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      _user = _firestoreService.getUser(uid);
      logger.d("User ID: $uid");
    } else {
      _user = Future.value(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B062B),

      body: SafeArea(
        child: FutureBuilder<UserModel?>(
          future: _user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              logger.e(snapshot.hasError);

              return Center(child: Text('Error Occurred'));
            }
            final user = snapshot.data!;

            logger.d("User: ${user.toJson()}");

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              children: [
                // Align(
                //   alignment: Alignment.topRight,
                //   child: IconButton(
                //     icon: Icon(Icons.settings_outlined, size: 24.sp),
                //     onPressed:
                //         () => Navigator.of(context).push(
                //           MaterialPageRoute(
                //             builder: (_) => const SettingsScreen(),
                //           ),
                //         ),
                //   ),
                // ),
                Center(
                  child: CircleAvatar(
                    radius: 50.r,
                    backgroundImage: NetworkImage(user.imageUrl),
                  ),
                ),
                Gap(16.h),
                Center(
                  child: Text(
                    user.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Gap(4),
                // Center(
                //   child: Text(
                //     'Joined Feb 01, 2025',
                //     style: TextStyle(color: Colors.white54, fontSize: 14),
                //   ),
                // ),
                Gap(24.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFDA5F74), Color(0xFFEFADBF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(16).w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Begin Todays\nMeditations",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Gap(8.h),
                      // Text(
                      //   "Check In",
                      //   style: TextStyle(
                      //     color: Colors.white70,
                      //     fontSize: 14.sp,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Gap(30.w),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Recently Played",
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 16.sp,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       // Text(
                //       //   "Discover",
                //       //   style: TextStyle(color: Colors.purpleAccent),
                //       // ),
                //     ],
                //   ),
                //   Gap(12.h),
                //   SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Row(
                //       children: [
                //         ProfileScreen._buildMiniCard(
                //           title: "Meditation For Happiness",
                //           subtitle: "Guided Meditation Session",
                //           assetName: "assets/images/therapy.png",
                //         ),
                //         ProfileScreen._buildMiniCard(
                //           title: "Focus Staying On Track",
                //           subtitle: "Guided Meditation Session",
                //           assetName: "assets/images/music.png",
                //         ),
                //         ProfileScreen._buildMiniCard(
                //           title: "Meditation For Anxiety",
                //           subtitle: "Guided Meditation Session",
                //           assetName: "assets/images/sleep.png",
                //         ),
                //       ],
                //     ),
                //   ),
                //   Gap(30.h),
                //   Text(
                //     "Activity History",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 16.sp,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   Gap(12.h),
                //   MorningCard(
                //     content: Content(
                //       title: "Morning Meditation",
                //       subtitle: "Start your day with positivity",
                //       imageUrl:
                //           "https://firebasestorage.googleapis.com/v0/b/frqncyapp-b46bf.firebasestorage.app/o/images%2Fhome%2Finspiring%2FHello_img.jpg?alt=media&token=5d309ef7-e865-48a3-90ad-ab70e0efc59d",
                //       id: "1",
                //       description:
                //           "A guided meditation to start your day with clarity and positivity.",
                //       musicUrl: "assets/music/morning_meditation.mp3",
                //       type: "guided",
                //     ),
                //   ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: settings.length,
                  separatorBuilder:
                      (_, __) => Divider(color: Colors.white24, height: 1.h),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        settings[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                      onTap: () {
                        // Handle each setting item tap
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(20).w,
                  child: SizedBox(
                    width: double.infinity,
                    height: 60.h,
                    child: ElevatedButton(
                      onPressed: () async {
                        await AuthService().signOut();
                        if (!context.mounted) return;
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => SignInScreen()),
                          (_) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9B51E0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: Text("Log Out", style: TextStyle(fontSize: 17.sp)),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
