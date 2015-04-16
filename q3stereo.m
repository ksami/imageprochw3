function q3stereo(dataset, fParam)
% Perform rectification and estimates disparity/depth maps for
% all images in dataset. fParam is the camera parameter file.

% Parameters %
maxDisp = 15;
windowSize = 5 ;


% FileOps %
inPath = sprintf('../data/%s', dataset);
outPath = sprintf('./output_%s', dataset);
if(~exist(outPath, 'dir'))
    mkdir(outPath);
end

% filename prefixes
prec1 = 'rec1_';
prec2 = 'rec2_';
pdisp = 'disp_';
pdept = 'dept_';


% load camera parameters
load(fParam, 'A1', 'R1', 'T1', 'A2', 'R2', 'T2') ;

% rectify camera parameters
[RM1, RM2, A1n, A2n, R1n, R2n, T1n, T2n] = rectify_pair(A1, A2, R1, R2, T1, T2) ;


% ImgOps %
imgs = dir(sprintf('%s/*.pgm', inPath));

for i=1:2:numel(imgs)
    fIL = imgs(i).name;
    fIR = imgs(i+1).name;
    
    fRectIL = sprintf('%s/%s%s', outPath, prec1, fIL);
    fRectIR = sprintf('%s/%s%s', outPath, prec2, fIR);
    
    fDispIm = sprintf('%s/%s%s', outPath, pdisp, fIL);
    fDeptIm = sprintf('%s/%s%s', outPath, pdept, fIL);
    
    IL = imread(sprintf('%s/%s', inPath, fIL));
    IR = imread(sprintf('%s/%s', inPath, fIR));
    
    
    % --------------------  Rectification

    [rectIL, rectIR, bbL, bbR] = warp_stereo(IL, IR, RM1, RM2) ;

    % resize to [240x320]
    rRectIL = imresize(rectIL, [240 320]);
    rRectIR = imresize(rectIR, [240 320]);
    
    % save
    imwrite(rRectIL, fRectIL);
    imwrite(rRectIR, fRectIR);


    % --------------------  Disparity

    dispM = get_disparity(rectIL, rectIR, maxDisp, windowSize) ;

    % --------------------  Depth

    depthM = get_depth(dispM, A1n, A2n, R1n, R2n, T1n, T2n) ;

    % -------------------- File saving

    % resize
    dispM = imresize(dispM, [240 320]);
    depthM = imresize(depthM, [240 320]);
    
    % save
    imwrite(dispM, fDispIm) ;
    imwrite(depthM, fDeptIm) ;
end
