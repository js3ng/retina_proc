function [ st_f,s_f, i_f, rgb_vid] = live_retina_model( grayImage, spatial_past, imHeight, imWidth, filtMode, sh_mode, enDiv, divMode, gaussSize, std, thresh1_arr, thresh2_arr, pix_nu, deadPix, satPix )

vidSize = [imHeight imWidth];

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
            lowFilt = 1/9*[1 1 1; 1 1 1; 1 1 1];
        elseif divMode(jj,1) == 3
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
        lowFilt = 1/9*[1 1 1; 1 1 1; 1 1 1];
    elseif filtMode == 3
        lowFilt = fspecial('gaussian',gaussSize, std);
    end
    if sh_mode == 1
        spatial_out = imfilter(in_var,lowFilt);
    elseif sh_mode == 2
        spatial_out = in_var-imfilter(in_var,lowFilt);
    else
        spatial_out = in_var;
    end
end


temp_out = spatial_out - spatial_past;
spatial_past = spatial_out;
ONevents = temp_out>= thresh1_arr;
OFFevents = temp_out<= thresh2_arr;
outFrame(ONevents) = 255;
outFrame(OFFevents) = 127;
rgb_vid(:,:,:) = zeros(vidSize(1),vidSize(2),3);
rgb_vid(:,:,1) = 255*ONevents;
rgb_vid(:,:,2) = 255*OFFevents;
i_f = in_var;
s_f = spatial_out;
st_f = uint8(outFrame);

end

