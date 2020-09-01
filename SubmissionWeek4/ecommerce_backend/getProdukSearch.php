<?php
require 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $data = array();
    $search = $_POST['search'];

    $sql = $kon->query("SELECT * FROM `produk` INNER JOIN toko ON produk.id_toko=toko.id_toko WHERE produk.nama_produk LIKE '%$search%' || produk.deskripsi LIKE '%$search%'");
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
