import 'package:flutter/material.dart';
import 'package:galeri_photo_mantan/views/detail_mantan.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var asset = "assets/images/";

  var _dataMantan = [
    {
      "nama": "Soekarno",
      "gambar": "soekarno.jpg",
      "jabatan": "Presiden Pertama RI",
      "masa": "18 Agustus 1945 — 12 Maret 1967",
      "keterangan":
          "Presiden pertama Republik Indonesia, Soekarno yang biasa dipanggil Bung Karno, lahir di Blitar, Jawa Timur, 6 Juni 1901 dan meninggal di Jakarta, 21 Juni 1970. Ayahnya bernama Raden Soekemi Sosrodihardjo dan ibunya Ida Ayu Nyoman Rai. Semasa hidupnya, beliau mempunyai tiga istri dan dikaruniai delapan anak. Dari istri Fatmawati mempunyai anak Guntur, Megawati, Rachmawati, Sukmawati dan Guruh. Dari istri Hartini mempunyai Taufan dan Bayu, sedangkan dari istri Ratna Sari Dewi, wanita turunan Jepang bernama asli Naoko Nemoto mempunyai anak Kartika.\n\nMasa kecil Soekarno hanya beberapa tahun hidup bersama orang tuanya di Blitar. Semasa SD hingga tamat, beliau tinggal di Surabaya, indekos di rumah Haji Oemar Said Tokroaminoto, politisi kawakan pendiri Syarikat Islam. Kemudian melanjutkan sekolah di HBS (Hoogere Burger School). Saat belajar di HBS itu, Soekarno telah menggembleng jiwa nasionalismenya. Selepas lulus HBS tahun 1920, pindah ke Bandung dan melanjut ke THS (Technische Hoogeschool atau sekolah Tekhnik Tinggi yang sekarang menjadi ITB). Ia berhasil meraih gelar “Ir” pada 25 Mei 1926.\n\nKemudian, beliau merumuskan ajaran Marhaenisme dan mendirikan PNI (Partai Nasional lndonesia) pada 4 Juli 1927, dengan tujuan Indonesia Merdeka. Akibatnya, Belanda, memasukkannya ke penjara Sukamiskin, Bandung pada 29 Desember 1929. Delapan bulan kemudian baru disidangkan. Dalam pembelaannya berjudul Indonesia Menggugat, beliau menunjukkan kemurtadan Belanda, bangsa yang mengaku lebih maju itu.\n\nPembelaannya itu membuat Belanda makin marah. Sehingga pada Juli 1930, PNI pun dibubarkan. Setelah bebas pada tahun 1931, Soekarno bergabung dengan Partindo dan sekaligus memimpinnya. Akibatnya, beliau kembali ditangkap Belanda dan dibuang ke Ende, Flores, tahun 1933. Empat tahun kemudian dipindahkan ke Bengkulu.\n\nSetelah melalui perjuangan yang cukup panjang, Bung Karno dan Bung Hatta memproklamasikan kemerdekaan RI pada 17 Agustus 1945. Dalam sidang BPUPKI tanggal 1 Juni 1945, Ir.Soekarno mengemukakan gagasan tentang dasar negara yang disebutnya Pancasila. Tanggal 17 Agustus 1945, Ir Soekarno dan Drs. Mohammad Hatta memproklamasikan kemerdekaan Indonesia. Dalam sidang PPKI, 18 Agustus 1945 Ir.Soekarno terpilih secara aklamasi sebagai Presiden Republik Indonesia yang pertama."
    },
    {
      "nama": "Soeharto",
      "gambar": "soeharto.jpg",
      "jabatan": "Presiden Ke-dua RI",
      "masa": "12 Maret 1967 — 21 Mei 1998",
      "keterangan":
          "Soeharto adalah Presiden kedua Republik Indonesia. Beliau lahir di Kemusuk, Yogyakarta, tanggal 8 Juni 1921. Bapaknya bernama Kertosudiro seorang petani yang juga sebagai pembantu lurah dalam pengairan sawah desa, sedangkan ibunya bernama Sukirah.\n\nSoeharto masuk sekolah tatkala berusia delapan tahun, tetapi sering pindah. Semula disekolahkan di Sekolah Desa (SD) Puluhan, Godean. Lalu pindah ke SD Pedes, lantaran ibunya dan suaminya, Pak Pramono pindah rumah, ke Kemusuk Kidul. Namun, Pak Kertosudiro lantas memindahkannya ke Wuryantoro. Soeharto dititipkan di rumah adik perempuannya yang menikah dengan Prawirowihardjo, seorang mantri tani.\n\nSampai akhirnya terpilih menjadi prajurit teladan di Sekolah Bintara, Gombong, Jawa Tengah pada tahun 1941. Beliau resmi menjadi anggota TNI pada 5 Oktober 1945. Pada tahun 1947, Soeharto menikah dengan Siti Hartinah seorang anak pegawai Mangkunegaran.\n\nPerkimpoian Letkol Soeharto dan Siti Hartinah dilangsungkan tanggal 26 Desember 1947 di Solo. Waktu itu usia Soeharto 26 tahun dan Hartinah 24 tahun. Mereka dikaruniai enam putra dan putri; Siti Hardiyanti Hastuti, Sigit Harjojudanto, Bambang Trihatmodjo, Siti Hediati Herijadi, Hutomo Mandala Putra dan Siti Hutami Endang Adiningsih.\n\nJenderal Besar H.M. Soeharto telah menapaki perjalanan panjang di dalam karir militer dan politiknya. Di kemiliteran, Pak Harto memulainya dari pangkat sersan tentara KNIL, kemudian komandan PETA, komandan resimen dengan pangkat Mayor dan komandan batalyon berpangkat Letnan Kolonel.\n\nPada tahun 1949, dia berhasil memimpin pasukannya merebut kembali kota Yogyakarta dari tangan penjajah Belanda saat itu. Beliau juga pernah menjadi Pengawal Panglima Besar Sudirman. Selain itu juga pernah menjadi Panglima Mandala (pembebasan Irian Barat).\n\nTanggal 1 Oktober 1965, meletus G-30-S/PKI. Soeharto mengambil alih pimpinan Angkatan Darat. Selain dikukuhkan sebagai Pangad, Jenderal Soeharto ditunjuk sebagai Pangkopkamtib oleh Presiden Soekarno. Bulan Maret 1966, Jenderal Soeharto menerima Surat Perintah 11 Maret dari Presiden Soekarno. Tugasnya, mengembalikan keamanan dan ketertiban serta mengamankan ajaran-ajaran Pemimpin Besar Revolusi Bung Karno.\n\nKarena situasi politik yang memburuk setelah meletusnya G-30-S/PKI, Sidang Istimewa MPRS, Maret 1967, menunjuk Pak Harto sebagai Pejabat Presiden, dikukuhkan selaku Presiden RI Kedua, Maret 1968. Pak Harto memerintah lebih dari tiga dasa warsa lewat enam kali Pemilu, sampai ia mengundurkan diri, 21 Mei 1998.\n\nPresiden RI Kedua HM Soeharto wafat pada pukul 13.10 WIB Minggu, 27 Januari 2008. Jenderal Besar yang oleh MPR dianugerahi penghormatan sebagai Bapak Pembangunan Nasional, itu meninggal dalam usia 87 tahun setelah dirawat selama 24 hari (sejak 4 sampai 27 Januari 2008) di Rumah Sakit Pusat Pertamina (RSPP), Jakarta.",
    },
    {
      "nama": "Bacharuddin Jusuf Habibie",
      "gambar": "habibie.jpg",
      "jabatan": "Presiden Ke-tiga RI",
      "masa": "21 Mei 1998 — 20 Oktober 1999",
      "keterangan":
          "Presiden ketiga Republik Indonesia, Bacharuddin Jusuf Habibie lahir di Pare-Pare, Sulawesi Selatan, pada 25 Juni 1936. Beliau merupakan anak keempat dari delapan bersaudara, pasangan Alwi Abdul Jalil Habibie dan RA. Tuti Marini Puspowardojo. Habibie yang menikah dengan Hasri Ainun Habibie pada tanggal 12 Mei 1962 ini dikaruniai dua orang putra yaitu Ilham Akbar dan Thareq Kemal.\n\nMasa kecil Habibie dilalui bersama saudara-saudaranya di Pare-Pare, Sulawesi Selatan. Sifat tegas berpegang pada prinsip telah ditunjukkan Habibie sejak kanak-kanak. Habibie yang punya kegemaran menunggang kuda ini, harus kehilangan bapaknya yang meninggal dunia pada 3 September 1950 karena terkena serangan jantung. Tak lama setelah bapaknya meninggal, Habibie pindah ke Bandung untuk menuntut ilmu di Gouvernments Middlebare School. Di SMA, beliau mulai tampak menonjol prestasinya, terutama dalam pelajaran-pelajaran eksakta. Habibie menjadi sosok favorit di sekolahnya.\n\nSetelah tamat SMA di bandung tahun 1954, beliau masuk Universitas Indonesia di Bandung (Sekarang ITB). Beliau mendapat gelar Diploma dari Technische Hochschule, Jerman tahun 1960 yang kemudian mendapatkan gekar Doktor dari tempat yang sama tahun 1965. Habibie menikah tahun 1962, dan dikaruniai dua orang anak. Tahun 1967, menjadi Profesor kehormatan (Guru Besar) pada Institut Teknologi Bandung.\n\nLangkah-langkah Habibie banyak dikagumi, penuh kontroversi, banyak pengagum namun tak sedikit pula yang tak sependapat dengannya. Setiap kali, peraih penghargaan bergengsi Theodore van Karman Award, itu kembali dari “habitat”-nya Jerman, beliau selalu menjadi berita. Habibie hanya setahun kuliah di ITB Bandung, 10 tahun kuliah hingga meraih gelar doktor konstruksi pesawat terbang di Jerman dengan predikat Summa Cum laude. Lalu bekerja di industri pesawat terbang terkemuka MBB Gmbh Jerman, sebelum memenuhi panggilan Presiden Soeharto untuk kembali ke Indonesia.\n\nDi Indonesia, Habibie 20 tahun menjabat Menteri Negara Ristek/Kepala BPPT, memimpin 10 perusahaan BUMN Industri Strategis, dipilih MPR menjadi Wakil Presiden RI, dan disumpah oleh Ketua Mahkamah Agung menjadi Presiden RI menggantikan Soeharto. Soeharto menyerahkan jabatan presiden itu kepada Habibie berdasarkan Pasal 8 UUD 1945. Sampai akhirnya Habibie dipaksa pula lengser akibat refrendum Timor Timur yang memilih merdeka. Pidato Pertanggungjawabannya ditolak MPR RI. Beliau pun kembali menjadi warga negara biasa, kembali pula hijrah bermukim ke Jerman."
    },
    {
      "nama": "Abdurrahman Wahid",
      "gambar": "gusdur.jpg",
      "jabatan": "Presiden Ke-empat RI",
      "masa": "20 Oktober 1999 — 23 Juli 2001",
      "keterangan":
          "Gus Dur adalah putra pertama dari enam bersaudara yang dilahirkan di Denanyar Jombang Jawa Timur pada tanggal 4 Agustus 1940. Secara genetik Gus Dur adalah keturunan “darah biru”. Ayahnya, K.H. Wahid Hasyim adalah putra K.H. Hasyim Asy’ari, pendiri jam’iyah Nahdlatul Ulama (NU)-organisasi massa Islam terbesar di Indonesia-dan pendiri Pesantren Tebu Ireng Jombang. Ibundanya, Ny. Hj. Sholehah adalah putri pendiri Pesantren Denanyar Jombang, K.H. Bisri Syamsuri. Kakek dari pihak ibunya ini juga merupakan tokoh NU, yang menjadi Rais ‘Aam PBNU setelah K.H. Abdul Wahab Hasbullah. Dengan demikian, Gus Dur merupakan cucu dari dua ulama NU sekaligus, dan dua tokoh bangsa Indonesia.\n\nPada tahun 1949, ketika clash dengan pemerintahan Belanda telah berakhir, ayahnya diangkat sebagai Menteri Agama pertama, sehingga keluarga Wahid Hasyim pindah ke Jakarta. Dengan demikian suasana baru telah dimasukinya. Tamu-tamu, yang terdiri dari para tokoh-dengan berbagai bidang profesi-yang sebelumnya telah dijumpai di rumah kakeknya, terus berlanjut ketika ayahnya menjadi Menteri agama. Hal ini memberikan pengalaman tersendiri bagi seorang anak bernama Abdurrahman Wahid. Secara tidak langsung, Gus Dur juga mulai berkenalan dengan dunia politik yang didengar dari kolega ayahnya yang sering mangkal di rumahnya.\n\nSejak masa kanak-kanak, ibunya telah ditandai berbagai isyarat bahwa Gus Dur akan mengalami garis hidup yang berbeda dan memiliki kesadaran penuh akan tanggung jawab terhadap NU. Pada bulan April 1953, Gus Dur pergi bersama ayahnya mengendarai mobil ke daerah Jawa Barat untuk meresmikan madrasah baru. Di suatu tempat di sepanjang pegunungan antara Cimahi dan Bandung, mobilnya mengalami kecelakaan. Gus Dur bisa diselamatkan, akan tetapi ayahnya meninggal. Kematian ayahnya membawa pengaruh tersendiri dalam kehidupannya.\n\nDalam kesehariannya, Gus Dur mempunyai kegemaran membaca dan rajin memanfaatkan perpustakaan pribadi ayahnya. Selain itu ia juga aktif berkunjung keperpustakaan umum di Jakarta. Pada usia belasan tahun Gus Dur telah akrab dengan berbagai majalah, surat kabar, novel dan buku-buku yang agak serius. Karya-karya yang dibaca oleh Gus Dur tidak hanya cerita-cerita, utamanya cerita silat dan fiksi, akan tetapi wacana tentang filsafat dan dokumen-dokumen manca negara tidak luput dari perhatianya. Di samping membaca, tokoh satu ini senang pula bermain bola, catur dan musik. Dengan demikian, tidak heran jika Gus Dur pernah diminta untuk menjadi komentator sepak bola di televisi. Kegemaran lainnya, yang ikut juga melengkapi hobinya adalah menonton bioskop. Kegemarannya ini menimbulkan apresiasi yang mendalam dalam dunia film. Inilah sebabnya mengapa Gu Dur pada tahun 1986-1987 diangkat sebagai ketua juri Festival Film Indonesia.\n\nMasa remaja Gus Dur sebagian besar dihabiskan di Yogyakarta dan Tegalrejo. Di dua tempat inilah pengembangan ilmu pengetahuan mulai meningkat. Masa berikutnya, Gus Dur tinggal di Jombang, di pesantren Tambak Beras, sampai kemudian melanjutkan studinya di Mesir. Sebelum berangkat ke Mesir, pamannya telah melamarkan seorang gadis untuknya, yaitu Sinta Nuriyah anak Haji Muh. Sakur. Perkimpoiannya dilaksanakan ketika ia berada di Mesir."
    },
    {
      "nama": "Megawati Soekarnoputri",
      "gambar": "mega.jpg",
      "jabatan": "Presiden Ke-lima RI",
      "masa": "23 Juli 2001 — 20 Oktober 2004",
      "keterangan":
          "Presiden Republik Indonesia ke-5, Megawati Soekarnoputri lahir di Yogyakarta, 23 Januari 1947. Sebelum diangkat sebagai presiden, beliau adalah Wakil Presiden RI yang ke-8 dibawah pemerintahan Abdurrahman Wahid. Megawati adalah putri sulung dari Presiden RI pertama yang juga proklamator, Soekarno dan Fatmawati.\n\nMegawati, pada awalnya menikah dengan pilot Letnan Satu Penerbang TNI AU, Surendro dan dikaruniai dua anak lelaki bernama Mohammad Prananda dan Mohammad Rizki Pratama.\n\nPada suatu tugas militer, tahun 1970, di kawasan Indonesia Timur, pilot Surendro bersama pesawat militernya hilang dalam tugas. Derita tiada tara, sementara anaknya masih kecil dan bayi. Namun, derita itu tidak berkepanjangan, tiga tahun kemudian Mega menikah dengan pria bernama Taufik Kiemas, asal Ogan Komiring Ulu, Palembang. Kehidupan keluarganya bertambah bahagia, dengan dikaruniai seorang putri Puan Maharani. Kehidupan masa kecil Megawati dilewatkan di Istana Negara. Sejak masa kanak-kanak, Megawati sudah lincah dan suka main bola bersama saudaranya Guntur. Sebagai anak gadis, Megawati mempunyai hobi menari dan sering ditunjukkan di hadapan tamu-tamu negara yang berkunjung ke Istana.\n\nWanita bernama lengkap Dyah Permata Megawati Soekarnoputri ini memulai pendidikannya, dari SD hingga SMA di Perguruan Cikini, Jakarta. Sementara, ia pernah belajar di dua Universitas, yaitu Fakultas Pertanian, Universitas Padjadjaran, Bandung (1965-1967) dan Fakultas Psikologi Universitas Indonesia (1970-1972). Kendati lahir dari keluarga politisi jempolan, Mbak Mega — panggilan akrab para pendukungnya — tidak terbilang piawai dalam dunia politik. Bahkan, Megawati sempat dipandang sebelah mata oleh teman dan lawan politiknya. Beliau bahkan dianggap sebagai pendatang baru dalam kancah politik, yakni baru pada tahun 1987. Saat itu Partai Demokrasi Indonesia (PDI) menempatkannya sebagai salah seorang calon legislatif dari daerah pemilihan Jawa Tengah, untuk mendongkrak suara.\n\nMasuknya Megawati ke kancah politik, berarti beliau telah mengingkari kesepakatan keluarganya untuk tidak terjun ke dunia politik. Trauma politik keluarga itu ditabraknya. Megawati tampil menjadi primadona dalam kampanye PDI, walau tergolong tidak banyak bicara. Ternyata memang berhasil. Suara untuk PDI naik. Dan beliau pun terpilih menjadi anggota DPR/MPR. Pada tahun itu pula Megawati terpilih sebagai Ketua DPC PDI Jakarta Pusat.\n\nTetapi, kehadiran Mega di gedung DPR/MPR sepertinya tidak terasa. Tampaknya, Megawati tahu bahwa beliau masih di bawah tekanan. Selain memang sifatnya pendiam, belaiu pun memilih untuk tidak menonjol mengingat kondisi politik saat itu. Maka belaiu memilih lebih banyak melakukan lobi-lobi politik di luar gedung wakil rakyat tersebut. Lobi politiknya, yang silent operation, itu secara langsung atau tidak langsung, telah memunculkan terbitnya bintang Mega dalam dunia politik. Pada tahun 1993 dia terpilih menjadi Ketua Umum DPP PDI. Hal ini sangat mengagetkan pemerintah pada saat itu."
    },
    {
      "nama": "Susilo Bambang Yudhoyono",
      "gambar": "sby.png",
      "jabatan": "Presiden Ke-enam RI",
      "masa": "20 Oktober 2004 — 20 Oktober 2014",
      "keterangan":
          "Susilo Bambang Yudhoyono adalah presiden RI ke-6. Berbeda dengan presiden sebelumnya, beliau merupakan presiden pertama yang dipilih secara langsung oleh rakyat dalam proses Pemilu Presiden putaran II 20 September 2004. Lulusan terbaik AKABRI (1973) yang akrab disapa SBY ini lahir di Pacitan, Jawa Timur 9 September 1949. Istrinya bernama Kristiani Herawati, merupakan putri ketiga almarhum Jenderal (Purn) Sarwo Edhi Wibowo.\n\nPensiunan jenderal berbintang empat ini adalah anak tunggal dari pasangan R. Soekotjo dan Sitti Habibah. Darah prajurit menurun dari ayahnya yang pensiun sebagai Letnan Satu. Sementara ibunya, Sitti Habibah, putri salah seorang pendiri Ponpes Tremas. Beliau dikaruniai dua orang putra yakni Agus Harimurti Yudhoyono (mengikuti dan menyamai jejak dan prestasi SBY, lulus dari Akmil tahun 2000 dengan meraih penghargaan Bintang Adhi Makayasa) dan Edhie Baskoro Yudhoyono (lulusan terbaik SMA Taruna Nusantara, Magelang yang kemudian menekuni ilmu ekonomi).\n\nPendidikan SR adalah pijakan masa depan paling menentukan dalam diri SBY. Ketika duduk di bangku kelas lima, beliau untuk pertamakali kenal dan akrab dengan nama Akademi Militer Nasional (AMN), Magelang, Jawa Tengah. Di kemudian hari AMN berubah nama menjadi Akabri. SBY masuk SMP Negeri Pacitan, terletak di selatan alun-alun. Ini adalah sekolah idola bagi anak-anak Kota Pacitan. Mewarisi sikap ayahnya yang berdisiplin keras, SBY berjuang untuk mewujudkan cita-cita masa kecilnya menjadi tentara dengan masuk Akademi Angkatan Bersenjata Republik Indonesia (Akabri) setelah lulus SMA akhir tahun 1968. Namun, lantaran terlambat mendaftar, SBY tidak langsung masuk Akabri. Maka SBY pun sempat menjadi mahasiswa Teknik Mesin Institut 10 November Surabaya (ITS).\n\nNamun kemudian, SBY justru memilih masuk Pendidikan Guru Sekolah Lanjutan Pertama (PGSLP) di Malang, Jawa Timur. Sewaktu belajar di PGSLP Malang itu, beliau mempersiapkan diri untuk masuk Akabri. Tahun 1970, akhirnya masuk Akabri di Magelang, Jawa Tengah, setelah lulus ujian penerimaan akhir di Bandung. SBY satu angkatan dengan Agus Wirahadikusumah, Ryamizard Ryacudu, dan Prabowo Subianto. Semasa pendidikan, SBY yang mendapat julukan Jerapah, sangat menonjol. Terbukti, belaiu meraih predikat lulusan terbaik Akabri 1973 dengan menerima penghargaan lencana Adhi Makasaya.\n\nPendidikan militernya dilanjutkan di Airborne and Ranger Course di Fort Benning, Georgia, AS (1976), Infantry Officer Advanced Course di Fort Benning, Georgia, AS (1982-1983) dengan meraih honor graduate, Jungle Warfare Training di Panama (1983), Anti Tank Weapon Course di Belgia dan Jerman (1984), Kursus Komandan Batalyon di Bandung (1985), Seskoad di Bandung (1988-1989) dan Command and General Staff College di Fort Leavenworth, Kansas, AS (1990-1991). Gelar MA diperoleh dari Webster University AS. Perjalanan karier militernya, dimulai dengan memangku jabatan sebagai Dan Tonpan Yonif Linud 330 Kostrad (Komandan Peleton III di Kompi Senapan A, Batalyon Infantri Lintas Udara 330/Tri Dharma, Kostrad) tahun 1974-1976, membawahi langsung sekitar 30 prajurit."
    },
  ];

  // void _buildDataMantan() {
  //   for (var i = 0; i < _dataMantan.length; i++) {
  //     _daftarMantan.add(_buildItem(_dataMantan[i]));
  //   }
  // }
  int get _countAxis =>
      MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3;

  @override
  void initState() {
    // _buildDataMantan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: CustomScrollView(
            slivers: [
              _buildSliverAppBar(context),
              SliverPadding(padding: EdgeInsets.only(top: 10)),
              _buildSliverGrid(),
              SliverPadding(padding: EdgeInsets.only(top: 10)),
            ],
          ),
        ),
      ),
    );
  }

  SliverGrid _buildSliverGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 0.9,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return _buildItem(_dataMantan[index]);
        },
        childCount: _dataMantan.length,
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
        floating: true,
        pinned: false,
        snap: true,
        expandedHeight: 250,
        flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    asset + 'lambang.jpg',
                    fit: BoxFit.cover,
                  )),
              Container(
                color: Colors.black.withOpacity(0.2),
              )
            ],
          ),
          title: Text(
            "Mantan Presiden RI",
          ),
          centerTitle: true,
        ));
  }

  Widget _buildItem(var data) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailMantan(
                    data: data,
                  ))),
      child: Card(
        child: Stack(
          children: [
            Container(
              width: 250,
              child: Hero(
                tag: data['nama'],
                child: Image.asset(
                  '$asset${data['gambar']}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                ),
                height: 30,
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        data['nama'],
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
