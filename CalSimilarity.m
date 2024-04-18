close all;clearvars;clc;

His_Data= csvread('E:\研究生\文献\采样方法\实验\数据集\分割数据集\slump_test\slump_test - 2.csv');
New_Data= csvread('E:\研究生\文献\采样方法\实验\数据集\分割数据集\slump_test\slump_test - Test.csv');

[a, b] = size(His_Data);
[e, f] = size(New_Data);
C = His_Data(:, b);
N_1 = sum(C);
N_0 = a - N_1;

His_Data_0 = His_Data(His_Data(:,b)==0,1: b-1);
His_Data_1 = His_Data(His_Data(:,b)==1,1: b-1);
New_Data_0 = New_Data(New_Data(:,b)==0,1: b-1);
New_Data_1 = New_Data(New_Data(:,b)==1,1: b-1);

% 以下两行比较版本，是计算均值和标准差的欧式距离
feature_His_Data = [mean(His_Data_0) std(His_Data_0, 1) mean(His_Data_1) std(His_Data_1, 1)];
feature_New_Data = [mean(New_Data_0) std(New_Data_0, 1) mean(New_Data_1) std(New_Data_1, 1)];


% 以下直到倒数第三行是CRPS版本，计算欧式距离
CRPS = zeros(1,(b-1)*2);
for i = 1:b-1
    data_series_His_Data_0 = His_Data_0(:, i)';
    data_series_New_Data_0 = New_Data_0(:, i)';

    [~, n] = size(data_series_His_Data_0);
    %最大值与最小值
    His_Data_max = max(data_series_His_Data_0);
    His_Data_min = min(data_series_His_Data_0);
    New_Data_max = max(data_series_New_Data_0);
    New_Data_min = min(data_series_New_Data_0);   
    d_max = max(His_Data_max, New_Data_max);
    d_min = min(His_Data_min, New_Data_min);
    %划区间,step是小的区间长度
    x = d_min:0.00001:d_max;
    if d_min == d_max
        x = 0:0.00001:1;
    end
    len = length(x);
    %提前给区间的频数f预留空间
    c_His_Data_0 = zeros(1, len);
    c_New_Data_0 = zeros(1, len);    
    for j = 1:len
        %sum内的data<=(d_min+i*step)是逻辑判断语句
        %整个语句意思是找出data内小于等于d_min+i*step的总个数
        c_His_Data_0(j) = sum(data_series_His_Data_0<=(d_min+j*0.00001));
        c_New_Data_0(j) = sum(data_series_New_Data_0<=(d_min+j*0.00001));
    end
    c_His_Data_0 = c_His_Data_0./n;
    c_New_Data_0 = c_New_Data_0./n;
%     if i == 1
%         figure
%         plot(x, c_His_Data_0, 'b-', 'LineWidth', 1)
%         hold on
%         plot(x, c_New_Data_0, 'r-', 'LineWidth', 1)    
%         title('经验分布函数')
% 
%         disp('x')
%         disp(x)
%         disp('c_His_Data_0')
%         disp(c_His_Data_0)
%         disp('c_New_Data_0')
%         disp(c_New_Data_0)
%     end
    Diff_0 = abs(c_His_Data_0-c_New_Data_0);
    CRPS(i) = trapz(x, Diff_0);
end

for i = 1:b-1
    data_series_His_Data_1 = His_Data_1(:, i)';
    data_series_New_Data_1 = New_Data_1(:, i)';

    [~, n] = size(data_series_His_Data_1);
    %最大值与最小值
    His_Data_max = max(data_series_His_Data_1);
    His_Data_min = min(data_series_His_Data_1);
    New_Data_max = max(data_series_New_Data_1);
    New_Data_min = min(data_series_New_Data_1);   
    d_max = max(His_Data_max, New_Data_max);
    d_min = min(His_Data_min, New_Data_min);
    %划区间,step是小的区间长度
    x = d_min:0.00001:d_max;
    if d_min == d_max
        x = 0:0.00001:1;
    end
    len = length(x);
    %提前给区间的频数f预留空间
    c_His_Data_1 = zeros(1, len);
    c_New_Data_1 = zeros(1, len);    
    for j = 1:len
        %sum内的data<=(d_min+i*step)是逻辑判断语句
        %整个语句意思是找出data内小于等于d_min+i*step的总个数
        c_His_Data_1(j) = sum(data_series_His_Data_1<=(d_min+j*0.00001));
        c_New_Data_1(j) = sum(data_series_New_Data_1<=(d_min+j*0.00001));
    end
    c_His_Data_1 = c_His_Data_1./n;
    c_New_Data_1 = c_New_Data_1./n;
    
%     if i == 1
%         figure
%         plot(x, c_His_Data_1, 'b-', 'LineWidth', 1)
%         hold on
%         plot(x, c_New_Data_1, 'r-', 'LineWidth', 1)    
%         title('经验分布函数')
% 
%         disp('x')
%         disp(x)
%         disp('c_His_Data_1')
%         disp(c_His_Data_1)
%         disp('c_New_Data_1')
%         disp(c_New_Data_1)
%     end
    Diff_1 = abs(c_His_Data_1-c_New_Data_1);
    CRPS(b-1+i) = trapz(x, Diff_1);    
end
disp(CRPS)

d_CRPS = sqrt(sum((CRPS).^2));
d_aver_std = sqrt(sum((feature_His_Data-feature_New_Data).^2));
disp(d_CRPS)
disp(d_aver_std)
