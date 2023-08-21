the_Video = VideoReader('Rhys.mp4.mp4'); % Finds and will Load the video file 
the_Video1 = VideoReader('vid 1.avi'); 
video_Frame = readFrame(the_Video); % Indicating where to look on the video

face_Detector = vision.CascadeObjectDetector(); % Creates Object Detector to detect objects or faces on images and videos
Face_of_a_Face = step(face_Detector, video_Frame); % Creating a variable here to indicating where to focus its detection on

Frames_Detected = insertShape(video_Frame, 'Rectangle', Face_of_a_Face); % Indicating where an object has been detected so will place a shape onto the video


rectangle_to_Points = bbox2points(Face_of_a_Face(1,:)); % Draws the box around the detection 

feature_Points = detectMinEigenFeatures(rgb2gray(Frames_Detected), 'ROI', Face_of_a_Face ); % Creating the pointers which will display on the users face withi 

TrackingthePoints = vision.PointTracker('MaxBidirectionalError', 2);

feature_Points = feature_Points.Location;
initialize(TrackingthePoints, feature_Points, Frames_Detected);




left = 100;
bottom = 100;
width = size(Frames_Detected, 2);
height = size(Frames_Detected, 1);
Video_Player = vision.VideoPlayer('Position', [left bottom width height]);

previous_Points = feature_Points;

while hasFrame(the_Video)
   video_Frame = readFrame(the_Video);
   [feature_Points, isFound] = step(TrackingthePoints, video_Frame);
   new_Points = feature_Points(isFound,:);
   old_Points = previous_Points(isFound,:);


   if size(new_Points, 1) >= 2
       [transformed_Rectangle, old_Points, Points_new] = ...
       estimateGeometricTransform(old_Points, new_Points, ...
       'similarity', 'MaxDistance', 4);
       Points_From_Rectangle = transformPointsForward(transformed_Rectangle, rectangle_to_Points);

       reshaped_Rectangle = reshape(rectangle_to_Points', 1, []);
      detected_Frame =  insertShape(video_Frame, 'Polygon', reshaped_Rectangle, 'LineWidth', 2);


     detected_Frame = insertMarker(detected_Frame, Points_new, '+', 'Color', 'White');

    Points_old = Points_new;
    setPoints(TrackingthePoints, previous_Points);
   end
   step(Video_Player, detected_Frame)

end


release(Video_Player);







