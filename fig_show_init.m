function [ fig ] = fig_show_init
fig=figure(1);
fig.Units='normalize';
fig.Position=[0 0 1 1];
ax(1)=axes;
ax(2)=axes;
ax(3)=axes;
x0=0.075;
y0=0.325;
dx=0.25;
dy=0.35;
ax(1).Position=[x0 y0 dx dy];
x0=x0+dx+0.05;
ax(2).Position=[x0 y0 dx dy];
x0=x0+dx+0.05;
ax(3).Position=[x0 y0 dx dy];


set(ax(1),'XTick',[],'YTick',[]);
set(ax(2),'XTick',[],'YTick',[]);
set(ax(3),'XTick',[],'YTick',[]);

ax(1).Title.String='Input video';
ax(2).Title.String='Spatial output';
ax(3).Title.String='Spatio-temporal output';

% set(im(1),'cdata',in1(:,:));
% set(im(2),'cdata',in2(:,:));
% set(im(3),'cdata',in3(:,:));
% drawnow;
% pause(1/20);


end

