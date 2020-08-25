<?php
require 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $search = $_POST['search'];
    $data = array();

    // $sql = $kon->query("SELECT * FROM `kata`");
    if (empty($search)) {
        $sql = $kon->query("SELECT * FROM `kata`");
    } else {
        $sql = $kon->query("SELECT * FROM `kata` WHERE kata like '%$search%'");
    }
    // $result = $sql->fetch_array();
    while ($fetchData = $sql->fetch_assoc()) {
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
