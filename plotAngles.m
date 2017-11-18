plot(data.skiangles);
xlabel('Номер столбца в матрице');
ylabel('Код угла C, отс');
Amin_ski = single(min(data.skiangles(:)))*ang_samp %мин. угол, гр
Amax_ski = single(max(data.skiangles(:)))*ang_samp %макс. угол, гр
