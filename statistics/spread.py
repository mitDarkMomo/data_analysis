
data = [15,4,3,8,15,22,7,9,2,3,3,12,6]

def cal_mean(data):
    sum = 0
    for i in data:
        sum += i
    mean = sum / len(data)
    print(mean)
    return mean

def cal_iq(data):
    data.sort()
    n = len(data)
    median = 0
    if n % 2 == 0:
        i = int(n/2)
        median = (data[i] + data[i - 1])/2
    else:
        i = (n-1)/2
        median = data[int(i)]
    
    print(median)
    return i

def cal_14(data, index):
    data.sort()
    n = len(data)
    if n % 2 == 0:
        data1 = data[:index]
        print('ready to print 1 quator')
        cal_iq(data1)
        print('ready to print 3 quator')
        data3 = data[index:]
        cal_iq(data3)
    else:
        data1 = data[:int(index)]
        print('ready to print 1 quator')
        cal_iq(data1)
        data3 = data[int(index)+1:]
        print('ready to print 3 quator')
        cal_iq(data3)

def cal_variance(data):
    mean = cal_mean(data)
    sum_of_squares = 0
    for value in data:
        sum_of_squares += (value - mean) ** 2
    
    variance = sum_of_squares / len(data)
    print('Variance is: {}'.format(variance))
    return variance

def cal_deviation(variance):
    deviation = variance ** 0.5
    print('Standard deviation is: {}'.format(deviation))

def main():
    median_index = cal_iq(data)
    cal_14(data, median_index)
    cal_mean(data)
    variance = cal_variance(data)
    cal_deviation(variance)

if __name__ == "__main__":
    main()