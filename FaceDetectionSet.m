clear % Will be giving us a fresh and clear workspace to begin my work from
% Now Below I will be creating a cascade Objector as which will allow us to
% detect faces from images or videos.

DetectFace = vision.CascadeObjectDetector();

% This will prompt the users to select one or more images

I = imread('picturewicture.jpg');

bbox = DetectFace(I); % Box Identifying the face inside of it 
IFaces = insertObjectAnnotation(I,'rectangle', bbox, 'Faces'); % Creates the box that will appear around the overall faces
figure
imshow(IFaces)
title('Faces are Detected'); % Displays the title for the boxes and informs the user that face is detected 