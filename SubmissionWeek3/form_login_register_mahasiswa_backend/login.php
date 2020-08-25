<?php
include 'koneksi.php';

$pass = $_POST['pass'];
$nim = $_POST['nim'];

$data = array();

$sql = $kon->query("SELECT * FROM mahasiswa WHERE nim_mahasiswa='$nim' AND password='$pass'");

while ($fetchData = $sql->fetch_assoc()) {
    $data[] = $fetchData;
}

echo json_encode($data);
