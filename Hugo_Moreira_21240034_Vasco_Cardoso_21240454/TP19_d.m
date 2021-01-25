[filenamee,path] = uigetfile('*.png','Escolha a imagem');
if isequal(filenamee,0)
   disp('User selected Cancel');
else
    file = fullfile(path, filenamee);
    nimg = 1;
    % Tratamento das imagens
        disp(file);
        p = strcat(file,'.png');
        preencher = file; 
        arraydeimagens{1} =imread(preencher);  
        arraydeimagens{1} =imresize(arraydeimagens{1},1);
        arraydeimagens{1} = imbinarize(arraydeimagens{1});

        BB(:,1) = reshape(arraydeimagens{1},[],1);
           uiopen('*.mat');
            y = sim (net,BB);

            for i=1:size(y,2)             
                [a b] = max(y(:,i));         
                    if b == 1
                        fprintf('\nCirculo\n');
                    end
                    if b == 2
                        fprintf('\nQuadrado\n');
                    end
                    if b == 3
                        fprintf('\nEstrela\n');
                    end
                    if b == 4
                        fprintf('\nTriangulo\n');
                    end 
            end
end    