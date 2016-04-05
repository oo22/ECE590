I = imread('CapandBattery_1.tiff'); %it likes tiff rather than gif
I = rgb2gray(I); %need to convert color image into a BW in order to hae a 2D image array
%figure
%imshow(I)
rotI = imrotate(I,0,'crop'); %this makes it so that the output image is the same size as the input image'
figure
imshow(rotI)

BW = edge(rotI, 'canny'); %makes it so that it outlines the edges 
figure,imshow(BW);
[H,theta,rho] = hough(BW);
imshow(imadjust(mat2gray(H)),[],...
    'XData',theta,...
    'YData',rho,...
    'InitialMagnification','fit');
xlabel('\theta (degrees)')
ylabel('\rho')
axis on
axis normal
hold on
colormap(hot)
P = houghpeaks(H,5,'threshold', ceil(.3*max(H(:)))); %finds the peaks in the Hough transform matrix
x = theta(P(:,2)); %superimpose a plot on the transform image to identify the peaks. There are only two columns in P
y = rho(P(:,1));
plot(x,y,'s','color','black');
lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',40); %finding the lines %fillgap is the distance between two line segments associated with same Hough transform bin. 
%if the distance between the two segments is less than the value specificed
%then the houghlines function merges the lines segments into one single
%line segment. Min length is the minimum line length

%this is for bypass the components..as you see 40 is large 

figure, imshow(rotI), hold on
max_len = 0;
points_1 = zeros (2,2,10);
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   points_1(:,:,k) = xy;
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');
