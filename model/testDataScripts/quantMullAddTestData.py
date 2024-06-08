import numpy as np

def get_scale(bitwidth: int, absMax: float):
    quant_max = 2**(bitwidth-1)-1
    factor = 2.0**(-1*np.floor(np.log2(quant_max/absMax)))
    return factor

def scale_to_shift(scale: float):
    return np.log2(scale)

def calculate_quant_system(resolution, What, Bhat, I, sw, sb, sI):
    correction = sw*sI/sb
    if correction > 1:
        print("swsi>sb")
        a = correction
        b = 1
        sout = sb
    else:
        print("swsi<sb")
        print(f"n>log(sb/(sw*si): {n>np.log2(sb/(sw*si))}")
        a = 1
        b = 1/correction
        sout = sw*sI
    res_hat = a*What@I + b*Bhat
    correction = 1/get_scale(resolution, np.abs(res_hat).max())  # use inverse because input is in quant world
    sout /= correction
    res_hat *= correction
    return res_hat, sout, correction, a, b

n = 8


sw = 2**0
si = 2**0
sb = 2**0

IHATs = [2**(n-1)-1, -2**(n-1)+1]
WHATs = [2**(n-1)-1, 2**(n-1)-1]
BHATs = [2**(n-1)-1, -2**(n-1)+1]

Is = [x*si for x in IHATs]
Ws = [x*sw for x in WHATs]
Bs = [x*sb for x in BHATs]

print(f"Is = {Is}")
print(f"Ws = {Ws}")
print(f"Bs = {Bs}")

for W, B, I in zip(Ws, Bs, Is):
    print(f"*********************")
    res_hat, sout, correction, a, b = calculate_quant_system(n, np.array([W/sw]), np.array([B/sb]), np.array([I/si]), sw, sb, si)
    print()

    shift_sout = scale_to_shift(sout)
    shift_correction = scale_to_shift(correction)

    res = W*I+B


    print(f"W*I+B= {res}")
    print(f"(a*What*Ihat + b*Bhat)*correction= {res_hat}")
    print(f"sout*outHat = {res_hat * sout}")
    print(f"sout = {sout}")
    print(f"correction = {correction}")
    print(f"shift_sout = {shift_sout}")
    print(f"shift_correction = {shift_correction}")
    print(f"a_shift = {scale_to_shift(a)}")
    print(f"b_shift = {scale_to_shift(b)}")
    print()

    aproxOut = res_hat * sout
    dif = np.abs(res - res_hat * sout)/res
    print(f"dif = {dif}")
    if np.all(dif <= 1e-6):
        print("it worked")
    else:
        print("it failed")