function [ i_vid, s_vid, st_vid, rgb_vid ] = retina_model( inVid, imHeight, imWidth, nFrames,  filtMode, sh_mode, enDiv, divMode, gaussSize, std, thresh1_mean, thresh2_mean, thresh1_var, thresh2_var, pix_mean, pix_var, deadPixPR, satPixPR, figW, arrW )
%%%%%%% RETINA FUNCTION using recorded video %%%%%%% 

in_dat = double(readVideo_rs(inVid, imHeight, imWidth, nFrames));

%random initial frame
init_spatial = rand(size(in_dat,1),size(in_dat,2))*255;
%%%introduce non-uniformities%%%
thresh1_arr = normrnd(thresh1_mean,thresh1_var, size(in_dat(:,:,1)));
thresh2_arr = normrnd(thresh2_mean,thresh2_var, size(in_dat(:,:,1)));
pix_nu = normrnd(pix_mean,pix_var, size(in_dat(:,:,1))); 
%dead/sat pixels
deadPix=zeros(imHeight,imWidth);
r=rand(imHeight,imWidth);
deadPix = (r<(1-deadPixPR)/2);
satPix=zeros(imHeight,imWidth);
r=rand(imHeight,imWidth);
satPix = (r<(1-satPixPR)/2);

for ii = 1:nFrames
    in_var = in_dat(:,:,ii) + pix_nu;
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
                lowFilt = fspecial('gaussian',gaussSize, std);
            elseif divMode(jj,1) == 3
                lowFilt = 1/9*[1 1 1; 1 1 1; 1 1 1];
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
            lowFilt = fspecial('gaussian',gaussSize, std);
        elseif filtMode == 3
            lowFilt = 1/9*[1 1 1; 1 1 1; 1 1 1];
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
        temp_out = zeros(imHeight,imWidth);
    else
        temp_out = spatial_out - spatial_past;
    end    
    spatial_past = spatial_out;
    ONevents = temp_out>= thresh1_arr;
    OFFevents = temp_out<= thresh2_arr;
    outFrame(ONevents) = 255;
    outFrame(OFFevents) = 127;
    rgb_vid(:,:,:,ii) = zeros(imHeight,imWidth,3);
    rgb_vid(:,:,1,ii) = 255*ONevents;
    rgb_vid(:,:,2,ii) = 255*OFFevents;
    i_vid(:,:,ii) = in_var;
    s_vid(:,:,ii) = uint8(spatial_out);
    st_vid(:,:,ii) = uint8(outFrame);
end
 
% for ii = 1:nFrames
%     imagesc(rgb_vid(:,:,:,ii));
%     pause(1/10);
% end
% fig = fig_show(i_vid, s_vid, st_vid, './output_videos/glpf_wdeadPix_satPix.mp4', figW);


end

