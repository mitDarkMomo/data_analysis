
negative_two_layers_a = [i for i in range(4, 26)]
def prepare_data():
    [negative_two_layers_a.append(i) for i in range(28, 31)]
    [negative_two_layers_a.append(i) for i in range(36, 128)]
    [negative_two_layers_a.append(i) for i in range(129, 163)]
    [negative_two_layers_a.append(i) for i in range(218, 220)]
    [negative_two_layers_a.append(i) for i in range(273, 292)]
    [negative_two_layers_a.append(i) for i in range(358, 362)]
    negative_two_layers_a.append(405)
    [negative_two_layers_a.append(i) for i in range(417, 419)]
    negative_two_layers_a.append(436) 
    [negative_two_layers_a.append(i) for i in range(439, 472)]
    negative_two_layers_a.append(177) 
    negative_two_layers_a.append(207) 
    negative_two_layers_a.append(261) 
    negative_two_layers_a.append(266) 
    negative_two_layers_a.append(298) 
    negative_two_layers_a.append(352) 
    negative_two_layers_a.append(368) 
    negative_two_layers_a.append(377) 
    negative_two_layers_a.append(385) 
    negative_two_layers_a.append(378) 
    negative_two_layers_a.append(251) 
    negative_two_layers_a.append(401) 
    negative_two_layers_a.append(263) 

def check_plot():
    park_plot = input("Enter your park plot: [default A plot]")
    print("Hello, you choose park plot a{}, check result is: ".format(park_plot))
    if int(park_plot) in negative_two_layers_a:
        print("It isn't a good park plot!")
    else:
        print("It's a good park plot")

def main():
    prepare_data()
    print(negative_two_layers_a)
    check_plot()

if __name__ == "__main__":
    main()