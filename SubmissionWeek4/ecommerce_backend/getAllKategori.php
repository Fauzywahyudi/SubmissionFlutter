<?php
require 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $data = array();

    $sql = $kon->query("SELECT * FROM `kategori`");
    while ($fetchData = $sql->fetch_array()) {
        $data[] = $fetchData;
    }
    if ($sql) {
        $response['value'] = 1;
        $response['message'] = "Berhasil load data";
        $response['data'] = json_encode($data);
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal load data";
        echo json_encode($response);
    }
}
