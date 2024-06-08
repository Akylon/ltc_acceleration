import numpy as np
import matplotlib.pyplot as plt

referencePath = "../../scripts/float_model/validation_data/ltc/ltc_output_0.txt"
modelPath = "../../scripts/float_model/validation_data/ltc/ltc_cModel_out.txt"
absErrorPath = "../../scripts/float_model/validation_data/ltc/ltc_abs_error.txt"
relErrorPath = "../../scripts/float_model/validation_data/ltc/ltc_rel_error.txt"

referenceData = np.loadtxt(referencePath)
modelData = np.loadtxt(modelPath)
absError = np.loadtxt(absErrorPath)
relError = np.loadtxt(relErrorPath)


error = np.abs(referenceData-modelData)
rError = np.abs(referenceData-modelData)/np.abs(referenceData)

plt.figure()
mean = error.mean(axis=1)
maximum = error.max(axis=1)
minimum = error.min(axis=1)

plt.plot(mean, label="mean")
plt.plot(maximum, label="max")
plt.plot(minimum, label="min")

plt.grid()
plt.legend()
plt.show()

print("finished")