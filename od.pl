#!/usr/bin/perl
use strict;
use warnings;

# take in command line args
my $arguments = @ARGV;
# scalar to take in binary
my $buffer;
# scalar to mark beginning of each 16 character set
my $offset = 0;
# file from command line
my $file;
# command line option, in this case for printable characters
my $option;

# possibly two arguments, the option and the image file
# check for option
if ($arguments == 2 && shift eq "-c") {

	$option = "true";
	$file = shift;
	
	}
# when no option provided, first argument, the image file
else {

	$file = shift;
	
	}

# filehandle created
open my $fh, '<', $file or die "couldn't open file $!\n";
#read from file to buffer 16 characters at a time
while (read($fh, $buffer, 16)) {
# unpack buffer as hex
my $hex = unpack("H*", $buffer);   
    #read hex two characters at a time
    while ($offset < length($hex)) { 
    
    my $binex = substr($hex, $offset, 2);
    
    $offset += 2;
    # option to check if two character hex is printable
   if ($option) {
   
  	if ($binex =~ /[2-7](?:[0-9]|[A-F]|[a-f])/) {
    	
    	print " ".chr(hex($binex))," ";
    	
	}    	
    	else {
    	
    	print " ".$binex," ";
    	
    	}
   
   
   }
   # no option give, print hex notation
   else {
   
   print " ".$binex," ";
   
   
   }
    
    
    
    }
    # start over with next 16 character set
    $offset = 0;
    print "\n";
    
    
}

