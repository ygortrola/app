import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notificações iOS',
      home: NotificacaoPage(),
    );
  }
}

class NotificacaoPage extends StatefulWidget {
  @override
  _NotificacaoPageState createState() => _NotificacaoPageState();
}

class _NotificacaoPageState extends State<NotificacaoPage> {
  String? _token;

  Future<void> _ativarNotificacoes() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await messaging.getToken();
      setState(() => _token = token);
      print('📲 Token do dispositivo: \$token');
    } else {
      print('❌ Permissão negada');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ativar Notificações')),
      body: Center(
        child: ElevatedButton(
          onPressed: _ativarNotificacoes,
          child: Text('Receber Notificações'),
        ),
      ),
    );
  }
}
