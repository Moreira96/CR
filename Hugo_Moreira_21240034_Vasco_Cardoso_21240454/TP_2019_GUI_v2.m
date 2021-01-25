classdef TP_2019_GUI_v2 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure               matlab.ui.Figure                   % UI Figure
        Treinar                matlab.ui.control.Button           % Treinar
        LabelDropDown          matlab.ui.control.Label            % Função ...
        treino                 matlab.ui.control.DropDown         % trainbf...
        Label                  matlab.ui.control.Label            % Função ...
        activa                 matlab.ui.control.DropDown         % compet,...
        Panel                  matlab.ui.container.Panel          % Configu...
        LabelNumericEditField  matlab.ui.control.Label            % Treino
        treinodv               matlab.ui.control.NumericEditField % [0 1]
        Label2                 matlab.ui.control.Label            % Validação
        validacao              matlab.ui.control.NumericEditField % [0 1]
        Label3                 matlab.ui.control.Label            % Teste
        teste                  matlab.ui.control.NumericEditField % [0 1]
        LabelSwitch            matlab.ui.control.Label            % dividerand
        Switch                 matlab.ui.control.Switch           % Off, On
        TabGroup               matlab.ui.container.TabGroup       % Treino,...
        Tab                    matlab.ui.container.Tab            % Treino
        ButtonGroup            matlab.ui.container.ButtonGroup    % Escolhe...
        Forma1                 matlab.ui.control.RadioButton      % Formas 1
        Forma2                 matlab.ui.control.RadioButton      % Formas 2
        carregarImg            matlab.ui.control.Button           % Carrega...
        Button2                matlab.ui.control.Button           % Guardar...
        Button3                matlab.ui.control.Button           % Carrega...
        Tab2                   matlab.ui.container.Tab            % Testes
        Button                 matlab.ui.control.Button           % Carrega...
        Button4                matlab.ui.control.Button           % Formas 3
        Label6                 matlab.ui.control.Label            % Testar ...
        Label7                 matlab.ui.control.Label            % Carrega...
        Button5                matlab.ui.control.Button           % Testar ...
        Label4                 matlab.ui.control.Label           
        LabelNumericEditField2 matlab.ui.control.Label            % Precisa...
        NumericEditField       matlab.ui.control.NumericEditField % [0 100]
        Label5                 matlab.ui.control.Label            % Precisa...
        NumericEditField2      matlab.ui.control.NumericEditField % [0 100]
        Lamp                   matlab.ui.control.Lamp            
    end

    
    properties (Access = private)
        caminho % Caminho para as imagens
        nimg    % numero de imagens
        B       % Imagens
        BB
        n       % Targets
        op      % opcao
        aux     % Description
        cam      % camadas escondidas
        size    %tamanho das imagens carregadas (0 a 1)
    end
    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.aux = 0;
            app.caminho = 'C:\Users\morei\Desktop\CR\2019\Formas_1';
            app.nimg = 4;
            app.op = 1;  
            app.cam = 2;
            app.size = 1;
        end

        % carregarImg button pushed function
        function carregarImgButtonPushed(app)
            app.Label4.Text = 'A carregar Imagens';
            % Carregar imagens
            if app.op == 1
                app.Lamp.Color = [1 0 0];
                
                                % Carregar imagens
                 app.aux = 0;
                 pasta = app.caminho;
                 addpath 'C:\Users\morei\Desktop\CR\2019\Formas_1';
                 ficheiro = fullfile(pasta,'*.png');
                
                f = dir(ficheiro);                  % caminho para as imagens
                ficheiros= {f.name};                % nome das imagens
                arraydeimagens = zeros(0,'uint8');  % array com as imagens
                
                %  Nome das Formas - Imagens
                for k =  1 : app.nimg
                    name{k} = strtok(ficheiros{k}, '*.png');  
                end
                
                % Tratamento das imagens
                for k =  1 : app.nimg
                    
                    p = strcat(name(k),'.png');
                    preencher = p{:};
                        
                    arraydeimagens{k} =imread(preencher);  
                    arraydeimagens{k} =imresize(arraydeimagens{k},app.size);
                    arraydeimagens{k} = imbinarize(arraydeimagens{k});
                    app.B(:,k) = reshape(arraydeimagens{k},[],1);
                end
                
                % Targets: cada coluna corresponde a uma forma - 4 formas -> 4 colunas
                i = 1;
                for k = 1 : 4
                    if k == i
                    app.n(k, i) = 1;
                    else
                        app.n(k, i) = 0;
                    end
                    i = i + 1;
                end
                app.n = logical(app.n);
                app.aux = 1;
            else  
                if app.op == 2
            app.Lamp.Color = [1 0 0];
            app.aux = 0;
            circle = strcat(app.caminho, '\circle');
            square = strcat(app.caminho, '\square');
            star   = strcat(app.caminho, '\star');
            triangle = strcat(app.caminho, '\triangle');

            ficheiro = fullfile(circle,'*.png');
            ficheiro2 = fullfile(square,'*.png');
            ficheiro3 = fullfile(star,'*.png');
            ficheiro4 = fullfile(triangle,'*.png');
            
            for pasta = 1 : 4
                if pasta == 1
                    addpath(circle);
                    disp(ficheiro);
                else
                    if pasta == 2
                        addpath(square);
                        ficheiro = ficheiro2;
                    else
                        if pasta == 3
                            addpath(star);
                            ficheiro = ficheiro3;
                        else
                            addpath(triangle);
                            ficheiro = ficheiro4;
                        end
                    end
                end
                
                f = dir(ficheiro);
                disp(ficheiro);           % caminho para as imagens
                ficheiros= {f.name};                % nome das imagens
                arraydeimagens = zeros(0,'uint8');  % array com as imagens
                
                %  Nome das Formas - Imagens
                for k =  1 : app.nimg
                    name{k} = strtok(ficheiros{k}, '*.png');
                end
                
                % Tratamento das imagens
                for k =  1 : app.nimg
                    
                    p = strcat(name(k),'.png');
                    preencher = p{:};
                    
                    arraydeimagens{k} =imread(preencher);
                    arraydeimagens{k} =imresize(arraydeimagens{k},app.size);
                    arraydeimagens{k} = imbinarize(arraydeimagens{k});
                    app.B(:,k+(app.nimg*(pasta-1))) = reshape(arraydeimagens{k},[],1);
                end
            end
                        % Targets: cada coluna corresponde a uma forma - 4 formas -> 4 colunas 804
            % linhas
            num = 1;
            aux = 0;
            for j = 1 : 4               
                for i = 1 : app.nimg * 4
                    if num > aux && num <= aux + app.nimg
                        app.n(j, i) = 1;
                    else
                        app.n(j, i) = 0;
                    end
                    num = num + 1;
                end
                %disp(aux);
                num = 1;
                aux = aux + app.nimg;
            end
            app.n = logical(app.n);
            app.aux = 1;
                end   
            end
            if app.aux == 1
                app.Label4.Text = 'Imagens Carregadas';
                app.Lamp.Color = [0.502 1 0];
            end
        end

        % ButtonGroup selection change function
        function TreinoSelectionChanged(app, event)
            selectedButton = app.ButtonGroup.SelectedObject;
            if app.Forma1.Value == true
                app.caminho = 'C:\Users\morei\Desktop\CR\2019\Formas_1';
                app.nimg = 4;
                app.op = 1;
            end
            if app.Forma2.Value == true
                app.caminho = 'C:\Users\morei\Desktop\CR\2019\Formas_2';
                app.nimg = 201;
                app.op = 2;
            end
        end

        % Treinar button pushed function
        function TreinarButtonPushed(app)
            nnet.guis.closeAllViews();
            close all;
            app.Label4.Text = 'A treinar rede';
            if app.aux == 1
            net = feedforwardnet(10);
            net.layers{app.cam}.transferFcn= app.activa.Value;         
            net.trainFCN = app.treino.Value;
            net.trainParam.epochs = 1000;
            
           if strcmp(app.Switch.Value, 'On') == 1
                net.divideFcn = 'dividerand';
                % Caso a soma dos tres ser diferente de 1, fazer a divisao com valores por defeito
                if app.treinodv.Value + app.validacao.Value + app.teste.Value == 1
                    net.divideParam.trainRatio =  app.treinodv.Value;
                    net.divideParam.valRatio = app.validacao.Value;
                    net.divideParam.testRatio =  app.teste.Value;
                   
                else
                    % escrever MSM e alterar nas Variáveis
                    net.divideParam.trainRatio =  0.7;
                    net.divideParam.valRatio = 0.15;
                    net.divideParam.testRatio =  0.15;
                    app.treinodv.Value = 0.7;
                    app.validacao.Value = 0.15;
                    app.teste.Value = 0.15;
                end
           else
                    net.divideFcn = ''; 
           end

            [net,tr] = train(net,app.B,app.n);
            
            view(net);
            y = sim (net,app.B); % testa a rede com as imagens que foram usadas para a treinar (previsao optimista)
            
            %VISUALIZAR DESEMPENHO
            
            plotconfusion(app.n, y) % Matriz de confusao
            
            plotperf(tr)         % Grafico com o desempenho da rede nos 3 conjuntos
            
            %Calcula e mostra a percentagem de classificacoes corretas no conjunto de teste
            r=0;
            for i=1:size(y,2)               % Para cada classificacao
                [a b] = max(y(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
                [c d] = max(app.n(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
                if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
                    r = r+1;
                end
            end
            
            accuracy = r/size(y,2)*100;
            app.NumericEditField.Value = accuracy;
            app.Label4.Text = 'Rede Treinada';
            if  strcmp(app.Switch.Value, 'On') == 1
                                % % SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
                TInput = app.B(:,tr.testInd);
                TTargets = app.n(:,tr.testInd);
                
                y = sim (net,TInput);
                
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
                app.NumericEditField2.Value = accuracy;  
            end
            else 
                app.Label4.Text = 'carregar imagens primeiro';
            end
            save ('net.mat', 'net');
        end

        % Switch value changed function
        function SwitchValueChanged(app)
            value = app.Switch.Value;       
            app.teste.Enable = value;
            app.validacao.Enable = value;
            app.treinodv.Enable = value;          
        end

        % Button button pushed function
        function ButtonButtonPushed2(app)
        [filenamee,path] = uigetfile('*.png','Escolha a imagem');
        if isequal(filenamee,0)
           disp('User selected Cancel');
        else
            file = fullfile(path, filenamee);
            app.nimg = 1;
            % Tratamento das imagens
            for k =  1 : app.nimg
                disp(file);
                p = strcat(file,'.png');
                preencher = file; 
                arraydeimagens{k} =imread(preencher);  
                arraydeimagens{k} =imresize(arraydeimagens{k},app.size);
                arraydeimagens{k} = imbinarize(arraydeimagens{k});
                
                 app.BB(:,k) = reshape(arraydeimagens{k},[],1);
            end
        end
       end

        % Button2 Guardar a Rede
        function Button2ButtonPushed2(app)
             load net;
             uisave('net');
             app.Label4.Text = 'Rede Guardada';
        end

        % Button3 Carregar a Rede
        function Button3ButtonPushed(app)
            uiopen ('*mat');
            save ('net.mat', 'net');
            app.Label4.Text = 'Rede Carregada';
        end

        % Button4 button pushed function
        function Button4ButtonPushed(app)
            app.Label4.Text = 'A carregar Imagens';
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
            
                 app.nimg = 50;                           % numero de imagens carregadas
            
                %  Nome das Formas - Imagens
                for k =  1 : app.nimg
                    name{k} = strtok(ficheiros{k}, '*.png');  
                end
            
                % Tratamento das imagens
                for k =  1 : app.nimg
            
                        p = strcat(name(k),'.png');
                        preencher = p{:};
                        
                        arraydeimagens{k} =imread(preencher);  
                        arraydeimagens{k} =imresize(arraydeimagens{k},app.size);
                        arraydeimagens{k} = imbinarize(arraydeimagens{k});
                        app.BB(:,k+(app.nimg*(pasta-1))) = reshape(arraydeimagens{k},[],1);
                end
              end
             app.Label4.Text = 'Imagens Carregadas';
        end

        % Button5 button pushed function
        function Button5ButtonPushed(app)
                load net;
                y = sim (net,app.BB);
                if app.nimg == 1
                    for i=1:size(y,2) 
                        [a b] = max(y(:,i));          
                            if b == 1
                               app.Label4.Text = 'Circulo';
                            end
                            if b == 2
                                app.Label4.Text = 'Quadrado';
                            end
                            if b == 3
                                app.Label4.Text = 'Estrela';
                            end
                            if b == 4
                               app.Label4.Text = 'Triangulo';
                            end 
                    end
                else
                    num = 1;
                    aux = 0;
                    for j = 1 : 4

                        for i = 1 : app.nimg * 4
                            if num > aux && num <= aux + app.nimg
                                TTargets(j, i) = 1;
                            else
                                TTargets(j, i) = 0;
                            end
                            num = num + 1;
                        end
                        num = 1;
                        aux = aux + app.nimg;

                    end
                    r=0;
                    for i=1: size(y,2)               % Para cada classificacao
                        [a b] = max(y(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
                        [c d] = max(TTargets(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
                        if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
                            r = r+1;
                        end
                    end

                    accuracy = r/size(y,2)*100;
                    app.NumericEditField.Value = 0;
                    app.NumericEditField2.Value = accuracy
                end
                    
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 603 480];
            app.UIFigure.Name = 'UI Figure';
            setAutoResize(app, app.UIFigure, true)

            % Create Treinar
            app.Treinar = uibutton(app.UIFigure, 'push');
            app.Treinar.ButtonPushedFcn = createCallbackFcn(app, @TreinarButtonPushed);
            app.Treinar.Position = [71 49 120 30];
            app.Treinar.Text = 'Treinar';

            % Create LabelDropDown
            app.LabelDropDown = uilabel(app.UIFigure);
            app.LabelDropDown.VerticalAlignment = 'center';
            app.LabelDropDown.FontWeight = 'bold';
            app.LabelDropDown.Position = [31.5 168 98 15];
            app.LabelDropDown.Text = 'Função de Treino';

            % Create treino
            app.treino = uidropdown(app.UIFigure);
            app.treino.Items = {'trainbfg', 'trainbfgc', 'trainbr', 'trainbu', 'trainc', 'traincgb', 'traincgf', 'traincgp', 'traingd', 'traingda', 'traingdm', 'traingdx', 'trainlm', 'trainoss', 'trainr', 'trainrp', 'trainru', 'trains', 'trainscg'};
            app.treino.Position = [159 166 112 20];
            app.treino.Value = 'trainscg';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.VerticalAlignment = 'center';
            app.Label.FontWeight = 'bold';
            app.Label.Position = [31.5 128 120 15];
            app.Label.Text = 'Função de Activação';

            % Create activa
            app.activa = uidropdown(app.UIFigure);
            app.activa.Items = {'compet', 'hardlim', 'hardlims', 'logsig', 'netinv', 'poslin', 'purelin', 'radbas', 'radbasn', 'satlin', 'satlins', 'softmax', 'tansig', 'tribas'};
            app.activa.Position = [159 126 112 20];
            app.activa.Value = 'purelin';

            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.BorderType = 'line';
            app.Panel.TitlePosition = 'centertop';
            app.Panel.Title = 'Configuração Da Rede Neuronal';
            app.Panel.FontName = 'Helvetica';
            app.Panel.FontWeight = 'bold';
            app.Panel.FontUnits = 'pixels';
            app.Panel.FontSize = 12;
            app.Panel.Units = 'pixels';
            app.Panel.Position = [32 205 239 242];

            % Create LabelNumericEditField
            app.LabelNumericEditField = uilabel(app.Panel);
            app.LabelNumericEditField.Position = [13 106 52 15];
            app.LabelNumericEditField.Text = 'Treino';

            % Create treinodv
            app.treinodv = uieditfield(app.Panel, 'numeric');
            app.treinodv.Limits = [0 1];
            app.treinodv.ValueDisplayFormat = '%11.3g';
            app.treinodv.Enable = 'off';
            app.treinodv.Position = [84 102 100 22];
            app.treinodv.Value = 0.7;

            % Create Label2
            app.Label2 = uilabel(app.Panel);
            app.Label2.HorizontalAlignment = 'right';
            app.Label2.Position = [14 65 55 15];
            app.Label2.Text = 'Validação';

            % Create validacao
            app.validacao = uieditfield(app.Panel, 'numeric');
            app.validacao.Limits = [0 1];
            app.validacao.Enable = 'off';
            app.validacao.Position = [84 61 100 22];
            app.validacao.Value = 0.15;

            % Create Label3
            app.Label3 = uilabel(app.Panel);
            app.Label3.Position = [15 22 55 15];
            app.Label3.Text = 'Teste';

            % Create teste
            app.teste = uieditfield(app.Panel, 'numeric');
            app.teste.Limits = [0 1];
            app.teste.Enable = 'off';
            app.teste.Position = [85 18 100 22];
            app.teste.Value = 0.15;

            % Create LabelSwitch
            app.LabelSwitch = uilabel(app.Panel);
            app.LabelSwitch.HorizontalAlignment = 'center';
            app.LabelSwitch.FontWeight = 'bold';
            app.LabelSwitch.Position = [91.5 190 60 15];
            app.LabelSwitch.Text = 'dividerand';

            % Create Switch
            app.Switch = uiswitch(app.Panel, 'slider');
            app.Switch.ValueChangedFcn = createCallbackFcn(app, @SwitchValueChanged);
            app.Switch.FontAngle = 'italic';
            app.Switch.Position = [88 152 66 29];

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Units = 'pixels';
            app.TabGroup.Position = [295 205 274 242];

            % Create Tab
            app.Tab = uitab(app.TabGroup);
            app.Tab.Units = 'pixels';
            app.Tab.Title = 'Treino';

            % Create ButtonGroup
            app.ButtonGroup = uibuttongroup(app.Tab);
            app.ButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @TreinoSelectionChanged, true);
            app.ButtonGroup.BorderType = 'line';
            app.ButtonGroup.TitlePosition = 'centertop';
            app.ButtonGroup.Title = 'Escolher Pasta com imagens para treino';
            app.ButtonGroup.FontName = 'Helvetica';
            app.ButtonGroup.FontWeight = 'bold';
            app.ButtonGroup.FontUnits = 'pixels';
            app.ButtonGroup.FontSize = 12;
            app.ButtonGroup.Units = 'pixels';
            app.ButtonGroup.Position = [11 106 249 102];

            % Create Forma1
            app.Forma1 = uiradiobutton(app.ButtonGroup);
            app.Forma1.Text = 'Formas 1';
            app.Forma1.Position = [10 55 70 16];
            app.Forma1.Value = true;

            % Create Forma2
            app.Forma2 = uiradiobutton(app.ButtonGroup);
            app.Forma2.Text = 'Formas 2';
            app.Forma2.Position = [10 33 70 16];

            % Create carregarImg
            app.carregarImg = uibutton(app.Tab, 'push');
            app.carregarImg.ButtonPushedFcn = createCallbackFcn(app, @carregarImgButtonPushed);
            app.carregarImg.Position = [10.5 62 116 27];
            app.carregarImg.Text = 'Carregar imagens';

            % Create Button2
            app.Button2 = uibutton(app.Tab, 'push');
            app.Button2.ButtonPushedFcn = createCallbackFcn(app, @Button2ButtonPushed2);
            app.Button2.Position = [11 25 116 26];
            app.Button2.Text = 'Guardar Rede';

            % Create Button3
            app.Button3 = uibutton(app.Tab, 'push');
            app.Button3.ButtonPushedFcn = createCallbackFcn(app, @Button3ButtonPushed);
            app.Button3.Position = [143 25 117 26];
            app.Button3.Text = 'Carregar Rede';

            % Create Tab2
            app.Tab2 = uitab(app.TabGroup);
            app.Tab2.Units = 'pixels';
            app.Tab2.Title = 'Testes';

            % Create Button
            app.Button = uibutton(app.Tab2, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonButtonPushed2);
            app.Button.Position = [77 85 120 30];
            app.Button.Text = 'Carregar Imagens';

            % Create Button4
            app.Button4 = uibutton(app.Tab2, 'push');
            app.Button4.ButtonPushedFcn = createCallbackFcn(app, @Button4ButtonPushed);
            app.Button4.Position = [76 154 120 30];
            app.Button4.Text = 'Formas 3';

            % Create Label6
            app.Label6 = uilabel(app.Tab2);
            app.Label6.HorizontalAlignment = 'center';
            app.Label6.VerticalAlignment = 'center';
            app.Label6.FontWeight = 'bold';
            app.Label6.Position = [7 193 259 15];
            app.Label6.Text = 'Testar Rede com imagens da pasta Formas 3';

            % Create Label7
            app.Label7 = uilabel(app.Tab2);
            app.Label7.FontWeight = 'bold';
            app.Label7.Position = [64 126 144 15];
            app.Label7.Text = 'Carregar outras Imagens';

            % Create Button5
            app.Button5 = uibutton(app.Tab2, 'push');
            app.Button5.ButtonPushedFcn = createCallbackFcn(app, @Button5ButtonPushed);
            app.Button5.Position = [76 35 120 30];
            app.Button5.Text = 'Testar Rede';

            % Create Label4
            app.Label4 = uilabel(app.UIFigure);
            app.Label4.BackgroundColor = [1 1 1];
            app.Label4.Position = [295 21 274 88];
            app.Label4.Text = '';

            % Create LabelNumericEditField2
            app.LabelNumericEditField2 = uilabel(app.UIFigure);
            app.LabelNumericEditField2.HorizontalAlignment = 'right';
            app.LabelNumericEditField2.FontWeight = 'bold';
            app.LabelNumericEditField2.Position = [295 167 79 15];
            app.LabelNumericEditField2.Text = 'Precisao total';

            % Create NumericEditField
            app.NumericEditField = uieditfield(app.UIFigure, 'numeric');
            app.NumericEditField.Limits = [0 100];
            app.NumericEditField.Editable = 'off';
            app.NumericEditField.HorizontalAlignment = 'center';
            app.NumericEditField.FontWeight = 'bold';
            app.NumericEditField.Position = [413 165 156 20];

            % Create Label5
            app.Label5 = uilabel(app.UIFigure);
            app.Label5.HorizontalAlignment = 'right';
            app.Label5.FontWeight = 'bold';
            app.Label5.Position = [295 127 103 15];
            app.Label5.Text = 'Precisao de Teste';

            % Create NumericEditField2
            app.NumericEditField2 = uieditfield(app.UIFigure, 'numeric');
            app.NumericEditField2.Limits = [0 100];
            app.NumericEditField2.Editable = 'off';
            app.NumericEditField2.HorizontalAlignment = 'center';
            app.NumericEditField2.FontWeight = 'bold';
            app.NumericEditField2.Position = [413 125 156 20];

            % Create Lamp
            app.Lamp = uilamp(app.UIFigure);
            app.Lamp.Position = [32 49 30 30];
            app.Lamp.Color = [1 0 0];
        end
    end

    methods (Access = public)

        % Construct app
        function app = TP_2019_GUI_v2()

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)
            delete('net.mat');
            nnet.guis.closeAllViews();
            close all;
            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end