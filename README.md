# My Git-Repositories for Bash (mr4b) ##

*mr4b* is a command line utility to perform mass operations on [Git](https://git-scm.com/) repositories on the local machine. 
It is just a collection of Bash scripts and therefore should run on most Linux(-like) environments. 

In contrast to many competiting solutions for performing mass operations on Git repositories *mr4b* does
not required a special scripting language like Python or Perl and therefore should also run on most
restricted or "emulated" Linux environments with the Bash shell and Git.
For example, it runs in [Cygwin](https://www.cygwin.com/) or [MinGW](http://www.mingw.org/) on Windows
and also on MacOS.

<br>

After installation you can enter `mb4r help` to obtain usage hints.

<br>

*mr4b* was inspired by [myrepos](https://myrepos.branchable.com/).

<br>


## Installation ##

The `PATH` variable mentioned in this sections means the environment variable `PATH`
of your Linux environment.

* **Option 1:**
  Clone or download the repository and add the `bin/` folder of the repository to the `PATH` variable. 
  Example: `export PATH=$PATH:/home/bob/mr4b/bin`    

* **Option 2:**
  Clone or download the repository and copy the contents of its `bin/` folder
  to a folder which is already in your `PATH` variable, e.g. `/usr/bin/`. 
  The subfolder `mr4b_includes` has also to be copied.
  For the example of `/usr/bin/` this would mean `/usr/bin/mr4b` and
   `/usr/bin/mr4b/mr4b_includes/...`


## Basic usage ##

Go to a folder which is the root folder (working directory) of a Git repository and register it:

    cd ~/Project_A/GitRepo123
    mr4b register
    
After this you can register a further folder:

    cd ~/Project_B/active/GitRepoABC
    mr4b register

<br>

It is also possible to register all Git repository folders that are below the current folder. Let's assume you have the following folder structure:

    /abc/GitRepo-1
    /abc/def/ProjectA/GitRepo-2
    /abc/def/ProjectA/GitRepo-3
    /xyz/GitRepo-4
    
Now go into folder `/abc` and call `registerResursively`:

    cd /abc
    mr4b registerResursively
    
The result will be that `GitRepo-1`, `GitRep-2` and `GitRepo-3` are registered, but not `GitRepo-4`.

<br>    

If at least one repository folder is registered, then you can execute one of the supported Git commands on all the registered Git repository folders 
with just one command. 
For example, to get the Git status information on all registered repositories:

    mr4b status

You can also perform `git pull` for all registered repos with one command:

    mr4b pull

    
