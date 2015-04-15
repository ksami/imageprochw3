function [RM1, RM2, A1n, A2n, R1n, R2n, T1n, T2n] = rectify_pair(A1, A2, R1, R2, T1, T2)
% This function takes left and right camera parameters (A,R,T) and returns left and
% right rectification matrices (M1,M2) and updated camera parameters.

% 1. Compute the optical center c1 and c2 of each camera. %
c1 = (A1 * R1) \ (A1 * T1);
c2 = (A2 * R2) \ (A2 * T2);

% 2. Compute the new rotation matrix %
