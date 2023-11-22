import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../core/data/database/database.dart';
import '../res/color_print.dart';
import '../route/app_routes.dart';
import '../utils/local_storage.dart';
import '../utils/utils.dart';

class AuthRepositories {
  static Future signInWithGoogle({RxBool? isLoader}) async {
    if (await getConnectivityResult()) {
      try {
        isLoader?.value = true;
        final GoogleSignIn googleSignIn =
            GoogleSignIn(scopes: <String>['email']);
        await googleSignIn.signOut();
        await googleSignIn.signIn().then(
          (value) async {
            final GoogleSignInAuthentication? googleAuth =
                await value?.authentication;

            if (!isValEmpty(googleAuth?.idToken)) {
              final OAuthCredential credential = GoogleAuthProvider.credential(
                  accessToken: googleAuth?.accessToken,
                  idToken: googleAuth?.idToken);

              final UserCredential google =
                  await FirebaseAuth.instance.signInWithCredential(credential);

              //? Action is here
              if (!isValEmpty(google.user)) {
                await LocalStorage.storeDataInfo(
                        uid: google.user?.uid ?? "",
                        userEmaIL: google.user?.email ?? "")
                    .then(
                  (value) async {
                    await DatabaseHelper()
                        .setUserData(
                      userId: google.user?.uid ?? "",
                      userName: google.user?.displayName,
                      userEmail: google.user?.email,
                      profileImage: google.user?.photoURL,
                    )
                        .then(
                      (value) async {
                        if (await DatabaseHelper().isUserExistOrNot()) {
                          isLoader?.value = false;
                          Get.offAllNamed(
                            AppRoutes.selectBusinessScreen,
                            arguments: {"isStartup": true},
                          );
                        } else {
                          await DatabaseHelper()
                              .restoreDatabaseFromFirebase()
                              .then(
                            (value) async {
                              isLoader?.value = false;
                              Get.offAllNamed(AppRoutes.dashboardScreen);
                            },
                          );
                        }
                      },
                    );
                  },
                );
              }
            }
          },
        );
      } catch (e) {
        isLoader?.value = false;
        printError(type: "SignInWithGoogle function", errText: "$e");
      } finally {
        isLoader?.value = false;
      }
    }
  }

  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future signInWithApple({RxBool? isLoader}) async {
    if (Platform.isIOS) {
      if (await getConnectivityResult()) {
        try {
          isLoader?.value = true;
          final rawNonce = generateNonce();
          final nonce = sha256ofString(rawNonce);

          // Request credential for the currently signed in Apple account.
          final appleCredential = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            nonce: nonce,
          );

          //+ Create an `OAuthCredential` from the credential returned by Apple.
          final oauthCredential = OAuthProvider("apple.com").credential(
            idToken: appleCredential.identityToken,
            rawNonce: rawNonce,
          );

          // Sign in the user with Firebase. If the nonce we generated earlier does
          // not match the nonce in `appleCredential.identityToken`, sign in will fail.
          final apple =
              await FirebaseAuth.instance.signInWithCredential(oauthCredential);
          if (!isValEmpty(apple.user)) {
            await LocalStorage.storeDataInfo(
                    uid: apple.user?.uid ?? "",
                    userEmaIL: apple.user?.email ?? "")
                .then(
              (value) async {
                await DatabaseHelper()
                    .setUserData(
                  userId: apple.user?.uid ?? "",
                  userName: apple.user?.displayName,
                  userEmail: apple.user?.email,
                  profileImage: apple.user?.photoURL,
                )
                    .then(
                  (value) async {
                    if (await DatabaseHelper().isUserExistOrNot()) {
                      isLoader?.value = false;
                      Get.offAllNamed(
                        AppRoutes.selectBusinessScreen,
                        arguments: {"isStartup": true},
                      );
                    } else {
                      await DatabaseHelper().restoreDatabaseFromFirebase().then(
                        (value) async {
                          await Future.delayed(const Duration(seconds: 2)).then(
                            (value) {
                              isLoader?.value = false;
                              Get.offAllNamed(AppRoutes.dashboardScreen);
                            },
                          );
                        },
                      );
                    }
                  },
                );
              },
            );
          }
        } catch (e) {
          printError(type: "signInWithApple function", errText: "$e");
        } finally {
          isLoader?.value = false;
        }
      }
    }
  }
}
