-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 02 Sep 2020 pada 02.50
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
-- Database: `db_ecommerce`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` int(11) NOT NULL,
  `nama_kategori` varchar(50) NOT NULL,
  `icon_kategori` text NOT NULL,
  `keterangan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`, `icon_kategori`, `keterangan`) VALUES
(1, 'Handphone & Aksesoris', 'handphone.png', NULL),
(2, 'Komputer & Aksesoris', 'laptop.png', NULL),
(3, 'Perawatan & Kecantikan', 'perawatan.png', NULL),
(4, 'Makanan & Minuman', 'makanan.png', NULL),
(5, 'Kesehatan', 'kesehatan.jpg', NULL),
(6, 'Pakaian Pria', 'pakaian_pria.jpg', NULL),
(7, 'Pakaian Wanita', 'pakaian_wanita.png', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `produk`
--

CREATE TABLE `produk` (
  `id_produk` int(11) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `id_toko` int(11) NOT NULL,
  `nama_produk` text NOT NULL,
  `harga` int(11) NOT NULL,
  `ratting` double NOT NULL,
  `terjual` int(11) NOT NULL,
  `stok` int(11) NOT NULL,
  `deskripsi` text NOT NULL,
  `thumbnail` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `produk`
--

INSERT INTO `produk` (`id_produk`, `id_kategori`, `id_toko`, `nama_produk`, `harga`, `ratting`, `terjual`, `stok`, `deskripsi`, `thumbnail`) VALUES
(1, 4, 1, 'Paket Roti Krim 1 lusin', 60000, 4.9, 54, 63, 'Paket terdiri dari: \r\n\r\n12 Roti Krim (ALL VARIAN)\r\n\r\nHalo pelanggan setia Sari Roti,\r\nUntuk saat ini kami melayani pengiriman pulau JAWA + SUMATERA. \r\nDengan jaminan dikirim H+1 dari pembayaran diatas jam 4 sore (pembayaran setelah jam tersebut akan dikirim H+2, kami tidak melakukan pengiriman di hari Sabtu dan Minggu).\r\nKami juga jamin produk yang dikirim fresh dari pabrik, dengan expired 4 hari.\r\n\r\nYUK DIPESAN SARI ROTINYA!\r\nTerima kasih\r\n\r\n\r\n#roti #bread #free #gratis\r\n#paket #hadiah #sariroti', 'krim_1lusin.jpeg'),
(2, 4, 1, 'Paket Ngemil 1', 32000, 4.9, 5, 911, 'Paket terdiri atas:\r\n\r\n1 Roti Isi Cokelat\r\n1 Roti Isi Cokelat Keju\r\n1 Krim Cokelat\r\n1 Krim Moka\r\n1 Krim Cokelat Vanila\r\n1 Krim Keju\r\n\r\n\r\nHalo pelanggan setia Sari Roti,\r\n\r\nUntuk saat ini kami melayani pengiriman pulau JAWA + SUMATERA. \r\nDengan jaminan dikirim H+1 dari pembayaran diatas jam 4 sore (pembayaran setelah jam tersebut akan dikirim H+2, kami tidak melakukan pengiriman di hari Sabtu dan Minggu).\r\nKami juga jamin produk yang dikirim fresh dari pabrik, dengan expired 4 hari.\r\n\r\nYUK DIPESAN SARI ROTINYA!\r\nTerima kasih', 'ngemil1.jpeg'),
(3, 4, 1, 'Paket Sekolah 2', 36500, 4.9, 10, 915, '1 Roti Tawar Kupas, 1 Sandwich Coklat, 1 Sandwich Krim Keju, 1 Roti Isi Coklat Keju, 1 Roti Isi Coklat\r\n\r\nHalo pelanggan setia Sari Roti,\r\n\r\nUntuk saat ini kami melayani pengiriman pulau JAWA + SUMATERA. \r\nDengan jaminan dikirim H+1 dari pembayaran diatas jam 4 sore (pembayaran setelah jam tersebut akan dikirim H+2, kami tidak melakukan pengiriman di hari Sabtu dan Minggu).\r\nKami juga jamin produk yang dikirim fresh dari pabrik, dengan expired 4 hari.\r\n\r\nYUK DIPESAN SARI ROTINYA!\r\nTerima kasih', 'paket_sekolah2.jpeg'),
(4, 4, 1, 'Paket Sehat', 32500, 4.9, 25, 128, 'Sari Roti - Paket Sehat\r\n\r\nMerupakan paket yang terdiri dari :\r\n\r\n1 Roti Tawar Spesial\r\n1 Roti Sobek Coklat Keju\r\n1 Sandwich Coklat\r\n\r\n\r\nCocok untuk nutrisi sarapan setiap hari!\r\n\r\nHalo pelanggan setia Sari Roti,\r\nUntuk saat ini kami melayani pengiriman pulau JAWA + SUMATERA. \r\nDengan jaminan dikirim H+1 dari pembayaran diatas jam 4 sore (pembayaran setelah jam tersebut akan dikirim H+2, kami tidak melakukan pengiriman di hari Sabtu dan Minggu).\r\nKami juga jamin produk yang dikirim fresh dari pabrik, dengan expired 4 hari.\r\n\r\nYUK DIPESAN SARI ROTINYA!\r\nTerima kasih\r\n\r\nPengiriman hanya dapat melalui GoSend/GrabInstant\r\nHari libur tidak kirim paket', 'paket_sehat.jpeg'),
(5, 1, 2, 'Apple iPhone 7 Plus 128GB, Black', 6349000, 4.9, 30, 207, 'iPhone 7 Plus memiliki kamera ganda 12 MP dengan video 4K, penstabilan gambar optik, dan mode Potret.  Layar Retina HD 5,5 inci dengan rentang warna luas.(1)Touch ID. Chip A10 Fusion untuk performa tinggi dan kekuatan baterai yang tahan lama.(3) Tahan air dan debu.(2)\r\n\r\nFitur-fitur utama\r\n• Layar Retina HD LCD 5,5 inci(1)\r\n• Tahan air dan debu (1 meter hingga selama 30 menit, IP67)(2)\r\n• Sistem kamera ganda dengan kamera Wide dan Telefoto 12 MP; mode Potret, dan video 4K hingga 30 fps\r\n• Kamera FaceTime HD 7 MP dengan video 1080p\r\n• Touch ID untuk autentikasi aman\r\n• Chip A10 Fusion\r\n• iOS 13 dengan Mode Gelap, alat baru untuk pengeditan foto dan video, dan fitur privasi baru\r\n\r\nLegal\r\n1. Lebar layar diukur secara diagonal. \r\n2. iPhone 7 Plus tahan cipratan, air, dan debu, dan diuji dalam kondisi laboratorium terkontrol dengan level IP67 menurut standar IEC 60529 (kedalaman maksimum 1 meter hingga selama 30 menit). Ketahanan terhadap cipratan, air, dan debu tidak berlaku secara permanen, dan daya tahan mungkin berkurang akibat penggunaan sehari-hari. Jangan coba mengisi daya iPhone yang basah; lihat panduan pengguna untuk instruksi pembersihan dan pengeringan. Kerusakan akibat cairan tidak ditanggung dalam garansi. \r\n3. Kekuatan baterai bervariasi tergantung penggunaan dan konfigurasi. Lihat www.apple.com/batteries untuk informasi selengkapnya.', 'iphone_7plus.jpeg'),
(6, 1, 3, 'Samsung Galaxy A51', 4999000, 5, 35, 12, 'Spesifikasi : \r\n\r\nSpesifikasi Fisik\r\n\r\nDimension (HxWxD, mm)\r\n158.5 x 73.6 x 7.9\r\nDisplay\r\n\r\nSize : 164.0mm (6.5\" full rectangle)\r\nResolusi : 1080 x 2400 (FHD+)\r\nTeknologi : Super AMOLED\r\nPerformance\r\n\r\nProsesor : Exynos 9611\r\nCPU Speed : 2.3GHz, 1.7GHz\r\nCPU Type : Octa-Core\r\nMemori\r\n\r\nRAM Size : 6GB / 8GB\r\nROM Size : 128GB\r\nMicroSD (Up to 512GB)\r\nKamera\r\n\r\nRear Camera - Resolution (Multiple)\r\n48.0 MP + 12.0 MP + 5.0 MP + 5.0 MP\r\nFront Camera - Resolution\r\n32.0 MP\r\nRear Camera Zoom\r\nDigital Zoom up to 8x\r\nNumber of SIM\r\n\r\nDual-SIM\r\nSIM size\r\nNano-SIM (4FF)\r\nNFC : Yes\r\nUSB : USB Type-C\r\nSistem Operasi\r\n\r\nAndroid 10\r\nBaterai\r\n\r\n4000 mAh\r\nSensors\r\n\r\nAccelerometer, Fingerprint Sensor, Gyro Sensor, Geomagnetic Sensor, Hall Sensor, Light Sensor, Virtual Proximity Sensing\r\nKelengkapan Paket :\r\n\r\n1 x Samsung Galaxy A51 [6GB/128GB]', 'samsung_a51.jpeg'),
(7, 2, 4, 'Toshiba Wireless Optical Mouse W55 PUTIH', 103000, 4.9, 15, 180, 'Cantumkan warna yg tersedia di catatn.\r\ntersedia warna:\r\n- GREY\r\n- BLUE\r\n\r\nOptical Sensor: Blue LED Optical Sensor\r\nTipe Koneksi: Wireless\r\nTeknnologi Wireless: Advanced 2.4GHz\r\nRange: 10m\r\nResolusi: 1200dpi (default), adjustable ke 800, 1200, 1600dpi\r\nPower: 1 x Baterai AA\r\nOS Support: Win 7/8/10, Mac OS X 10.8 or later\r\nGaransi Resmi 1 Tahun', 'mouse.jpeg'),
(8, 2, 5, 'Dell Inspiron 3476 [Ci3-7020U-4-1T-AMD-W10-BLK] DELL OFFICIAL', 6749000, 4.8, 25, 22, 'DELL Inspiron 14-3476 14\" HD merupakan notebook persembahan Dell yang memiliki beragam performa handal yang lebih optimal dengan harga yang terjangkau. Notebook ini menggabungkan performa perangkat keras yang sangat cepat dengan desain yang ergonomis dan juga stylish. Dibekali dengan prosesor Intel Core i3-7020U, yang mengerjakan semua perintah komputasi. Ditambah dengan kartu grafis AMD Radeon 520 2GB, memberikan visual yang lebih baik saat Anda menggunakan notebook Anda untuk bekerja maupun untuk bermain game.\r\n\r\nTech Specs :\r\n•	14.0” HD (1366 x 768) Truelife LED-Backlit Display\r\n•	Intel Core i3-7020U Processor (3M Cache, 2.30 GHz)\r\n•	4 GB DDR4L, 2133 MHz\r\n•	1 TB HDD SATA, 5400 RPM\r\n•	AMD Radeon R5 M520, 2GB GDDR5\r\n•	Windows 10 Home Single Language (English) 64bit\r\n•	Try Load DVD /- RW\r\n•	Dell Wireless 1707 Card 802.11bgn + Bluetooth v4.0\r\n•	HD (720p) capable webcam, microphone\r\n•	Full size, spill-resistant keyboard\r\n•	Multi-touch gesture-enabled pad with integrated scrolling\r\n•	I/O Port : HDMI 1.4a, 1x USB 3.0, 2x USB 2.0, Media Card (SD, SDHC, SDXC)\r\n•	W40 WHr, 4-Cell Battery (removable) dengan 65 att AC Adapter\r\n•	Dimensi : 345 mm x 243 mm x 24 mm\r\n•	Berat : 1.77 Kg (3.90 lbs)\r\n•	Garansi Resmi 1 tahun Dell Indonesia\r\n•	Garansi Resmi DELL INDONESIA layanan purna jualnya pun sangat professional.\r\n•	1 tahun Dell Prosupport Onsite Service memberikan jaminan kenyamanan pengguna dalam melakukan klaim garansi.\r\n•	Hanya cukup menelpon ke Dell Technical Support 1500 858, teknisi Dell Indonesia yang akan datang ketempat anda.\r\n•	Harap Menghubungi kami / Chat sebelum order untuk konfirmasi stock\r\n\r\nHappy Shopping', 'laptop_dell.jpeg'),
(9, 3, 7, 'Scarlett Whitening Body Lotion / Scarlet body scrub lulur Serum Shampoo Conditioner', 52000, 4.9, 50, 225, 'READY STOCK\r\n\r\nGOSEND DAN GRAB open\r\n\r\n100% ORIGINAL DAN SUDAH BPOM, AMAN UTK BUSUI BUMIL\r\n\r\nORIGINAL EMBOSS TULISAN SCARLETT PADA KEMASAN DAN ADA HOLO ORIGINAL\r\n\r\nFREE GIFT \r\nSETIAP PEMBELIAN 3 BOTOL FREE SPONS (TIDAK BERLAKU KELIPATAN) \r\nSETIAP PEMBELIAN 48 BOTOL FREE 1SET SERUM KIJOONGGI (TIDAK BERLAKU KELIPATAN) \r\n\r\nFREE BERLAKU SELAMA PERSEDIAAN MASIH ADA\r\n\r\n\r\nWhitening bodylotion\r\nTersedia Varian\r\n- fantasia \r\n- romansa BEST SELLER\r\n-charming (new)\r\n\r\nWhitening body scrub\r\n- pomegrante BEST SELLER\r\n- mango\r\n- cucumber \r\n\r\nFacial wash \r\n- Normal\r\n\r\n\r\nShampoo\r\nConditioner \r\n\r\nMohon tulis jenis vrian yang diinginkan\r\n\r\nDibuat khusus untuk kamu yang ingin mencerahkan kulit tubuh, mengandung Glutathione (vitamin pencerah kulit paling cepat di dunia) dan butiran Vitamin E. Juga terdapat butiran scrub yang mampu mengangkat sel kulit mati dan kotoran yang menumpuk di kulit tubuhmu.\r\n\r\nSYARAT DAN KETENTUAN BELANJA DI SINI : \r\n\r\n1. BELI ONLINE ADA RESIKO RUSAK DI JALAN. JIKA ANDA TIDAK SIAP, TOLONG JANGAN BELI DITOKO SAYA. TAPI JIKA ANDA BELI DI TOKO SAYA. SAYA UCAPKAN TERIMA KASIH.. \r\n\r\n2. KAMI MENYEDIAKAN PACKING TAMBAHAN/BUBBLE & KARTON BOX UNTUK MENGURANGI RESIKO KERUSAKAN DI JALAN, DAPAT DI BELI DI ETALASE. TAPI JIKA TERJADI KERUSAKAN JUGA, TETAP MERUPAKAN RESIKO DI JALAN.\r\n\r\n3. MEMBELI BERARTI SETUJU DENGAN SYARAT DIATAS. KAMI TIDAK BISA MEMAKSA ANDA MEMBELI DISINI.. TAPI JIKA ANDA SETUJU KAMI UCAPKAN TRIMA KASIH\r\n\r\n4. SEMUA BARANG DIKIRIM KONDISI BAIK.. SUDAH ATTACHED/ SUDAH BELI = DIASUMSIKAN MENYETUJUI KETENTUAN YG TERTERA PADA DESKRIPSI PRODUK', 'scarlet.jpeg'),
(10, 3, 8, 'KRIM CREAM LC BEAUTY LCBEAUTY KF SKIN KFSKIN CARE ORIGINAL', 234000, 4.8, 20, 210, 'SILAHKAN KLIK TAWAR HARGA APABILA HARGA YG DITAWAR BISA KITA SEPAKATI AKAN KITA ACC PENAWARAN PEMBELI.\r\n\r\nLC beauty membantu mengatasi masalah kulit wajah seperti jerawat, bekas jerawat, dan bisa membuat kulit menjadi glowing\r\n\r\n* LC BEAUTY PAKET TONER  + TAS\r\n    Terdiri : Night cream , Day Cream , Toner , Facial wash & Tas Cantik\r\n*LC BEAUTY TERBARU ADA YANG TANPA KODE\r\n\r\nUntuk Pembelian eceran,silahkan klik BELI lalu pilih variasi :\r\n\r\n* Ecer Night Cream L C BEAUTY\r\n* Ecer Day Cream L C BEAUTY\r\n* Ecer Toner L C BEAUTY\r\n* Ecer Cleanser L C BEAUTY\r\n* Serum Acne\r\n* Berry white drink  KF SKIN...PIRT513351573070746-23\r\n* Perfect Wet Powder.............BPOM NA 18180103091\r\n* Glowing Gold Gell................BPOM NA 18181900725\r\n* Bringhtening EE Cream........BPOM NA 18180917071\r\n* Serum Silky..........................BPOM NA18180103091\r\n* Serum Derma.....................BPOM NA 18161900342\r\n\r\nMengatasi Kulit bermasalah : jerawat,flex ,komedo kulit berminyak dan kusam.\r\nPaket toner Proses dengan pengelupasan\r\nPaket Cleaser proses tidak pengelupasan\r\n\r\nManfaat L C BEAUTY :\r\n1. Membuat kulit putih dan licin\r\n2. Meremajakan kulit\r\n3. Mengikis kulit mati bekas jerawat / jerawat batu\r\n4. Menghilangkan flex hitam pada wajah\r\n5. Mengecilkan dan meratakan pori pori\r\n6. Mengangkat sel kulit mati\r\n7. Mengencangkan kulit\r\n8. Menghilangkan dan mencegah jerawat\r\n9. Kulit bersih bersinar merona dan halus\r\n\r\nKOMPOSISI :\r\nArbutin - Memitihkan kulit dari dalam\r\nKolid Acid - bermanfaat memerangi bakteri penyebab jerawat dan mengangkat sel kulit mati yang menyembabkan sel kulit tersumbat.\r\nAHA - berguna untuk mengangkat sel kulit mati \r\nVITAMIN E - memberikan nutrisi pada kulit dan menjaga kehalusanya\r\n\r\n\r\n\r\n\r\nNB : Hasil tiap orang berbeda beda, tergantung jenis kulit, kegiatan sehari-hari, factor genetika, dll. ', 'cream.jpeg'),
(11, 5, 6, 'BYOOTE COLLAGEN by Paopao - 1 Box', 350000, 4.9, 17, 56, 'BYOOTE COLLAGEN GLUTATHIONE  1 BOX (16 Sachet) BPOM HALAL\r\n\r\nSudah rajin perawatan kulit tapi kulit tetap saja kusam dan makin kelihatan tua? Jangan sedih terlebih dahulu. Hal tersebut sebenarnya juga dialami oleh banyak orang.\r\n\r\nPerlu anda ketahui, untuk bisa menjaga kesehatan kulit wajah itu bukan hanya dengan rutin perawatan saja. Selain itu, anda juga wajib merubah pola hidup anda dengan yang sehat.\r\nTak lupa juga, anda harus rutin berolahraga. Untuk mempercepat prosesnya, anda juga perlu meminum suplemen yang punya banyak kandungan yang bermanfaat untuk kulit seperti kandungan kolagen.\r\n\r\nSalah satu suplemen yang bisa dikatakan sangat baik untuk membantu menjaga kesehatan kulit adalah suplemen Byoote.\r\n\r\nKenapa harus Byoote? Berikut ini adalah beberapa alasan kenapa Byoote lebih baik dari suplemen kolagen lain:\r\n• Kandungan kolagen sudah ditakar sesuai dengan kebutuhan tubuh mayoritas orang.\r\n• Kandungan kolagen yang digunakan di dalam suplemen ini juga terbukti sangat cepat diserap di dalam tubuh.\r\n• Dibuat sepenuhnya dari bahan-bahan alami tanpa menggunakan bahan kimia.\r\n• Suplemen kolagen yang sudah mendapatkan ijin resmi dari BPOM.\r\n• Juga sudah mendapatkan sertifikasi Halal dari MUI.\r\n• Dibuat dalam bentuk sachet sehingga sangat praktis untuk dibawa kemanapun anda pergi.\r\n\r\nCara Konsumsi Byoote Kolagen :\r\n1 sachet suplemen Byoote dicampurkan dengan 150 ml air dingin. Sangat cocok diminum sebelum makan. Suplemen ini bisa dikonsumsi 1 sampai 2 kali setiap hari.', 'BYOOTE COLLAGEN.jpeg'),
(12, 6, 9, 'Kaos Danilo lengan Panjang', 99000, 4.9, 78, 211, 'Kaos Lengan Panjang Pria Keren', 'danilo.jpeg'),
(13, 6, 9, 'Kaos Polos New States Apparel NSA - Softstyle 3600 Setara Cotton Combed 30\'s', 40000, 4.8, 29, 302, 'Kaos Polos New States Apparel NSA - Softstyle 3600 Setara Cotton Combed 30\'s, merupakan Produk dari New States Apparel dengan kualitas bahan yang sangat bagus. Model leher O-neck, lebar rib leher 2cm, dan juga body fit. Kaos ini sangat cocok untuk kegiatan sehari-hari, dapat dipakai ngampus ataupun pergi. Berbahan dasar 100% Cotton Ring Spun Preshrunk Jersey Knit setara Combed 30\'s sangat adem dan nyaman dipakai. Dapat digunakan untuk sablon manual maupun digital\r\n\r\nTidak Banyak Bulu\r\nBahan Halus dan Lembut\r\nBisa Untuk Sablon Digital\r\nO-Neck\r\nBody Fit\r\nJahitan Rantai\r\nBahan Lemas, Lembut Dan Adem\r\n100% Cotton Ring Spun Preshrunk Jersey Knit\r\nSize Asian Fit S-XXL\r\nTear Away Label (Label Dapat Disobek Dengan Mudah)\r\n\r\nS = 47 x 66cm\r\nM = 50 x 69cm\r\nL = 53 x 72cm\r\nXL = 56 x 74cm\r\nXXL = 59 x 76cm\r\n\r\nMohon dibaca agar mempermudah dan mempercepat proses pesanan :\r\n\r\n- Untuk size S/M/L/XL dapat langsung ditulis dikolom pesan pada saat melakukan checkout\r\n- Untuk warna GOLD, MILITARY GREEN & CHESNUT harap memilih warna apapun SELAIN PUTIH & menambahkan di kolom keterangan untuk warna dan size yang diinginkan.\r\n- Toleransi ukuran 1-3cm\r\n- Untuk mempermudah proses pesanan, silahkan cek ketersediaan ukuran dibawah ini\r\n\r\nUpdate Stok Agustus 2020\r\n1. Hitam : S, M, L, XL, XXL\r\n2. Charcoal : S, M, L, XL, XXL\r\n3. Misty : S, M, L, XL, XXL\r\n4. Putih : S, L, XL, XXL\r\n5. Light Pink : S, M, L, XL, XXL\r\n6. Maroon : S, M, L, XL, XXL\r\n7. Heliconia : S, M, L, XL, XXL\r\n8. Merah : S, M, L, XL, XXL\r\n9. Orange : S, M, L, XL, XXL\r\n10. Gold : S, M, XL, XXL\r\n11. Daisy : S, M, L, XL, XXL\r\n12. Lime : S, M, L, XL, XXL\r\n13. Irish Green : S, M, L, XL, XXL\r\n14. Forest Green : S, M, L, XL, XXL\r\n15. Navy : S, M, L, XL, XXL\r\n16. Royal Blue : S, M, L, XL, XXL\r\n17. Sapphire : S, M, L, XL, XXL\r\n18. Caroline Blue : S, M, L, XL, XXL\r\n19. Purple : S, M, L, XL, XXL\r\n20. Dark Chocolate : S, M, L, XL, XXL\r\n21. Sand : S, M, L, XL, XXL\r\n22. Military Green : S, M, L, XL, XXL\r\n23. Chestnut : S, M, L, XL, XXL\r\n\r\nJam Kerja :\r\nSenin - Minggu : 08.00 - 20.00\r\nPengiriman Gosend/Grab Senin-Minggu\r\n\r\n#kaos #kaospolos #kaosdistro #kaosmurah #kaossablon #kaosgrosir #kaoscombed #tshirtpria #katuncombed #kaosfashion #gildan #doxa #doxaapparel #kaosdoxa #kaosjersey #kaospria #kaoswanita #tshirt', 'kaos.jpeg'),
(14, 7, 10, 'El and Eve Sarala Woman Top Only Baju Atasan Wanita', 159000, 4.7, 42, 2, '“SARALA” berarti lurus dan jujur dalam bahasa sansekerta. Sama seperti motif “SARALA” berupa garis-garis lurus berwarna pink pastel memberi makna tersendiri bagi koleksi terbaru ini.\r\n\r\n“SARALA” tersedia tidak hanya untuk anak perempuan, tapi juga untuk Ibu. Busui friendly dan sangat nyaman.\r\n_\r\nSize:\r\nMoms Size: M & L (reversable)\r\n*untuk menyusui, kancing di depan.\r\n.\r\n.\r\n#elandeve #new #momsandgirls #localbrand #newmodel #selfmanufactured #indonesia #mosfit #hellomosfit #babyclothing #babyfashion #autumn #coupleset #kidsclothing #kidsfashion #bajuanak #bajubayi', 'baju_cewek.jpeg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `toko`
--

CREATE TABLE `toko` (
  `id_toko` int(11) NOT NULL,
  `nama_toko` varchar(50) NOT NULL,
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `toko`
--

INSERT INTO `toko` (`id_toko`, `nama_toko`, `alamat`) VALUES
(1, 'Sariroti.id', 'KOTA JAKARTA PUSAT - JOHAR BARU, DKI JAKARTA, ID'),
(2, 'iboxofficial', 'KOTA JAKARTA UTARA - PENJARINGAN, DKI JAKARTA, ID'),
(3, 'samsung.official', 'KOTA JAKARTA UTARA - TANJUNG PRIOK, DKI JAKARTA, ID'),
(4, 'toshibastorageofficial', 'KOTA JAKARTA BARAT - TAMAN SARI, DKI JAKARTA, ID'),
(5, 'dellindonesia', 'KOTA JAKARTA PUSAT - SAWAH BESAR, DKI JAKARTA, ID'),
(6, 'byoote.official', 'KOTA JAKARTA BARAT - CENGKARENG, DKI JAKARTA, ID'),
(7, 'evendic', 'KOTA JAKARTA UTARA - TANJUNG PRIOK, DKI JAKARTA, ID'),
(8, 'fortisa', 'KOTA SURABAYA - WONOKROMO, JAWA TIMUR, ID'),
(9, 'jangtamedia', 'KOTA TANGERANG - CILEDUG, BANTEN, ID'),
(10, 'elandeveofficial', 'KOTA TANGERANG - CIPONDOH, BANTEN, ID');

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
(4, 'fauzy@gmail.com', '6172de70289f996b192e1b2f5a932ace', 'Fauzy Wahyudi', '+6282288229856', 'Solok', '2020-09-01 10:55:06');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indeks untuk tabel `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`);

--
-- Indeks untuk tabel `toko`
--
ALTER TABLE `toko`
  ADD PRIMARY KEY (`id_toko`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `produk`
--
ALTER TABLE `produk`
  MODIFY `id_produk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `toko`
--
ALTER TABLE `toko`
  MODIFY `id_toko` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
