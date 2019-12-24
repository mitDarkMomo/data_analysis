# encoding:utf-8

negative_two_layers_a = [i for i in range(4, 26)]
negative_one_layers_a = [i for i in range(9, 40)]

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

    [negative_one_layers_a.append(i) for i in range(61, 88)]
    [negative_one_layers_a.append(i) for i in range(116, 119)]
    [negative_one_layers_a.append(i) for i in range(144, 162)]
    [negative_one_layers_a.append(i) for i in range(183, 185)]
    [negative_one_layers_a.append(i) for i in range(244, 281)]

def check_plot():
    while True:
        try:
            layer = input('请选择楼层: [-1 or -2]')
            if layer in ['-1', '-2']:
                break
        except:
            print('您输入的楼层必须为 -1 或者 -2！')
    
    if layer == '-1':
        data_layer = negative_one_layers_a
    else:
        data_layer = negative_two_layers_a

    park_plot = int(input("请选择车位: "))
    print("楼层{}，车位 A{}, 检查结果是: ".format(layer, park_plot))
    
    if park_plot in data_layer:
        print("不好的车位!")
    else:
        print("好车位")

def main():
    while True:
        prepare_data()
        # print("-2 layer：")
        # print(negative_two_layers_a)
        # print("----------------------------------------")
        # print('-1 layer:')
        # print(negative_one_layers_a)
        check_plot()

if __name__ == "__main__":
    main()