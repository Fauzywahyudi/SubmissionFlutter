<?php
require 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $email = $_POST['email'];
    $pass = md5($_POST['password']);
    $nama = $_POST['nama'];
    $nohp = $_POST['nohp'];
    $alamat = $_POST['alamat'];

    $sql = $kon->query("SELECT * FROM user WHERE email='$email'");
    $resultCek = $sql->fetch_array();

    if (isset($resultCek)) {
        $response['value'] = 2;
        $response['message'] = "email telah terdaftar";
        echo json_encode($response);
    } else {
        $sql = $kon->query("INSERT INTO `user`(`id_user`, `email`, `password`, `nama`, `nohp`, `alamat`, `tgl_daftar`) VALUES (NULL,'$email','$pass','$nama','$nohp','$alamat',NOW())");

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
