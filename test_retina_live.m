clear;clc;  
cam = webcam;
imHeight = 320;
imWidth = 240;
Frames = 50;
vidSize = [imHeight imWidth];

%%%set model modes%%%
filtMode = 3; %LPF mode - 1: 4NN average, 2: 9NN average, 3: adjustable Gaussian
sh_mode =  1; %1: LPF, 2: HPF, 3: NF
enDiv = 0; %partion filtering
divMode = [4 1; 2 1; 4 1;1 3]; %first col: fMode, second col: shMode
gaussSize = 7;
std = 2;
%write out-mode
figW = 0; %figure write

%random initial frame
init_spatial = rand(imHeight, imWidth)*255;

%%%introduce non-uniformities%%%
%threshold nu
thresh1_mean = 10;
thresh2_mean = -10;
thresh2_var = 0;
thresh1_var = 0;

pix_mean = 0;
pix_var = 20;

deadPixPR = .999;  
satPixPR = .999;  


%%%introduce non-uniformities%%%
%threshold nu
thresh1_arr = normrnd(thresh1_mean,thresh1_var, vidSize);
thresh2_arr = normrnd(thresh2_mean,thresh2_var, vidSize);
%pixel nu
pix_nu = normrnd(pix_mean,pix_var, vidSize); 
%dead/sat pixels
deadPix=zeros(vidSize(1),vidSize(2));
r=rand(vidSize(1),vidSize(2));
deadPix = (r<(1-deadPixPR)/2);
satPix=zeros(vidSize(1),vidSize(2));
r=rand(vidSize(1),vidSize(2));
satPix = (r<(1-satPixPR)/2);

%st set
colorVidEn = 1;

for ii =1:Frames
    rgbImage = snapshot(cam);
    grayImage = double(rgb2gray(rgbImage));
    if ii == 1
        spatial_past = init_spatial;
    else
        spatial_past = s_f;
    end
     [ st_f,s_f, i_f, rgb_vid ] = live_retina_model( grayImage, spatial_past, imHeight, ...
         imWidth, filtMode, ...
         sh_mode, enDiv, divMode, gaussSize, std, thresh1_arr, ...
         thresh2_arr, pix_nu, deadPix, satPix );
     clear st_in
     if colorVidEn == 1
         st_in = rgb_vid;
     else
         st_in = st_vid;
     end
     figure(1) = fig_show_live(i_f, s_f, st_in);
     if ii == 30
         saveas(gcf,'../figs/live_rgbOut_glpf_deadSatpix_noDiv.png')
     end
end

clear('cam');