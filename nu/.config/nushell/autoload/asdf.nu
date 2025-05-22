#!/usr/bin/env nu

const asdf_packages = [
  [ machine_name,   plugin,   version];
  
	[ "WKMZTAFD6544", "java",   "corretto-21.0.7.6.1"]
	[ "WKMZTAFD6544", "java",   "corretto-21.0.7.6.1"]
	[ "WKMZTAFD6544", "java",   "corretto-21.0.7.6.1"]
	[ "WKMZTAFD6544", "maven",  "3.9.9"]
	[ "WKMZTAFD6544", "scala",  "2.12.18"]
	[ "WKMZTAFD6544", "nodejs", "20.19.1"]
	[ "WKMZTAFD6544", "awscli", "2.27.0"]
]

def asdf-sync [packages = $asdf_packages] {
  if (which asdf | length) > 0 {
    section $"Syncing ASDF"
    cd $env.HOME
    $asdf_packages
    | par-each --keep-order {|pkg|
    	asdf plugin add $pkg.plugin $pkg.version
    	asdf install $pkg.plugin $pkg.version
    	asdf set $pkg.plugin $pkg.version 
    }
  }
}
