<?php
require 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $id = $_POST['id'];
    $data = array();
    $sql = $kon->query("DELETE FROM notes WHERE id_notes='$id'");


    if ($sql) {
        $response['value'] = 1;
        $response['message'] = "Notes berhasil dihapus";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Notes gagal dihapus";
        echo json_encode($response);
    }
}
