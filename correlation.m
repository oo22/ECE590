%resize images to be the same 
R1=imread('resistor2.jpg'); %265x500
R_db=rgb2gray(imread('resistor1.png')); %750 x 2000
R1=imresize(R1, 4);
R_db_size = size(R_db);
R1size=size(R1);
R1=imcrop(R1, [0 150 R_db_size(2) R_db_size(1)-1]);
corr_R = corr2(R1, R_db)

cap_db=rgb2gray(imread('capacitor.png')); 
 

