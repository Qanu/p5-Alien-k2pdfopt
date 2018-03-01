use Test::More;

use strict;
use warnings;
use File::Basename;
use File::Spec;
use Cwd 'abs_path';

use Test::Needs qw(Inline::C);

use_ok('Alien::k2pdfopt');

Inline->import( with => qw(Alien::k2pdfopt) );

subtest 'Retrieve a constant' => sub {
	Inline->bind( C => q|
		char *
		usage() {

			size_t len = k2usage_len();
			char* usage_str = malloc(sizeof(char) * (len + 1));
			k2usage_to_string(usage_str);

			return usage_str;
		}
	|, ENABLE => AUTOWRAP => );

	like( usage(), qr/^usage:  k2pdfopt/);
};

done_testing;
