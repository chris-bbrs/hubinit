# hubinit

A simple shell script to automate the procedure of manually creating a github repository to push your local one

## Running

You need [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [expect](http://expect.sourceforge.net/)

Navigate to script's directory and execute with:
```bash
bash hubinit
```
Or use a folder in PATH
```bash
$PATH
```
and execute it as a command
```bash
hubinit
```

## Usage

Navigate to your local repository and run the script
e.g.
```bash
cd ~/myProject
bash ~/hubinit
```
<pre>
Options:  
  -d 'description'          Add repository description  
  -n 'repository_name       Repository name, default = current folder  
  -r 'remote_name'          Remote name, default = origin  
  -s                        In case of SSH (currently doesn't work)  
  -i 'commit_description'   Initialize current folder, add everything and commit 
</pre>
By running hubinit without any flags you need an already initialized local repository you are working with. Then hubinit creates a github repository with current folder's name and pushes everything to an origin remote linked to this repository.