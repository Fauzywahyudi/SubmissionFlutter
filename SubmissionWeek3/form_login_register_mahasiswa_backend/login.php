<?php
require 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $nim = $_POST['nim'];
    $pass = md5($_POST['pass']);

    $sql = $kon->query("SELECT * FROM mahasiswa WHERE nim_mahasiswa='$nim' AND password='$pass'");

    $result = $sql->fetch_array();

    if (isset($result)) {
        $response['value'] = 1;
        $response['message'] = "Login berhasil";
        $response['data'] = json_encode($result);
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Login gagal";
        echo json_encode($response);
    }
}
