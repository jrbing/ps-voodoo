VooDoo
===========

VooDoo is a command line application to help automate some PeopleSoft
administration activities that are typically performed locally.

Why?
---- 

PeopleSoft installation and administration is tedious.
Migrating projects, generating compare reports, and running SQR's
locally is a pain.

VooDoo alleviates some of this by providing a simple command line
interface for interacting with your local PeopleTools installation
using predefined settings for each of your environments. For example,
migrating a project between two environments using VooDoo is as simple
as issuing the following command:

    C:\> voodoo migrate TEST_PROJECT HRDEV HRTEST

**Features include:**

* Generate HTML compare reports for projects
* Migrate projects between databases
* Build project definitions
* Archive project to file
* Execute Application Engine programs locally
* Execute SQR's locally


Super. What are the requirements?
---------------------------------

In order to run VooDoo, you'll first need the following:

* Ruby 1.9.2 
* Local installation of PeopleSoft Application Designer, DataMover, SQR, Appengine (developed and tested using 8.49)
* Windows XP or higher (Developed using Windows 7, tested on XP)
* PeopleSoft Environments running on Oracle Database

Ok, done. How do I use it?
--------------------------

VooDoo is packaged as a ruby gem, and can be installed via the following command:  

    C:\> gem install ps-voodoo

Once installed, you'll first need to setup the global configuration:

    C:\>voodoo config

    ### Global Configuration Settings ###
    Local tools directory: C:\psoft\pt84927                    # Set to the root of your tools installation
    Default output directory for migration data: X:\output     # Base directory for output

Next you'll want to add a few environments:

    C:\>voodoo add VDDEV

    ### Appdesigner/Datamover/AppEngine Settings ###
    Database type: |ORACLE| ORACLE             # Default is Oracle; no other databases supported currently
    Application username: VD1                  # Specify the application username for use with Application Designer

    Would you like to archive migration output files for this environment? (y/n) n

    ### SQR Settings ###
    Database username: |sysadm| sysadm         # Username used when running SQR's; default is sysadm
    PS_HOME directory: V:\VDDEV                # Base directory to use when looking for the SQR bin

    C:\>voodoo add VDTEST

    ### Appdesigner/Datamover/AppEngine Settings ###
    Database type: |ORACLE| ORACLE
    Application username: VD1

    Would you like to archive migration output files for this environment? (y/n) y
    Archive destination: X:\archive            # Setting this option allows you to copy migration output from
                                               # the default output directory to an archive directory

    ### SQR Settings ###
    Database username: |sysadm|
    PS_HOME directory: V:\VDTEST

To run a compare report: 

    C:\>voodoo compare COMPARE_TEST VDDEV VDTEST
    Application password for VDDEV: **********
    Application password for VDTEST: **********
    Name for output folder: VOODOO_TEST
    07/18/2011 13:09:54: Creating compare reports for SCRIPTING_TEST between FNDEV and FNSPTB

If successful, the generated HTML output of the compare report will be
opened in your default browser. To see what else you can do, run:

    C:\>voodoo help
      NAME:

        Voodoo

      DESCRIPTION:

        Black Magic Utility for PeopleSoft Administration

      COMMANDS:

        add                  adds an environment to the configuration file
        archive              copies a project to file from the specified environment
        build                builds a project definition in the specified environment
        compare              create a compare report for the specified project
        config               create global configuration settings
        help                 Display global or [command] help documentation.
        list                 Outputs a list of configured environments
        migrate              migrates a project between environments
        remove               removes an environment from the configuration file
        run appengine        runs an appengine against the specified environment
        run sqr              runs the specified sqr locally
        show                 shows configuration details for an environment
        template datafix     creates a datafix folder with template files

      GLOBAL OPTIONS:

        -h, --help
            Display help documentation

        -v, --version
            Display version information

        -t, --trace
            Display backtrace when an error occurs



Sounds too easy.  How does it work?
----------------------------------

It's actually pretty simple. Global and environment configuration data
is stored in YAML files under the .voodoo folder in the user's HOME
directory. When commands are issued to VooDoo, it uses the environment
configuration information to pass command line arguments to the local
executable.

In some situations the Windows registry is updated to set options
that cannot be passed via the command line (project build output
destinations, datamover output destinations).


Who wrote this thing?
---------------------

Original author: JR Bing

License
-------

(The MIT License) 

Copyright (c) 2012 JR Bing

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
