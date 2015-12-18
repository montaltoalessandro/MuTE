function u1=pharand(u)
%
%  u1=pharand(u)
%  Randomise the phase of matrix u
%
%  Ref: Yamada & Ohkitani 1991  Orthonormal wavelet analysis of turbulence
%  Fluid Dynamics Res, 8: 101-115.
%
[n,m]=size(u);
n2=fix(n/2);
% If n is odd we need to deal with n/2+1 data
if 2*n2 ~= n
   n2=n2+1;
end
%  Transform u
U=fft(u);
% Find radius and random phase for first n2 data
R=abs(U(1:n2,:));
theta=rand(n2,m)*2*pi;  % uniform distribution of phase
%P=cos(theta) + i*sin(theta);
P=exp(1i*theta);     % this is faster than cos(theta) + i*sin(theta)

% Reconstitute the signal in the freq domain
% by constructing the top half first, then duplicating the
% bottom half by the reversed complex conj
U1top=R.*P;                  % top of FT
U2bot=conj(flipud(U1top));   % bottom of FT is complex conj of top

%  If n is even, the value at n/2+1 must have zero phase,
%  so replace it with the original data value ie U(n2+1)
if 2*n2 == n
   U1=[U1top;U(n2+1,:);U2bot(1:n2-1,:)];
else
   %  when n is odd we just butt the 2 arrays together
   U1=[U1top;U2bot(1:n2-1,:)];
end

%  Set the first component (ie mean) of both arrays to be same
U1(1,:)=U(1,:);

% Transform back and take real part (imag is zero, but no is complex)
u1=real(ifft(U1)); 