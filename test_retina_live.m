clear;clc;  
cam = webcam;
imHeight = 320;
imWidth = 240;
Frames = 50;
vidSize = [imHeight imWidth];

%%%set model modes%%%
filtMode = 2; %LPF mode - 1: 4NN average, 2: 9NN average, 3: 9member Gaussian, 4: adjustable Gaussian
sh_mode =  1; %1: LPF, 2: HPF, 3: NF
enDiv = 0; %partion filtering
divMode = [4 1; 2 1; 4 1;1 3]; %first col: fMode, second col: shMode
gaussSize = 7;
std = 2;
%write out-mode
arrW = 0; %array write
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
     figure(1) = fig_show_live(i_f, s_f, st_f);
%      if ii == 1
%          fig=figure(1);
%          fig.Units='normalize';
%          fig.Position=[0 0 1 1];
%          ax(1)=axes;
%          ax(2)=axes;
%          ax(3)=axes;
%          x0=0.075;
%          y0=0.325;
%          dx=0.25;
%          dy=0.35;
%          ax(1).Position=[x0 y0 dx dy];
%          x0=x0+dx+0.05;
%          ax(2).Position=[x0 y0 dx dy];
%          x0=x0+dx+0.05;
%          ax(3).Position=[x0 y0 dx dy];
%          
%          
%          im(1)=imagesc(uint8(in1),'Parent',ax(1));
%          im(2)=imagesc(uint8(in2),'Parent',ax(2));
%          im(3)=imagesc(uint8(in3),'Parent',ax(3));
%          
%          colormap(gray);
%          
%          set(ax(1),'XTick',[],'YTick',[]);
%          set(ax(2),'XTick',[],'YTick',[]);
%          set(ax(3),'XTick',[],'YTick',[]);
%          
%          ax(1).Title.String='Input video';
%          ax(2).Title.String='Spatial output';
%          ax(3).Title.String='Spatio-temporal output';
%      else
%          set(im(1),'cdata',in1);
%          set(im(2),'cdata',in2);
%          set(im(3),'cdata',in3);
%          drawnow;
%          pause(1/20);
%      end;
end

clear('cam');