close all;clearvars;clc;

His_Data1= csvread('E:\�о���\����\��������\ʵ��\���ݼ�\�ָ����ݼ�\Quality Assessment-Digital Colposcopy\Quality Assessment-Digital Colposcopy-1.csv');
His_Data2= csvread('E:\�о���\����\��������\ʵ��\���ݼ�\�ָ����ݼ�\Quality Assessment-Digital Colposcopy\Quality Assessment-Digital Colposcopy-2.csv');
His_Data3= csvread('E:\�о���\����\��������\ʵ��\���ݼ�\�ָ����ݼ�\Quality Assessment-Digital Colposcopy\Quality Assessment-Digital Colposcopy-3.csv');
His_Data4= csvread('E:\�о���\����\��������\ʵ��\���ݼ�\�ָ����ݼ�\Quality Assessment-Digital Colposcopy\Quality Assessment-Digital Colposcopy-4.csv');
His_Data5= csvread('E:\�о���\����\��������\ʵ��\���ݼ�\�ָ����ݼ�\Quality Assessment-Digital Colposcopy\Quality Assessment-Digital Colposcopy-5.csv');
His_Data6= csvread('E:\�о���\����\��������\ʵ��\���ݼ�\�ָ����ݼ�\Quality Assessment-Digital Colposcopy\Quality Assessment-Digital Colposcopy-6.csv');
His_Data7= csvread('E:\�о���\����\��������\ʵ��\���ݼ�\�ָ����ݼ�\Quality Assessment-Digital Colposcopy\Quality Assessment-Digital Colposcopy-7.csv');
His_Data8= csvread('E:\�о���\����\��������\ʵ��\���ݼ�\�ָ����ݼ�\Quality Assessment-Digital Colposcopy\Quality Assessment-Digital Colposcopy-8.csv');
His_Data9= csvread('E:\�о���\����\��������\ʵ��\���ݼ�\�ָ����ݼ�\Quality Assessment-Digital Colposcopy\Quality Assessment-Digital Colposcopy-9.csv');
New_Data= csvread('E:\�о���\����\��������\ʵ��\���ݼ�\�ָ����ݼ�\Quality Assessment-Digital Colposcopy\Quality Assessment-Digital Colposcopy-Test.csv');
[e, f] = size(New_Data);
New_Data_0 = New_Data(New_Data(:,f)==0,1: f-1);
New_Data_1 = New_Data(New_Data(:,f)==1,1: f-1);
[f3, x3] = ksdensity(New_Data_0(:));
[f4, x4] = ksdensity(New_Data_1(:));
figure
for i = 1:9
    namestr = ['His_Data', num2str(i)];
    His_Data = eval(namestr);
    disp(namestr)
    [a, b] = size(His_Data);
    C = His_Data(:, b);
    N_1 = sum(C);
    N_0 = a - N_1;
    
    subplot(3,3,i);
    His_Data_0 = His_Data(His_Data(:,b)==0,1: b-1);
    [f1, x1] = ksdensity(His_Data_0(:));
    plot(x1,f1);%���Ƹ����ܶ�����
    hold on
    plot(x3,f3);%���Ƹ����ܶ����� 
end

figure
for i = 1:9
    namestr = ['His_Data', num2str(i)];
    His_Data = eval(namestr); 
    [a, b] = size(His_Data);
    C = His_Data(:, b);
    N_1 = sum(C);
    N_0 = a - N_1;
    
    subplot(3,3,i);
    His_Data_1 = His_Data(His_Data(:,b)==1,1: b-1);
    [f2, x2] = ksdensity(His_Data_1(:));
    plot(x2,f2,'b');%���Ƹ����ܶ�����
    hold on
    plot(x4,f4,'r');%���Ƹ����ܶ�����
end