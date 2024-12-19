function inversion_dynamique_image()
    % Étape 1: Lire une image
    [filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp', 'Images (*.jpg, *.png, *.bmp)'}, 'Sélectionnez une image');
    if isequal(filename, 0)
        disp('Aucune image sélectionnée.');
        return;
    end
    img = imread(fullfile(pathname, filename));
    
    % Convertir en niveaux de gris si l'image est en couleur
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    
    % Étape 2: Afficher l'histogramme original
    figure;
    subplot(2, 2, 1);
    imshow(img);
    title('Image originale');
    
    subplot(2, 2, 2);
    imhist(img);
    title('Histogramme original');
    
    % Étape 3: Inversion de la dynamique
    M = 255; % Maximum pour une image 8 bits
    inverted_img = M - img;
    
    % Étape 4: Afficher la nouvelle image après transformation
    subplot(2, 2, 3);
    imshow(inverted_img);
    title('Image après inversion');
    
    % Étape 5: Afficher le nouvel histogramme
    subplot(2, 2, 4);
    imhist(inverted_img);
    title('Nouvel histogramme');
    
    % Enregistrer la nouvelle image
    [savefile, savepath] = uiputfile('inverted_image.png', 'Enregistrer image inversée');
    if ~isequal(savefile, 0)
        imwrite(inverted_img, fullfile(savepath, savefile));
        disp(['Image inversée enregistrée sous : ', fullfile(savepath, savefile)]);
    else
        disp('Image inversée non enregistrée.');
    end
end
