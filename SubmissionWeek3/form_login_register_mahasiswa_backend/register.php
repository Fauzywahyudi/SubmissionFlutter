<?php
require 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $nim = $_POST['nim'];
    $pass = md5($_POST['pass']);
    $nama = $_POST['nama'];
    $alamat = $_POST['alamat'];
    $jk = $_POST['jk'];
    $jurusan = $_POST['jurusan'];

    $resultCek = $kon->query("SELECT * FROM mahasiswa WHERE nim_mahasiswa='$nim'");

    if (isset($resultCek)) {
        $response['value'] = 2;
        $response['message'] = "NIM telah terdaftar";
        echo json_encode($response);
    } else {
        $sql = $kon->query("INSERT INTO `mahasiswa`(`id_mahasiswa`, `nim_mahasiswa`, `password`, `nama_lengkap`, `jenis_kelamin`, `jurusan`, `alamat`, `tgl_daftar`) VALUES (NULL,'$nim','$pass','$nama','$jk','$jurusan','$alamat',NOW())");

        if ($sql) {
            $response['value'] = 1;
            $response['message'] = "Berhasil didaftarkan";
            echo json_encode($response);
        } else {
            $response['value'] = 0;
            $response['message'] = "Gagal didaftarkan";
            echo json_encode($response);
        }
    }
}
