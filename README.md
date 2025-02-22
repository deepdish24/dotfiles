# How to install

# Installing VIM
Copy vimrc within vim/ directory into ~/.vimrc and open any file in vim

# Installing ZSH plugins
first create python3 virtual env via running
```
python3 -m venv myenv
```
Activate virtualenv by running
```
source myenv/bin/activate
```

Then once you are in the virtualenv, run the following commands
```
pip install dotbot
dotbot -c install.conf.yaml
```
