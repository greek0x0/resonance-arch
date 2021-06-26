import os

path = '/home/usr/'

y_n = str(os.path.exists(path))

if y_n == "True":
    os.system("mpc play")
else:
    print(y_n)

