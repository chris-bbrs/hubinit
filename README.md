# hubinit

A simple shell script to automate the procedure of manually creating a github repository to push your local one

## Running

You need git and expect

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
Options:  
  -d Add description  
  -n Repository name, default=current folder  
  -r remote name, default=origin  
  -t Token authentication  
  -s In case of SSH (currently doesn't work)  
