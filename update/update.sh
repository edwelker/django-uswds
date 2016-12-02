source pyswitch all;
virtualenv3 venv;
source venv/bin/activate;
pip install -r update-req.txt

./venv/bin/python update.py

deactivate;
