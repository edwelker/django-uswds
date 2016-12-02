source pyswitch all;
virtualenv3 venv;
source venv/bin/activate;

./venv/bin/python update.py

deactivate;
