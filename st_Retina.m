function [out] = st_Retina(in, thresh1, thresh2, mode)
in_dat = readVideo(in);
lowFilt = [0 1/8 0; 1/8 1/2 1/8; 0 1/8 0];
init_spatial = rand(size(in_dat,1),size(in_dat,2))*255;
for ii = 1:size(in_dat,3)
    if mode == 1
       spatial_out = imfilter(in_dat(:,:,ii),lowFilt);
    elseif mode == 2
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
    OFFevents = temp_out>= thresh2;
    outFrame(ONevents) = 255;
    outFrame(OFFevents) = 122;
    out(:,:,ii) = uint8(outFrame);
end
end