clear all;
close all;

% Carregar imagens
 pasta = 'C:\Users\morei\Desktop\CR\2019\Formas_1';
 addpath 'C:\Users\morei\Desktop\CR\2019\Formas_1';
 ficheiro = fullfile(pasta,'*.png');

f = dir(ficheiro);                  % caminho para as imagens
ficheiros= {f.name};                % nome das imagens
arraydeimagens = zeros(0,'uint8');  % array com as imagens

nimg = 4;                           % numero de imagens carregadas

%  Nome das Formas - Imagens
for k =  1 : nimg
    name{k} = strtok(ficheiros{k}, '*.png');  
end

% Tratamento das imagens
for k =  1 : nimg
    
        p = strcat(name(k),'.png');
        preencher = p{:};
        
        arraydeimagens{k} =imread(preencher);  
        arraydeimagens{k} =imresize(arraydeimagens{k},0.25);
        arraydeimagens{k} = imbinarize(arraydeimagens{k});
    B(:,k) = reshape(arraydeimagens{k},[],1);
end

% Targets: cada coluna corresponde a uma forma - 4 formas -> 4 colunas
i = 1;
for k = 1 : 4
    if k == i
    Targets(k, i) = 1;
    else
        Targets(k, i) = 0;
    end
    i = i + 1;
end
n = Targets;
n = logical(n);
net = feedforwardnet(10);

net.layers{1}.transferFcn= 'radbasn';

% FUNCAO DE TREINO 
net.trainFcn = 'trainscg';
net.trainParam.epochs = 100;

  net.divideFcn = '';                 
[net,tr] = train(net,B,n);

view(net);
y = sim (net,B);

%VISUALIZAR DESEMPENHO

plotconfusion(n, y) % Matriz de confusao

plotperf(tr)         % Grafico com o desempenho da rede nos 3 conjuntos  

%Calcula e mostra a percentagem de classificacoes corretas no conjunto de teste
r=0;
for i=1:size(y,2)               % Para cada classificacao  
  [a b] = max(y(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
  [c d] = max(n(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      r = r+1;
  end
end

accuracy = r/size(y,2)*100;
fprintf('Precisao total %f\n', accuracy);