import 'package:flutter/material.dart';

// 6. Ini adalah widget untuk halaman utama kita.
// Dibuat sebagai StatefulWidget karena konten di dalamnya (nilai counter) akan berubah.
class MyHomePage extends StatefulWidget {
  // Konstruktor untuk menerima data dari parent widget (dalam hal ini, judul dari MyApp).
  const MyHomePage({
    super.key,
    required this.title,
    required this.currentTheme,
    required this.changeTheme,
  });

  final String title;
  final ThemeMode currentTheme; // Menerima mode tema saat ini.
  final Function(ThemeMode) changeTheme; // Menerima fungsi untuk mengubah tema.

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 7. Ini adalah kelas State untuk MyHomePage.
// Semua logika dan variabel yang bisa berubah (state) diletakkan di sini.
class _MyHomePageState extends State<MyHomePage> {
  // Ini adalah "state" kita. Variabel yang nilainya akan berubah dan ditampilkan di UI.
  int _counter = 1000;

  // Ini adalah fungsi (perintah) untuk mengubah state.
  void _incrementCounter() {
    // 9. setState() adalah fungsi krusial.
    // Ia memberitahu Flutter bahwa state telah berubah, dan Flutter harus
    // menjalankan ulang method `build()` untuk memperbarui tampilan.
    setState(() {
      // Logika perubahan state diletakkan di dalam callback setState.
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 1000; // Kembali ke nilai awal
    });
  }

  void _multiplyCounter() {
    setState(() {
      _counter = _counter * 2;
    });
  }

  void _divideCounter() {
    setState(() {
      _counter = (_counter / 2).round();
    });
  }

  // 8. Method `build()` dipanggil oleh Flutter untuk "menggambar" UI.
  // Method ini akan berjalan saat halaman pertama kali dimuat, dan setiap kali
  // `setState()` dipanggil.
  @override
  Widget build(BuildContext context) {
    // Scaffold adalah kerangka dasar untuk sebuah halaman di Material Design.
    // Ia menyediakan AppBar, Body, FloatingActionButton, dll.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // `actions` adalah daftar widget yang ditempatkan di sebelah kanan AppBar.
        actions: [
          // IconButton untuk mengubah tema.
          IconButton(
            // Ikon akan berubah tergantung pada tema saat ini.
            icon: Icon(widget.currentTheme == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              // Memanggil fungsi `changeTheme` yang kita dapatkan dari MyApp.
              // Jika sekarang gelap, ubah ke terang. Jika terang, ubah ke gelap.
              final newTheme = widget.currentTheme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
              widget.changeTheme(newTheme);
            },
            tooltip: 'Toggle Theme',
          ),
        ],
        // `widget.title` digunakan untuk mengakses properti dari kelas StatefulWidget (`MyHomePage`).
        title: Text(widget.title),
      ),
      // =======================================================================
      // CARA LEBIH FLEKSIBEL: Menggunakan Stack untuk menumpuk widget
      // =======================================================================
      // `Stack` memungkinkan kita menumpuk widget di atas satu sama lain.
      // Widget pertama dalam `children` akan berada di paling bawah, dan seterusnya.
      body: Stack(
        children: <Widget>[
          // Widget pertama (paling bawah): Konten utama halaman (teks counter).
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You have pushed the button this many times:'),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),

          // Widget kedua (di atas konten): Grup tombol kita.
          // Kita bungkus dengan `Align` untuk memposisikannya.
          Align(
            // `alignment` menentukan posisi di dalam Stack.
            // `Alignment.bottomCenter` berarti di tengah-bawah.
            alignment: Alignment.bottomCenter,
            child: Padding(
              // Padding agar tidak terlalu mepet ke bawah dan samping.
              padding: const EdgeInsets.only(bottom: 100.0, left: 16.0, right: 16.0),
              child: Row(
                // Mengatur jarak antar tombol di dalam Row.
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: _multiplyCounter,
                    tooltip: 'Multiply by 2',
                    child: const Icon(Icons.close),
                  ),
                  FloatingActionButton(
                    onPressed: _decrementCounter,
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    onPressed: _resetCounter,
                    tooltip: 'Reset',
                    child: const Icon(Icons.replay),
                  ),
                  FloatingActionButton(
                    onPressed: _incrementCounter,
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    onPressed: _divideCounter,
                    tooltip: 'Divide by 2',
                    child: const Icon(Icons.horizontal_rule),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}