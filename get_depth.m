function depthM = get_depth(dispM,A1,A2,R1,R2,t1,t2)
% Creates depth map from disparity map dispM

[row, col] = size(dispM);
depthM = zeros(row, col);

c1 = (A1 * R1) \ (A1 * t1);
c2 = (A2 * R2) \ (A2 * t2);
b = norm(c1 - c2);
f = A1(1,1);

for y=1:row
    for x=1:col
        if(dispM(y,x) == 0)
            depthM(y,x) = 0;
        else
            depthM(y,x) = b * f / dispM(y,x);
        end
    end
end