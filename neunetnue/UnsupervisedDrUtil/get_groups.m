function spG = get_groups( mode, dims )

%==========================================================================
% GET_GROUPS
%
% Easy interface to generate overlapping sets of groups such as 
%
%   -For the 2D setting (length(dims)==2):
%
%       + rectangles (mode.rectangle==true)
%       + groups with pi/4 orientations (mode.pi4==true)
% 
%   -For the 3D setting (length(dims)==3):
%
%       + rectangular boxes (mode.rectangle==true)
%       + groups with pi/4 orientations (mode.pi4==true)
%
%
%       dims(1) <-> height
%       dims(2) <-> width
%       (if length(dims)==3, dims(3) <-> depth)
%
% For a more complete parametrization of the groups (e.g., the weights), see get_2D_groups.m and get_3D_groups.m
%
%
% For more details, see
%
%   (2009) R. Jenatton, G. Obozinski and F. Bach.  Structured sparse principal component analysis.
%   (2009) R. Jenatton, J.-Y. Audibert and F. Bach. Structured variable selection with sparsity-inducing norms. 
%
% Copyright (c) 2010 Rodolphe Jenatton. All rights reserved.
%==========================================================================

if (length(dims) == 2), % 2D case
    
    params.slope = [];
    
    if isfield(mode,'rectangle') && mode.rectangle,     
        params.slope = [params.slope, 0];
    end
    if isfield(mode,'pi4') && mode.pi4,     
        params.slope = [params.slope, 1];
    end
    if isempty(params.slope),
       params.slope = 0;
    end
    
    %dims(1) <-> height
    %dims(2) <-> width
    
    [ G, D ] = get_2D_groups( dims(1), dims(2), params );
    
    spG = sparse(D);
    
elseif (length(dims) == 3 ), % 3D case
    
    %dims(1) <-> height
    %dims(2) <-> width
    %dims(3) <-> depth
    
    [ G, D ] = get_3D_groups( dims(1), dims(2), dims(3), mode );
    
    spG = sparse(D);
   
else           
    error('*** The dimensions provided are erroneous ! (The length of dims must 2 or 3) ***')
end


end