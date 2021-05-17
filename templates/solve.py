# =====================================================
#
# File Name: solve.py
# Date of Creation: Sat 15 May 2021 20:05:05
# Author: Josiah Tan
# Description: This python script is used to solve systems of linear equations
# https://stackoverflow.com/questions/58878594/solving-simultaneous-equations-with-python
# =====================================================
# =====================================================


from sympy import Eq, solve
from sympy.parsing.sympy_parser import parse_expr, standard_transformations, implicit_multiplication_application

def sv(eqs, exact = False):
    # if the eqs passed in is comma separated then split into list by the commas
    if type(eqs) == str:
        eqs =  eqs.split(",");

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

    i = '1/(RC) = 5000, 1/(CL) = 4*10**6,L=10*10**-3'
    #C: 400000000.000000}, {L: 0.0100000000000000}, {R: 80000.0000000000}]
    print(f"sv(i) = {sv(i)}");
