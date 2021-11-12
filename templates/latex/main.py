# =====================================================
# File Name: main.py
# Date of Creation: Mon 08 Nov 2021 10:14:07 PM AEST
# Author: Josiah Tan
# Description: contains all code
#
# =====================================================
# =====================================================

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sympy import symbols, Symbol, Eq, dsolve, sin, cos, tan, sqrt, asin, atan, acos
from sympy import *
%run -n "~/.vim/templates/python/markdown"
%run -n "~/.vim/templates/python/solve"





##

def appendNewLine(file_name, text_to_append):
    """Append given text as a new line at the end of file"""
    # Open the file in append & read mode ('a+')
    with open(file_name, "a+") as file_object:
        # Move read cursor to the start of file.
        file_object.seek(0)
        # If file is not empty then append '\n'
        data = file_object.read(100)
        if len(data) > 0:
            file_object.write("\n")
        # Append text at the end of file
        file_object.write(text_to_append)

def preprocessing(val):
    if type(val) == float:
        val = f"{val:.4f}"
    return val
def export(*cls):
    file_name = "main.dat"
    # just clear out the entire file for writing later
    open(file_name, 'w').close()
    for c in cls:
        for i in [attr for attr in dir(c) if not callable(getattr(c, attr)) and not attr.startswith("__")]:
            appendNewLine(file_name, f"{c.__qualname__}_{i} = {preprocessing(c.__dict__[i])}")


##


class TestWriting:
    a = "hello"
    b = "bye"

##

class HelloWorld:
    a = 98.237432 * 2
    b = 2389

    c = a * b * 2
    print(f"c  = {c }")


##


#make sure that the console is in the same directory
export(TestWriting, HelloWorld)
