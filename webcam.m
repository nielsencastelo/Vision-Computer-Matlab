clear;close all;clc;
vid = videoinput('winvideo', 1);
% Configure the number of frames to log upon triggering.
set(vid,'FramesPerTrigger', 1);
set(vid,'TriggerRepeat', Inf);
optical = vision.OpticalFlow( ...
    'OutputValue', 'Horizontal and vertical components in complex form');

imsize = get(vid,'VideoResolution');
shapes = vision.ShapeInserter;
shapes.Shape = 'Lines';
shapes.BorderColor = 'white';
row = 1:5:imsize(2);
column = 1:5:imsize(1);
[Cv, Rv] = meshgrid(column,row);
Rv = Rv(:)';
Cv = Cv(:)';

hVideoIn = vision.VideoPlayer;
hVideoIn.Name  = 'Original Video';
hVideoOut = vision.VideoPlayer;
hVideoOut.Name  = 'Motion Detected Video';

start(vid);
nFrames = 0;
while (nFrames < 100)     % Process for the first 100 frames.
    % Acquire single frame of single data type.
    rgbData = getdata(vid, 1, 'single');

    % Compute the optical flow for that particular frame.
    optFlow = step(optical,rgb2gray(rgbData));

    % Downsample optical flow field.
    optFlow_DS = optFlow(row, column);
    H = imag(optFlow_DS)*50;
    V = real(optFlow_DS)*50;

    % Draw lines on top of image
    lines = [Rv; Cv; Rv+H(:)'; Cv+V(:)'];
    rgb_Out = step(shapes, rgbData, lines);

    % Send image data to video player
    % Display original video.
    step(hVideoIn, rgbData);
    % Display video along with motion vectors.
    step(hVideoOut, rgb_Out);

    % Increment frame count
    nFrames = nFrames + 1;
end
stop(vid);
delete(vid);
clear vid;

delete(optical);
delete(shapes);
delete(hVideoIn);
delete(hVideoOut);