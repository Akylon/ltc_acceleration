import numpy as np
import matplotlib.pyplot as plt
from walker_model import train_walker

source = "quant_model"

if source == "quant_model":
    modelOutPath = "../vitis_hls/validation_data/model/"
    imagePath = "data/evaluationResults/quant_model/"
elif source == "float_model":
    modelOutPath = "../scripts/float_model/validation_data/model/"
    imagePath = "data/evaluationResults/C_model/"

validationDataPath = "data/walker_relu_tanh_checkpoint/float_validation/dense_out/blackbox/"



NUMBER_OF_DATASETS = 1936
NUMBER_OF_OUTFEATURES = 17
SEQUENCE_LENGTH = 64

def gauss(std, mean, range, N):
    x = np.linspace(range[0], range[1], N)
    f = 1/(std*np.sqrt(2*np.pi)) * np.exp(-0.5*np.power(x-mean, 2)/std**2)
    return x, f

def get_data(validationDataPath, modelOutPath):

    # for statistical reasoning
    errorData = np.zeros((NUMBER_OF_DATASETS, SEQUENCE_LENGTH, NUMBER_OF_OUTFEATURES))  # error = validation - model
    relErrorData = np.zeros((NUMBER_OF_DATASETS, SEQUENCE_LENGTH, NUMBER_OF_OUTFEATURES))  # error = (validation - model)/|validation|

    # for quality reasoning
    absErrorData = np.zeros((NUMBER_OF_DATASETS, SEQUENCE_LENGTH, NUMBER_OF_OUTFEATURES))  # error = |validation - model|
    absRelErrorData = np.zeros((NUMBER_OF_DATASETS, SEQUENCE_LENGTH, NUMBER_OF_OUTFEATURES))  # error = |validation - model|/|validation|

    # validationData_arr
    validationData_arr = np.zeros((NUMBER_OF_DATASETS, SEQUENCE_LENGTH, NUMBER_OF_OUTFEATURES))

    for dataset in range(NUMBER_OF_DATASETS):
        validationData = np.loadtxt(validationDataPath + f"dense_out_output_{dataset}.txt")
        modelOutData = np.loadtxt(modelOutPath + f"cModel_out_{dataset}.txt")

        if source == "quant_model":
            modelOutData *= 2.0**(-3)

        # calculate errors
        error = (modelOutData - validationData)
        relError = error/np.abs(validationData)

        absError = np.abs(error)
        absRelError = np.abs(relError)

        # store data
        errorData[dataset, :, :] = error
        relErrorData[dataset, :, :] = relError

        absErrorData[dataset, :, :] = absError
        absRelErrorData[dataset, :, :] = absRelError

        validationData_arr[dataset, :, :] = validationData

    return errorData, relErrorData, absErrorData, absRelErrorData, validationData_arr

def get_MSE_data(modelOutPath):
    data = train_walker.load_training_data()
    y_test = data.test_y

    errorData = np.zeros((NUMBER_OF_DATASETS, SEQUENCE_LENGTH, NUMBER_OF_OUTFEATURES))
    errorSquaredData = np.zeros((NUMBER_OF_DATASETS, SEQUENCE_LENGTH, NUMBER_OF_OUTFEATURES))

    out_scale = 2.0 ** (-3)
    if source == "quant_model":
        print(f"Outscale = {out_scale}")
        print("If outscale is incorrect please adjust.")

    for dataset in range(NUMBER_OF_DATASETS):
        modelOutData = np.loadtxt(modelOutPath + f"cModel_out_{dataset}.txt")

        if source == "quant_model":
            modelOutData *= 2.0**(-3)

        # calculate errors
        error = (modelOutData - y_test[dataset])
        errorData[dataset] = error

        errorSquared = np.power(error, 2)
        errorSquaredData[dataset] = errorSquared

    return errorData, errorSquaredData



errorData, relErrorData, absErrorData, absRelErrorData, validationData = get_data(validationDataPath, modelOutPath)

# calculated means
meanError_feature = errorData.mean(axis=0)
meanError = errorData.mean(axis=(0, 2))
meanErrorTotal = errorData.mean()

meanRelError_feature = relErrorData.mean(axis=0)
meanRelError = relErrorData.mean(axis=(0, 2))
meanRelErrorTotal = relErrorData.mean()

meanAbsError_feature = absErrorData.mean(axis=0)
meanAbsError = absErrorData.mean(axis=(0, 2))
meanAbsErrorTotal = absErrorData.mean()

meanAbsRelError_feature = absRelErrorData.mean(axis=0)
meanAbsRelError = absRelErrorData.mean(axis=(0, 2))
meanAbsRelErrorTotal = absRelErrorData.mean()

# calculate variances
stdError_feature = errorData.std(axis=0)
stdError = errorData.std(axis=(0, 1))
stdErrorTotal = errorData.std()

stdRelError_feature = relErrorData.std(axis=0)
stdRelError = relErrorData.std(axis=(0, 1))
stdRelErrorTotal = relErrorData.std()

stdAbsError_feature = absErrorData.std(axis=0)
stdAbsError = absErrorData.std(axis=(0, 1))
stdAbsErrorTotal = absErrorData.std()

stdAbsRelError_feature = absRelErrorData.std(axis=0)
stdAbsRelError = absRelErrorData.std(axis=(0, 1))
stdAbsRelErrorTotal = absRelErrorData.std()

# calculate min max errors
minAbsError = absErrorData.min()
maxAbsError = absErrorData.max()
minAbsRelError = absRelErrorData.min()
maxAbsRelError = absRelErrorData.max()

for feature in range(NUMBER_OF_OUTFEATURES):
    # plot means per feature
    featureFig, featureAxs = plt.subplots(2, 1)
    featureAxs[0].plot(meanError_feature[:, feature], label="meanError")
    featureAxs[0].plot(meanRelError_feature[:, feature], "--", label="meanRelError")
    featureAxs[0].plot(meanAbsError_feature[:, feature], label="meanAbsError")
    featureAxs[0].plot(meanAbsRelError_feature[:, feature], "--", label="meanAbsRelError")
    featureAxs[0].set_title(f'error mean of feature {feature}')
    featureAxs[0].grid()
    featureAxs[0].legend()

    # plot std per feature
    featureAxs[1].plot(stdError_feature[:, feature], label="stdError")
    featureAxs[1].plot(stdRelError_feature[:, feature], "--", label="stdRelError")
    featureAxs[1].plot(stdAbsError_feature[:, feature], label="stdAbsError")
    featureAxs[1].plot(stdAbsRelError_feature[:, feature], "--", label="stdAbsRelError")
    featureAxs[1].set_title(f'standard deviation of feature {feature}')
    featureAxs[1].grid()
    featureAxs[1].legend()

    plt.savefig(imagePath + f"error_propagation_output_feature_{feature}.pdf", bbox_inches='tight')

# plot error mean
fig, axs = plt.subplots(2, 2)
axs[0, 0].set_title("Error over all features")
axs[0, 0].plot(meanError_feature[:, feature], label="meanError")
axs[0, 0].plot(meanAbsError_feature[:, feature], label="meanAbsError")
axs[0, 0].grid()
axs[0, 0].legend()

axs[1, 0].set_title("Relative error over all features")
axs[1, 0].plot(meanRelError_feature[:, feature], "--", label="meanRelError")
axs[1, 0].plot(meanAbsRelError_feature[:, feature], "--", label="meanAbsRelError")
axs[1, 0].grid()
axs[1, 0].legend()

# plot error std
axs[0, 1].set_title("Std. error over all features")
axs[0, 1].plot(stdError_feature[:, feature], label="stdError")
#axs[0, 1].plot(stdAbsError_feature[:, feature], label="stdAbsRelError")
axs[0, 1].grid()
axs[0, 1].legend()

axs[1, 1].set_title("Relative std. over all features")
axs[1, 1].plot(stdRelError_feature[:, feature], "--", label="stdRelError")
#axs[1, 1].plot(stdAbsRelError_feature[:, feature], label="stdAbsRelError")
axs[1, 1].grid()
axs[1, 1].legend()

plt.savefig(imagePath + f"error_propagation_output_feature_all.pdf", bbox_inches='tight')

# plot histograms per feature
for i in range(NUMBER_OF_OUTFEATURES):
    data = errorData[:, :, i].flatten()
    std = data.std()
    mean = data.mean()
    histRange = [-3 * std + mean, 3 * std + mean]

    expected_data = validationData[:, :, i].flatten()

    print(f"\nFeature {i} stats:")
    print(f"error: mean = {mean}")
    print(f"error: min = {data.min()}")
    print(f"error: max = {data.max()}")
    print(f"error: std = {std}")

    print(f"expected value: mean = {expected_data.mean()}")
    print(f"expected value: min = {expected_data.min()}")
    print(f"expected value: max = {expected_data.max()}")
    print(f"expected value: std = {expected_data.std()}")


    x, f = gauss(std, mean, histRange, int(1e3))

    fig, axs = plt.subplots(1, 1)
    axs = [axs]  # remove if multiple subplots are required
    axs[0].set_title(f"Error Distribution of Output Feature {i}")
    axs[0].hist(data, density=True, bins=20, range=histRange, edgecolor="k")
    axs[0].plot(x, f, "k--")
    axs[0].grid()
    axs[0].set_xlabel("Error")
    axs[0].set_ylabel("Probability Density")

    data = relErrorData[:, :, i].flatten()
    std = data.std()
    mean = data.mean()
    histRange = [-3*std + mean, 3*std + mean]
    x, f = gauss(std, mean, histRange, int(1e3))

    #axs[1].set_title(f"relative error of {i}")
    #axs[1].hist(data, density=True, bins=20, range=histRange, edgecolor="k")
    #axs[1].plot(x, f, "k--")
    #axs[1].grid()

    plt.savefig(imagePath + f"error_distribution_output_feature_{i}.pdf", bbox_inches='tight')

# print total errors
print(f"meanErrorTotal = {meanErrorTotal}")
print(f"meanRelErrorTotal = {meanRelErrorTotal}")
print(f"meanAbsErrorTotal = {meanAbsErrorTotal}")
print(f"meanAbsRelErrorTotal = {meanAbsRelErrorTotal}")

print()

print(f"meanErrorTotal = {stdErrorTotal}")
print(f"stdRelErrorTotal = {stdRelErrorTotal}")
print(f"stdAbsErrorTotal = {stdAbsErrorTotal}")
print(f"stdAbsRelErrorTotal = {stdAbsRelErrorTotal}")

print()

print(f"minAbsRelError = {minAbsRelError}")
print(f"maxAbsRelError = {maxAbsRelError}")
print(f"minAbsError = {minAbsError}")
print(f"maxAbsError = {maxAbsError}")


# %% Calculate MSE
errorData, errorSquaredData = get_MSE_data(modelOutPath)
MSE = errorSquaredData.mean(axis=(0, 2))
indece = np.arange(0, len(MSE))
print(f"MSE = {MSE.mean()}")
p = np.polyfit(indece, MSE, 1)
fit = np.polyval(p, indece)

plt.figure()
plt.plot(MSE, "kx")
plt.plot(fit, "k--")
plt.xlabel("Sequence Index")
plt.ylabel("MSE")

plt.savefig(imagePath + f"MSE.pdf", bbox_inches='tight')

plt.show()

print("finished")