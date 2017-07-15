#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use Time::Piece;

my ($buffer, $magicnr, $blocksize, $version, $hashprev, $hashmerkel, $time, $bits, $nonce, $wait, $epoch, $txcount, $blockRest, $rest, $txversion, $txrest, $incounter, $inputs);
my ($locktime);

my $blocknr = 0;
my $loop = 0;

open my $fh, '<', '/storage/block/blocks/blk00000.dat' or die "File not found: $!";

binmode($fh);

while (read ($fh, $buffer, 4) != 0 && $loop <= 10) {
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
	$hashprev = unpack 'H*', $buffer;
	print "Hash Prev Block = $hashprev\n";

	#Hash Merkel Root
	read ($fh, $buffer, 32);
	$hashmerkel = unpack 'H*', $buffer;
	print "Hash Merkel Root = $hashmerkel\n";

	#Read Time
	read ($fh, $buffer, 4);
	$epoch = unpack 'i', $buffer;
	$time = localtime($epoch)->strftime('%F %T');
	print "Time = $time\n";

	#Read Bits
	read ($fh, $buffer, 4);
	$bits = unpack 'H*', $buffer;
	print "Bits = $bits\n";

	#Read Nonce
	read ($fh, $buffer, 4);
	$nonce = unpack 'H*', $buffer;
	print "Nonce = $nonce\n";

	#Read Txcounter
	read ($fh, $buffer, 1);
	$txcount = unpack 'H*', $buffer;
	print "Txcount = $txcount\n";

    #Read TX version
	read ($fh, $buffer, 4);
	$txversion = unpack 'i', $buffer;
	print "Txversion = $txversion\n";

	 #Read incounter
	read ($fh, $buffer, 1);
	$incounter = unpack 'H*', $buffer;
	my $incounterDec = sprintf("%d", hex($incounter));
	print "Incounter = $incounterDec\n";

	#Read var
	read ($fh, $buffer, 32);
	my $TxOutHash = unpack 'H*', $buffer;
	print "TxOutHash = $TxOutHash\n";

	#Read Signumber
	read ($fh, $buffer, 4);
	my $TxOutIndex = unpack 'H*', $buffer;
	print "TxOutIndex = $TxOutIndex\n";

	#Read Script length
	read ($fh, $buffer, 1);
	my $ScriptsLength = unpack 'H*', $buffer;
	my $ScriptsLengthDec = sprintf("%d", hex($ScriptsLength));
	print "Scripts length = $ScriptsLengthDec\n";

	#Read Script
	read ($fh, $buffer, $ScriptsLengthDec);
	my $script = unpack 'H*', $buffer;
	print "Script = $script\n";

	#Read Sequence
	read ($fh, $buffer, 4);
	my $sequence = unpack 'H*', $buffer;
	print "Sequence = $sequence\n";

	#Read outcounter
	read ($fh, $buffer, 1);
	my $outcounter = unpack 'H*', $buffer;
	my $outcounterDec = sprintf("%d", hex($outcounter));
	print "Outcounter = $outcounterDec\n";

	#Read Bitcoin value
	read ($fh, $buffer, 8);
	my $bitcoin = unpack 'H*', $buffer;
	print "bitcoin = $bitcoin\n";

	#Read pk_script length
	read ($fh, $buffer, 1);
	my $PKScriptLength = unpack 'H*', $buffer;
	my $PKScriptLengthDec = sprintf("%d", hex($PKScriptLength));
	print "PK Script length = PKScriptLengthDec\n";

	#Read Script
	read ($fh, $buffer, $PKScriptLengthDec);
	my $PKScript = unpack 'H*', $buffer;
	print "PKScript = $PKScript\n";

	#Read Locktime
	read ($fh, $buffer, 4);
	my $Locktime = unpack 'H*', $buffer;
	print "Locktime = $Locktime\n";

	$loop = $loop + 1;
}