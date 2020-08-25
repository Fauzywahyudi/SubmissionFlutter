<?php 
include 'koneksi.php';

$nim = $_POST['nim'];
$pass = $_POST['pass'];
$nama = $_POST['nama'];
$alamat = $_POST['alamat'];
$jk = $_POST['jk'];
$jurusan = $_POST['jurusan'];

$sql = $kon->query("INSERT INTO `mahasiswa`(`id_mahasiswa`, `nim_mahasiswa`, `password`, `nama_lengkap`, `jenis_kelamin`, `jurusan`, `alamat`) VALUES (NULL,'$nim','$pass','$nama','$jk','$jurusan','$alamat')");
