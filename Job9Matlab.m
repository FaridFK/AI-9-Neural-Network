% Mempersiapkan data latih dan target latih 
data_latih=[1 1;1 0;0 1;0 0]';
kelas_latih=[0 1 1 0 1 1];
%Plot data latih
figure('Position',[300 300 210 160]); 
plotpv(data_latih,kelas_latih); 
point = findobj(gca,'type','line'); 
set(point,'Color','black');
HL = 3;
% Pembuatan JST
net = newff(minmax(data_latih),[HL 1], {'logsig' 'logsig'},'traingdx');
net.IW{3,1}=[0.3 0.5; -0.8 0.1]
net.LW {3,1} = [0.2 0.7 0.3];
net.b {3,1} = [0.2; -0.2 0.3];
net.b{3,1} = [0.3]
% Memberikan nilai untuk mempengaruhi proses pelatihan
net.performFcn = 'sse';
net.trainParam.goal = 0.001;
net.trainParam.show = 20;
net.trainParam.epochs = 5000;
net.trainParam.mc = 0.95;
net.trainParam.lr = 0.1;
% Proses training
[net_keluaran,tr,Y,E] = train(net,data_latih,kelas_latih);
%Hasil setelah pelatihan
bobot_hidden=net_keluaran.IW{1,1};
bobot_keluaran = net_keluaran.LW{3,1}
bias_hidden = net_keluaran.b{1,1}
bias_keluaran = net_keluaran.b{3,1}
jumlah_iterasi=tr.num_epochs
nilai_keluaran = Y
nilai_error=E
error_SSE=0.5*sum(nilai_error.^2)
