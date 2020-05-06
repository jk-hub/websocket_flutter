<?php
 
$host = "192.168.0.105";

// An example list of IP addresses owned by the computer
$sourceips['kevin']    = '127.0.0.1';
$sourceips['madcoder'] = "192.168.0.105";
$port = "58650";


 
set_time_limit(0);
// create socket
$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP) or die('Could not create socket\n');
print "$socket";
// bind socket to port
$result  = socket_bind($socket,'192.168.0.105','8080') or die('Could not bind to socket\n');
print "$result";
// start listening to connections
// socket_connect($socket, $host, 6000);


$result = socket_listen($socket , 12) or die('Could not set up socket listener');
print "$result";


// Write
$request = 'GET / HTTP/1.1' . "\r\n" .
           'Host: example.com' . "\r\n\r\n";

           print"$request";
// socket_write($socket, $request);

    // $spawn = socket_accept($socket) or die('Could not accept incoming connection');

    // $input  = socket_read($spawn, 1024) or die('Could not read input');

    // $input = trim($input);
    // echo "Client Message: ".$input;

    //     $output = strrev($input);
    // socket_write($spawn, $output, strlen($output)) or die('Could not write output');



// $result = socket_write($socket, "test", strlen ("test")) or die("Could not write output\n");
// print "$result";

 
while(true){
    // accept incoming connections
    // spawn another socket to handle communication
    $spawn = socket_accept($socket) or die('Could not accept incoming connection');
    // read client input
    $input  = socket_read($spawn, 1024) or die('Could not read input');
    // clean up input string
    $input = trim($input);
    echo "Client Message: ".$input;
    // reverse the message and send back
    $output = strrev($input);
    socket_write($spawn, $output, strlen($output)) or die('Could not write output');
}
 
// Close sockets
socket_close($spawn);
socket_close($socket);
 
?>

<!-- <?php
// // Create a new socket
// $sock = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);

// // An example list of IP addresses owned by the computer
// $sourceips['kevin']    = '127.0.0.1';
// $sourceips['madcoder'] = '127.0.0.2';

// // Bind the source address
// socket_bind($sock, $sourceips['madcoder']);

// // Connect to destination address
// socket_connect($sock, '127.0.0.1', 80);

// // Write
// $request = 'GET / HTTP/1.1' . "\r\n" .
//            'Host: example.com' . "\r\n\r\n";

//            print"$request";
// socket_write($sock, $request);

// // Close
// socket_close($sock);

?> -->