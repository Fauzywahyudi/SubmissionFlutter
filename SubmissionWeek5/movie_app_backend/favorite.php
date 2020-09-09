<?php


if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    require 'koneksi.php';
    $response = array();
    $status = $_POST['status'];
    $id_video = $_POST['id_video'];
    $id_user = $_POST['id_user'];
    if ($status == "tambah") {
        $sql = $kon->query("INSERT INTO `favorite`(`id_favorite`, `id_user`, `id_video`, `tgl_favorite`) VALUES (NULL,'$id_user','$id_video',NOW())");
        $response['message'] = "$status";
        echo json_encode($response);
    } else {
        $sql = $kon->query("DELETE FROM favorite WHERE id_video='$id_video' AND id_user='$id_user'");
        $response['message'] = "$status";
        echo json_encode($response);
    }

    // if ($sql) {
    //     $response['value'] = 1;
    //     $response['message'] = "berhasil s";
    //     echo json_encode($response);
    // } else {
    //     $response['value'] = 0;
    //     $response['message'] = "gagal";
    //     echo json_encode($response);
    // }
}
