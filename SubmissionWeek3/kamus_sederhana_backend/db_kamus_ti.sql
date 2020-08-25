-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 25 Agu 2020 pada 22.07
-- Versi server: 10.4.13-MariaDB
-- Versi PHP: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+07:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_kamus_ti`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `kata`
--

CREATE TABLE `kata` (
  `id_kata` int(11) NOT NULL,
  `kata` text NOT NULL,
  `penjelasan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kata`
--

INSERT INTO `kata` (`id_kata`, `kata`, `penjelasan`) VALUES
(1, 'Application', 'Software yang dibuat oleh suatu perusahaan komputer untuk mengerjakan tugas-tugas tertentu, misalnya Ms Word.'),
(2, 'Class', 'Bagian / Golongan, merupakan suatu blueprint atau cetakan untuk menciptakan suatu instant dari object. Class juga merupakan grup suatu object dengan kemiripan attributes/properties, behaviour dan relasi ke object lain.'),
(3, 'Coding', 'Sebuah metode pengkodean data yang digunakan dalam komunikasi'),
(4, 'Content', 'Isi, artikel, tulisan dari website'),
(5, 'Create', 'Membuat'),
(6, 'Database', 'Sekumpulan data yang disusun dalam bentuk (beberapa) tabel, baik yang saling berkaitan maupun berdiri sendiri.'),
(7, 'DFD (Data Flow Diagram)', 'Suatu model logika data atau proses yang dibuat untuk menggambarkan dari mana asal data dan kemana tujuan data yang keluar dari sistem, dimana data disimpan, proses apa yang menghasilkan data tersebut dan interaksi antara data yang tersimpan dan proses yang digunakan pada data tersebut.'),
(8, 'DBMS (Database Management System)', 'Sebuah perangkat lunak yang bertujuan untuk mengatur dan mengorganisasi system database'),
(9, 'Delete', 'Hapus'),
(10, 'Download', 'Disebut unduh, proses transmisi sebuah file dari sebuah sistem computer ke sistem komputer yang lainnya. Dari internet, user yang melakukan proses download adalah proses dimana seorang user meminta / request sebuah file dari sebuah komputer lain (web site, server atau yang lainnya) dan menerimanya.'),
(11, 'Drivers', 'Teknologi informasi dalam bahasa Inggris yang mengacu kepada komponen perangkat lunak yang mengizinkan sebuah sistem komputer untuk berkomunikasi dengan sebuah perangkat keras.'),
(12, 'Error', 'Kesalahan pada perintah yang kita berikan yang mengakibatkan sistem menampilkan sebuah pesan kesalahan dan meminta kita untuk mengulangi dengan perintah yang benar.'),
(13, 'Feedback', 'Isyarat atau tanggapan yang berisi kesan dari penerima pesan dalam bentuk verbal maupun nonverbal. Tanpa balikan seorang pengirim pesan tidak akan tahu dampak pesannya terhadap sipenerima pesan Hal ini penting bagi manajer atau pengirim pesan untuk mengetahui apakah pesan sudah diterima dengan pemahaman yang benar dan tepat.'),
(14, 'Field', 'Merupakan nama lain dari kolom pada suatu tabel.'),
(15, 'Foregin Key', 'Field yang menjadi penghubung atau relasi dari kedua tabel.'),
(16, 'Framework', 'Kumpulan dari fungsi-fungsi/prosedur-prosedur dan class-class untuk tujuan tertentu yang sudah siap digunakan.'),
(17, 'Hardware', 'Perangkat keras.'),
(18, 'Home Page', 'Halaman utama.'),
(19, 'Hyperlink', 'Cara untuk menghubungkan suatu bagian dalam slide, file, program, atau halaman web dengan bagian lainnya dalam bidang-bidang tersebut.'),
(20, 'Input', 'Alat yang digunakan untuk menerima masukkan data dan program yang akan diproses di dalam computer.'),
(21, 'JSON (JavaScript Object Notation)', 'Suatu format ringkas pertukaran data komputer. Formatnya berbasis teks dan terbaca-manusia serta digunakan untuk merepresentasikan struktur data sederhana dan larik asosiatif (disebut objek)'),
(22, 'Null', 'Null?disini bukan nol (angka nol) dan juga bukan space (untuk jenis data alpha, alphanumeric, dan string).'),
(23, 'Object', 'Obyek, instance dari class.'),
(24, 'Online', 'Keadaan computer yang terkoneksi / terhubung ke jaringan internet.'),
(25, 'Open Source', 'Software yang membebaskan source codenya untuk dilihat orang lain dan membiarkan orang lain mengetahui cara kerja software tersebut. Orang lain juga bisa memperbaiki kelemahan yang ada pada software tersebut.'),
(26, 'Output', 'Sebagai peralatan yang berfungsi untuk mengeluarkan hasil pemrosesan ataupun pengolahan data yang berasal dari CPU kedalam suatu media yang dapat dibaca oleh manusia ataupun dapat digunakan untuk penyimpanan data hasil proses.'),
(27, 'Password', 'Kata sandi yang bersifat rahasia yang digunakan pada saat login untuk memverifikasi sah tidaknya seorang user dalam menggunakan suatu sistem.'),
(28, 'Plug-In', 'Aplikasi berukuran kecil yang ditanam ke dalam aplikasi lain yang lebih besar, tujuannya untuk meningkatkan fungsionalitas aplikasi induknya.'),
(29, 'Primary Key', 'Field yang bersifat unique.'),
(30, 'Read', 'Membaca.'),
(31, 'Real Time', 'Kondisi pengoperasian dari suatu sistem perangkat keras dan perangkat lunak yang dibatasi oleh rentang waktu dan memiliki tenggat waktu (deadline) yang jelas, relatif terhadap waktu suatu peristiwa atau operasi terjadi.'),
(32, 'Record', 'Kumpulan dari elemen-elemen data yang terkait dalam sebuah basis data.'),
(33, 'Relasional', 'Sebuah program komputer (atau secara lebih tipikal adalah seperangkat program komputer) yang dirancang untuk mengatur/memanajemen sebuah basis data sebagai sekumpulan data yang disimpan secara terstruktur, dan melakukan operasi-operasi atas data atas permintaan penggunanya.'),
(34, 'Script', 'Bahasa pemrograman yang menyediakan fasilitas penerjemahan serta kompilasi kode dalam satu rangkaian proses secara integratif sehingga memungkinkan kode dibuat dapat langsung dijalankan sebagai program secara dinamis.'),
(35, 'Software', 'Perangkat lunak'),
(36, 'SQL (Structure Query Language)', 'Bahasa yang digunakan untuk melakukan suatu perintah query pada perangkat lunak RDBMS. Lihat juga query dan RDBMS.'),
(37, 'State Chart Diagram', 'Menggambarkan transisi dan perubahan keadaan (dari satu state ke state lainnya) suatu obyek pada sistem sebagai akibat dari stimulans yang diterima.'),
(38, 'System', 'Kesatuan bagian-bagian yang saling berhubungan yang berada dalam suatu wilayah serta memiliki item-item penggerak.'),
(39, 'Tbook', 'Nama aplikasi media social di Politeknik TEDC Bandung.'),
(40, 'Trend', 'Digunakan untuk mengungkapkan keadaan dimana suatu hal sedang digemari atau sedang menjadi perhatian kebanyakan orang.'),
(41, 'Update', 'Perbaharui'),
(42, 'Upload', 'Proses transmisi sebuah file dari sebuah sistem komputer ke sistem komputer yang lainnya dengan arah yang berkebalikan dengan download. Dari internet, user yang melakukan proses upload adalah proses dimana user mengirimkan file ke komputer lain yang memintanya.'),
(43, 'User', 'Merupakan pengguna.'),
(44, 'Username', 'Merupakan serangkaian huruf yang merupakan tanda pengenal untuk masuk dan mengakses.'),
(45, 'XML (eXtensibel Markup Language)', 'Suatu bahasa markup yang digunakan untuk membawa dan menyimpan data'),
(46, 'Website', 'Halaman yang ditampilkan di internet yang memuat informasi tertentu (khusus).');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `kata`
--
ALTER TABLE `kata`
  ADD PRIMARY KEY (`id_kata`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `kata`
--
ALTER TABLE `kata`
  MODIFY `id_kata` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
