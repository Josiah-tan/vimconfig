# =====================================================
#
# File Name: solve.py
# Date of Creation: Sat 15 May 2021 20:05:05
# Author: Josiah Tan
# Description: This python script is used to solve systems of linear equations
# https://stackoverflow.com/questions/58878594/solving-simultaneous-equations-with-python
# =====================================================
# =====================================================


from sympy import Eq, solve, pi, integrate, symbols, simplify, inverse_laplace_transform, laplace_transform
from sympy.parsing.sympy_parser import parse_expr, standard_transformations, implicit_multiplication_application
import numpy as np

def sv(eqs, exact = False):
    # if the eqs passed in is comma separated then split into list by the commas
    if type(eqs) == str:
        eqs =  eqs.split(",");

    # adding an =0, in case we forget to put it in
    eqs = [eq if ("=" in eq) else eq + '= 0' for eq in eqs];


    # fancy math stuff from stack overflow
    transformations=(standard_transformations + (implicit_multiplication_application,))
    eqs_sympy = [Eq(parse_expr(e.split('=')[0], transformations=transformations),
                    parse_expr(e.split('=')[1], transformations=transformations))
                 for e in eqs]
    sol = solve(eqs_sympy)

    # figuring out what to do with whether we want the exact value or the estimated value
    if not exact:
        if type(sol) == dict:
            sol = [sol];
        sol = [[{s:ss[s].evalf()} for s in ss] for ss in sol];

    return sol;

def P2R(radii, angles, deg = False):
    #polar to rectangular coordinates
    return radii * np.exp(1j*angles * (1 + deg * (np.pi / 180 - 1)))

def R2P(x, deg = False):
    #rectangular to polar coordinates
    return abs(x), np.angle(x, deg)

def L(f):
    # laplace transform of a function (t)
    t, s = symbols("t s")
    return laplace_transform(f, t, s, noconds=True)

def invL(F):
    # inverse laplace transform of a function (s)
    t, s = symbols("t s")
    return inverse_laplace_transform(F, s, t)


def ll(*args):
    return 1/sum(1/i for i in args);

if __name__ == '__main__':
    #eqs = 'x + y = 4, x + 2y = 5'
    #eqs1 = ['2w + x + 4y + 3z = 5x + 5y', 'w - 2x + 3z = 3x + 5y + 5x**2/5', '3w + 2x - y + z = -1', '4x - 5z = -3']
    #eqs2 = '2w + x + 4y + 3z = 5x + 5y, w - 2x + 3z = 3x + 5y + 5x**2/5, 3w + 2x - y + z = -1, 4x - 5z = -3'
    #eqs3 = "y ** 2 = x, y**2 - x**2 = -12"
    #eqs4 = "a_b + c_d = 2, c_d * 2 + a_b = 5"
    #eqs5 = "-3.4386 = 1.1462v_g1 + 0.1338x, -4.5846 = 1.5282v_g1 + 0.0764y, v_g1 = 0.15x + 0.2y"

    #print(f"sv(eqs) = {sv(eqs)}");
    #print(f"sv(eqs1, False) = {sv(eqs1, False)}");
    #print(f"sv(eqs2, True) = {sv(eqs2, True)}");
    #print(f"sv(eqs3, True) = {sv(eqs3, True)}");
    #print(f"sv(eqs3, False) = {sv(eqs3, False)}");
    #print(f"sv(eqs4) = {sv(eqs4)}");
    
    R1, R2, L, C = 1, 4, 1/2, 1/8;
    v_cp = 20 * R2/(R1 + R2);
    print(f"v_cp = {v_cp}");

    v = f'v ** 2 + {1/(R2 * C) + R1 /L} * v + {(R1 + R2)/(L * C * R2)}'
    print(f"v = {v}");
    print(f"sv(v) = {sv(v)}");

    print(f"sv('cos(x) = 5') = {sv('cos(x) = 1')}");
    print(f"sv('theta ** 2 + theta  = 4') = {sv('theta ** 2 + theta  = 4')}");
    print(f"sv('x = conjugate(1+4j)') = {sv('x = conjugate(1+4j)')}");
    print(f"sv('x = re(1 + 5j) + im(1+ 5j)') = {sv('x = re(1 + 5j) + im(1+ 5j)')}");
    
    print(f"sv('conjugate(x) + 1 + 2j') = {sv('conjugate(x) + 1 + 2j')}");
    print(f"sv('x = sin(x)') = {sv('x = sin(x)')}");
    



