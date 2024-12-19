function extension_dynamique()
    % Étape 1: Lire l'image
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
    
    % Étape 2: Afficher l'image originale et son histogramme
    figure;
    subplot(2, 2, 1);
    imshow(img);
    title('Image originale');
    
    subplot(2, 2, 2);
    imhist(img);
    title('Histogramme original');
    
    % Étape 3: Réaliser l’extension de la dynamique
    min_val = double(min(img(:)));
    max_val = double(max(img(:)));
    extended_img = uint8(255 * (double(img) - min_val) / (max_val - min_val));
    
    % Étape 4: Afficher la nouvelle image et son histogramme
    subplot(2, 2, 3);
    imshow(extended_img);
    title('Image après extension de la dynamique');
    
    subplot(2, 2, 4);
    imhist(extended_img);
    title('Histogramme après extension');
    
    % Étape 5: Enregistrer l'image transformée
    [savefile, savepath] = uiputfile('extended_image.png', 'Enregistrer l\'image étendue');
    if ~isequal(savefile, 0)
        imwrite(extended_img, fullfile(savepath, savefile));
        disp(['Image étendue enregistrée sous : ', fullfile(savepath, savefile)]);
    else
        disp('Image étendue non enregistrée.');
    end
end
