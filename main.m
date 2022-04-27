clc;
clear all;
close all;
home;

% Read Input images and display
%    I1=rgb2gray(imread('..'));
%      I2=rgb2gray(imread('..'));
  I1=(imread('..'));
  I2=(imread('..'));


% Assigning values to the parameters
 n=20; 
 dt=3;
 k=4;
 m=2;
 % Decomposing input images
[CL1]=piifcm(I1,n);
o1=I1.*(CL1);  
b1=double(I1)-double(o1);
o2=I2.*(CL1); 
b2=double(I2)-double(o2);

   figure,imshow(o1, [],'border','tight');
     figure,imshow(b1, [],'border','tight');
        figure,imshow(o2, [],'border','tight');
     figure,imshow(b2, [],'border','tight');
 % Target Region Fusion 
imf1= selc_myem1(o1,o2)

  % Background Region Fusion 

  C1 = cov([b1(:) b2(:)]);
  [V11, D11] = eig(C1);
        if D11(1,1) >= D11(2,2)
        pca1 = V11(:,1)./sum(V11(:,1));
        else  
        pca1 = V11(:,2)./sum(V11(:,2));
        end
  imf3 = pca1(1)*I1 + pca1(2)*I2;
  imf4 = imf2+imf3 ;
% Final fused image

fuseimage=(double(imf1)+double(imf4));

figure, imshow(fuseimage, [],'border','tight');

 
