<?php
require 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $user = $_POST['username'];
    $pass = md5($_POST['password']);

    $sql = $kon->query("SELECT * FROM user WHERE username='$user' AND password='$pass'");

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
