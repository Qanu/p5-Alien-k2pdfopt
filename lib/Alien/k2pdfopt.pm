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

sub cflags {
	return "-I" . File::Spec->catfile( Alien::k2pdfopt->dist_dir, 'include' );
}

sub libs {
	return "-L" . File::Spec->catfile( Alien::k2pdfopt->dist_dir, 'lib' );
	#" -lk2pdfopt -lwillus";
}

sub inline_auto_include {
	return  [ 'k2pdfopt.h' ];
}

sub Inline {
	my ($self, $lang) = @_;

	if( $lang eq 'C' ) {
		my $params = Alien::Base::Inline(@_);
		$params->{MYEXTLIB} .= ' ' .
			join( " ",
				map { File::Spec->catfile(
					File::Spec->rel2abs(Alien::k2pdfopt->dist_dir),
					'lib',  $_ ) }
				qw(libk2pdfopt.a libwillus.a)
			);
		$params->{AUTO_INCLUDE} = <<'		EOF' . $params->{AUTO_INCLUDE};
		/* undef macros from Perl headers that conflict with willus.h */
		#undef utf8_length
		#undef utf16_to_utf8
		EOF

		return $params;
	}
}

1;

__END__
# ABSTRACT: Alien package for the k2pdfopt PDF editing library

=head1 Inline support

This module supports L<Inline's with functionality|Inline/"Playing 'with' Others">.

=head1 K2PDFOPT LICENSE

C<k2pdfopt> is licensed under the GNU Affero General Public License version 3
or later.

=head1 SEE ALSO

L<k2pdfopt|http://www.willus.com/k2pdfopt/>


