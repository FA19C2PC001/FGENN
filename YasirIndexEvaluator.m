%This file results those indexes whose output are same for KNN and My ALGO
%This file is to check individual DPIndex Neighbours
%It calculates neighbours with my algorithm and KNN Search algorithm
Matching_DPIndex = [];
%Classification Variables
BothWrong = 0;
CorrectMyAlgo=0;
CorrectKNNAlgo=0;
Black_Msg_Counts=0;
Red_Msg_Counts=0;
SpeciesGENN=species;
SpeciesKNN=species;
%Classification variable ends here
for DPIndex = 1 : length(Data)

Diff = 1;
Diff_Start = 2;%Default Value is 2
Min_N_Required=5;%it was 3
MaxDiff=5000;
%DPIndex = 3552; %Use this line if u want to perform test on a specific
%datapoint

%======My CODE for Searching Neighbours=====
NeighbouringIndexes = YasirNeighbours3(Diff,FinalRankedOutput,DPIndex);
    if(length(NeighbouringIndexes)<Min_N_Required)
        for Diff=Diff_Start:MaxDiff
            NeighbouringIndexes = YasirNeighbours3(Diff,FinalRankedOutput,DPIndex);
            if(length(NeighbouringIndexes)<Min_N_Required)
                continue;
            else
                break;
            end
            
        end        
    end
%===========Code For DataPoint KNN based Neighbours Searching===========
[Idx,D] = knnsearch((Data)',Data(:,DPIndex)','k',Min_N_Required);
Idx=Idx(Idx~=DPIndex);
KNN_Neighbors = sort(Idx);

if (ismember(KNN_Neighbors,NeighbouringIndexes))
    Matching_DPIndex = [Matching_DPIndex; DPIndex,Diff];
end
YasirClassification;
SpeciesGENN{DPIndex}=Distinct_Labels{Ind,1};
SpeciesKNN{DPIndex}=Distinct_Labels{Ind2,1};
end