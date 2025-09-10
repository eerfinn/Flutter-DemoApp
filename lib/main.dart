import 'package:flutter/material.dart';
import 'package:my_first_app/home_page.dart';

// 1. Fungsi main() adalah titik masuk (entry point) dari setiap aplikasi Flutter.
// Kode di dalam sini akan dieksekusi pertama kali.
void main() {
  // 2. runApp() adalah fungsi bawaan Flutter untuk memulai aplikasi
  // dengan sebuah widget sebagai akar (root) dari semua widget lainnya.
  runApp(const MyApp());
}

// 3. MyApp sekarang menjadi StatefulWidget.
// Ini karena ia akan "memegang" state yang bisa berubah, yaitu mode tema (terang/gelap).
// State ini perlu berada di sini agar bisa memengaruhi seluruh aplikasi.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Variabel untuk menyimpan state tema saat ini.
  // Kita mulai dengan `ThemeMode.system` agar mengikuti pengaturan sistem operasi.
  ThemeMode _themeMode = ThemeMode.system;

  // Fungsi untuk mengubah tema, yang akan kita teruskan ke halaman lain.
  void _changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 4. MaterialApp adalah widget dasar untuk aplikasi yang mengikuti Material Design.
    // Ia menyediakan banyak fungsionalitas dasar seperti navigasi, tema, dll.
    return MaterialApp(
      title: 'Flutter Demo',
      // `theme` adalah ThemeData yang akan digunakan untuk mode terang (light mode).
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // `darkTheme` adalah ThemeData yang akan digunakan untuk mode gelap (dark mode).
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Ini adalah properti kunci untuk mode gelap.
        useMaterial3: true,
      ),
      // `themeMode` menentukan mode mana yang sedang aktif. Nilainya kita ambil dari state `_themeMode`.
      themeMode: _themeMode,
      // 5. `home` menentukan widget apa yang akan menjadi halaman pertama yang dilihat pengguna.
      // Kita juga mengirimkan state tema saat ini dan fungsi untuk mengubahnya.
      home: MyHomePage(title: 'Flutter Demo', currentTheme: _themeMode, changeTheme: _changeTheme),
    );
  }
}
