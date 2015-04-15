function dispM = get_disparity(IL,IR,maxDisp,windowSize)
% Create disparity map from rectified images Il, IR where
% maxDisp is the maximum disparity and windowSize is the window size.

mask = ones(windowSize, windowSize);
[row, col] = size(IL);
disps = zeros(row, col, maxDisp+1);
tmp = zeros(row, col);

for i=0:maxDisp
    idx = 1:(row * (col-i));
    tmp(idx) = (IL(idx + row*i) - IR(idx)).^2;
    disps(:,:,i+1) = conv2(tmp, mask, 'same');
end

[vals, inds] = min(disps, [], 3);
dispM = inds - 1;

%//debug
%figure; imagesc(dispM); colormap(gray); axis image;