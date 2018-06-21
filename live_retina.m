%%%%%%% LIVE RETINA EMULATION USING USB CAMERA %%%%%%% 

clear;clc;  
cam = webcam;
vidSize = [320 240];
Frames = 100;

%%%set model modes%%%
filtMode = 4; %LPF mode - 1: 4NN average, 2: 9NN average, 3: 9member Gaussian, 4: adjustable Gaussian
sh_mode =  1; %1: LPF, 2: HPF, 3: NF
enDiv = 0; %partion filtering
divMode = [4 1; 2 1; 4 1;1 3]; %first col: fMode, second col: shMode
gaussSize = 7;
std = 2;
%write out-mode
arrW = 0; %array write
figW = 0; %figure write

%random initial frame
init_spatial = rand(vidSize)*255;

%%%introduce non-uniformities%%%
%threshold nu
thresh1_mean = 10;
thresh1_var = 0;
thresh1_arr = normrnd(thresh1_mean,thresh1_var, vidSize);
thresh2_mean = -10;
thresh2_var = 0;
thresh2_arr = normrnd(thresh2_mean,thresh2_var, vidSize);
%pixel nu
pix_mean = 0;
pix_var = 20;
pix_nu = normrnd(pix_mean,pix_var, vidSize); 
%dead/sat pixels
deadPix=zeros(vidSize(1),vidSize(2));
r=rand(vidSize(1),vidSize(2));
deadPixPR = .999;  
deadPix = (r<(1-deadPixPR)/2);
satPix=zeros(vidSize(1),vidSize(2));
r=rand(vidSize(1),vidSize(2));
satPixPR = .999;  
satPix = (r<(1-satPixPR)/2);


ii = 1;
while ii < Frames
    rgbImage = snapshot(cam);
    grayImage = double(rgb2gray(rgbImage));
    in_dat = imresize(grayImage,vidSize);
    
    in_var = in_dat(:,:) + pix_nu;
    in_var(deadPix) = 0; 
    in_var(satPix) = 255; 
    outFrame = zeros(size(in_dat,1),size(in_dat,2));
    p = zeros(floor(size(in_dat,1)/2),floor(size(in_dat,2)/2),4);
    if enDiv == 1
        p(:,:,1) = in_var(1:floor(size(in_dat,1)/2),1:floor(size(in_dat,2)/2));
        p(:,:,2) = in_var(1:floor(size(in_dat,1)/2),ceil(size(in_dat,2)/2)+1:end);
        p(:,:,3) = in_var(ceil(size(in_dat,1)/2)+1:end,1:floor(size(in_dat,2)/2));
        p(:,:,4) = in_var(ceil(size(in_dat,1)/2)+1:end,ceil(size(in_dat,2)/2)+1:end);
        for jj = 1:4
            if divMode(jj,1) == 1
                lowFilt = [0 1/8 0; 1/8 1/2 1/8; 0 1/8 0];
            elseif divMode(jj,1) == 2
                lowFilt = 1/16*[1 2 1; 1 2 1; 1 2 1];
            elseif divMode(jj,1) == 3
                lowFilt = 1/9*[1 1 1; 1 1 1; 1 1 1];
            elseif divMode(jj,1) == 4
                lowFilt = fspecial('gaussian',gaussSize, std);
            end
            if divMode(jj,2) == 1
                p_f(:,:,jj) = imfilter(p(:,:,jj),lowFilt);
            elseif divMode(jj,2) == 2
                p_f(:,:,jj) = p(:,:,jj)-imfilter(p(:,:,jj),lowFilt);
            else
                p_f(:,:,jj) = p(:,:,jj);
            end
        end
        spatial_out = [p_f(:,:,1) p_f(:,:,2); p_f(:,:,3) p_f(:,:,4)];
    else
        if filtMode == 1
            lowFilt = [0 1/8 0; 1/8 1/2 1/8; 0 1/8 0];
        elseif filtMode == 2
            lowFilt = 1/16*[1 2 1; 1 2 1; 1 2 1];
        elseif filtMode == 3
            lowFilt = 1/9*[1 1 1; 1 1 1; 1 1 1];
        elseif filtMode == 4
            lowFilt = fspecial('gaussian',gaussSize, std);
            %     lowFilt = 1/256*[1 4 6 4 1; 4 16 24 16 4; 6 24 36 24 6; 4 16 24 16 4; 1 4 6 4 1];
        end
        if sh_mode == 1
            spatial_out = imfilter(in_var,lowFilt);
        elseif sh_mode == 2
            spatial_out = in_var-imfilter(in_var,lowFilt);
        else
            spatial_out = in_var;
        end
    end
    
    if ii == 1
        temp_out = spatial_out - init_spatial;
    else
        temp_out = spatial_out - spatial_past;
    end    
    spatial_past = spatial_out;
    ONevents = temp_out>= thresh1_arr;
    OFFevents = temp_out<= thresh2_arr;
    outFrame(ONevents) = 255;
    outFrame(OFFevents) = 127;
    rgb_vid(:,:,:) = zeros(vidSize(1),vidSize(2),3);
    rgb_vid(:,:,1) = 255*ONevents;
    rgb_vid(:,:,2) = 255*OFFevents;
    i_f(:,:) = in_var;
    s_f(:,:) = uint8(spatial_out);
    st_f(:,:) = uint8(outFrame);
         
%     imagesc(s_vid(:,:));
%     colormap(gray);
%     pause(1/10);
    
    figure(1) = fig_show_live(i_f, s_f, st_f);
    ii = ii + 1;
end


clear('cam');