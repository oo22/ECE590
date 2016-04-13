I = imread('CapandBattery copy.png'); %it likes tiff rather than gif
I = rgb2gray(I); %need to convert color image into a BW in order to hae a 2D image array
%figure
%imshow(I)
rotI = imrotate(I,0,'crop'); %this makes it so that the output image is the same size as the input image'
% figure
% imshow(rotI)

BW = edge(rotI, 'canny'); %makes it so that it outlines the edges 
% figure,imshow(BW);
[H,theta,rho] = hough(BW);
% imshow(imadjust(mat2gray(H)),[],...
%     'XData',theta,...
%     'YData',rho,...
%     'InitialMagnification','fit');
% xlabel('\theta (degrees)')
% ylabel('\rho')
% axis on
% axis normal
% hold on
% colormap(hot)
P = houghpeaks(H,4,'threshold', ceil(.3*max(H(:)))); %finds the peaks in the Hough transform matrix
x = theta(P(:,2)); %superimpose a plot on the transform image to identify the peaks. There are only two columns in P
y = rho(P(:,1));
% plot(x,y,'s','color','black');
lines = houghlines(BW,theta,rho,P,'FillGap',3,'MinLength',20); %finding the lines %fillgap is the distance between two line segments associated with same Hough transform bin. 
%if the distance between the two segments is less than the value specificed
%then the houghlines function merges the lines segments into one single
%line segment. Min length is the minimum line length


figure, imshow(rotI), hold on
max_len = 0;
points = zeros (2,2,10);
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   points(:,:,k) = xy; %putting the points into a matrix 
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
%    % Plot beginnings and ends of lines
%    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

end
cap_1=[points(2,:,1);points(1,:,2)]
cap_2=[points(2,:,3);points(1,:,4)]
cap_3=[points(2,:,5);points(1,:,6)]
cap_4=[points(2,:,7);points(1,:,8)] %why 2,:,1 instead of 2,2,1?
 figure, imshow(rotI), hold on
% Plot beginnings and ends of lines
plot(cap_1(1,1),cap_1(1,2),'x','LineWidth',2,'Color','yellow');
plot(cap_1(2,1),cap_1(2,2),'x','LineWidth',2,'Color','yellow');
plot(cap_2(1,1),cap_2(1,2),'x','LineWidth',2,'Color','red');
plot(cap_2(2,1),cap_2(2,2),'x','LineWidth',2,'Color','red');
plot(cap_3(1,1),cap_3(1,2),'x','LineWidth',2,'Color','green');
plot(cap_3(2,1),cap_3(2,2),'x','LineWidth',2,'Color','green');
plot(cap_4(1,1),cap_4(1,2),'x','LineWidth',2,'Color','black');
plot(cap_4(2,1),cap_4(2,2),'x','LineWidth',2,'Color','black');

for ii = 1:2:(k)
fprintf('Analyzing capacitor %f\n', ii); 
diff_cap_1 = abs(points(2,:,ii)-points(1,:,ii+1))
if diff_cap_1(1) ==0 %this means it's vertical 
      x_max= round((diff_cap_1(2))/2) + points(1,1,ii); 
      x_min= points(1,1,ii)-round((diff_cap_1(2))/2); %add to horizantal
      cap = [points(2,:,ii);points(1,:,ii+1)];
      y_min = min(cap(:,2))-2;
      y_max = max(cap(:,2))+2;
   
else 
    y_max= round((diff_cap_1(1))/2) + points(1,2,ii);
    y_min= points(1,2,ii)-round((diff_cap_1(1))/2);
    cap = [points(2,:,ii);points(1,:,ii+1)];
    x_min = min(cap(:,1))-2;
    x_max = max(cap(:,1))+2;
end

figure;
New_I=I(y_min:y_max,x_min:x_max);
imshow(New_I);
end 




% boundary = bwtraceboundary(BW,[116, 18],'W');
% imshow(I)
% hold on;
% list = zeros (1,2,1);
% for ii = length(boundary)/2+30.5:length(boundary)-30
% xx = [boundary(ii,1), boundary(ii,2)];
% list(:,:,ii) = xx;
% plot(boundary(ii,2),boundary(ii,1),'g','LineWidth',3);
% end
% BW2 = bwselect(116,18,BW,2,2,1);
% imshow(BW2);
% 
% % % 0 = black, 255 = white 
% % for jj = 164:length(list)
% %     I(list(:,:,jj))=[0,0];
% % end 
% % imshow(I)