import math

def Iteration(data, h = 2, kernelMode = False):
	result = []
	for i in range(len(data)):
		result.append(shiftVector(data[i], neighborsFinder(data[i], data, h), kernelMode))
	
	return result

def kernelFunction(X):
	return math.exp((-1/2)*(X**2))

def neighborsFinder(pos, data, h=2):
	return [Xi for Xi in data if distance(Xi, pos) < h]

def shiftVector(X, Xi, useKernel = False):
	n = len(Xi)

	resultX = 0
	resultY = 0
	sumKernel = 0

	for i in range(n):
		kernel = kernelFunction(distance(X, Xi[i])) if useKernel else kernelFunction(0)
		resultX += Xi[i][0] * kernel
		resultY += Xi[i][1] * kernel

		sumKernel += kernel
	
	resultX = resultX/sumKernel
	resultY = resultY/sumKernel
	
	return resultX, resultY

def distance(X, Y):
	return math.sqrt((X[0] - Y[0])**2 + (X[1] - Y[1])**2)

def main():
	
	h = 2
	data = [
		[1, 2],
		[1, 5],
		[2, 4],
		[3, 2],
		[4, 3],
		[4, 5]
	]

	itr1 = Iteration(data, h, True)
	itr2 = Iteration(itr1, h, True)

	print(F"Iteration 1 with kernel: {itr1}")
	print(F"Iteration 2 with kernel: {itr2}")

	return 0

if __name__ == "__main__":
	main()
