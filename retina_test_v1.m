clear; clc;
addpath ./model_code/

kern_size = 9;
pix_width = 8;
kern_width = 4;

vidFile = 'handshake_left.avi';
pixHeight = 32;
pixWidth = 32;
nFrames = 32;

vid = readVideo_rs(vidFile, pixHeight, pixWidth, nFrames);
fps = 5;
for ii = 1:nFrames
	figure(1);
	imagesc(vid(:,:,ii));
	colormap(gray);
	pause(1/fps);
end

fid = fopen('retina_test_in.txt','w');

h = [1 2 1; 2 4 2; 1 2 1]; h = dec2bin(h, kern_width);
h_str = '';
for kk = 1:length(h)
	h_str = strcat(h_str, h(kk,:));
end
num = 0;	

mode = 0;
m_str = dec2bin(mode,2);
thresh1 = 1;
t1_str = dec2bin(thresh1, 9);
thresh2 = -1;
t2_str = strcat('1',dec2bin(typecast(int8(thresh2),'uint8'), 8));
rst = 1;
r_str = int2str(rst);
store = 0;
s_str = int2str(store);
smp_str = int2str(0);
tic;
for ii = 1:nFrames-1
	%%%get two frames and pad them
	f_p1 = padarray(vid(:,:,ii), [1 1] , 0, 'both');
	f_p2 = padarray(vid(:,:,ii+1), [1 1] , 0, 'both');
	bb = 0;
	for jj = 2:pixHeight+1
		for kk = 2:pixWidth+1
			%%%get two patches from consecutive frames
			p1 = [f_p1(jj-1,kk-1) f_p1(jj-1,kk) f_p1(jj-1,kk+1); f_p1(jj,kk-1) f_p1(jj,kk) f_p1(jj,kk+1); f_p1(jj+1,kk-1) f_p1(jj+1,kk) f_p1(jj+1,kk+1)];
			p2 = [f_p2(jj-1,kk-1) f_p2(jj-1,kk) f_p2(jj-1,kk+1); f_p2(jj,kk-1) f_p2(jj,kk) f_p2(jj,kk+1); f_p2(jj+1,kk-1) f_p2(jj+1,kk) f_p2(jj+1,kk+1)];
			p1_bin = dec2bin(p1', pix_width);
			p1_str = '';
			for ll = 1:length(p1_bin)
				p1_str = strcat(p1_str, p1_bin(ll,:));
			end
			p2_bin = dec2bin(p2', pix_width);
			p2_str = '';
			for ll = 1:length(p2_bin)
				p2_str = strcat(p2_str, p2_bin(ll,:));
			end
			if length(p2_str) > pix_width*kern_size
				bb = 1;
				break;
			end
			% reset for one clock cycles
			rst = 1;
			r_str = int2str(rst);
			store = 0;
			s_str = num2str(store);
			smp = 0;
			smp_str = num2str(smp);
			din = strcat(r_str,s_str,smp_str, m_str,t1_str,t2_str,h_str,p1_str);
			fprintf(fid,[din '\n']);
			% store two patches
			rst = 0;
			r_str = int2str(rst);
			store = 1;
			s_str = num2str(store);
			din = strcat(r_str,s_str,smp_str, m_str,t1_str,t2_str,h_str,p1_str);
			fprintf(fid,[din '\n']);
			din = strcat(r_str,s_str,smp_str, m_str,t1_str,t2_str,h_str,p2_str);
			fprintf(fid,[din '\n']);
			% wait for processing for 4 clock cycles
			store = 0;
			s_str = num2str(store);
			din = strcat(r_str,s_str,smp_str, m_str,t1_str,t2_str,h_str,p2_str);
			fprintf(fid,[din '\n']);
			din = strcat(r_str,s_str,smp_str, m_str,t1_str,t2_str,h_str,p2_str);
			fprintf(fid,[din '\n']);
			din = strcat(r_str,s_str,smp_str, m_str,t1_str,t2_str,h_str,p2_str);
			fprintf(fid,[din '\n']);
			din = strcat(r_str,s_str,smp_str, m_str,t1_str,t2_str,h_str,p2_str);
			fprintf(fid,[din '\n']);
			smp = 1;
			smp_str = num2str(smp);
			din = strcat(r_str,s_str,smp_str, m_str,t1_str,t2_str,h_str,p2_str);
			fprintf(fid,[din '\n']);
			num = num + 1;
		end
		if bb == 1
			break
		end
	end
end
time = toc;

fprintf(fid,[din '\n']);
fclose(fid);

clkT = 10e-9;
res = 1e-6;
procC = 8;
nProc = 1;

t_proc = (clkT*pixWidth*pixHeight*(nFrames-1)*procC/res)/(nProc);

display('-----RUN VHDL AND RESUME WHEN FINISHED-----');
pause;

fid = fopen('retina_test_out.txt','r');
kk = 1;

while 1
	tline = fgetl(fid);
	if ~ischar(tline), break, end
	spat_vec(kk,:) = bin2dec(tline(1:8));
	temp_vec(kk,:) = bin2dec(tline(9:16));
	kk = kk+ 1;
end

for ii = 1:nFrames
	for jj = 1:pixHeight
		for kk = 1:pixWidth
			spat_arr(jj,kk,ii) = spat_vec((pixHeight*pixWidth)*(ii-1)+pixWidth*(jj-1)+kk,:);
			temp_arr(jj,kk,ii) = temp_vec((pixHeight*pixWidth)*(ii-1)+pixWidth*(jj-1)+kk,:);
		end 
	end
end

for ii = 1:nFrames
	figure(2);
	imagesc(spat_arr(:,:,ii));
	colormap(gray);
	pause(1/fps);
	figure(3);
	imagesc(temp_arr(:,:,ii));
	colormap(gray);
	pause(1/fps);
end 

fclose(fid);
