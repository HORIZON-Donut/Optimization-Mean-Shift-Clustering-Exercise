import math

def kernelFunction(X):
	return math.exp((-1/2)/(X**2))

def neighborsFinder(pos, data, h=2):
	neighbors = []
	for Item in data:
		if Item[0] > (pos[0] - h) and Item[0] < (pos[0] + h) and Item[1] > (pos[1] - h) and Item[1] < (pos[1] + h):
			neighbors.append(Item)
	
	return neighbors

def meanShift(X, data):
	n = len(data)

	resultX = 0
	resultY = 0

	for i in range(n):
		resultX += data[i][0]
		resultY += data[i][1]
	
	resultX = resultX/n
	resultY = resultY/n
	
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

	return 0

if __name__ == "__main__":
	main()
