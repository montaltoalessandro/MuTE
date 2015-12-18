function [ G, D ] = get_3D_groups( Width, Depth, Height, params )

%==========================================================================
% GET_3D_GROUPS
%
% [ G, D ] = get_3D_groups( Height, Width, Depth, params )
%
% Depth <-> y ; Width <-> x ; Height <-> z
%
% The coding of the variables, the inputs and outputs are similar to the 2-D setting (see get_2D_groups.m)
%
% To visualize the group in G indexed by g, use reshape( G(:,g), Depth, Width, Height)
%
% Copyright (c) 2010 Rodolphe Jenatton. All rights reserved.
%==========================================================================

%--------------------------------------------------------------------------
% Process params
%--------------------------------------------------------------------------
if isfield( params, 'exp_factor' ),
    exp_factor = params.exp_factor;
else
    exp_factor = 0.5;
end
%--------------------------------------------------------------------------
if isfield( params, 'rectangle' ) && islogical(params.rectangle),
    rectangle = params.rectangle;
else
    rectangle = true;
end
%--------------------------------------------------------------------------
if isfield( params, 'pi4' ) && islogical(params.pi4),
    pi4 = params.pi4;
else
    pi4 = false;
end
%--------------------------------------------------------------------------

G = [];
D = [];

if rectangle,

    [ G, D ] = get_rectangular_3D_groups( Width, Depth, Height, exp_factor );
  
end

if pi4,
    
    [ G_, D_ ] = get_pi4_3D_groups( Width, Depth, Height, exp_factor );
    
    G = [G,G_];
    D = [D,D_];
    
end   


end
%==========================================================================
%==========================================================================
function [ G, D ] = get_rectangular_3D_groups( Width, Depth, Height, beta )


ncells  = Height * Width * Depth;

[x,y,z] = meshgrid( 1:Width, 1:Depth, 1:Height );

x = x(:);
y = y(:);
z = z(:);

G = false( ncells, 2*( Height + Width + Depth - 3 ) );
D = zeros( ncells, 2*( Height + Width + Depth - 3 ) );

k = 1;

%==========================================================================
%==========================================================================
%==========================================================================

diagonal_index = 1:(Width-1);

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index       = ( x == diagonal_index(i) );

        D(index, k) = beta^(j-i);
        
        G(index,k)  = true;
    end
    
    k = k + 1;
    
end

%==========================================================================

diagonal_index = Width:-1:2;

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index       = ( x == diagonal_index(i) );

        D(index, k) = beta^(j-i);
        
        G(index,k)  = true;
    end
    
    k = k + 1;
    
end

%==========================================================================
%==========================================================================
%==========================================================================

diagonal_index = 1:(Depth-1);

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index       = ( y == diagonal_index(i) );

        D(index, k) = beta^(j-i);
        
        G(index,k)  = true;
    end
    
    k = k + 1;
    
end

%==========================================================================

diagonal_index = Depth:-1:2;

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index       = ( y == diagonal_index(i) );

        D(index, k) = beta^(j-i);
        
        G(index,k)  = true;
    end
    
    k = k + 1;
    
end

%==========================================================================
%==========================================================================
%==========================================================================

diagonal_index = 1:(Height-1);

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index       = ( z == diagonal_index(i) );

        D(index, k) = beta^(j-i);
        
        G(index,k)  = true;
    end
    
    k = k + 1;
    
end

%==========================================================================

diagonal_index = Height:-1:2;

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index       = ( z == diagonal_index(i) );

        D(index, k) = beta^(j-i);
        
        G(index,k)  = true;
    end
    
    k = k + 1;
    
end

end
%==========================================================================
%==========================================================================
%==========================================================================
function [ G, D ] = get_pi4_3D_groups( Width, Depth, Height, beta )


ncells  = Height * Width * Depth;

[x,y,z] = meshgrid( 1:Width, 1:Depth, 1:Height );

x = x(:);
y = y(:);
z = z(:);

G = false( ncells, 8*( (Height + Width + Depth)-3 ) );
D = zeros( ncells, 8*( (Height + Width + Depth)-3 ) );

k = 1;

%==========================================================================

diagonal_index = 2:(Width + Height - 1);

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index      = ( x+z == diagonal_index(i) );
        
        G(index,k) = true;
        
        D(index,k) = beta^(j-i);
        
    end
    
    k = k + 1;
    
end

%==========================================================================

diagonal_index = (Width + Height):-1:3;

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index      = ( x+z == diagonal_index(i) );
        
        G(index,k) = true;
        
        D(index,k) = beta^(j-i);
        
    end
    
    k = k + 1;
    
end
%==========================================================================

diagonal_index = (-Width + 1):(Height - 2);

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index      = ( -x+z == diagonal_index(i) );
        
        G(index,k) = true;
        
        D(index,k) = beta^(j-i);
        
    end
    
    k = k + 1;
    
end

%==========================================================================

diagonal_index = (Height - 1):-1:(-Width+2);

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index      = ( -x+z == diagonal_index(i) );
        
        G(index,k) = true;
        
        D(index,k) = beta^(j-i);
        
    end
    
    k = k + 1;
    
end

%==========================================================================
%==========================================================================
%==========================================================================

diagonal_index = 2:(Width + Depth - 1);

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index      = ( x+y == diagonal_index(i) );
        
        G(index,k) = true;
        
        D(index,k) = beta^(j-i);
        
    end
    
    k = k + 1;
    
end

%==========================================================================

diagonal_index = (Width + Depth):-1:3;

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index      = ( x+y == diagonal_index(i) );
        
        G(index,k) = true;
        
        D(index,k) = beta^(j-i);
        
    end
    
    k = k + 1;
    
end
%==========================================================================

diagonal_index = (-Width + 1):(Depth - 2);

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index      = ( -x+y == diagonal_index(i) );
        
        G(index,k) = true;
        
        D(index,k) = beta^(j-i);
        
    end
    
    k = k + 1;
    
end

%==========================================================================

diagonal_index = (Depth - 1):-1:(-Width + 2);

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index      = ( -x+y == diagonal_index(i) );
        
        G(index,k) = true;
        
        D(index,k) = beta^(j-i);
        
    end
    
    k = k + 1;
    
end

%==========================================================================
%==========================================================================
%==========================================================================

diagonal_index = 2:(Depth + Height - 1);

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index      = ( y+z == diagonal_index(i) );
        
        G(index,k) = true;
        
        D(index,k) = beta^(j-i);
        
    end
    
    k = k + 1;
    
end

%==========================================================================

diagonal_index = (Depth + Height):-1:3;

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index      = ( y+z == diagonal_index(i) );
        
        G(index,k) = true;
        
        D(index,k) = beta^(j-i);
        
    end
    
    k = k + 1;
    
end
%==========================================================================

diagonal_index = (-Height + 1):(Depth - 2);

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index      = ( -z+y == diagonal_index(i) );
        
        G(index,k) = true;
        
        D(index,k) = beta^(j-i);
        
    end
    
    k = k + 1;
    
end

%==========================================================================

diagonal_index = (Depth - 1):-1:(-Height + 2);

for j=1:length(diagonal_index),
       
    for i=1:j,
        
        index      = ( -z+y == diagonal_index(i) );
        
        G(index,k) = true;
        
        D(index,k) = beta^(j-i);
        
    end
    
    k = k + 1;
    
end

end
%==========================================================================