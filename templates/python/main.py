file_number = 1
part_1 = True
# from personal import Point, sign
# import numpy as np
with open(f'{file_number}.txt') as f:
    entries = f.read().rstrip().split('\n')
print(f"entries = {entries}")
