classdef P1 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                     matlab.ui.Figure
        Panel3                       matlab.ui.container.Panel
        GenerarsealPanel             matlab.ui.container.Panel
        ImportararchivodeaudioPanel  matlab.ui.container.Panel
        EditField                    matlab.ui.control.EditField
        AbrirButton                  matlab.ui.control.Button
        Panel2                       matlab.ui.container.Panel
        UIAxes_3                     matlab.ui.control.UIAxes
        UIAxes_Frequency             matlab.ui.control.UIAxes
        UIAxes                       matlab.ui.control.UIAxes
        EfectosPanel                 matlab.ui.container.Panel
        AudioPanel                   matlab.ui.container.Panel
        GrabacinPanel                matlab.ui.container.Panel
        GuardarButton                matlab.ui.control.Button
        RecordingLabel               matlab.ui.control.Label
        Button_4                     matlab.ui.control.Button
        Button_5                     matlab.ui.control.Button
        ControlesPanel               matlab.ui.container.Panel
        Button_2                     matlab.ui.control.Button
        Button_3                     matlab.ui.control.Button
        Button                       matlab.ui.control.Button
    end


    % Public properties that correspond to the Simulink model
    properties (Access = public, Transient)
        Simulation simulink.Simulation
    end

    properties (Access = private)
        Property2 % Description
        recObj    % Objeto de grabación
        audioData % Datos de audio grabado
        y  % Datos del archivo de audio
        Fs % Frecuencia de muestreo
        player % Objeto audioplayer para controlar la reproducción
        cursorLine % Línea que actúa como cursor en la gráfica
        isPlaying % Variable para saber si el audio está reproduciéndose
        recorder % Objeto audiorecorder para grabar audio
        recordedAudio % Datos del audio grabado
        recordedFs % Frecuencia de muestreo del audio grabado
        isRecording % Flag para indicar que se está grabando
    end

    methods (Access = private)




        % Función para actualizar el cursor en la gráfica
        function updateCursor(app)
            if app.isPlaying
                currentTime = app.player.CurrentSample / app.Fs; % Tiempo actual de reproducción
                set(app.cursorLine, 'XData', [currentTime currentTime]); % Actualiza la posición del cursor
            end
        end

        function plotFrequencySpectrum(app)
            if ~isempty(app.y) && ~isempty(app.Fs)
                % Get the length of the signal
                L = length(app.y);

                % If stereo, convert to mono
                if size(app.y, 2) == 2
                    y_mono = mean(app.y, 2);
                else
                    y_mono = app.y;
                end

                % Compute the Fourier transform of the signal
                Y = fft(y_mono);

                % Compute the two-sided spectrum P2
                P2 = abs(Y/L);

                % Compute the single-sided spectrum P1 based on P2 and the even-valued signal length L
                P1 = P2(1:floor(L/2)+1);
                P1(2:end-1) = 2*P1(2:end-1);

                % Define the frequency domain f
                f = app.Fs * (0:(L/2))/L;

                % Plot the single-sided amplitude spectrum
                plot(app.UIAxes_Frequency, f, P1);

                % Set labels and title
                title(app.UIAxes_Frequency, 'Single-Sided Amplitude Spectrum');
                xlabel(app.UIAxes_Frequency, 'Frequency (Hz)');
                ylabel(app.UIAxes_Frequency, '|P1(f)|');

                % Set x-axis to logarithmic scale for better visualization
                app.UIAxes_Frequency.XScale = 'log';

                % Adjust x-axis limits to show from 20 Hz to Nyquist frequency
                xlim(app.UIAxes_Frequency, [20 app.Fs/2]);
            else
                % If no audio loaded, display a message
                cla(app.UIAxes_Frequency);
                text(app.UIAxes_Frequency, 0.5, 0.5, 'No audio loaded', 'HorizontalAlignment', 'center');
            end
        end

        function updatePlot(app)
            % Update plot with current audio data
            if ~isempty(app.y)
                plot(app.UIAxes, (1:length(app.y))/app.Fs, app.y);
                xlabel(app.UIAxes, 'Time (s)');
                ylabel(app.UIAxes, 'Amplitude');
                title(app.UIAxes, 'Audio Waveform');

                % Add cursor
                hold(app.UIAxes, 'on');
                app.cursorLine = plot(app.UIAxes, [0 0], ylim(app.UIAxes), 'r', 'LineWidth', 2);
                hold(app.UIAxes, 'off');

                % Update frequency spectrum
                plotFrequencySpectrum(app);
            end
        end
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: AbrirButton
        function LoadAudioButtonPushed(app, event)
            try
                % Abre un cuadro de diálogo para seleccionar el archivo de audio
                [file, path] = uigetfile('*.wav', 'Select an audio file');
                figure(app.UIFigure);   % Para volver a la ventana principal

                % Si se selecciona un archivo, se carga y se muestra la ruta
                if isequal(file, 0)
                    disp('No se seleccionó ningún archivo');
                else
                    % Ruta completa del archivo
                    fullFileName = fullfile(path, file);

                    % Muestra la ruta en el campo de texto
                    app.EditField.Value = fullFileName;

                    % Carga el archivo de audio
                    [app.y, app.Fs] = audioread(fullFileName);

                    % Grafica la forma de onda del audio
                    plot(app.UIAxes, (1:length(app.y))/app.Fs, app.y);
                    xlabel(app.UIAxes, 'Tiempo (s)');
                    ylabel(app.UIAxes, 'Amplitud');

                    % Añade el cursor inicial en la posición 0
                    hold(app.UIAxes, 'on');
                    app.cursorLine = plot(app.UIAxes, [0 0], ylim(app.UIAxes), 'r', 'LineWidth', 2);
                    hold(app.UIAxes, 'off');

                    % VEO EL ESPECTRO DE LA SEÑAL
                    plotFrequencySpectrum(app);

                end

            catch ME
                uialert(app.UIFigure, ['Error al cargar el archivo: ' ME.message], 'Error');
            end

        end

        % Value changed function: EditField
        function EditFieldValueChanged(app, event)
            value = app.EditFieldValueChanged.Value;
        end

        % Button pushed function: Button
        function PlayButtonPushed(app, event)
            if isempty(app.y)
                uialert(app.UIFigure, 'No audio loaded. Please load or record audio first.', 'Error');
            else
                if isempty(app.player)
                    app.player = audioplayer(app.y, app.Fs);
                end

                play(app.player);
                app.isPlaying = true;

                % Set up timer for cursor update
                app.player.TimerFcn = @(~,~) updateCursor(app);
                app.player.TimerPeriod = 0.05;
            end
        end

        % Button pushed function: Button_3
        function PauseButtonPushed(app, event)
            if ~isempty(app.player) && isplaying(app.player)
                pause(app.player);
                app.isPlaying = false;
            end
        end

        % Button pushed function: Button_2
        function StopButtonPushed(app, event)
            if ~isempty(app.player)
                stop(app.player);
                app.isPlaying = false;
                % Reinicia el cursor al inicio
                set(app.cursorLine, 'XData', [0 0]);
            end
        end

        % Button pushed function: Button_4
        function StartRecordingButtonPushed(app, event)
            app.recordedFs = 44100; % Standard sampling frequency
            numChannels = 1; % Mono

            app.recorder = audiorecorder(app.recordedFs, 16, numChannels);

            record(app.recorder);
            app.isRecording = true;
            app.RecordingLabel.Text = 'Recording...';
            app.RecordingLabel.FontColor = [1 0 0]; % Red color
        end

        % Button pushed function: Button_5
        function StopRecordingButtonPushed(app, event)
            if ~isempty(app.recorder) && app.isRecording
                stop(app.recorder);
                app.isRecording = false;
                app.RecordingLabel.Text = 'Recording Stopped';
                app.RecordingLabel.FontColor = [0 0 0]; % Black color

                app.y = getaudiodata(app.recorder);
                app.Fs = app.recordedFs;

                updatePlot(app);

                % Create audioplayer object for the recorded audio
                app.player = audioplayer(app.y, app.Fs);
            end
        end

        % Button pushed function: GuardarButton
        function SaveRecordingButtonPushed(app, event)
            if isempty(app.y)
                uialert(app.UIFigure, 'No audio data to save.', 'Error');
            else
                [file, path] = uiputfile('*.wav', 'Save audio file');
                if ~isequal(file, 0)
                    fullFileName = fullfile(path, file);
                    audiowrite(fullFileName, app.y, app.Fs);
                    app.EditField.Value = fullFileName;
                    uialert(app.UIFigure, ['File saved: ' fullFileName], 'Success');
                end
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [1 1 1];
            app.UIFigure.Position = [100 100 1920 1080];
            app.UIFigure.Name = 'MATLAB App';

            % Create AudioPanel
            app.AudioPanel = uipanel(app.UIFigure);
            app.AudioPanel.Title = 'Audio';
            app.AudioPanel.Position = [28 706 373 350];

            % Create ControlesPanel
            app.ControlesPanel = uipanel(app.AudioPanel);
            app.ControlesPanel.Title = 'Controles';
            app.ControlesPanel.Position = [19 214 186 80];

            % Create Button
            app.Button = uibutton(app.ControlesPanel, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @PlayButtonPushed, true);
            app.Button.Icon = fullfile(pathToMLAPP, 'imgs', 'play.svg');
            app.Button.Position = [71 8 49 40];
            app.Button.Text = '';

            % Create Button_3
            app.Button_3 = uibutton(app.ControlesPanel, 'push');
            app.Button_3.ButtonPushedFcn = createCallbackFcn(app, @PauseButtonPushed, true);
            app.Button_3.Icon = fullfile(pathToMLAPP, 'imgs', 'pause.svg');
            app.Button_3.Position = [128 8 49 40];
            app.Button_3.Text = '';

            % Create Button_2
            app.Button_2 = uibutton(app.ControlesPanel, 'push');
            app.Button_2.ButtonPushedFcn = createCallbackFcn(app, @StopButtonPushed, true);
            app.Button_2.Icon = fullfile(pathToMLAPP, 'imgs', 'square.svg');
            app.Button_2.IconAlignment = 'center';
            app.Button_2.Position = [13 8 49 40];
            app.Button_2.Text = '';

            % Create GrabacinPanel
            app.GrabacinPanel = uipanel(app.AudioPanel);
            app.GrabacinPanel.Title = 'Grabación';
            app.GrabacinPanel.Position = [19 84 332 111];

            % Create Button_5
            app.Button_5 = uibutton(app.GrabacinPanel, 'push');
            app.Button_5.ButtonPushedFcn = createCallbackFcn(app, @StopRecordingButtonPushed, true);
            app.Button_5.Icon = fullfile(pathToMLAPP, 'imgs', 'square.svg');
            app.Button_5.IconAlignment = 'center';
            app.Button_5.Position = [77 39 49 40];
            app.Button_5.Text = '';

            % Create Button_4
            app.Button_4 = uibutton(app.GrabacinPanel, 'push');
            app.Button_4.ButtonPushedFcn = createCallbackFcn(app, @StartRecordingButtonPushed, true);
            app.Button_4.Icon = fullfile(pathToMLAPP, 'imgs', 'mic.svg');
            app.Button_4.FontSize = 8;
            app.Button_4.Position = [14 39 49 40];
            app.Button_4.Text = '';

            % Create RecordingLabel
            app.RecordingLabel = uilabel(app.GrabacinPanel);
            app.RecordingLabel.Position = [159 59 117 22];
            app.RecordingLabel.Text = '[...]';

            % Create GuardarButton
            app.GuardarButton = uibutton(app.GrabacinPanel, 'push');
            app.GuardarButton.ButtonPushedFcn = createCallbackFcn(app, @SaveRecordingButtonPushed, true);
            app.GuardarButton.BackgroundColor = [0.9412 0.9412 0.9412];
            app.GuardarButton.Position = [159 23 137 29];
            app.GuardarButton.Text = 'Guardar';

            % Create EfectosPanel
            app.EfectosPanel = uipanel(app.UIFigure);
            app.EfectosPanel.Title = 'Efectos';
            app.EfectosPanel.Position = [28 22 373 657];

            % Create Panel2
            app.Panel2 = uipanel(app.UIFigure);
            app.Panel2.Title = 'Panel2';
            app.Panel2.Position = [422 382 1477 674];

            % Create UIAxes
            app.UIAxes = uiaxes(app.Panel2);
            title(app.UIAxes, 'Title')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [51 463 1280 155];

            % Create UIAxes_Frequency
            app.UIAxes_Frequency = uiaxes(app.Panel2);
            title(app.UIAxes_Frequency, 'Title')
            xlabel(app.UIAxes_Frequency, 'X')
            ylabel(app.UIAxes_Frequency, 'Y')
            zlabel(app.UIAxes_Frequency, 'Z')
            app.UIAxes_Frequency.Position = [51 264 1281 155];

            % Create UIAxes_3
            app.UIAxes_3 = uiaxes(app.Panel2);
            title(app.UIAxes_3, 'Title')
            xlabel(app.UIAxes_3, 'X')
            ylabel(app.UIAxes_3, 'Y')
            zlabel(app.UIAxes_3, 'Z')
            app.UIAxes_3.Position = [51 65 1281 155];

            % Create Panel3
            app.Panel3 = uipanel(app.UIFigure);
            app.Panel3.Title = 'Panel3';
            app.Panel3.Position = [422 22 1478 338];

            % Create ImportararchivodeaudioPanel
            app.ImportararchivodeaudioPanel = uipanel(app.Panel3);
            app.ImportararchivodeaudioPanel.Title = 'Importar archivo de audio';
            app.ImportararchivodeaudioPanel.Position = [19 181 677 112];

            % Create AbrirButton
            app.AbrirButton = uibutton(app.ImportararchivodeaudioPanel, 'push');
            app.AbrirButton.ButtonPushedFcn = createCallbackFcn(app, @LoadAudioButtonPushed, true);
            app.AbrirButton.Position = [24 51 79 23];
            app.AbrirButton.Text = 'Abrir';

            % Create EditField
            app.EditField = uieditfield(app.ImportararchivodeaudioPanel, 'text');
            app.EditField.ValueChangedFcn = createCallbackFcn(app, @EditFieldValueChanged, true);
            app.EditField.Tag = 'EditFieldValueChanged';
            app.EditField.Position = [118 52 538 22];

            % Create GenerarsealPanel
            app.GenerarsealPanel = uipanel(app.Panel3);
            app.GenerarsealPanel.Title = 'Generar señal';
            app.GenerarsealPanel.Position = [21 32 676 128];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = P1

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end