%This is the FGENN Main Algorithm
%To find neighbors of any datapoint call Function YasirNeighbours3()
%To Find Neighbors of Datapoint 13 with Diff = 1 
%First Generate FinalRankedOutput by executing Algorithm 1 Code snippet
%in YasirRank.m File
%code will be YasirNeighbours3(1,FinalRankedOutput,13)
function NeighbouringIndexes = YasirNeighbours3(Diff, FinalRankedOutput, DPIndex)
for Feature=1:length(FinalRankedOutput(:,1))
    if(Feature==1)
        NeighbouringIndexes = [];
        Row = FinalRankedOutput(1,:);
        RItem=Row(1,DPIndex);
        for I=1:length(Row)
            if(Row(1,I)-Diff<=RItem)&&(RItem<=Row(1,I)+Diff)
                NeighbouringIndexes = [NeighbouringIndexes,I];
            end
        end
    else    
        NeighbouringIndexesTemp=NeighbouringIndexes;
        Row = FinalRankedOutput(Feature,:);
        RItem=Row(1,DPIndex);
        %====
        for I=1:length(NeighbouringIndexesTemp)
            if(Row(NeighbouringIndexesTemp(I))>=RItem-Diff)&&(Row(NeighbouringIndexesTemp(I))<=RItem+Diff)
                continue;
            else
                NeighbouringIndexes=NeighbouringIndexes(NeighbouringIndexes~=NeighbouringIndexesTemp(I));
            end
        end
        %====
        
    end
end
    
NeighbouringIndexes=NeighbouringIndexes(NeighbouringIndexes~=DPIndex);
%fprintf('Neighbours of DataPoint %d are:',DPIndex);
%disp(NeighbouringIndexes);
%fprintf('\n');