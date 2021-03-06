package Iodef::Pb::Format::Bindzone;
use base 'Iodef::Pb::Format';

use strict;
use warnings;

use constant DEFAULT_OUTPUT => '/etc/namedb/';

sub write_out {
    my $self = shift;
    my $args = shift;
   
    my $array = $self->SUPER::to_keypair($args);
    return '' unless(exists(@{$array}[0]->{'address'}));
    
    my $config = $args->{'config'};
    
    my @config_search_path = ('claoverride', $args->{'query'}, 'client' );
    my $cfg_bindzone_path = $args->{'bindzone_path'} || $self->confor($config, \@config_search_path, 'bindzone_path', DEFAULT_OUTPUT());
    
    my $text = '// generated by: '.$0." at ".time()."\n";
    foreach (@$array){
        $text .= 'zone "'.$_->{'address'}.'" {type master; file "'.$cfg_bindzone_path.'";};'."\n";
    }
    return $text;
    
}
1;
