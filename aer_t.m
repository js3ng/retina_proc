% function [ AERstream ] = aer_t( vid )
clear AERstream* ONevents* OFFevents* ii jj
tic;
sizeVid = size(st_vid);
bits_row = length(dec2bin(sizeVid(1)));
bits_col = length(dec2bin(sizeVid(2)));
bits = max([bits_row bits_col 8]);
off = 127;
on = 255;
kk = 1;
for ii = 1:sizeVid(3)
    [ONeventsrow, ONeventscol] = find(st_vid(:,:,ii) == on);
    [OFFeventsrow, OFFeventscol] = find(st_vid(:,:,ii) == off);
    ONmat = [ONeventsrow ONeventscol];
    OFFmat = [OFFeventsrow OFFeventscol];
    sizeOn = size(ONmat,1);
    sizeOff = size(OFFmat,1);
    lengthVec = max([sizeOn sizeOff]);
    for jj = 1:sizeOn
        AERstream(kk,:) = [ONmat(jj,1) ONmat(jj,2) on ii];
        kk = kk + 1;
    end
    for jj = 1:sizeOff
        AERstream(kk,:) = [OFFmat(jj,1) OFFmat(jj,2) off ii];
        kk = kk + 1;
    end
end
time = toc;


% end



%     for jj = 1:lengthVec
%         if jj > sizeOn
% %             offrow_bin = dec2bin(OFFevents(jj,1),bits);
% %             offcol_bin = dec2bin(OFFevents(jj,2),bits);
% %             AERstream((sizeVid(1)*sizeVid(2))*(ii-1)+jj,:) = strcat(offrow_bin,offcol_bin,dec2bin(off, bits)); 
% %             offrow_bin = bitget(OFFevents(jj,1),bits:-1:1);
% %             offcol_bin = bitget(OFFevents(jj,2),bits:-1:1);
% %             AERstream((sizeVid(1)*sizeVid(2))*(ii-1)+jj,:) = [offrow_bin offcol_bin bitget(off,bits:-1:1)];
%                 AERstream((sizeVid(1)*sizeVid(2))*(ii-1)+jj,:) = [OFFmat(jj,1) OFFmat(jj,2) off ii];
%         elseif jj > sizeOff
% %             onrow_bin = dec2bin(ONevents(jj,1),bits);
% %             oncol_bin = dec2bin(ONevents(jj,2),bits);
% %             AERstream((sizeVid(1)*sizeVid(2))*(ii-1)+jj,:) = strcat(offrow_bin,offcol_bin,dec2bin(on, bits)); 
% %             onrow_bin = bitget(ONevents(jj,1),bits:-1:1);
% %             oncol_bin = bitget(ONevents(jj,2),bits:-1:1);
% %             AERstream((sizeVid(1)*sizeVid(2))*(ii-1)+jj,:) = [onrow_bin oncol_bin bitget(on,bits:-1:1)];
%                 AERstream((sizeVid(1)*sizeVid(2))*(ii-1)+jj,:) = [ONmat(jj,1) ONmat(jj,2) on ii];
%         else
% %             onrow_bin = dec2bin(ONevents(jj,1),bits);
% %             oncol_bin = dec2bin(ONevents(jj,2),bits);
% %             AERstream((sizeVid(1)*sizeVid(2))*(ii-1)+jj,:) = strcat(onrow_bin,oncol_bin,dec2bin(on, bits)); 
% %             onrow_bin = bitget(ONevents(jj,1),bits:-1:1);
% %             oncol_bin = bitget(ONevents(jj,2),bits:-1:1);
% %             AERstream((sizeVid(1)*sizeVid(2))*(ii-1)+jj,:) = [onrow_bin oncol_bin bitget(on,bits:-1:1)];
%                 AERstream((sizeVid(1)*sizeVid(2))*(ii-1)+jj,:) = [ONmat(jj,1) ONmat(jj,2) on ii];
% %             offrow_bin = dec2bin(OFFevents(jj,1),bits);
% %             offcol_bin = dec2bin(OFFevents(jj,2),bits);
% %             AERstream((sizeVid(1)*sizeVid(2))*(ii-1)+jj,:) = strcat(offrow_bin,offcol_bin,dec2bin(off, bits)); 
% %             offrow_bin = bitget(OFFevents(jj,1),bits:-1:1);
% %             offcol_bin = bitget(OFFevents(jj,2),bits:-1:1);
% %             AERstream((sizeVid(1)*sizeVid(2))*(ii-1)+jj,:) = [offrow_bin offcol_bin bitget(off,bits:-1:1)];
%                 AERstream((sizeVid(1)*sizeVid(2))*(ii-1)+jj+1,:) = [OFFmat(jj,1) OFFmat(jj,2) off ii];
%         end
%   end
