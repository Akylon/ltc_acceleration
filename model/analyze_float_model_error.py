import numpy as np
import matplotlib.pyplot as plt

rel_path = "../scripts/float_model/validation_data/ltc/ltc_rel_error.txt"
abs_path = "../scripts/float_model/validation_data/ltc/ltc_abs_error.txt"
expected_path = "../scripts/float_model/validation_data/ltc/ltc_output_0.txt"
predicted_path = "../scripts/float_model/validation_data/ltc/ltc_cModel_out.txt"

rel_error = np.loadtxt(rel_path)
abs_error = np.loadtxt(abs_path)
expected = np.loadtxt(expected_path)
predicted = np.loadtxt(predicted_path)

relmeans = np.mean(np.abs(rel_error), axis=1)
absmeans = np.mean(np.abs(abs_error), axis=1)

plt.figure()
for i in range(64):
    plt.plot(np.abs(rel_error[i]), label=f"i={i}")


plt.figure()
for i in range(64):
    plt.plot(np.abs(abs_error[i]), label=f"i={i}")


plt.figure()
plt.plot(relmeans)

plt.figure()
plt.plot(absmeans)

plt.figure()
plt.title("rel_error")
plt.hist(rel_error.flatten(), bins=10, density=True)

plt.figure()
plt.title("abs_error")
plt.hist(abs_error.flatten(), bins=10, density=True)

plt.figure()
plt.title("expected")
plt.hist(expected.flatten(), bins=10, density=True)

plt.figure()
plt.title("predicted")
plt.hist(predicted.flatten(), bins=10, density=True)


print(predicted.max())
print(predicted.min())

print(predicted[55, 26])
print(expected[55, 26])
print(rel_error[55, 26])
print(abs_error[55, 26])

plt.show()