clear all;
close all;

% Carregar imagens
 circle = 'C:\Users\morei\Desktop\CR\2019\Formas_3\square';
 square = 'C:\Users\morei\Desktop\CR\2019\Formas_3\square';
 star   = 'C:\Users\morei\Desktop\CR\2019\Formas_3\star';
 triangle='C:\Users\morei\Desktop\CR\2019\Formas_3\triangle';
 
 addpath 'C:\Users\morei\Desktop\CR\2019\Formas_3\circle';

 ficheiro = fullfile(circle,'*.png');
 ficheiro2 = fullfile(square,'*.png');
 ficheiro3 = fullfile(star,'*.png');
 ficheiro4 = fullfile(triangle,'*.png');
 
  for pasta = 1 : 4
    if pasta == 1
         disp(ficheiro);
    else
        if pasta == 2
            addpath 'C:\Users\morei\Desktop\CR\2019\Formas_3\square';
           ficheiro = ficheiro2; 
        else
            if pasta == 3
                 addpath 'C:\Users\morei\Desktop\CR\2019\Formas_3\star';
                ficheiro = ficheiro3;
            else
                addpath 'C:\Users\morei\Desktop\CR\2019\Formas_3\triangle';
               ficheiro = ficheiro4; 
            end
        end
    end
    
f = dir(ficheiro); 
                disp(ficheiro);           % caminho para as imagens
                ficheiros= {f.name};                % nome das imagens
                arraydeimagens = zeros(0,'uint8');  % array com as imagens
            
                 nimg = 50;                           % numero de imagens carregadas
            
                %  Nome das Formas - Imagens
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
            BB(:,k+(nimg*(pasta-1))) = reshape(arraydeimagens{k},[],1);
    end
 end

    % Targets: cada coluna corresponde a uma forma - 4 formas -> 4 colunas
    % 150
% linhas
num = 1;
aux = 0;
for j = 1 : 4
    
    for i = 1 : nimg * 4
        if num > aux && num <= aux + nimg
            TTargets(j, i) = 1;
        else
            TTargets(j, i) = 0;
        end
        num = num + 1;
    end
    num = 1;
    aux = aux + nimg;
    
end
    
%Carrega Rede
uiopen ('*mat');

y = sim (net,BB); 

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