<?php
require 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $data = array();
    $status = $_POST['status'];
    $id_user = $_POST['id_user'];

    if ($status == "favorite") {
        $sql = $kon->query("SELECT * FROM favorite INNER JOIN video ON favorite.id_video=video.id_video WHERE favorite.id_user='$id_user'");
    } else {
        $sql = $kon->query("SELECT * FROM video");
    }

    while ($fetchData = $sql->fetch_array()) {
        $data[] = $fetchData;
    }

    if (isset($data)) {
        $response['value'] = 1;
        $response['message'] = "Load data berhasil";
        $response['data'] = json_encode($data);
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Load data gagal";
        echo json_encode($response);
    }
}
