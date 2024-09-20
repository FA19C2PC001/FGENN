Distinct_Labels = unique(species);%name of the column that contains actual labels

for Label = 1:length(Distinct_Labels)
    Temp_Count = 0;
    %=============My ALGO
    for i=1:length(NeighbouringIndexes)
        if isequal(species(NeighbouringIndexes(i)),Distinct_Labels(Label,1))
            Temp_Count = Temp_Count+1;
        end
    end
    Distinct_Labels{Label,2} = (Temp_Count/length(NeighbouringIndexes))*100;
    %=====================
    %Calculating Class Prob for KNN in 3rd Column of Dinstinct Matrix
    Temp_Count = 0;
    for i=1:length(Idx)
        if isequal(species(Idx(i)),Distinct_Labels(Label,1))
            Temp_Count = Temp_Count+1;
        end
    end
    Distinct_Labels{Label,3} = (Temp_Count/length(Idx))*100;
    %======================================================
end
Results = cell2mat(Distinct_Labels(:,2:3)); %Converting to Matrix
[Val,Ind]=max(Results(:,1)); %Finding Max Prob and Index of my ALGO
[Val2,Ind2]=max(Results(:,2));%Finding Max Prob and Index of KNN ALGO

if((Ind==Ind2)&&(isequal(species(DPIndex),Distinct_Labels(Ind,1))))
    CorrectMyAlgo=CorrectMyAlgo+1;
    CorrectKNNAlgo = CorrectKNNAlgo+1;
    %disp("OK");
elseif isequal(species(DPIndex),Distinct_Labels(Ind,1))
    disp("Not Matched for"+DPIndex);
    disp("Actual:"+species(DPIndex)...
        +" Geometrical:"+Distinct_Labels(Ind,1)...
        +" KNN:"+Distinct_Labels(Ind2,1));
    CorrectMyAlgo=CorrectMyAlgo+1;
    Black_Msg_Counts=Black_Msg_Counts+1;
elseif isequal(species(DPIndex),Distinct_Labels(Ind2,1))
    disp("Not Matched for"+DPIndex);
    fprintf(2, "Actual:"+species(DPIndex)...
        +" Geometrical:"+Distinct_Labels(Ind,1)...
        +" KNN:"+Distinct_Labels(Ind2,1)+"\n");
    CorrectKNNAlgo = CorrectKNNAlgo+1;
    Red_Msg_Counts=Red_Msg_Counts+1;
else
    BothWrong = BothWrong+1;
end
