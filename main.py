import math

def meanShift(data):
	n = len(data)

	resultX = 0
	resultY = 0

	for i in range(n):
		resultX += data[n][0]
		resultY += data[n][1]
	
	return resultX, resultY

def main():
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
