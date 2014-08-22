#puppet-bugzilla

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What bugzilla affects](#what-bugzilla-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with bugzilla](#beginning-with-bugzilla)
4. [Usage](#usage)
5. [Limitations](#limitations)
6. [TODOs](#todos)

##Overview

This small bugzilla module installs and configures bugzilla.

Bugzilla is taken from the bugzilla Website!

##Module Description

See [Overview](#overview) for now.

##Setup

###What bugzilla affects

* Installs bugzilla.
* Optionally installs dependencies.

###Setup Requirements

Nothing.
	
###Beginning with bugzilla	

Simply include it.

##Usage

Just include the module by 

```puppet
include bugzilla
```

##Limitations:

Tested only on 
* Debian 7
so far.

Can only configure Bugzilla initially (as log 'data/params' does not exists')!

-> Template 'localconfig.erb' cannot inlcude comments (like 'Managed by puppet.').

##TODOs:

* Make it work on RedHat like systems.
* Make mare configurable.
* ... suggestions? Open an issue on github...
