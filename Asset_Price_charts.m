clc
clear
clf

% 2005-01-01 ~ 2019-12-31
Datatable1 = readtable('Amazon.xlsx','ReadRowNames',true);
Datatable2 = readtable('IBM.xlsx','ReadRowNames',true);
Datatable3 = readtable('JPM.xlsx','ReadRowNames',true);

Num = 3770;
Data(:, 1) = Datatable1{2:Num,{'PriceOrBid_AskAverage'}}
Data(:, 2) = Datatable2{2:Num,{'PriceOrBid_AskAverage'}}
Data(:, 3) = Datatable3{2:Num,{'PriceOrBid_AskAverage'}}

%% Return
for i=1:3
    for l=1:Num-2
        Data_return(l, i) = (Data(l+1, i)/Data(l, i)) - 1;
    end
end

 figure(1)
 t = 1: 1: Num-1; 
 plot(t, Data(:,1), 'color', 'blue')
 hold on
 plot(t, Data(:,2), 'color', 'red')
 hold on
 plot(t, Data(:,3), 'color', 'black')
 hold on
 legend('Amazon (blue)', 'IBM (red)', 'JP Morgan (black)')
 hold on
 title('Stock prices for the period from 1 Jan 2005 to 31 Dec 2019')
 
 figure(2)
 t = 1: 1: Num-2; 
 plot(t, Data_return(:,1), 'color', 'blue')
 hold on
 plot(t, Data_return(:,2), 'color', 'red')
 hold on
 plot(t, Data_return(:,3), 'color', 'black')
 hold on
 legend('Amazon (blue)', 'IBM (red)', 'JP Morgan (black)')
 hold on
 title('Daily returns of the stock prices for the period from 1 Jan 2005 to 31 Dec 2019')

%% Normalization
for i=1:3
    for l=1:Num-2
        Data_return(l, i) = (Data(l+1, i)/Data(l, i)) - 1;
        Data_mean = mean(Data_return(l, i));
        Data_std = std(Data_return(l, i));
        Return_normalized = (Data_return(l, i) - Data_mean)/Data_std;
    end
end



%%% Kernel density estimation

randn('state', 100)

M = [10^2, 10^3, 10^4, 10^5]; %%the number of samples
dx = 0.05; %%width of bin
interval = [-4: dx: 4];


%%% Iterative loop for M
for j=1:4
    N = M(j);
    U = randn(1, N);
    
    counts = hist(U, interval);
    density = counts/(dx * N);
    
    figure(j)
    bar(interval, density)
    hold on
    plot(interval, normpdf(interval))
end