function nflApp(app)

%% Loading ELO Data
NFLData = readcell("NFL_ELO_2022-2023_Season.xlsx");
[nRow, nCol] = size(NFLData);
% Add a column for game week number
NFLData{1, nCol + 1} = 'Week Number';
% NFLData{2, nCol + 1} = 1;
startGameDate = NFLData{2,1}; % Start of a game week
endGameDate = startGameDate + caldays(7); % End of a game week
gameWeek = 1; % Game week counter

for iRow = 2:nRow
    if isbetween(NFLData{iRow, 1}, startGameDate, endGameDate, 'openright') % tests if the game is within the start and end date variables
        NFLData{iRow, nCol + 1} = gameWeek; 
    else % otherwise, move the start date to the end date and increment the week
        startGameDate = endGameDate;
        endGameDate = startGameDate + caldays(7);
        gameWeek = gameWeek + 1;
        NFLData{iRow, nCol + 1} = gameWeek; 
    end
    if strcmp(class(NFLData{iRow, 4}), 'missing')
        NFLData{iRow, 4} = 'N/A';
    end
    NFLData{iRow, 1} = char(NFLData{iRow, 1});
end

%% Loading Metadata
Metadata = readcell("NFL_Team_Metadata.xlsx");
[nRowM, nColM] = size(Metadata);
%% Start Up of App
teamSelection = "Arizona Cardinals";
teamAbriv = "";
teamBye = 0;
for i = 1:nRowM
    if(Metadata{i, 2} == teamSelection)
        teamAbriv = Metadata{i, 1};
        teamBye = Metadata{i, 6};
    end
end
app.TeamDropDown.Value = teamSelection;






