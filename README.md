medjool_bumper
==============

Simple. mBump your versions.

What is it for?
---------------
For the Jetson Project (for Apprisen), we want to use dates to help distinguish our version numbers. We use the following
versioning format (major, minor, revision, build), but we are swapping out the minor and the revision for the following:
minor => yyyy
revision => mmdd

The rules are simple:
-Whenever a major or build number is bumped, we check the date of the current version and update it to the current date.
-If the build number is getting bumped and minor-revision is out of date, then the date is updated and the build => 1.
-If the major is getting bumped, we update the date and reset the build => 0.
-There is never a need to bump the minor or revision - just bump the build and let it automagically be set for you.

Also, since version_bumper already is using "bump" for its invocation, we'll use mbump so you can have version_bumper
installed as well for use on other projects.

Quick start
-----------
You can use bundler to install from the Git project:

    $ gem "medjool_bumper", :git => "git://github.com/sunergeos/medjool_bumper.git"

In your `Rakefile` `require 'medjool_bumper'` and you're done.
  
    $ rake -T
    rake mbump:build     # bump build
    rake mbump:init      # write initial dated version of 0.yyyymm.dd.0
    rake mbump:major     # bump major

    $ rake mbump:init
    version: 0.201112.15.0
    $ rake mbump:build
    version: 0.201112.15.1
    $ rake mbump:major
    version: 1.201112.15.0

You can optionally use `bumper_file 'version.txt'` in your rake file to switch from the default `VERSION` file name.
Use `bumper_medjool` anywhere you need access to the current version in your rake script.

Committers
---------
sunergeos (Danny Johnson)

Copyright
---------
Copyright (c) 2011 Danny Johnson. See LICENSE.txt for further details.

[1]: http://semver.org
