%% init
Fa = 1e-4;
inData = sdc_data(2000:end,:);
r = 13000:14000;
a = 1:length(sdc_ang);
%% detect
%(sdcdata.,13000:14000,1:length(sdcdata.sdc_ang)

temp = abs(inData(r,a));
s2 = var(temp(:));
thr = 2.5*sqrt(-2*log(Fa)*s2);
detections = inData > thr;

%% show normal

figure;
%сырые данные
subplot(1,2,1);
temp = abs(inData(:));
q = quantile(temp,0.9);
imagesc(abs(inData),[0 q]);
xlabel('Угол, отс');
ylabel('Дальность, отс');
if ~isempty(detections)
    subplot(1,2,2);
    %данные после порога
    imagesc(abs(detections),[0 1]);
    xlabel('Угол, отс');
    ylabel('Дальность, отс');
end


