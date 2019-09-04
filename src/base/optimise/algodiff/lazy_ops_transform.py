import re


with open('owl_algodiff_ops.ml', 'r') as f:
    s = f.read()
    pattern = 'and ([\w]+) ='
    ops = re.findall(pattern, s)
    print(len(ops))
    for op in ops:
        print(op)


