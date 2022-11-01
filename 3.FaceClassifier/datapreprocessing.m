%% Refresher
%With Regards Team Bazinga ;)
clc;
close all;
clear;
%% Create Traing Data
naam=input('Enter your name: ','s')%persons name
mkdir('TrainingData',naam);
b=pwd;
b1=strcat(b,'\TrainingData',naam,'\');
load(fullfile("utilities","detectorYoloV2.mat"));
vid = VideoReader('data\3(1).mp4');%Name of the video
cd TrainingData
cd (naam)
for i=1:vid.NumberOfFrames
    b2=strcat('b',num2str(i),'.jpeg');%name of image to be saved
    image=read(vid,i);
    [bboxes,scores,labels] = detect(detectorYolo2,image,0.5);% 
    if ~isempty(bboxes) 
    crop = imcrop(image,bboxes(1,:));    
    gray1=rgb2gray(crop);
    resized=imresize(gray1,[150 150]);
    imwrite(resized,b2);
    end
end
cd .. 
cd ..
%% Check
load(fullfile("utilities","detectorYoloV2.mat"));%
vidobj = vision.VideoFileReader('data\b.mp4');
viewer = vision.DeployableVideoPlayer;
position =  [1 20];
value = 'Processing...';
    while ~isDone(vidobj)
              A = step(vidobj);
              [bboxes,scores,labels] = detect(detectorYolo2,A,'Threshold',0.65,'SelectStrongest',true);

              if ~isempty(bboxes)
              A= insertShape(A,'rectangle', bboxes,'Linewidth',2);
              
              end 
              
              A = insertText(A,position,value,'AnchorPoint','LeftBottom');
              step(viewer, A);
    end
release(vidobj);
release(viewer);