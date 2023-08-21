DetectBody = vision.CascadeObjectDetector('BodyUpper');
DetectBody.MinSize = [ 30, 60]; 
DetectBody.MergeThreshold = 25;

I2 = imread('picturewicture.jpg'); 
bboxBody = DetectBody(I2);

IBody = insertObjectAnnotation(I2, 'rectangle', bboxBody, 'BodyUpper');
figure
imshow(IBody)
title('Showing All Upper Bodies which are detected');