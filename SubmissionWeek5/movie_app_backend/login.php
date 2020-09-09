<?php
require 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $email = $_POST['email'];
    $pass = md5($_POST['password']);

    $sql = $kon->query("SELECT * FROM user WHERE email='$email' AND password='$pass'");

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
