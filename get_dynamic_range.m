G_data = [];
vol_infused = (unique(data_02.vol_Infused));
numFills = length(vol_infused);

xFills = diff(data_02.vol_Infused);
idxFills = sort([find(xFills>0);find(xFills<0)]);
idxFills(end+1) = length(data_02.vol_Infused);

numTrials = length(idxFills)/numFills;
idxFills = reshape(idxFills, [numFills numTrials]);


for col = 1:numTrials 
    for row = 1:numFills-1
       vol_a = idxFills(row,col);
       vol_b = idxFills(row+1,col);
       G_data(row, col) = median(data_02.v1(vol_a:vol_b));
    end
end
G_diff = diff(G_data);
% figure(); 
% for i = 1:numTrials 
%     plot(nonzeros(vol_infused), G_data(:,i),'o','Color', [0.8500 0.3250 0.0980])
%     grid on;
%     hold on
% end