%% init
%определяем параметры когерентной СДЦ
n_chain = 8; %число отсчетов в пачке
n_step = 4; %шаг смещения пачки

zCh = -2:2; %номера нулевых каналов СДЦ (содержат отражания от земли и стац. объектов)

%% init data

%создаем окно для наложения на пачку
wnd = ones(1,n_chain);
%определяем параметры отображения
med = median(abs(convolved_data(:)));

%% fft sdc

 %когерентнаф сдц через цифровую фильтрацию
sdc_data = [];
 %удаляем результаты прошлых вычислений
temp = convolved_data;
 %исходные данны для свертки
n = size(temp,2);
 %число периодов по дальности
n = fix(n/n_step)*n_step;
 %общее число обрабатываемых каналов
temp(:,(n+1):end) = [];
 %удаляем на обрабатываемые данные
sdc_data = zeros(size(temp,1),n_chain,n/n_step-1);
for ii = 1:n/n_step-1
    temp2 = fft(temp(:,(ii-1)*n_step+(1:n_chain)),[],2); %формула (12)
    sdc_data(:,:,ii) = fftshift(temp2,2);
end
sdc_ang = 1:n_step:n-n_step;

%% show

figure;
subplot(1,2,1);
imagesc(abs(convolved_data),[0 10*abs(med)]);
xlabel('Угол, отс');
ylabel('Дальность, отс');
subplot(1,2,2);
%проверка типа СДЦ
sz = size(sdc_data);
if length(sz)>2
    %когерентная сдц
    viewdata = sdc_data;
    viewdata(:,n_chain/2+zCh,:) = 0; %формула (13)
    viewdata = ifft(ifftshift(viewdata,2),[],2); %формула (14)
    viewdata = viewdata(:,n_chain/2,:);
    viewdata = permute(viewdata,[1,3,2]);
    imagesc(abs(viewdata),[0 10*abs(med)]);
else
    %некогерентая сдц
    imagesc(abs(sdc_data),[0 10*abs(med)]);
end
xlabel('Угол, отс');
ylabel('Дальность, отс');





