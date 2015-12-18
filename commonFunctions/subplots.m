function [] = subplots(nameFile,titleFig)

    numReshapedMtx = dir(['*' nameFile '*.mat']);
    f = figure;
    ha = tight_subplot(length(numReshapedMtx),1,[0.1 0.1],[0.05 0.05],[0.06 0.01]);
    for i = 1:length(numReshapedMtx)
    %     h = subplot(length(numReshapedMtx),2,i);
        load(numReshapedMtx(i).name);
        axes(ha(i));
        set(gca,'FontSize',14);
        imagesc(meanRes);
    %     meanImg = imagesc(meanRes);
        colormap(1-gray);
        colorbar;
        if (strfind(numReshapedMtx(i).name,'linearNonUniformTransferEntropy'))
                title('LIN NUE','FontSize',20);
        elseif (strfind(numReshapedMtx(i).name,'nonUniformTransferEntropy'))
                title('BIN NUE','FontSize',20);
        elseif (strfind(numReshapedMtx(i).name,'nonUniTENearNeighbour'))
                title('NN NUE','FontSize',20);
        elseif (strfind(numReshapedMtx(i).name,'binTransferEntropy'))
                title('BIN UE','FontSize',20);
        elseif (strfind(numReshapedMtx(i).name,'linearTransferEntropy'))
                title('LIN UE','FontSize',20);
        elseif (strfind(numReshapedMtx(i).name,'uniTENearNeighbour'))
                title('NN UE','FontSize',20);
        elseif (strfind(numReshapedMtx(i).name,'nonUniNeuralNet'))
                title('NeuNet NUE','FontSize',20);
        end
    %     title(['row influences column  |  ' numReshapedMtx(i).name(1:end-19)],'FontSize',16);
    %     axis image
    %     titleFig = [numReshapedMtx(i).name(1:end-19) '_meanReshapedMtx_grayScale'];
    %     saveas(meanImg,titleFig,'png');
    end

    % titleFig = [numReshapedMtx(i).name(1:end-19) '_meanReshapedMtx_grayScale'];
    set(f,'Position',[1 1 1680 1050]);
    saveas(f,titleFig,'png');

return;