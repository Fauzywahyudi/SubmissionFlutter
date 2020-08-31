<?php
require 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $id = $_POST['id'];
    $judul = $_POST['judul'];
    $isi = $_POST['isi'];

    $sql = $kon->query("INSERT INTO `notes`(`id_notes`, `id_user`, `judul_notes`, `isi_notes`, `tgl_buat`, `tgl_update`) VALUES (NULL,'$id','$judul','$isi',NOW(),NOW())");

    if ($sql) {
        $response['value'] = 1;
        $response['message'] = "Notes berhasil dibuat";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Notes gagal dibuat";
        echo json_encode($response);
    }
}
