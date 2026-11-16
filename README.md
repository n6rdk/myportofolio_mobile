# MyPortfolio Mobile App

> Aplikasi mobile portofolio pribadi yang menampilkan informasi singkat pemilik serta menu prototipe untuk melihat atau menambahkan proyek, keahlian, dan pengalaman.

## About the Project

Project ini merupakan aplikasi portofolio pribadi versi mobile yang dikembangkan sebagai bagian dari penugasan mata kuliah **Pemrograman Berbasis Platform**.

Aplikasi ini dibangun menggunakan Flutter dan merupakan pendamping dari website portofolio berbasis Django yang sudah dibuat sebelumnya. Desain visualnya mengikuti tema gelap yang terinspirasi dari tampilan terminal.

Versi saat ini masih berada pada tahap awal pengembangan (Week 1).

## Features

* Tema gelap berbasis Material 3 dengan palet warna kustom.
* Integrasi Google Fonts menggunakan package `google_fonts`.
* Warna dan gaya teks diambil dari tema (`Theme.of(context)`) sehingga konsisten di seluruh halaman.

## Tech Stack

| Technology          | Purpose                                                |
| ------------------- | ------------------------------------------------------ |
| Flutter             | Framework untuk membangun aplikasi mobile              |
| Dart                | Bahasa pemrograman yang digunakan                      |
| Material 3          | Sistem desain dan komponen UI                          |
| google_fonts        | Menyediakan font dari Google Fonts                     |

## Project Structure

```text
myportofolio_mobile/
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   └── menu.dart
├── linux/
├── macos/
├── test/
│   └── widget_test.dart
├── web/
├── windows/
├── analysis_options.yaml
├── pubspec.lock
├── pubspec.yaml
├── .gitignore
└── README.md
```

## Getting Started

### Prerequisites

Pastikan sudah memiliki:

* Flutter SDK
* Git
* Android Studio atau VS Code (dengan ekstensi Flutter)
* Developer Mode aktif (khusus Windows, diperlukan untuk symlink saat build dengan plugin)

### Installation

Clone repository:

```bash
git clone <repository-url>
cd myportofolio_mobile
```

Install dependencies:

```bash
flutter pub get
```

Jalankan aplikasi:

```bash
flutter run
```

## Weekly Progress

### Week 1

* Setup project.
* Mendesign layout, color palette, dan font yang digunakan pada aplikasi ini.
* Mengatur tema gelap Material 3 dengan color scheme kustom.
* Menambahkan Google Fonts menggunakan package `google_fonts`.
* Implementasi Tutorial 8

---

# Jawaban Pertanyaan Reflektif

## Tugas 1

> 1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!

Widget tree adalah representasi logis dari semua widget penyusun UI di Flutter, di mana tiap widget menjadi node dalam struktur pohon yang dipakai saat layout, rendering, dan hit testing. Dalam hubungan parent-child, widget parent memberi properti atau deskripsi ke childnya, sehingga child pada StatelessWidget tidak mengubah dirinya sendiri. Kalau state sebuah StatefulWidget berubah, widget tersebut beserta child-nya akan di-rebuild, sedangkan data yang dibutuhkan banyak widget di bawah (misalnya Theme) bisa diteruskan lewat InheritedWidget.

> 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!

- `MaterialApp`: Mengatur konfigurasi utama aplikasi, seperti tema, judul, dan halaman awal.
- `MyHomePage`: Custom widget yang menampilkan halaman utama portofolio berisi informasi profil dan menu.
- `Scaffold`: Menyediakan struktur dasar halaman aplikasi untuk menampilkan konten.
- `SafeArea`: Memastikan konten tidak tertutup oleh notch atau area sistem pada perangkat.
- `SingleChildScrollView`: Memungkinkan halaman digulir secara vertikal ketika konten melebihi ukuran layar.
- `Column`: Menyusun widget secara vertikal dari atas ke bawah.
- `Row`: Menyusun widget secara horizontal dari kiri ke kanan.
- `Expanded`: Memperluas widget agar mengisi ruang kosong yang tersedia dalam `Row` atau `Column`.
- `Text`: Menampilkan teks seperti judul, nama, NPM, kelas, dan informasi menu.
- `InkWell`: Memberikan respons interaksi ketika pengguna menekan suatu widget.
- `CircleAvatar`: Menampilkan elemen berbentuk lingkaran untuk inisial profil dan ikon menu.
- `Icon`: Menampilkan ikon tertentu, seperti ikon logout, folder, dan tambah.
- `SizedBox`: Memberikan jarak antarwidget.
- `Container`: Mengatur ukuran, padding, warna, dan dekorasi suatu widget.
- `Wrap`: Menyusun widget secara berurutan dan memindahkannya ke baris berikutnya jika ruang tidak mencukupi.
- `GridView.count`: Menampilkan kumpulan item dalam bentuk grid dengan jumlah kolom yang ditentukan.
- `Material`: Menyediakan permukaan visual untuk kartu menu, termasuk warna dan sudut melengkung.
- `Spacer`: Memberikan ruang kosong fleksibel di antara widget dalam `Row` atau `Column`.
- `SnackBar`: Menampilkan pesan singkat sementara sebagai respons terhadap interaksi pengguna.
- `InfoCard`: Custom widget yang menampilkan informasi profil seperti NPM, nama, dan kelas.
- `ItemCard`: Custom widget yang menampilkan item menu dalam bentuk kartu interaktif.

> 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!

`MaterialApp` berfungsi membungkus tampilan aplikasi Flutter dan menyediakan dasar Material Design seperti komponen `Scaffold`, navigasi, tema, dan lainnya. Widget ini umumnya dijadikan root agar fiturnya bisa digunakan secara konsisten di seluruh aplikasi.

> 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?

`StatelessWidget` adalah widget yang tidak punya state, jadi tampilannya tidak bisa berubah sendiri dan hanya berubah jika parent-nya memberi data baru. `StatefulWidget` sebaliknya, punya class State pendamping yang menyimpan kondisi widget saat ini, sehingga tampilannya bisa berubah dinamis dan akan di-rebuild setiap state-nya berubah. Pilih StatelessWidget jika tampilannya cuma bergantung pada data dari parent dan tidak perlu berubah sendiri, misalnya `Text` atau `MyApp`. Pakai `StatefulWidget` jika widget perlu merespons perubahan internal, contohnya input pengguna saat ini.

> 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?

BuildContext adalah objek yang menunjukkan posisi sebuah widget di dalam widget tree, dan penting karena lewat context ini widget bisa mengakses data dari widget di atasnya, misalnya tema lewat `Theme.of(context)`. Di dalam metode build, context diterima sebagai parameter (`Widget build(BuildContext context)`), lalu dipakai untuk mengambil data yang diteruskan lewat `InheritedWidget` tanpa harus dikirim manual dari parent.

> 6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?

Hot reload adalah fitur Flutter yang menerapkan perubahan kode ke dalam VM dan membangun ulang widget tree tanpa menghilangkan state aplikasi, serta tidak menjalankan ulang main() maupun initState(). Sementara itu, hot restart memulai ulang aplikasi sehingga state sebelumnya akan hilang. Hot restart diperlukan ketika perubahan kode tidak dapat diterapkan hanya dengan hot reload, misalnya perubahan pada inisialisasi aplikasi yang perlu menjalankan ulang main() atau initState(). Full restart diperlukan ketika perubahan juga melibatkan kode native seperti Java, Kotlin, Objective-C, atau Swift, karena proses ini membutuhkan kompilasi ulang.

---

# AI Disclosure

Claude digunakan sebagai alat bantu untuk memahami konsep Flutter dan membantu proses pengembangan. Saran Claude ditinjau kembali dan disesuaikan dengan kebutuhan proyek.

Tools AI yang digunakan: Claude

Log penggunaan AI:
<br>https://claude.ai/share/5e5be8c2-3b3c-431c-ae62-f9ede7904555

## Peran AI

Claude membantu beberapa hal berikut:

* Menjelaskan penggunaan warna hex dan `ColorScheme` di Flutter.
* Membantu memahami pengaturan font dan `TextTheme`.
* Membantu debugging masalah instalasi `google_fonts` dan ketidakcocokan tipe `TextTheme`.
* Membantu membuat kerangka dan sebagian isi `README.md`.

## Keterbatasan AI

Claude dapat memberikan saran yang kurang sesuai dengan konteks proyek atau versi Flutter dan package yang digunakan. Karena itu, hasilnya perlu diperiksa dan mungkin perlu disesuaikan sebelum diterapkan.

## Manual Improvements

Saran Claude disesuaikan secara manual dengan versi package yang terpasang dan desain aplikasi. Warna, tema, serta tipografi dipilih dan dirapikan agar sesuai dengan tampilan portofolio yang diinginkan.

---

## License

This project is developed for educational purposes as part of the Pemrograman Berbasis Platform course.
