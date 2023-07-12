function [EMGLabels] = getPlotPowCorrTask(EEG, fdPowCorr, chanClass, freqBands, lesionSide, strokeType, saveTopos)

col = size(chanClass.EMGLocs, 2);
for i = 1:col
    EMGLabels{i} = chanClass.EMGLocs(i).labels;
end

%GRAPHI
col = size(EMGLabels,2);
for i = (length(chanClass.EEGChans)+1):col
    cfg                  = [];
    cfg.parameter        = 'powcorrspctrm';
    cfg.xlim             = [freqBands.delta(1) freqBands.delta(end-1); freqBands.theta(1) freqBands.theta(end-1); freqBands.alphaMu(1) freqBands.alphaMu(end-1); freqBands.beta1(1) freqBands.beta1(end-1); freqBands.beta2(1) freqBands.beta2(end-1); freqBands.gamma1(1) freqBands.gamma1(end-1); freqBands.gamma2(1) freqBands.gamma2(end-1)];
    cfg.zlim             = [-1 1];
    cfg.comment          = 'xlim';
    cfg.channel = chanClass.EEGOriginalLabels;
    cfg.refchannel = EMGLabels{1, i};
    
    if lesionSide == 'r'
        if strokeType == 'cort'
            cfg.layout           = 'GSN-HydroCel-257-flip.sfp';
        end
    else
        cfg.layout       = 'GSN-HydroCel-257.sfp';
    end
    figure; ft_topoplotER(cfg, fdPowCorr);
    imName = strcat(EEG.setname, '_PowCorrTask_', EMGLabels{1, i}, '.svg');
    title(imName)
    if saveTopos =='y'
        saveas(gcf, imName);
    end
end