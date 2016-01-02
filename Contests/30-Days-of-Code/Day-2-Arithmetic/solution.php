<?php
$fh = fopen('php://stdin', 'r');
$mainPrice = (float) fgets($fh);
$tipPercentage = (float) fgets($fh);
$taxPercentage = (float) fgets($fh);

$total = $mainPrice * (1 + ($tipPercentage + $taxPercentage)/100);

echo 'The final price of the meal is $' . round($total) . '.';
