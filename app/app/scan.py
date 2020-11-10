from django.shortcuts import render
import cv2
from pyzbar.pyzbar import decode

def button(request):
    return render(request,'index.html')
def Scanner(request):
    cap = cv2.VideoCapture(1)
    cap.set(1,1024)
    cap.set(2,768)
    mydata=""
    while True:
        ret,img = cap.read()
        mydata=""
        for barcode in decode(img):
            mydata = barcode.data.decode('utf-8')
        
        cv2.imshow('Sanjeevni-Scanner',img)
        if(mydata!=""):
            break
        if cv2.waitKey(20)==ord('q'):
            break
    cv2.destroyAllWindows()
    print(mydata)
    return render(request,'index.html',{'BARCODE':mydata})
