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
[A1]=fpdepyou(b1,n);
[A2]=fpdepyou(b2,n);
D1=double(I1)-double(A1);
D2=double(I2)-double(A2);

 A(:,:,1)=A1;
 A(:,:,2)=A2;
 
 D(:,:,1)=D1;
 D(:,:,2)=D2;
   figure,imshow(D1, [],'border','tight');
     figure,imshow(D2, [],'border','tight');
        figure,imshow(A1, [],'border','tight');
     figure,imshow(A2, [],'border','tight');
 % Target Region Fusion 
imf1= selc_myem1(o1,o2)

  % Background Region Basic Layer Fusion 
        imf2=(0.5*A1+0.5*A2);
  figure,imshow(imf2,[],'border','tight');
    % Background Region Detail Layer Fusion 
  C1 = cov([D1(:) D2(:)]);
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

 
