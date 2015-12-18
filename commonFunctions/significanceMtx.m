function [reshaped_mtx] = significanceMtx(significanceOnDrivers,row,col)

     signif = sum(significanceOnDrivers);
     tmp = reshape(signif,row,col);
     reshaped_mtx = zeros(col);
     reshaped_mtx(:,1) = [0;tmp(:,1)];
     for j = 2:col-1
        reshaped_mtx(:,j) = [tmp(1:j-1,j);0;tmp(j:end,j)];
     end
     reshaped_mtx(:,col) = [tmp(:,col);0];

return;