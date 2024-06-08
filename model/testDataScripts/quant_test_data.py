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
        a = correction
        b = 1
        sout = sb
    else:
        a = 1
        b = 1/correction
        sout = sw*sI
    res_hat = a*What@I + b*Bhat
    correction = 1/get_scale(resolution, np.abs(res_hat).max())  # use inverse because input is in quant world
    sout /= correction
    res_hat *= correction
    return res_hat, sout, correction, a, b

# prepare cases
cases = {}

W = np.array([[-1, -2, -3],
              [1, 2, 3]])
B = np.array([[4],
              [-8]])
I = np.array([[1],
              [1],
              [-1/4]])
sI = 2**-6
cases["state"] = [W, B, I, sI]

# -------------------------------------------------------------------

W = np.array([[1, 2, 3],
              [-1, -2, -3]])
B = np.array([[4],
              [-1]])
I = np.array([[-3],
              [2],
              [1]])
sI = 2**-5
cases["sig"] = [W, B, I, sI]

# -------------------------------------------------------------------

W = np.array([[1, -3],
              [0.125, -0.125],
              [-1, 11]])
B = np.array([[-1],
              [-0.5],
              [1]])
I = np.array([[9.75],
              [0]])
sI = 2**-3
cases["ff1"] = [W, B, I, sI]

# -------------------------------------------------------------------

W = np.array([[0.0625, -0.25],
              [0.125, -0.125],
              [-0.25, -0.5]])
B = np.array([[-0.125],
              [0.25],
              [0.125]])
I = np.array([[9.75],
              [0]])
sI = 2**-3
cases["ff2"] = [W, B, I, sI]

# -------------------------------------------------------------------

W = np.array([[-1/2, -1/16],
              [1/4, 1/32],
              [1/8, -1/4]])
B = np.array([[32],
              [-64],
              [0]])
I = np.array([[9.75],
              [0]])
sI = 2**-3
cases["ta"] = [W, B, I, sI]

# -------------------------------------------------------------------

W = np.array([[32, -1/2],
              [16, -1],
              [8, 8]])
B = np.array([[-800],
              [-400],
              [-256]])
I = np.array([[9.75],
              [0]])
sI = 2**-3
cases["tb"] = [W, B, I, sI]


# -------------------------------------------------------------------
resolution = 8
case = "ta"

# select case
print(f"Current case is {case}\n")
W, B, I, sI = cases[case]


sw = get_scale(resolution, np.abs(W).max())
shift_w = scale_to_shift(sw)
What = W/sw
print(f"*********************")
print(f"W = {W}")
print(f"What = {What}")
print(f"sw = {sw}")
print(f"shift_w = {shift_w}")
print()



sb = get_scale(resolution, np.abs(B).max())
shift_b = scale_to_shift(sb)
Bhat = B/sb
print(f"*********************")
print(f"B = {B}")
print(f"Bhat = {Bhat}")
print(f"sb = {sb}")
print(f"shift_b = {shift_b}")
print()


shift_I = scale_to_shift(sI)
Ihat = I/sI
res = W@I+B
print(f"*********************")
print(f"I = {I}")
print(f"Ihat = {Ihat}")
print(f"sI = {sI}")
print(f"shift_I = {shift_I}")
print()

res_hat, sout, correction, a, b = calculate_quant_system(resolution, What, Bhat, Ihat, sw, sb, sI)
shift_sout = scale_to_shift(sout)
shift_correction = scale_to_shift(correction)
print(f"*********************")
print(f"W*I+B= {res}")
print(f"(a*What*Ihat + b*Bhat)*correction= {res_hat}")
print(f"sout*outHat = {res_hat*sout}")
print(f"sout = {sout}")
print(f"correction = {correction}")
print(f"shift_sout = {shift_sout}")
print(f"shift_correction = {shift_correction}")
print(f"a_shift = {scale_to_shift(a)}")
print(f"b_shift = {scale_to_shift(b)}")
print()

if np.all(res == res_hat*sout):
    print("it worked")
else:
    print("it failed")

print(f"Current case is {case}\n")