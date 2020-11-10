import cv2
from pyzbar.pyzbar import decode
from PIL import Image
cap = cv2.VideoCapture(1)
cap.set(1,1024)
cap.set(2,768)
mydata=""
while True:
    ret,img = cap.read()
    mydata=""
    for barcode in decode(img):
        mydata = barcode.data.decode('utf-8')
    cv2.imshow('Result',img)
    if(mydata!=""):
        break
    if cv2.waitKey(20)==ord('q'):
        break
cv2.destroyAllWindows()
print(mydata)
