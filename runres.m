in1 = readVideo('./nofilt.avi');
in2 = readVideo('./gaussfilt_1.avi');
in3 = readVideo('./eventout_nofilt.avi');
in4 = readVideo('./eventout_gaussfilt.avi');

fig2 = fig_show2(in1, in2, in3, in4);