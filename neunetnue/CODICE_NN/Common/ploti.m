function h=ploti(x, y, colorSpec, varargin)
% h=ploti(x, y, colorSpec, varargin)

%     close all;
%     h = figure;
    C=size(y,2);
    
    xmin = min(x);
    xmax = max(x);
    xi = linspace(xmin,xmax,1000);        
    for i=1:C
        yi{i} = interp1(x,y(:,i),xi,'pchip');
        %yi{i} = interp1(x,y(:,i),xi,'spline');        
    end
    
    for i=1:C    
        color  = colorSpec((i-1)*2+1);
        symbol = colorSpec(i*2);
        plot(x,y(:,i),[color symbol],'MarkerSize',7,'LineWidth',1);
        hold on;
    end
    
    legend(varargin(:),'Location','Best');
    
    for i=1:C
        color  = colorSpec((i-1)*2+1);
        symbol = colorSpec(i*2);       

        switch color
            case 'r'
                intColor = [1 0.9 0.9];
            case 'g'
                intColor = [0.9 1 0.9];
            case 'b'
                intColor = [0.9 0.9 1];
            case 'k'
                intColor = [0.9 0.9 0.9];
            case 'm'
                intColor = [1 0.9 1];
            case 'c'
                intColor = [0.9 1 1];
        end

        plot(xi,yi{i},'LineWidth',4,'Color',intColor);
        hold on;        
    end
    
    for i=1:C    
        color  = colorSpec((i-1)*2+1);
        symbol = colorSpec(i*2);
        plot(x,y(:,i),[color symbol],'MarkerSize',7,'LineWidth',1);
        hold on;
    end   
    
    hold off;


return;