import cv2
import time
import numpy as np
#載入資料
img=cv2.imread("mode.jpg");#載入模板(1366*768)
img2=cv2.imread("001.jpg");#載入插入目標
img3=cv2.resize(img2,(1366,768));#調整目標大小
x_axis=1078;y_axis=503;ro_angle=21;mag=26;#已調試完的數據
'''
#資料調整用
def change_value(x):
    x_axis = cv2.getTrackbarPos('x_axis', 'image')
    y_axis = cv2.getTrackbarPos('y_axis', 'image')
    ro_angle = cv2.getTrackbarPos('ro_angle', 'image')
    mag= cv2.getTrackbarPos('mag', 'image')
    #載入插入目標
    img2=cv2.imread("001.jpg");
    img3=cv2.resize(img2,(1366,768));
    #調整插入目標
    M = cv2.getRotationMatrix2D((x_axis,y_axis),ro_angle, mag/100)
    img4 = cv2.warpAffine(img3, M, (1366,768))
    #遮罩和目標組合
    cloak = cv2.bitwise_and(img4,img4,mask=mask)#使綠色挖空部分出現目標
    combined = cv2.add(cloak, current_background)
    cv2.imshow('image',combined)
def get_Location():
    #建立拉條
    cv2.createTrackbar('x_axis', 'image', 0, 1366, change_value)
    cv2.createTrackbar('y_axis', 'image', 0, 768, change_value)
    cv2.createTrackbar('ro_angle', 'image', 0, 359, change_value)
    cv2.createTrackbar('mag', 'image', 0,100, change_value)
    #拉條的初始化
    cv2.setTrackbarPos('x_axis', 'image', 1000)
    cv2.setTrackbarPos('y_axis', 'image', 500)
    cv2.setTrackbarPos('ro_angle', 'image', 22)
    cv2.setTrackbarPos('mag', 'image',25)
'''
#綠色區塊(遮罩)
lower_bound = np.array([33 ,77, 90])
upper_bound = np.array([77,255,255])

#main主要運行
hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)#轉換成hsv的資料，方便擷取指定色域的顏色
mask = cv2.inRange(hsv, lower_bound, upper_bound)#將綠色色域資料匯入製造遮罩(綠色部分設為白)
inverse_mask = cv2.bitwise_not(mask)#將色域反轉(綠色部分顏色轉為黑，其他轉為白)
current_background = cv2.bitwise_and(img, img, mask=inverse_mask)#將反遮罩與模板組合，綠色部分無影像，其他地方有
#cv2.namedWindow('image')#資料調整用
#get_Location();#資料調整用
M = cv2.getRotationMatrix2D((x_axis,y_axis),ro_angle, mag/100)#調整欲插入資料的角度和大小
img4 = cv2.warpAffine(img3, M, (1366,768))
cloak = cv2.bitwise_and(img4,img4,mask=mask)#使綠色部分出現背景
combined = cv2.add(cloak, current_background)#將綠色部分(模板影像)和綠色以外(插入影像)組合
cv2.imshow('image',combined)
cv2.imwrite("new.jpg",combined)
cv2.waitKey(0)
