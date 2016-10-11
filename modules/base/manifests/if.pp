class base::if {
		if $::hostname =~ /^node*/ {
			notice("you have arrived at Server $0")
		}
}