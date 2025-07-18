import math

def meanShift():
	pass

def distane(X, Y):
	dis = X**2 + Y**2

	return dis

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
