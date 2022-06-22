#!/usr/bin/perl
# -*- cperl -*-
#
# Copyright (c) 2007, 2017, Oracle and/or its affiliates. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License, version 2.0,
# as published by the Free Software Foundation.
#
# This program is also distributed with certain software (including
# but not limited to OpenSSL) that is licensed under separate terms,
# as designated in a particular file or component or in included license
# documentation.  The authors of MySQL hereby grant you an additional
# permission to link the program and your derivative works with the
# separately licensed software that they have included with MySQL.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License, version 2.0, for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA

##############################################################################
#
#  This script reports various configuration settings that may be needed
#  when using the MySQL client library.
#
#  This script try to match the shell script version as close as possible,
#  but in addition being compatible with ActiveState Perl on Windows.
#
#  All unrecognized arguments to this script are passed to mysqld.
#
#  NOTE: This script will only be used on Windows until solved how to
#        handle  and other strings inserted that might contain
#        several arguments, possibly with spaces in them.
#
#  NOTE: This script was deliberately written to be as close to the shell
#        script as possible, to make the maintenance of both in parallel
#        easier.
#
##############################################################################

use File::Basename;
use Getopt::Long;
use Cwd;
use strict;

my $cwd = cwd();
my $basedir;

my $socket  = '/tmp/mysql.sock';
my $version = '8.0.17';

sub which
{
  my $file = shift;

  my $IFS = $^O eq "MSWin32" ? ";" : ":";

  foreach my $dir ( split($IFS, $ENV{PATH}) )
  {
    if ( -f "$dir/$file" or -f "$dir/$file.exe" )
    {
      return "$dir/$file";
    }
  }
  print STDERR "which: no $file in ($ENV{PATH})\n";
  exit 1;
}

# ----------------------------------------------------------------------
# If we can find the given directory relatively to where mysql_config is
# we should use this instead of the incompiled one.
# This is to ensure that this script also works with the binary MySQL
# version
# ----------------------------------------------------------------------

sub fix_path
{
  my $default = shift;
  my @dirs = @_;

  foreach my $dirname ( @dirs )
  {
    my $path = "$basedir/$dirname";
    if ( -d $path )
    {
      return $path;
    }
  }
  return $default;
}

sub get_full_path
{
  my $file = shift;

  # if the file is a symlink, try to resolve it
  if ( $^O ne "MSWin32" and -l $file )
  {
    $file = readlink($file);
  }

  if ( $file =~ m,^/, )
  {
    # Do nothing, absolute path
  }
  elsif ( $file =~ m,/, )
  {
    # Make absolute, and remove "/./" in path
    $file = "$cwd/$file";
    $file =~ s,/\./,/,g;
  }
  else
  {
    # Find in PATH
    $file = which($file);
  }

  return $file;
}

##############################################################################
#
#  Form a command line that can handle spaces in paths and arguments
#
##############################################################################

sub quote_options {
  my @cmd;
  foreach my $opt ( @_ )
  {
    next unless $opt;           # If undefined or empty, just skip
    push(@cmd, "\"$opt\"");       # Quote argument
  }
  return join(" ", @cmd);
}

##############################################################################
#
#  Main program
#
##############################################################################

my $me = get_full_path($0);
$basedir = dirname(dirname($me)); # Remove "/bin/mysql_config" part

my $ldata   = 'C:/Program Files/MySQL/MySQL Server 8.0/data';
my $execdir = 'C:/Program Files/MySQL/bin';
my $bindir  = 'C:/Program Files/MySQL/bin';

# ----------------------------------------------------------------------
# If installed, search for the compiled in directory first (might be "lib64")
# ----------------------------------------------------------------------

my $pkglibdir = fix_path('C:/Program Files/MySQL/lib',"libmysql/relwithdebinfo",
                         "libmysql/release","libmysql/debug","lib/mysql","lib");

my $pkgincludedir = fix_path('C:/Program Files/MySQL/include', "include/mysql", "include");

# Assume no argument with space in it
my @ldflags = split(" ",'');

my $port;
if ( '0' == 0 ) {
  $port = 0;
} else {
  $port = '3306';
}

# ----------------------------------------------------------------------
# Create options 
# ----------------------------------------------------------------------

my(@lib_opts,@lib_e_opts);
if ( $^O eq "MSWin32" )
{
  my $linkpath   = "$pkglibdir";
  @lib_opts   = ("$linkpath/LIBMYSQL_OS_OUTPUT_NAME-NOTFOUND");
  @lib_e_opts = ("$linkpath/");
}
else
{
  my $linkpath   = "-L$pkglibdir";
  @lib_opts   = ($linkpath,"-lLIBMYSQL_OS_OUTPUT_NAME-NOTFOUND");
  @lib_e_opts = ($linkpath,"-l");
}


my $flags;
$flags->{libs} = [@lib_opts, qw(ws2_32 G:/ade/build/sb_0-34785539-1561575937.3/dep3/lib/ssleay32.lib G:/ade/build/sb_0-34785539-1561575937.3/dep3/lib/libeay32.lib crypt32 Secur32)];

$flags->{include} = ["-I$pkgincludedir"];
$flags->{cflags}  = [@{$flags->{include}},split(" ",'')];
$flags->{cxxflags}= [@{$flags->{include}},split(" ",'')];

my $include =       quote_options(@{$flags->{include}});
my $cflags  =       quote_options(@{$flags->{cflags}});
my $cxxflags=       quote_options(@{$flags->{cxxflags}});
my $libs    =       quote_options(@{$flags->{libs}});

##############################################################################
#
#  Usage information, output if no option is given
#
##############################################################################

sub usage
{
  print <<EOF;
Usage: $0 [OPTIONS]
Options:
        --cflags         [$cflags]
        --cxxflags       [$cxxflags]
        --include        [$include]
        --libs           [$libs]
        --libs_r         [$libs]
        --socket         [$socket]
        --port           [$port]
        --version        [$version]
EOF
  exit 1;
}

@ARGV or usage();

##############################################################################
#
#  Get options and output the values
#
##############################################################################

GetOptions(
           "cflags"  => sub { print "$cflags\n" },
           "cxxflags"=> sub { print "$cxxflags\n" },
           "include" => sub { print "$include\n" },
           "libs"    => sub { print "$libs\n" },
           "libs_r"  => sub { print "$libs\n" },
           "socket"  => sub { print "$socket\n" },
           "port"    => sub { print "$port\n" },
           "version" => sub { print "$version\n" },
           ) or usage();

exit 0
