<?php
require 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $id = $_POST['id'];
    $judul = $_POST['judul'];
    $isi = $_POST['isi'];

    $sql = $kon->query("UPDATE `notes` SET `judul_notes`='$judul',`isi_notes`='$isi',`tgl_update`=NOW() WHERE id_notes='$id'");

    if ($sql) {
        $response['value'] = 1;
        $response['message'] = "Notes berhasil diedit";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Notes gagal diedit";
        echo json_encode($response);
    }
}
