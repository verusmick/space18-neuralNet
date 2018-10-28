
clear
clc

date='20111103';

data= readtable(strcat('dataclean',date,'.dat'));
data=table2array(data);

date=str2num(date);

year=uint32(date/10000);
month=uint32(date/100)-year*100;
day=date-year*10000-month*100;
year=year-2009;
month=month-1;
day=day-1;

time=(year*365+month*30+day)*24;
[a,b]=size(data);
data(:,1)=uint32(data(:,1))+repmat(time,a,1);

save(strcat('dataclnTime19.dat'),'data','-ascii');


