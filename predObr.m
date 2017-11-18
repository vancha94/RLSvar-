%проводим медианную фильтрацию данных в логарифмическом масштабе, чтобы
%легче было продетектировать границу зон аттенюации (усиления)
cutrange = medfilt1(20*log10(abs(single(data.skiraw(:,1)))),50);
figure;
plot(cutrange);
xlabel('Каналы дальности, отс');
ylabel('Амплитуда, отс');
raw = single(data.skiraw);
angles = single(data.skiangles);
m = median(abs(raw(:)));%медиана абсолютных амплитуд в файле
%flag_raf%флаг рафинирования
mean_raw = zeros(1,3); %мат ожидание шумов
disp_re = zeros(1,3); %дисперсия вещественной части шумов
disp_im = zeros(1,3); %дисперсия мнимой части шумов
%выделяем зоны для обработки
zone1 = [1:996];
zone2 = [997:2150];
zone3 = [2151:16000];
%% до рафинирования
 %отображение данных
figure;
imagesc(abs(raw),[0 2*m]);

flag_raf = 0
%% рафинирование


%выборка данных: все каналы дальности и m последних каналов
%дальности
%%% зона 1
temp = raw(zone1(end)-m:zone1(end),:);
%выборка только шумовых отсчетов (исключаем все нешумовые)
temp = temp(temp(:) < median(temp(:)));
temp = temp(:);
%вычисление мат. ожидания по формуле (1)
mean_raw(1) = mean(temp);
%вычисление дисперсий по формуле (2)-(3)
disp_re(1) = var(real(temp)); %дисперсия вещественной части шумов
disp_im(1) = var(imag(temp)); %дисперсия мнимой части шумов
%компенсация квадратур по фомруле (4)
raw(zone1,:) = 1/sqrt(disp_re(1))*(real(raw(zone1,:))-real(mean_raw(1)))...
+1j/sqrt(disp_im(1))*(imag(raw(zone1,:))-imag(mean_raw(1)));
%%% зона 2



temp = raw(zone2(end)-m:zone2(end),:);
%выборка только шумовых отсчетов (исключаем все нешумовые)
temp = temp(temp(:) < median(temp(:)));
temp = temp(:);
%вычисление мат. ожидания по формуле (1)
mean_raw(2) = mean(temp(:));
%вычисление дисперсий по формуле (2)-(3)
disp_re(2) = var(real(temp(:))); %дисперсия вещественной части шумов
disp_im(2) = var(imag(temp(:))); %дисперсия мнимой части шумов
%компенсация квадратур по фомруле (4)
raw(zone2,:) = 1/sqrt(disp_re(2))*(real(raw(zone2,:))-real(mean_raw(2)))...
+1j/sqrt(disp_im(2))*(imag(raw(zone2,:))-imag(mean_raw(2)));
%%% зона 3
temp = raw(zone3(end)-m:zone3(end),:);
%выборка только шумовых отсчетов (исключаем все нешумовые)
temp = temp(temp(:) < median(temp(:)));
temp = temp(:);
%вычисление мат. ожидания по формуле (1)
mean_raw(3) = mean(temp(:));
%вычисление дисперсий по формуле (2)-(3)
disp_re(3) = var(real(temp(:))); %дисперсия вещественной части шумов
disp_im(3) = var(imag(temp(:))); %дисперсия мнимой части шумов
%компенсация квадратур по фомруле (4)
raw(zone3,:) = 1/sqrt(disp_re(3))*(real(raw(zone3,:))-real(mean_raw(3)))...
+1j/sqrt(disp_im(3))*(imag(raw(zone3,:))-imag(mean_raw(3)));
%рафинирование выполнено
flag_raf = 1;
%% после рафинирования
figure;
imagesc(abs(raw),[0 2*m]);