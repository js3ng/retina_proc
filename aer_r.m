% function [ AERstream ] = aer_r( AERstream )

lengthStr = size(st_vid);
bits = 9;
rowSize = height;
colSize = width;

figure(1);
image = zeros(rowSize,colSize);
imagesc(image);
colormap(gray);
for ii = 1:size(AERstream,1)
%     row = bin2dec(AERstream(ii,1));
%     col = bin2dec(AERstream(ii,2));
%     event = bin2dec(AERstream(ii,3));
    image(AERstream(ii,1),AERstream(ii,2)) = AERstream(ii,3);
    figure(1);
    imagesc(image);
    colormap(gray);
    pause(1/1e9);
end



% end
