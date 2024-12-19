function binarisation_image()
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
    
    % Étape 2: Choisir un seuil
    % Vous pouvez utiliser une méthode automatique comme Otsu ou choisir un seuil fixe
    % Méthode d'Otsu pour trouver le seuil optimal
    seuil = graythresh(img) * 255; % Convertir en échelle de 0-255 pour un affichage clair
    fprintf('Seuil utilisé pour la binarisation : %.2f\n', seuil);
    
    % Étape 3: Appliquer la binarisation
    binary_img = img > seuil; % Pixels supérieurs au seuil deviennent 1, sinon 0
    
    % Étape 4: Afficher les résultats
    figure;
    subplot(1, 3, 1);
    imshow(img);
    title('Image originale');
    
    subplot(1, 3, 2);
    imshow(binary_img);
    title('Image binarisée');
    
    subplot(1, 3, 3);
    imhist(img);
    hold on;
    xline(seuil, 'r', 'LineWidth', 2);
    title('Histogramme avec seuil');
    hold off;
    
    % Enregistrer l'image binarisée
    [savefile, savepath] = uiputfile('binarized_image.png', 'Enregistrer l image binarisée');
    if ~isequal(savefile, 0)
        imwrite(binary_img, fullfile(savepath, savefile));
        disp(['Image binarisée enregistrée sous : ', fullfile(savepath, savefile)]);
    else
        disp('Image binarisée non enregistrée.');
    end
end
