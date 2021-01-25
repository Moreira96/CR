clear all;
close all;

% Carregar imagens
circle = 'C:\Users\morei\Desktop\CR\2019\Formas_2\circle';
square = 'C:\Users\morei\Desktop\CR\2019\Formas_2\square';
star   = 'C:\Users\morei\Desktop\CR\2019\Formas_2\star';
triangle='C:\Users\morei\Desktop\CR\2019\Formas_2\triangle';

addpath 'C:\Users\morei\Desktop\CR\2019\Formas_2\circle';

ficheiro = fullfile(circle,'*.png');
ficheiro2 = fullfile(square,'*.png');
ficheiro3 = fullfile(star,'*.png');
ficheiro4 = fullfile(triangle,'*.png');

for pasta = 1 : 4
    if pasta == 1
        disp(ficheiro);
    else
        if pasta == 2
            addpath 'C:\Users\morei\Desktop\CR\2019\Formas_2\square';
            ficheiro = ficheiro2;
        else
            if pasta == 3
                addpath 'C:\Users\morei\Desktop\CR\2019\Formas_2\star';
                ficheiro = ficheiro3;
            else
                addpath 'C:\Users\morei\Desktop\CR\2019\Formas_2\triangle';
                ficheiro = ficheiro4;
            end
        end
    end
    
    f = dir(ficheiro);
    disp(ficheiro);           % caminho para as imagens
    ficheiros= {f.name};                % nome das imagens
    arraydeimagens = zeros(0,'uint8');  % array com as imagens
    
    nimg = 50;                           % numero de imagens carregadas
    
    %  Nome das Imagens
    for k =  1 : nimg
        name{k} = strtok(ficheiros{k}, '*.png');
    end
    
    % Tratamento das imagens
    for k =  1 : nimg
        
        p = strcat(name(k),'.png');
        preencher = p{:};
        
        arraydeimagens{k} =imread(preencher);
        arraydeimagens{k} =imresize(arraydeimagens{k},1);
        arraydeimagens{k} = imbinarize(arraydeimagens{k});
        B(:,k+(nimg*(pasta-1))) = reshape(arraydeimagens{k},[],1);
    end
end

% Targets: cada coluna corresponde a uma forma - 4 formas -> 4 colunas
% linhas
num = 1;
aux = 0;
for j = 1 : 4    
    for i = 1 : nimg * 4
        if num > aux && num <= aux + nimg
            Targets(j, i) = 1;
        else
            Targets(j, i) = 0;
        end
        num = num + 1;
    end
    num = 1;
    aux = aux + nimg;    
end

n = Targets;
n = logical(n);

net = feedforwardnet(10);

net.layers{2}.transferFcn= 'purelin';

net.trainFCN = 'traincgp';
net.trainParam.epochs = 100;
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 0.70;
net.divideParam.valRatio = 0.15;

net.divideParam.testRatio = 0.15;

[net,tr] = train(net,B,n);


view(net);
y = sim (net,B); % testa a rede com as imagens que foram usadas para a treinar (previsao optimista)

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
fprintf('Precisao total %f\n', accuracy)

% % SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
TInput = B(:,tr.testInd);
TTargets = n(:,tr.testInd);

y = sim (net,TInput);

% % GUARDA REDE
uisave({'net', 'tr'});

% Calcula e mostra a percentagem de classificacoes corretas no conjunto de teste
r=0;
for i=1: size(tr.testInd,2)               % Para cada classificacao
    [a b] = max(y(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
    [c d] = max(TTargets(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
    if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
        r = r+1;
    end
end

accuracy = r/size(tr.testInd,2)*100;
fprintf('Precisao teste %f\n', accuracy)