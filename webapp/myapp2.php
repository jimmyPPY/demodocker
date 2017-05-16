<?php
try {
	$dbh = new PDO('mysql:host=db;dbname=mysql', 'root', 'passe');

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
