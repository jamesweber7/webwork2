package WeBWorK::ContentGenerator::ProblemSets;
our @ISA = qw(WeBWorK::ContentGenerator);

use strict;
use warnings;
use WeBWorK::ContentGenerator;
use WeBWorK::DB::WW;
use Apache::Constants qw(:common);
use CGI qw(-compile :html :form);

sub initialize {
	my $self = shift;
	my $courseEnvironment = $self->{courseEnvironment};
	
	# Open a database connection that we can use for the rest of
	# the content generation.
	
	my $wwdb = new WeBWorK::DB::WW $courseEnvironment;
	$self->{wwdb} = $wwdb;
}

sub title {
	my $self = shift;
	my $r = $self->{r};
	my $courseEnvironment = $self->{courseEnvironment};
	my $user = $r->param('user');

	return "Problem Sets for $user";
}

sub body {
	my $self = shift;
	my $r = $self->{r};
	my $courseEnvironment = $self->{courseEnvironment};
	my $user = $r->param('user');
	my $wwdb = $self->{wwdb};
	
	if (!defined $wwdb->getSets($user)) {
		print "undefined".br;
	}
	
	my @setNames = $wwdb->getSets($user);
	
	print "Set Names<br>\n";
	print join(br."\n", @setNames);
	print p;
	
	print startform({-method=>"POST", -action=>$r->uri."set0/"});
	print $self->hidden_authen_fields;
	print input({-type=>"submit", -value=>"Do Set 0"});
	print endform;
	"";
}

1;
