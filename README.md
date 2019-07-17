# My Git-Repositories for Bash (mr4b) ##

*mr4b* is a command line utility to perform mass operations on [Git](https://git-scm.com/) repositories on the local machine. 
It is just a collection of Bash scripts and therefore should run on most Linux(-like) environments. 

In contrast to many competiting solutions for performing mass operations on Git repositories *mr4b* does
not required a special scripting language like Python or Perl and therefore should also run on most
restricted or "emulated" Linux environments with the Bash shell and Git.
For example, it runs in [Cygwin](https://www.cygwin.com/) or [MinGW](http://www.mingw.org/) on Windows
and also on MacOS.

<br>

mr4b was inspired by [myrepos](https://myrepos.branchable.com/).

<br>


## Installation ##

The `PATH` variable mentioned in this sections means the environment variable `PATH`
of your Linux environment.

* **Option 1:**
  Clone or download the repository and add the `bin/` folder of the repository to the `PATH` variable. Example: `export PATH=$PATH:/home/bob/mr4b/bin`    

* **Option 2:**
  Clone or download the repository and copy the contents of its `bin/` folder
  to a folder which is already in your `PATH` variable, e.g. `/usr/bin/`. 
  The subfolder `mr4b_includes` has also to be copied.
  For the example of `/usr/bin/` this would mean `/usr/bin/mr4b` and
   `/usr/bin/mr4b/mr4b_includes/...`
