function [ outVid ] = readVideo( videoFile )
v = VideoReader(videoFile);
ii = 1; 
while hasFrame(v)
    frame = readFrame(v);
    outVid(:, : , ii) = rgb2gray(frame);
     ii = ii + 1;
end

end

