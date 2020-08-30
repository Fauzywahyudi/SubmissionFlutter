<?php
require 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $user = $_POST['username'];
    $pass = md5($_POST['password']);
    $nama = $_POST['nama'];
    $jk = $_POST['jk'];

    $sql = $kon->query("SELECT * FROM user WHERE username='$user'");
    $resultCek = $sql->fetch_array();

    if (isset($resultCek)) {
        $response['value'] = 2;
        $response['message'] = "username telah terdaftar";
        echo json_encode($response);
    } else {
        $sql = $kon->query("INSERT INTO `user`(`id_user`, `username`, `password`, `nama_lengkap`, `jenis_kelamin`, `tgl_daftar`) VALUES (NULL,'$user','$pass','$nama','$jk',NOW())");

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
