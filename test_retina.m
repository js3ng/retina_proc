%%%%%%% RETINA EMULATION USING .AVI %%%%%%% 

clear;clc;  

inVid = '../example_video/fil_cat.avi';
imHeight = 128;
imWidth = 96;
nFrames = 150;

%%%set model modes%%%
filtMode = 2; %LPF mode - 1: 4NN average, 3: 9NN average, 2: adjustable Gaussian
sh_mode = 1; %1: LPF, 2: HPF, 3: NF
enDiv = 0; %partion filtering
divMode = [4 1; 2 1; 4 1;1 3]; %first col: fMode, second col: shMode
gaussSize = 7;
std = 2;
%write out-mode
arrW = 0; %array write
figW = 0; %figure write

%%%set non-uniformities%%%
%threshold nu
thresh1_mean = 10;
thresh1_var = 0;
thresh2_mean = -10;
thresh2_var = 0;
%pixel nu
pix_mean = 0;
pix_var = 0;
%dead/sat pixels
deadPixPR = .999;  
satPixPR = .999;  

[ i_vid, s_vid, st_vid, rgb_vid ] = retina_model( inVid, imHeight, ...
    imWidth, nFrames, ...
    filtMode, sh_mode, ...
    enDiv, divMode, ...
    gaussSize, std, ...
    thresh1_mean, thresh2_mean, ...
    thresh1_var, thresh2_var, ...
    pix_mean, pix_var, ...
    deadPixPR, satPixPR, ...
    figW, arrW );