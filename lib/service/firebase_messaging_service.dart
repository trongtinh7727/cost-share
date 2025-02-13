import 'package:cost_share/main.dart';
import 'package:cost_share/utils/route/route_name.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart' as auth;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  print('Message data: ${message.data}');
}

class FirebaseMessagingService {
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._();
  factory FirebaseMessagingService() {
    return _instance;
  }
  FirebaseMessagingService._();
  FirebaseMessagingService get instance => _instance;

  String? _token;

  String? get token => _token;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final token = await _firebaseMessaging.getToken();
    print('Token: $token');
    _token = token;

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');
      navigatorKey.currentState?.pushNamed(RouteName.notificationDetail,
          arguments: message.notification?.title);
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "cost-share-7c539",
      "private_key_id": "98be711bc1ac87ec9ae7e92853f2b32e0eb1fae4",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCtP9qUF8kmen0X\neM9dmRTCbSyoqjn50FC2+W5L2CuUTHMZ8dGr2e7lLTxXLOCTVmaU7VSugp3IQxeZ\nStHOKfhIj27S4NjrRgmARK2+DIS9DWuHQ5b1rCx/wGxrxrhaYuMFsP8PmMZ/L29b\nbya8ImtsvVWV7sdYb0WbZfHv4wHRnOGChUZzV9b4OZSEuYkhdiGIMAHaDOewAsrM\n/HAQwrDuZdTBI1hnwFjqzrh177//yqoA3fimW5AVhO32OaT7Af3kw6/ls0pt10xG\n2ZoimFvKff2kk2mcL6t4bllinKrYBHaMRFK0eL8ooW6xONHxAnSVzdTbC8dwqawe\nFoRQxreXAgMBAAECggEAIeWQ6BHBTvB/QhTmiZsWZzYCG1v27Ow3pp0l2dwJJsJQ\ncN6R1exVY+yWVj4XEGzCtFe9DknLAjAyUVFEvHAUvmml1secWWgCGuEVF06OuAiE\npdnxEs8lg7dL30hpsHGRln77YHtVNvQ6durH6t5XI1bmBGhMA3794PowvG0vYWnc\nPidlK4J4yoR+BaffiBA5Xu9hRNA7T9iEXoz1TrjRgkYYKlgjA8HumhOK1YqTedFg\nyOvaK2qd7VXRWtFuCnj9UHpp1IuInfuiF3+icL7uL32DTbRB7lTOIPsPwzHXPF30\notdOymWIwIcVY8XVGvtvgFekLaO/I1/jBfTEX9YGbQKBgQDkQPmsvZxP5otewo3J\nqw777oyTHpK9MgO2OAHf2ywBfgbsZLpY76LdjZyohooMzjl9GW1z9+/S9y6TNVAG\n7GckSHbUeDR9rmRUKNbnU9ssdbu+LSRKZq/Fck2CmQO7ralpb8AprT6IDqHtztXl\nHP6tQ4emtTZJsWVGf+Xw9RScHQKBgQDCTzLUen5rRKUvYHHcZJbQfJCDALm4xUEr\ngBQ2CMPPtdtFMGQ4Gg00DJq1yC2RfCitUoTAOzUoZqAXUcMjS3egT9mdEXMoMl9A\nm29/mZhSMP9nj8zN9cRUPAebxq4ywKM+h1HTfAkbzF4ooeAY9tzY7MUL/gFmAaZl\nj6jT32qMQwKBgAxDVWardTdxunEn4LhCAXcVlOXekaGqizqB/c/KFa4q2DJhIwXe\nMhDXJ+CCAe64Max/7jp5yp+5+f2csqT8lHoFjqTRpHhQI0HGQ+1/utnDpYeNI1L/\n+1ePUYy/rcyqgtyQTXGvxhlHN/nvz9wUV7Z1V1dkivsglcFY48CzWh0dAoGBAIQT\nl2ZsWPAK+gkpElwPl5/he81AOf2JPxIVfid4b7kJUSFHkme79YuSobq8dZT1gyTE\n+W09EZYDpAAV2IFuM8MpY67rBI6nJq3gubpPKgV8Pq8jRMAetTPYlgdh1lizLoM7\nMfiB0CMwGDSgS5ZMfrOIxSuwnTy8FGHmc4iIzYDHAoGAHwFKU2+i+bMgMFE/FDEJ\nR/xhKnO/4+xha9w+5pJVKcjZWisPBxLFt7mlBcXqMxGAXfcMuJ+KWypK30MsLvTb\nqXdOX0kcJNPcuRV5clBl9ttgqUOcNvrPvC360XIeb9kTjrXIkq5olloRNl7fure5\nXsYGYWNV02A/4T3m0pbxpQs=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-sgm0s@cost-share-7c539.iam.gserviceaccount.com",
      "client_id": "102755757027690529108",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-sgm0s%40cost-share-7c539.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    // Obtain the access token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    // Close the HTTP client
    client.close();

    // Return the access token
    return credentials.accessToken.data;
  }

  Future<void> sendFCMMessage(
      {required String FCMToken,
      required String title,
      required String body,
      Map<String, String?>? data}) async {
    final String serverKey = await getAccessToken();
    final String fcmEndpoint =
        'https://fcm.googleapis.com/v1/projects/cost-share-7c539/messages:send';

    final Map<String, dynamic> message = {
      'message': {
        'token': FCMToken,
        'notification': {'body': body, 'title': title},
        'data': data,
      }
    };

    final http.Response response = await http.post(
      Uri.parse(fcmEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('FCM message sent successfully');
    } else {
      print('Failed to send FCM message: ${response.statusCode}');
    }
  }
}
