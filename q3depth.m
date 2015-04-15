clear all ;

% --------------------  parameters


% For office dataset
fIL = '../result/rectIL_office.pgm' ;
fIR = '../result/rectIR_office.pgm' ;
fRectP = '../result/rect_office.mat' ;
fDispIm = '../result/disparity_0_office.png' ;
fDepthIm = '../result/depth_0_office.png' ;
%}


%{
% For street dataset
fIL = '../result/rectIL_street.pgm' ;
fIR = '../result/rectIR_street.pgm' ;
fRectP = '../result/rect_street.mat' ;
fDispIm = '../result/disparity_0_street.png' ;
fDepthIm = '../result/depth_0_street.png' ;
%}

% --------------------  load two images
IL = imread(fIL) ;
IR = imread(fIR) ;


% --------------------  load RECTIFICATION

% load the rectification parameters
load(fRectP, 'RM1', 'RM2', 'A1n', 'A2n', 'R1n', 'R2n', 'T1n', 'T2n');


% --------------------  get disparity map

maxDisp = 15;
windowSize = 5 ;
dispM = get_disparity(IL, IR, maxDisp, windowSize) ;



% --------------------  get depth map

depthM = get_depth(dispM, A1n, A2n, R1n, R2n, T1n, T2n) ;


% --------------------  Display

figure; imagesc(dispM); colormap(gray); axis image;
figure; imagesc(depthM); colormap(gray); axis image;


% -------------------- File saving

imwrite(dispM, fDispIm) ;
imwrite(depthM, fDepthIm) ;
