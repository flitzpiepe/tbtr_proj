#!/usr/bin/perl -w

#
# author:
# created:
# version:
#
# Split a patch file into multiple files, one for each file contained in the combined (input) patch
#

use strict;
use warnings;

# autoflush ON
$|=101010;

sub check_params
{
	my ($patch_file) = @_;

	die "Bad input file" unless defined $patch_file and -f $patch_file;
}

sub get_params
{
	my $patch_file = shift @ARGV;

	check_params($patch_file);

	return ($patch_file);
}

sub read_next_filename
{
	my $filehandle = shift;

	while (<$filehandle>)
	{
		if (/^Index: (.*)\s*$/)
		{
			return $1;
		}
	}
}

sub split_single_file
{
	my ($fh, $fn, $oh) = @_;

	print "Splitting for file $fn\n";

	while (<$fh>)
	{
		return $_ if /^Index:/;
		#print $_;
		print $oh $_;
	}
}

sub split_patchfile
{
	my ($patch_file) = @_;

	# prepare input file handle
	open my $fh, $patch_file or die "Could not read file $patch_file"; 

	# read the initial file name
	my $fn = read_next_filename($fh);
	$fn =~ s|.*/||;
	$fn =~ s/\s*$//;

	# output file handle
	my $oh;
	my $on = '__'.$fn.'.patch';
	open $oh, '>', $on or die "Could not write to $on: $!";

	# write lines from the current input handle into the current output handle
	# when a line /^Index:/ is found, switch the output handle
	while (1)
	{
		# when discovering a line /^Index:/, it will return the listed filename
		# or else it will return an empty string
		$fn = split_single_file($fh, $fn, $oh);

		# continue, if we read another file name
		if (defined $fn and $fn =~ /Index: (.*)\s*$/)
		{
			$fn =~ s|.*/||;
			$fn =~ s/\s*$//;
			# switch output handle
			close $oh;
			$on = '__'.$fn.'.patch';
			open $oh, '>', $on or die "Could not write to $on: $!";
		}
		else
		{
			last;
		}
	}

	close $oh;
	close $fh;
}

sub main
{
	my ($patch_file) = get_params();

	eval
	{
		split_patchfile($patch_file);
		1;
	}
	or do
	{
		print "Something went wrong:\n$@";
	};
}

main();

