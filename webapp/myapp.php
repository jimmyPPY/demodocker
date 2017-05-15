<?php
	$dbhost=getenv('MSQL_PORT_3306_TCP_ADDR');

	echo 'test'.$dbhost;
try {
	$dbh = new PDO('mysql:host='.$dbhost.';dbname=mysql', 'root', 'passe');

	echo '<h1>Liste Database</h1><br/><br/>';

	foreach($dbh->query('SHOW DATABASES;') as $row){
		  echo $row[0].'<br/>';
	}
}
catch (Exception $e)
{
        die('Erreur : ' . $e->getMessage());
}
?>
