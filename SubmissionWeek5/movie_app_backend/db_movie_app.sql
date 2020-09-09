-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 09 Sep 2020 pada 22.01
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
-- Database: `db_movie_app`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `favorite`
--

CREATE TABLE `favorite` (
  `id_favorite` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_video` int(11) NOT NULL,
  `tgl_favorite` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `nama` varchar(50) NOT NULL,
  `nohp` varchar(15) NOT NULL,
  `alamat` text NOT NULL,
  `tgl_daftar` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `email`, `password`, `nama`, `nohp`, `alamat`, `tgl_daftar`) VALUES
(4, 'fauzy@gmail.com', '6172de70289f996b192e1b2f5a932ace', 'Fauzy Wahyudi', '+6282288229856', 'Solok', '2020-09-01 10:55:06'),
(5, 'fauzywahyudi@gmail.com', '6172de70289f996b192e1b2f5a932ace', 'Fauzy Wahyudi', '082288229856', 'Solok', '2020-09-09 12:47:20'),
(6, 'zyzy@gmail.com', 'd47f3c0b34a86bf7330016830a497438', 'Fauzy Wahyudi', '082288229856', 'Solok', '2020-09-10 02:58:18');

-- --------------------------------------------------------

--
-- Struktur dari tabel `video`
--

CREATE TABLE `video` (
  `id_video` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `link` text NOT NULL,
  `durasi` varchar(10) NOT NULL,
  `thumbnail` text NOT NULL,
  `deskripsi` text NOT NULL,
  `jumlah_tonton` int(11) NOT NULL,
  `jumlah_like` int(11) NOT NULL,
  `jumlah_dislike` int(11) NOT NULL,
  `tgl_upload` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `video`
--

INSERT INTO `video` (`id_video`, `title`, `link`, `durasi`, `thumbnail`, `deskripsi`, `jumlah_tonton`, `jumlah_like`, `jumlah_dislike`, `tgl_upload`) VALUES
(1, 'Bukan Salah Cinta - FILM PENDEK (romantic love story)', 'wMF3_YLRDMg', '15:22', '1.jpg', 'Pranala Pictures mempersembahkan sebuah film pendek drama romantis karya Alief Amalfi.\r\n\r\nBercerita tentang kisah cinta anak SMA yang rumit dan labil. Cinta itu bebas, dia bisa datang kapan saja dan dimana saja. Cinta juga berhak memilih siapapun yang dia mau, tapi tetap, jangan salahin cinta.\r\n\r\nCast : \r\nFaradhea Salsabila\r\nRaflian Yasraf\r\nFirriz Alchoiri\r\nSultan Fatih\r\nDiska Ayu Fahira\r\n\r\nCrew : \r\nWritten & Directed by : Alief Amalfi\r\nCamera operator : Hilmi Sufyaan\r\nAssistant camera : Andiko Abimanyu\r\nEditor : Kokong\r\nscript continuity : M. Ridho\r\nSound designer : Febby El\r\nArt director : M. Subchan\r\nSet dresser : Rifki Pahala\r\nGaffer : Naufal Aqila\r\nBestboy : Rajendra Ihza\r\nBehind the scene : Wimawan\r\n\r\nSupported by : \r\nSMAN 8 BEKASI\r\nBSM RENTAL\r\nZENON RENTAL\r\nDIBALIK KOPI\r\n\r\nHappy Watching!! :)', 2594847, 56000, 1000, '2019-08-09 18:28:24'),
(2, 'Film Pendek - Singsot (2016)', 'gZp2x5k_9YI', '14:09', '2.jpg', 'Ravacana Films mempersembahkan sebuah karya film pendek berjudul SINGSOT.\r\n\r\n\r\nSeorang anak kecil yang menginap di rumah Kakek dan Neneknya mengalami kejadian-kejadian menyeramkan setelah mendengar cerita mitos yang diceritakan oleh neneknya. Namun dibalik kejadian-kejadian tersebut ternyata ada sesuatu lain yang tidak disadari. Dari semua kejadian yang terjadi, akhirnya membuat si anak tidak ingin bersiul lagi.\r\n\r\n\r\n\r\nWinner Fiagra Horor Film Festival 2016 - Film Terbaik\r\nWinner Taman Film Festival 2017 - Film Horor Terbaik\r\nOfficial Selection Jogja-Netpac Asian Film Festival 2016 \r\n\r\n============================\r\n\r\nCast :\r\nNaufal Rafa Adyaksa\r\nAnton Suprapto\r\nIndarwati\r\nBudi Arifianto\r\n\r\n\r\nCrew :\r\nDirector : Wahyu Agung Prasetyo \r\nWriter : Wahyu Titis Swirani\r\nProduser : Elena Rosmeisara\r\nD.O.P : Egha Harismina\r\nArt Director : Iqbal Ariefurrachman\r\nSound Designer : Aditya Trisnawan\r\nMusic Director : Pandu Maulana \r\nEditor : Helmi Nur Rasyid\r\n\r\n========================================\r\n\r\nRavacana Films (c) 2016\r\nwww.ravacanafilms.com\r\nwww.instagram.com/ravacanafilms\r\nwww.twitter.com/ravacanafilms\r\nravacanafilms[dot]id[at]gmail[dot]com\r\n\r\n========================================', 849890, 26000, 251, '2019-09-09 18:34:39'),
(3, 'Katakan Cinta - FILM PENDEK (romantic love story)', 'XCnSzG3IxgU', '12:52', '3.jpg', 'Based & Inspired by \r\nJadi Kekasihku Saja - Keisya Levronka\r\nhttps://www.youtube.com/watch?v=zt4Ne...\r\n\r\nPranala Pictures mempersembahkan sebuah kisah drama remaja, bercerita tentang sepasang sahabat yang saling jatuh cinta dalam diam.\r\nsaling menunggu siapa yang kira-kira akan menyatakannya duluan, sampai akhirnya ada suatu kejadian yang membuat mereka harus mengungkapkan perasaannya masing masing.\r\n\r\nCast\r\nNurul Qodariatul Aulia\r\nFakhri Taqiuddin\r\nEga Sedellavia\r\nAlfira Putri Marlyta\r\nPutri Larasati\r\nRizky Rahayudi\r\nFaizal Fitriah Ali\r\n\r\nCrew\r\nPenulis & Sutradara : Alief Amalfi\r\nProduser : Ajeng Ratih, Devia Liyanti\r\nEksekutif Produser : Alief Amalfi, Ajeng Ratih\r\nAstrada : Utha Chandra\r\nD.o.P : Rizky Alatas\r\nEditor : Dzikri Aulia\r\nAscam : Abi Sarwan\r\nGaffer : Reza Prasojo\r\nClapper : Rimba Salam\r\nArtistik : Nakisha Alfada, Setya M.r\r\nSound post : Furqon Syiva\r\nBts : Andiko, Hilmi, Subchan\r\n\r\nTim Creative:\r\nMuhammad Rayhan Taswin\r\nCharisiotto Van Handriyanto\r\nUta Gobret\r\n\r\nFor business inquiries :\r\npranalapictures@gmail.com\r\nOr Visit our Instagram : pranalapictures', 824, 156, 3, '2020-09-09 18:38:26'),
(4, 'ANNIVERSARY - SHORT MOVIE (sad love story)', '71iaeCC3C4M', '12:23', '4.jpg', 'PRANALA PICTURES mempersembahkan sebuah film pendek yang diperankan dan disutradarai oleh ALIEF AMALFI.\r\n\r\nMenceritakan tentang sepasang kekasih yang ingin merayakan hari jadi mereka yang ke 1 tahun, tapi seketika ada yang berubah dari sifat si perempuan, hmm ada apa ya?\r\n\r\nCast\r\nAlief amalfi\r\nDiandra zalfa\r\nDirham abdullah\r\nIlham akbar\r\nFarahdiba\r\n\r\nCrew\r\nCameraman : Hilmi sufyaan\r\nSound director : M.Ridho\r\nBoomer : Febby el\r\nEditor : Andiko A\r\nStory & directed by : Alief amalfi\r\n\r\nHAPPY WATCHING :)', 33374, 1300, 29, '2019-11-10 18:42:52'),
(5, 'Film Pendek - TILIK (2018)', 'GAyvgz8_zV8', '32:34', '5.jpg', 'Ravacana Films bekerjasama dengan Dinas Kebudayaan DIY mempersembahkan sebuah film pendek berjudul Tilik. \r\n\r\nSynopsis :\r\nDian adalah seorang kembang desa. Banyak lelaki yang mendekatinya hingga datang melamarnya. Warga desa bergunjing tentang status lajang Dian. Dalam satu kesempatan perjalanan naik truk dalam rangka menjenguk (tilik) Bu Lurah di Rumah sakit di kota, beberapa warga berdebat tentang siapa yang bakal mempersunting Dian. Perjalanan “tilik” menjadi penuh gosip dan petualangan bagi para warga desa yang naik truk tersebut.\r\n\r\n\r\nWinner Piala Maya 2018 - Film Pendek Terpilih\r\nOfficial Selection Jogja-Netpac Asian Film Festival 2018\r\nOfficial Selection World Cinema Amsterdam 2019\r\n\r\n\r\n========================================\r\n\r\nCAST\r\nSiti Fauziah\r\nBrilliana Desy\r\nAngelina \"Punyk\"\r\nDyah Mulani\r\nLuly Syahkisrani \r\nHardiansyah Yoga Pratama\r\nTri Sudarsono\r\nGotrek\r\nRatna Indriastuti\r\nStephanus Wahyu Gumilar\r\n\r\n\r\nBACKGROUND ACTORS\r\nTutik, Krismiyati, Sukamti, Lastriyatun, Ambar, Mardiyah, Suniyati, Tuminah, Lestari, Tri, Tumijem, Wajiyem, Rondiyah, Martini, Titik, Nganti, Suryanti, Asti, Saerah, Wiwid, Darmi, Suharji, Poniran, Sukriyanto\r\n\r\nCREW\r\nExecutive Produser : Budi Wibowo, SH, MM.\r\nScript Writer : Bagus Sumartono\r\nProducer : Elena Rosmeisara\r\nUnit Manager : Addi Kurniawan\r\nProduction Assistant : Brilian Merbawani, Ikhwan Abu Zakaria\r\nLocation Unit : Mahardika Subangun, Satria Wijayanto, Aliya Kinasih\r\nRunner : Ahmed Nurcahyo, Karmujiyanto\r\nDirector : Wahyu Agung Prasetyo\r\n1st Asst. Director : Rizky Kurnia S.\r\n2nd Asst. Director : Riyadi Prabowo\r\nScript Continuity : Dhisga Amandatya, Witarti\r\nTalent Coordinator : Tiara Kristiningtyas\r\nAsst. Talent Coordinator : Aditya Putra N.\r\nD.O.P : Satria Kurnianto\r\nAsst. Cameraman  : Dimaz Amanta\r\nCamera Boy : Tito Ramadhan\r\nCamera Technician : Doddyk Triesna\r\nDigital Imaging Technician : Esza Prayojana Parapaga\r\nClap person : Moh. Ivan Haris Kurniawan\r\nGaffer : Andik Budi Prasetyo\r\nLightingman : Afandi Aziz, Edi Hidayat, Fahman Putra, Danang\r\nArt Director : Rifat Satya\r\nArt Departement : Ariesta Maulina, Rizal Rizky, Fahmi Sutan\r\nMake Up & Wardrobe : Felicia Desi\r\nAsst. Make Up & Wardrobe: Annisa Dewi, Wiji Astuti\r\nSound Recordist : Pandu Maulana\r\nBoom Operator : Prima Setiawan\r\nSound Designer : Aditya Trisnawan\r\nMusic Designer : Redy Afrians\r\nVolley Artist : Bayu Putro Pamungkas, \r\nPhilipus Agung Prasetyo\r\nColorist : Egha Harismina\r\nEditor : Indra Sukmana, Helmi Nur Rasyid\r\nBTS Team : Ayesha Alma Almera, Pramuditya Ranutanta, Aryo Yudantoko\r\nPoster Artwork : Bustanul Choir\r\nSubtitle : Vanis, \r\nLudy Oji Prastama\r\nTransportation : Tadtad, Liandri, Gufron, Abu, Hartono, Toni, Trevi\r\n\r\n========================================\r\n\r\nRavacana Films (c) 2020 \r\nwww.ravacanafilms.com\r\nwww.instagram.com/ravacanafilms\r\nwww.twitter.com/ravacanafilms\r\nravacanafilms[dot]id[at]gmail[dot]com\r\n\r\n========================================\r\n\r\nFilm Pendek - Tilik (2018)\r\n#tilik #butejo #filmpendek #nontontilik #filmpendekindonesia #ravacanafilms', 22685182, 841000, 14000, '2020-08-17 18:58:54'),
(6, 'Film Pendek - Geladiresik (2020)', 'TJrrxYwD9lU&t=3s', '7:36', '6.jpg', 'Ravacana Films bersama Dinas Kebudayaan DIY mempersembahkan sebuah respon audio visual atas COVID-19 berjudul Geladiresik. Film ini adalah bagian dari inisiasi #pentasdaringseni dari Dinas Kebudayaan DIY sebagai bentuk kepedulian terhadap sesama.\r\n\r\n\r\nSinopsis:\r\nSonso (36) dan Paung (40) adalah dua orang yang bekerja paruh waktu sebagai penyedia jasa syuting video. Namun, dikarenakan pandemi, pekerjaan mereka terhenti. Sonso dan Paung akhirnya mencari cara untuk memanfaatkan keadaan demi berlangsung hidup. Mereka berusaha untuk menawarkan jasa syuting kepada banyak perusahaan. \r\n\r\nHingga suatu waktu, sebuah rumah sakit menerima tawaran mereka dan meminta mereka untuk membuat sebuah video pilot pemakaman korban COVID-19. Video tersebut dimaksudkan sebagai syarat proyek mereka diterima oleh rumah sakit. Tak disangka, di tengah proses tersebut, mereka malah berseteru dan tak sengaja terekam oleh kamera. Rekaman tersebut secara masif menjadikan mereka viral dan membuka jalan baru bagi keberlangsungan hidup kedua orang tersebut yakni menjadi youtuber.\r\n\r\n\r\n=======================================\r\n\r\n\r\nCast\r\nBudi Arifianto\r\nBagus Sumartono\r\nYusacdika Klawu\r\nTiara Tita\r\n\r\nCrew\r\nProduser : Elena Rosmeisara\r\nSutradara & Penulis : Wahyu Agung Prasetyo\r\nPenata Gambar : Egha Harismina\r\nPenata Suara dan Musik : Pandu Maulana\r\nPenyunting Gambar : Tri Yono\r\n\r\n========================================\r\n\r\nRavacana Films (c) 2020 \r\nwww.ravacanafilms.com\r\nwww.instagram.com/ravacanafilms\r\nwww.twitter.com/ravacanafilms\r\nravacanafilms[dot]id[at]gmail[dot]com\r\n\r\n========================================\r\nFilm Pendek - Geladiresik (2020)\r\n#FilmPendek #Geladiresik #Covid19 #CoronaVirus', 481430, 14000, 238, '2020-07-31 19:03:19'),
(7, 'Film Pendek - Nilep (2015)', '_ULC6emqXzM&', '9:08', '7.jpg', 'Ravacana Films mempersembahkan sebuah karya film pendek berjudul NILEP.\r\n\r\n\r\nSekumpulan anak-anak berkumpul di Pos Kamling. Mereka berdebat tentang seorang anak yang mencuri mainan hingga mereka menyalahkan satu sama lain.\r\n\r\nWinner Moviestifal Kantor Pos Indonesia 2015 - Film Pendek Favorit\r\nWinner Accfest KPK 2015 - Film Fiksi Pendek Terbaik \r\nWinner Accfest KPK 2015 - Film Pilihan Juri\r\nWinner XXI Short Film Festival 2016 - Film Fiksi Pendek Terbaik Kategori Drama / Komedi Pilihan Juri Media\r\nWinner Banten Short Movie Festival 2016 - Film Pendek Terbaik\r\nWinner Jogja Film Academy Short Competition 2016 - Film Pilihan Juri / Special Mention \r\nWinner Festival Film Trenggalek 2016 - Juara 3\r\nNomination Festival Film Pendek Kompas TV 2016\r\n\r\n==============================\r\n\r\nCast :\r\nAfifah Nur Azizah\r\nRindho Perdana\r\nErlan Bayu Saputra\r\nBagus Sumartono\r\nAbdilah Irfandi\r\nRidho\r\n\r\n\r\nCrew :\r\nDirector : Wahyu Agung Prasetyo \r\nWriter : Wahyu Agung Prasetyo\r\nProduser : Elena Rosmeisara\r\nD.O.P : Egha Harismina\r\nArt Director : Rizky Mahardhika Subangun\r\nSound Designer : Prasida Yogi Iswara\r\nEditor : Egha Harismina\r\n\r\n========================================\r\n\r\nRavacana Films (c) 2015\r\nwww.ravacanafilms.com\r\nwww.instagram.com/ravacanafilms\r\nwww.twitter.com/ravacanafilms\r\nravacanafilms[dot]id[at]gmail[dot]com\r\n\r\n========================================', 972161, 27000, 312, '2019-09-09 19:06:50'),
(8, 'Film Pendek - Kodhok (2017)', 'BKEJCGu2rEw', '11:49', '8.jpg', 'Ravacana Films mempersembahkan sebuah karya film pendek berjudul KODHOK.\r\n\r\nDua orang pemuda mencari kodhok untuk mendapatkan nomer ajaib.\r\n\r\nWinner. Juara 2 Kategori Favorite Panties Pizza Short Movie Competition 2017\r\n\r\n==============================\r\nCast :\r\nAryudha Fasha\r\nZulian Ramadhan\r\nMarcelius Deo Priyatno\r\n\r\nCrew :\r\nDirector :  Wahyu Agung Prasetyo\r\nWriter : Wahyu Agung Prasetyo\r\nProduser : Elena Rosmeisara\r\nD.O.P : Egha M. Harismina\r\nArt Director : Triyono \r\nSound Designer : Moh. Ali Azca & Cahya Kalatidha\r\nEditor : Helmi Nur Rasyid\r\n\r\n========================================\r\n\r\nRavacana Films (c) 2017\r\nwww.ravacanafilms.com\r\nwww.instagram.com/ravacanafilms\r\nwww.twitter.com/ravacanafilms\r\nravacanafilms[dot]id[at]gmail[dot]com\r\n\r\n========================================', 197782, 5600, 84, '2019-09-08 19:06:50');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`id_favorite`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- Indeks untuk tabel `video`
--
ALTER TABLE `video`
  ADD PRIMARY KEY (`id_video`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `favorite`
--
ALTER TABLE `favorite`
  MODIFY `id_favorite` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `video`
--
ALTER TABLE `video`
  MODIFY `id_video` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
