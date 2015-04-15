function [RM1, RM2, A1n, A2n, R1n, R2n, T1n, T2n] = rectify_pair(A1, A2, R1, R2, T1, T2)
% This function takes left and right camera parameters (A,R,T) and returns left and
% right rectification matrices (M1,M2) and updated camera parameters.

% 1. Compute the optical center c1 and c2 of each camera. %
c1 = (A1 * R1) \ (A1 * T1);
c2 = (A2 * R2) \ (A2 * T2);

% 2. Compute the new rotation matrix %
r1 = (c1 - c2) / norm(c1 - c2);
r2 = cross(R1(3,:)', r1);
r3 = cross(r1, r2);
Rn = [r1 r2 r3]';

An = A2;

T1n = -Rn * c1;
T2n = -Rn * c2;

P1n = An * [Rn, T1n];
P2n = An * [Rn, T2n];

RM1 = (An * Rn) / (A1 * R1);
RM2 = (An * Rn) / (A2 * R2);


%fulfil output variables
A1n = An;
A2n = An;
R1n = Rn;
R2n = Rn;
