import numpy as np
import cv2


imgname = "worldtopo.png"
frame=cv2.imread(imgname)
worldarray=np.array(frame,dtype=float)


lat=180
lon=360
[x,y,rgb]=np.shape(worldarray)


Xpx=x/lat
Ypx=y/lon

data=np.loadtxt('D:\EXTRA work\Hackathon Nasa 2018\DATABASE\Data clean\dataclnTime18.dat',dtype=float)

[datR,datC]=np.shape(data)
data=np.array([data[:,2],data[:,1],data[:,3]])

colorM=data[2,:]/np.max(data[2,:])*255
print(colorM)

datapx=np.array([(data[0,:])*Xpx,(data[1,:]+90)*Ypx], dtype=int)

for i in range(datR):


	xi=datapx[0,i]
	yi=datapx[1,i]
	xf=int(xi+100)
	yf=int(yi+100)
	color=colorM[i]
	
	#cv2.rectangle(worldarray,(xi,yi),(xf,yf), (0,color,color), thickness=cv2.FILLED, lineType=8, shift=0)
	cv2.circle(worldarray, (xi,yi), 50, (0,color,color), thickness=cv2.FILLED, lineType=8, shift=0) 
cv2.imwrite('plotg18.png',worldarray)



