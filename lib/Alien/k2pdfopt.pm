package Alien::k2pdfopt;

use strict;
use warnings;

use parent qw(Alien::Base);
use File::Spec;

=method k2view_path

Returns a C<Str> which contains the absolute path
to the C<k2view> binary.

=cut
sub k2view_path {
	my ($self) = @_;
	File::Spec->catfile( File::Spec->rel2abs($self->dist_dir) , 'bin', 'k2view' );
}

sub inline_auto_include {
	return  [ 'k2pdfopt.h' ];
}

sub Inline {
	my ($self, $lang) = @_;

	if('C') {
		my $params = Alien::Base::Inline(@_);
		$params->{MYEXTLIB} .= ' ' .
			join( " ",
				map { File::Spec->catfile(
					File::Spec->rel2abs(Alien::k2pdfopt->dist_dir),
					'lib',  $_ ) }
				qw(libk2pdfopt.a libwillus.a)
			);

		return $params;
	}
}

1;

__END__
# ABSTRACT: Alien package for the k2pdfopt PDF editing library

=head1 Inline support

This module supports L<Inline's with functionality|Inline/"Playing 'with' Others">.

=head1 SEE ALSO

L<k2pdfopt|http://www.willus.com/k2pdfopt/>

L<Repository information|http://project-renard.github.io/doc/development/repo/p5-Alien-k2pdfopt/>
