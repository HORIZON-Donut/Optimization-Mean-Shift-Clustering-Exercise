import math

def kernelFunction(X):
	return math.exp((-1/2)*(X**2))

def neighborsFinder(pos, data, h=2):
	return [Xi for Xi in data if distance(Xi, pos) < h]

def meanShift(X, Xi, useKernel = False):
	n = len(Xi)

	resultX = 0
	resultY = 0
	sumKernel = 0

	for i in range(n):
		kernel = kernelFunction(distance(X, Xi[i])) if useKernel else kernelFunction(0)
		resultX += Xi[i][0] * kernel
		resultY += Xi[i][1] * kernel

		sumKernel += kernel
	
	resultX = resultX/kernel
	resultY = resultY/kernel
	
	return resultX - X[0], resultY - X[1]

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

	for i in range(len(data)):
		print(F"Data {i}: X: {data[i][0]}, Y: {data[i][1]}")
		print(F"Neighbors of {data[i]}: {neighborsFinder(data[i], data, h)}")
		print(F"Mean shift without kernel of {data[i]}: {meanShift(data[i], neighborsFinder(data[i], data, h))}")
		print(F"Mean shift with kernel of {data[i]}: {meanShift(data[i], neighborsFinder(data[i], data, h), True)}")
	
	return 0

if __name__ == "__main__":
	main()
