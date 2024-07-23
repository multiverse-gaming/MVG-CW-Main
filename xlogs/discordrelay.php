<?php
if (!isset($_POST["content"], $_POST["url"], $_POST["key"])) {
    return;
}

$privatekey = "76561198093398631";
$passedkey = $_POST["key"];

if ($privatekey != $passedkey) {
    echo "Invalid key!";
    return;
}

$request = json_encode([
    "embeds" => [
        [
            "title" => $_POST["title"],
            "type" => "rich",
            "description" => $_POST["content"],
            "color" => hexdec($_POST["color"]),
            "timestamp" => date("c"),
        ]
    ]
], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);

$ch = curl_init($_POST["url"]);

curl_setopt_array($ch, [
    CURLOPT_POST => 1,
    CURLOPT_FOLLOWLOCATION => 1,
    CURLOPT_POSTFIELDS => $request,
    CURLOPT_RETURNTRANSFER => 1
]);

curl_exec($ch);