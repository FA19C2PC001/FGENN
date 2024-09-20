%This file Ranks the Data and Finds Neighbors of each datapoint of dataset
%First Time value shows time taken by FGENN and second time value
%represents time taken by KNN
%Graphs code is commented. U can uncomment it and zoom it out to see the
%plots for Original Data and Ranked Data
%===========Ranking Code===============
load fisheriris;
Data = meas';
%=======Final Ranked Output Generation Algorithm 1=====
FeaturesCount= size(Data,1);%Counting Features
FinalRankedOutput=[];%An Empty Variable That Will Contain Final Ranking
for F=1:FeaturesCount%Loop For Every Feature
    SingleFeatureOutput = Data(F,:);%Extracting Single Feature Data Values
    DistinctData = unique(Data(F,:));%Extracting Indexed Unique Feature Values
    Ranking_OFFSET = max(DistinctData);
    for I=size(DistinctData,2):-1:1%Loop For Assigning Rank to Data Points
        SingleFeatureOutput(SingleFeatureOutput==DistinctData(I))=(I+Ranking_OFFSET);%Refined Logic 
    end
    SingleFeatureOutput = SingleFeatureOutput - Ranking_OFFSET;
    FinalRankedOutput=[FinalRankedOutput;SingleFeatureOutput];%Appending Result Values
end
disp('Final Ranked Output Generated....');
clear SingleFeatureOutput;clear DistinctData;clear Ranking_OFFSET;clear I;clear F;
%===========Ranking Code Ends Here=====================


%===========Code For Each DataPoint Neighbours Searching===========
Min_N_Required=3;%Neighbors Required
tic
DIFF_OBSERVER=[];
for DPIndex=1:length(Data(1,:))%DPIndex is Data Point Whose Neighbours Are Required
    Diff = 1;
    MaxDiff=50;
    NeighbouringIndexes = YasirNeighbours3(Diff,FinalRankedOutput,DPIndex);
    if(length(NeighbouringIndexes)<Min_N_Required)
        for Diff=2:MaxDiff
            NeighbouringIndexes = YasirNeighbours3(Diff,FinalRankedOutput,DPIndex);
            if(length(NeighbouringIndexes)<Min_N_Required)
                continue;
            else
                DIFF_OBSERVER=[DIFF_OBSERVER;DPIndex,Diff,length(NeighbouringIndexes)];
                break;
            end            
        end
    else
        DIFF_OBSERVER=[DIFF_OBSERVER;DPIndex,Diff,length(NeighbouringIndexes)];
    end
    if(mod(DPIndex,500)==0)
       fprintf('DataPointIndex := %d\n',DPIndex);
    end
end
toc
%/////////////////////////////////////////////
%===========Code For Each DataPoint Neighbours Searching Using KNN===========
tic
KNN_NeighbouringIndexes=[];
for DPIndex=1:length(Data(1,:))%DPIndex is Data Point Whose Neighbours Are Required
    [Idx,D] = knnsearch((Data)',Data(:,DPIndex)','k',(Min_N_Required+1));%here +1 because original point is also counted
    KNN_NeighbouringIndexes =[KNN_NeighbouringIndexes; sort(Idx)];
    if(mod(DPIndex,500)==0)
        fprintf('DataPointIndex := %d\n',DPIndex);
    end
end
toc

% %If you dont see any data then plz Zoom out the graph because its there..
% figure
% ylabel({'Feature - 2'});
% xlabel({'Feature - 1'});
% %title({'Data Plot of Synthetic Dataset'});
% %plot(Data(1,:),Data(2,:))%draws line
% for i=1:length(Data)
% text(Data(1,i),Data(2,i),strcat('D_{',num2str(i),'}'))
% hold on
% end
% 
% 
% %If you dont see any data then plz Zoom out the graph because its there..
% figure
% %plot(Data(1,:),Data(2,:))
% for i=1:length(FinalRankedOutput)
% text(FinalRankedOutput(1,i),FinalRankedOutput(2,i),strcat('D_{',num2str(i),'}'))
% hold on
% end
% ylabel({'Feature - 2'});
% xlabel({'Feature - 1'});
% title({'Rank Based Plot of Synthetic Dataset'});