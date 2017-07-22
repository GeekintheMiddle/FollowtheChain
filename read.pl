#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use Time::Piece;

my ($buffer, $magicnr, $blocksize, $version, $hashprev, $hashmerkel, $time, $bits, $nonce, $epoch, $txcount, $txcountDec, $n);
my ($txversion, $incounter, $incounterDec, $inputs, $TxOutHash, $TxOutIndex, $ScriptsLength, $ScriptsLengthDec, $script, $sequence, $outcounter, $outcounterDec, $bitcoin, $PKScriptLength, $PKScriptLengthDec, $PKScript, $Locktime);

my $blocknr = 0;
my $loop = 0;

open my $fh, '<', '/storage/block/blocks/blk00065.dat' or die "File not found: $!";

binmode($fh);

while (read ($fh, $buffer, 4) != 0 && $loop < 1) {
	next unless ((unpack 'H*', $buffer) eq "f9beb4d9");

	#Blocknr.
	$blocknr = $blocknr + 1;
	print "Block number: $blocknr\n";

	#Read MagicNR
	$magicnr = unpack 'H*', $buffer;
	print "Magicnr = $magicnr\n";

	#Read Blocksize
	read ($fh, $buffer, 4);
	$blocksize = unpack 'i', $buffer;
	print "Blocksize = $blocksize\n";

	#Read Version
	read ($fh, $buffer, 4);
	$version = unpack 'i', $buffer;
	print "Version = $version\n";

	#Hash Prev Block
	read ($fh, $buffer, 32);
	my @hashprev = unpack 'H*', $buffer;
	print "Hash Prev Block = ";
	for (@hashprev){
		my $rev = join '', reverse m/([[:xdigit:]]{2})/g;
	    print "$rev\n";
	}
	
	#Hash Merkel Root
	read ($fh, $buffer, 32);
	my @hashmerkel = unpack 'H*', $buffer;
	print "Hash Merkel Root = ";
	for (@hashmerkel){
		my $rev = join '', reverse m/([[:xdigit:]]{2})/g;
	    print "$rev\n";
	}

	#Read Time
	read ($fh, $buffer, 4);
	$epoch = unpack 'i', $buffer;
	$time = localtime($epoch)->strftime('%F %T');
	print "Time = $time\n";

	#Read Bits
	read ($fh, $buffer, 4);
	my @bits = unpack 'H*', $buffer;
	print "Difficulty (Bits) = ";
	for (@bits){
		my $rev = join '', reverse m/([[:xdigit:]]{2})/g;
	    print "$rev\n";
	}

	#Read Nonce
	read ($fh, $buffer, 4);
	$nonce = unpack 'I', $buffer;
	print "Nonce = $nonce\n";

	#Read Txcounter
	read ($fh, $buffer, 1);
	$txcount = unpack 'H*', $buffer;
	$txcountDec = sprintf("%d", hex($txcount));
	print "Transaction counter HEX = $txcount\n\n";
	print "Transaction counter = $txcountDec\n\n";

	my $txnr = 1;
	while ($txnr <= $txcountDec) {

		print "Transaction number = $txnr\n";
	    #Read TX version
		read ($fh, $buffer, 4);
		$txversion = unpack 'i', $buffer;
		print "Transaction Version = $txversion\n";

		 #Read incounter
		read ($fh, $buffer, 1);
		$incounter = unpack 'H*', $buffer;
		$incounterDec = sprintf("%d", hex($incounter));
		print "Input counter = $incounterDec\n";

		#Read Transaction out hash
		read ($fh, $buffer, 32);
		$TxOutHash = unpack 'H*', $buffer;
		print "Transaction out hash = $TxOutHash\n";

		#Read Transaction out Index
		read ($fh, $buffer, 4);
		$TxOutIndex = unpack 'H*', $buffer;
		print "Transaction out Index = $TxOutIndex\n";

		#Read Script length
		read ($fh, $buffer, 1);
		$ScriptsLength = unpack 'H*', $buffer;
		$ScriptsLengthDec = sprintf("%d", hex($ScriptsLength));
		print "Scripts length = $ScriptsLengthDec\n";

		#Read Script
		read ($fh, $buffer, $ScriptsLengthDec);
		$script = unpack 'H*', $buffer;
		print "Script = $script\n";

		#Read Sequence
		read ($fh, $buffer, 4);
		$sequence = unpack 'H*', $buffer;
		print "Sequence = $sequence\n";

		#Read outcounter
		read ($fh, $buffer, 1);
		$outcounter = unpack 'H*', $buffer;
		$outcounterDec = sprintf("%d", hex($outcounter));
		print "Output counter = $outcounterDec\n";

		#my $out = 1;
		#while ($out <= $outcounterDec) {
			#Read Bitcoin value
			read ($fh, $buffer, 8);
			$bitcoin = unpack 'H*', $buffer;
			print "Bitcoin value = $bitcoin\n";

			#Read PK script length
			read ($fh, $buffer, 1);
			$PKScriptLength = unpack 'H*', $buffer;
			$PKScriptLengthDec = sprintf("%d", hex($PKScriptLength));
			print "PK Script length = $PKScriptLengthDec\n";

			#Read PK Script
			read ($fh, $buffer, $PKScriptLengthDec);
			$PKScript = unpack 'H*', $buffer;
			print "PK Script = $PKScript\n";
			#$out = $out + 1;
		#}

		#Read Locktime
		read ($fh, $buffer, 4);
		$Locktime = unpack 'H*', $buffer;
		print "Locktime = $Locktime\n\n";

		$txnr = $txnr + 1;
	}

	$loop = $loop + 1;
}