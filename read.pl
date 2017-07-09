#!/usr/local/bin/perl
use strict;
use warnings;
use 5.010;
use Time::Piece;

my ($buffer, $magicnr, $blocksize, $version, $hashprev, $hashmerkel, $time, $bits, $nonce, $wait, $epoch, $txcount);

my $blocknr = 0;

open my $fh, '<', '/mnt/storage/bitcoin/blocks/blk00000.dat' or die "File not found: $!";

binmode($fh);

while (read ($fh, $buffer, 4) != 0) {
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

	#Start Blockheader
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
        $bits = unpack 'i', $buffer;
        print "Bits = $bits\n";

        #Read Nonce
        read ($fh, $buffer, 4);
        $nonce = unpack 'H*', $buffer;
        print "Nonce = $nonce\n";

	#Read Tx count
	read ($fh, $buffer, 9);
        $txcount = unpack 'i', $buffer;
        print "TX Count = $txcount\n";	

	$wait = <>;
}
