<?php
require 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $id = $_POST['id'];
    $data = array();
    $sql = $kon->query("SELECT * FROM notes WHERE id_notes='$id'");
    while ($fetchData = $sql->fetch_array()) {
        $data[] = $fetchData;
    }

    if ($sql) {
        $response['value'] = 1;
        $response['message'] = "Notes berhasil diambil";
        $response['data'] = json_encode($data);
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Notes gagal diambil";
        echo json_encode($response);
    }
}
