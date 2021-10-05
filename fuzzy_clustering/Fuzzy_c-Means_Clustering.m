%% Fuzzy c-Means Clustering(FCM)

clc, clear;

f1 = figure; % plot 2D data
f2 = figure; % result of clustering
f3 = figure; % result of clustering with center point
f4 = figure; % termination clustering iteraions

%cluster_n = 3;
data_n = 300;
dist = 3;

%% Figure 1 : plot 2D data

figure(f1);

data = randn(data_n, 2);
data = [data; randn(data_n,2)+dist*ones(data_n,2)];
data = [data; randn(data_n,2)-dist*ones(data_n,2)];

plot(data(:,1), data(:,2), 'o');
xlabel("x");
ylabel("y");
title("Plot 2D Data");

%% Figure 2 : resulf of clustering

figure(f2);

[centers, U, objFun] = fcm(data, 2);
maxU = max(U);

idx1 = find(U(1,:) == maxU);
idx2 = find(U(2,:) == maxU);

plot(data(idx1,1), data(idx1,2), 'ob');
hold on
plot(data(idx2,1), data(idx2,2), 'or');
hold off
xlabel("x");
ylabel("y");
title("Result of Fuzzy c-Means Clustering");

%% Figure 3 : result of clustering with center point

figure(f3);

plot(data(idx1,1), data(idx1,2), 'ob');
hold on
plot(data(idx2,1), data(idx2,2), 'or');
plot(centers(1,1),centers(1,2),'xr','MarkerSize',15,'LineWidth',3)
plot(centers(2,1),centers(2,2),'xb','MarkerSize',15,'LineWidth',3)
hold off
xlabel("x");
ylabel("y");
title("Result of Fuzzy c-Means Clustering with Centers");

%% Figure 4 : termination clustering iteraions

figure(f4);

plot(1:length(objFun), objFun);
xlabel("iterations");
ylabel("fcn : Object function values");
title("Termination Condition stopped the clustering");
