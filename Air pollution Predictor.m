outs = readtable('death-rates-from-air-pollution.csv', 'PreserveVariableNames', true);
outs((find(string(outs.Code) == "")),:) = []; %Scrubbing all the regions from the data%
outs(:,6) = []; %Scrubbing Outdoor particulate matter (deaths per 100,000) from the data%
outs(:,6) = []; %Scrubbing Outdoor ozone pollution (deaths per 100,000) from the data%
outs(5377:5404,:) = []; %Scubbed World out of the data since World is not a country%
[r c] = size(outs);
AvgAllTD = mean(table2array(outs(:,4))); %mean of all Total
AvgAllID = mean(table2array(outs(:,5))); %mean of all Indoor
CountryName = unique(outs.Entity);
%Menu Selection Thing%
Prompt = "Choose a country from the menu!";
Options = [string(CountryName)];
UserCountry = menu(Prompt,Options);
UserCountry = CountryName(UserCountry)

fprintf('Welcome to the deaths caused by air pollution by country infomation program!\n\n');

if sum(contains(CountryName,UserCountry)) == 1
    Usertable = outs((find(string(outs.Entity) == UserCountry)),:);
    %%Usertable = [Usertable;idk]
    x = table2array(Usertable(:,3));
    TD = table2array(Usertable(:,4)); %Air pollution (total) (deaths per 100,000)%
    IDD = table2array(Usertable(:,5)); %Indoor air pollution (deaths per 100,000)%
    
    AvgTD = mean(TD);%Means Average Total Death for the country%
    AvgID = mean(IDD); %Means Average InDoor Death for the country%
    
    coefsTD = polyfit(x,TD,2);
    coefsIDD = polyfit(x,IDD,2);
    
    CurvePredictionTD = polyval(coefsTD, 2018:2028);
    CurvePredictionIDD = polyval(coefsIDD, 2018:2028);
    
    fprintf('From 1990 to 2017: \n\n')
    fprintf('The Average of the Total Air pollution (death per 100,000) is %f\n', AvgTD)
    fprintf('The Average of the Indoor Air pollution (death per 100,000) is %f\n', AvgID)
    
    fprintf('\n');
    
    %binning for Air pollution%
    dec = zeros(1,3);
    if AvgTD > AvgAllTD 
        dec = "above";
    elseif AvgTD < AvgAllTD
        dec = "below";
    elseif AvgTD == AvgAllTD
        dec = "equal to";
    end
    fprintf('The Average Air Pollution Total Deaths in this country is %s the dataset average\n', dec);
    
    %binning for Indoor Air pollution%
    dec2 = zeros(1,3);
    if AvgID > AvgAllID 
        dec2 = "above";
    elseif AvgID < AvgAllID
        dec2 = "below";
    elseif AvgID == AvgAllID
        dec2 = "equal to";
    end
    fprintf('The Average Indoor Air Pollution Deaths in this country is %s the dataset average\n', dec2);
    
    
    clf
    subplot(2,2,1)
    plot(x,TD,'b')
    title('Total Air Pollution Deaths over Year for', UserCountry)
    xlabel('Year')
    ylabel('Air pollution (total deaths per 100,000)')
    grid on
    
    subplot(2,2,2)
    plot(2018:2028,CurvePredictionTD,'r')
    title('PREDICTION: Total Air Pollution Deaths over Year for', UserCountry)
    xlabel('Year')
    ylabel('Air pollution (total deaths per 100,000)')
    grid on
    
    subplot(2,2,3)
    plot(x,IDD,'b')
    title('Total Indoor Air Pollution Deaths over Year for', UserCountry)
    xlabel('Year')
    ylabel('Air pollution (total deaths per 100,000)')
    grid on
    
    subplot(2,2,4)
    plot(2018:2028,CurvePredictionIDD,'r')
    title('PREDICTION: Total Indoor Air Pollution Deaths over Year for', UserCountry)
    xlabel('Year')
    ylabel('Air pollution (total deaths per 100,000)')
    grid on
    
else
    error('Information on the inputted country is not avaliable')
end
