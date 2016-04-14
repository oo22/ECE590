A = imread('Battery.jpg');
A = rgb2gray(A);
imshow(A);
[centers, radii, metric] = imfindcircles(A,[15 30]);

viscircles(centers, radii,'EdgeColor','b');

point2=[radii + centers(1,1);centers(1,2)]
point3=[centers(1,1)-radii;centers(1,2)]

figure, imshow(A), hold on
% Plot beginnings and ends of lines
   plot(point1(1,1),point1(2,1),'x','LineWidth',2,'Color','yellow');
   plot(point2(1,1),point2(2,1),'x','LineWidth',2,'Color','red');