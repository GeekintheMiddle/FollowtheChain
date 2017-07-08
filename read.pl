#!/usr/local/bin/perl
use strict;
use warnings;

my ($buffer, $magicnr, $blocksize);

open my $fh, '<', '/mnt/storage/bitcoin/blocks/blk00000.dat' or die "File not found: $!";

binmode($fh);

while (read ($fh, $buffer, 4) != 0) {
	next unless ((unpack 'H*', $buffer) eq "f9beb4d9");

	#Print MagicNR
	$magicnr = unpack 'H*', $buffer;
	print "Magicnr = $magicnr\n";

	#Read Blocksize
	read ($fh, $buffer, 4);
	$blocksize = unpack 'H*', $buffer;
	print "Blocksize = $blocksize\n";
}
