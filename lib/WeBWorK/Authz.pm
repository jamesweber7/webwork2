package WeBWorK::Authz;

use strict;
use warnings;

use WeBWorK::DB::Auth;

sub new($$$) {
	my $invocant = shift;
	my $class = ref($invocant) || $invocant;
	my $self = {};
	($self->{r}, $self->{courseEnvironment}) = @_;
	bless $self, $class;
	return $self;
}

sub hasPermissions {
	my ($self, $user, $activity) = @_;
	my $r = $self->{r};
	my $courseEnvironment = $self->{courseEnvironment};
	my $permission_hash = $courseEnvironment->{permission_hash};
	my $auth = WeBWorK::DB::Auth->new($courseEnvironment);
	
	my $permissionLevel = $auth->getPermissions($user);
	if ($permissionLevel >= $permission_hash->{$activity}) {
		return 1;
	} else {return 0;}
}

1;
