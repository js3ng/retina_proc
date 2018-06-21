clear;clc;  

in = '../example_video/fil_cat.avi';
in_dat = double(readVideo(in));

thresh1 = 10;
thresh2 = -10;
sh_mode = 1;
filtMode = 2;
w = 0;

if filtMode == 1
    lowFilt = [0 1/8 0; 1/8 1/2 1/8; 0 1/8 0];
elseif filtMode == 2
    lowFilt = 1/16*[1 2 1; 1 2 1; 1 2 1];
elseif filtMode == 3
    lowFilt = 1/9*[1 1 1; 1 1 1; 1 1 1];
end
init_spatial = rand(size(in_dat,1),size(in_dat,2))*255;
for ii = 1:size(in_dat,3)
    outFrame = zeros(size(in_dat,1),size(in_dat,2));
    if sh_mode == 1
       spatial_out = imfilter(in_dat(:,:,ii),lowFilt);
    elseif sh_mode == 2
        spatial_out = in_dat(:,:,ii)-imfilter(in_dat(:,:,ii),lowFilt);
    else
        spatial_out = in_dat(:,:,ii);
    end
    if ii == 1
        temp_out = spatial_out - init_spatial;
    else
        temp_out = spatial_out - spatial_past;
    end
    spatial_past = spatial_out;
    ONevents = temp_out>= thresh1;
    OFFevents = temp_out<= thresh2;
    outFrame(ONevents) = 255;
    outFrame(OFFevents) = 122;
    s_vid(:,:,ii) = uint8(spatial_out);
    st_vid(:,:,ii) = uint8(outFrame);
end
% out = st_Retina(in,50, -50,0);
if w == 1
    filtOut = VideoWriter('nofilt.avi');
    tempOut = VideoWriter('eventout_nofilt.avi');
    filtOut.FrameRate = 10;
    tempOut.FrameRate = 10;
    open(filtOut);
    open(tempOut);
    for ii = 1:size(in_dat,3)
        %     figure(1);
        %     imagesc(st_vid(:,:,ii));
        %     colormap(gray);
        writeVideo(tempOut,st_vid(:,:,ii));
        %     figure(2);
        %     imagesc(s_vid(:,:,ii));
        %     colormap(gray);
        writeVideo(filtOut,s_vid(:,:,ii));
        %     pause(1/10);
    end
    close(tempOut);
    close(filtOut);
end


fig = fig_show(in_dat, s_vid, st_vid);
