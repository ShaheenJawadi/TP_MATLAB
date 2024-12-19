function traitement_bruit()
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
    
    % Étape 2: Ajouter du bruit poivre et sel
    img_bruitee = imnoise(img, 'salt & pepper', 0.4); % 2% de bruit poivre et sel
    
    % Étape 3: Appliquer un filtre moyen (taille 3x3 et 5x5)
    h3 = fspecial('average', [3, 3]); % Filtre moyen 3x3
    filtre_moyen_3x3 = imfilter(img_bruitee, h3, 'replicate');
    
    h5 = fspecial('average', [5, 5]); % Filtre moyen 5x5
    filtre_moyen_5x5 = imfilter(img_bruitee, h5, 'replicate');
    
    % Étape 4: Appliquer un filtre médian (taille 3x3)
    filtre_median_3x3 = medfilt2(img_bruitee, [3, 3]);
    
    % Étape 5: Appliquer un filtre minimum et maximum (taille 3x3)
    filtre_minimum = ordfilt2(img_bruitee, 1, true(3)); % Minimum
    filtre_maximum = ordfilt2(img_bruitee, 9, true(3)); % Maximum (3x3 a 9 éléments)
    
    % Étape 6: Afficher les résultats
    figure;
    
    subplot(3, 3, 1);
    imshow(img);
    title('Image originale');
    
    subplot(3, 3, 2);
    imshow(img_bruitee);
    title('Image avec bruit poivre et sel');
    
    subplot(3, 3, 3);
    imshow(filtre_moyen_3x3);
    title('Filtre moyen 3x3');
    
    subplot(3, 3, 4);
    imshow(filtre_moyen_5x5);
    title('Filtre moyen 5x5');
    
    subplot(3, 3, 5);
    imshow(filtre_median_3x3);
    title('Filtre médian 3x3');
    
    subplot(3, 3, 6);
    imshow(filtre_minimum);
    title('Filtre minimum 3x3');
    
    subplot(3, 3, 7);
    imshow(filtre_maximum);
    title('Filtre maximum 3x3');
    
    % Étape 7: Sauvegarder les résultats
    [savefile, savepath] = uiputfile('resultats.png', 'Enregistrer les résultats');
    if ~isequal(savefile, 0)
        saveas(gcf, fullfile(savepath, savefile));
        disp(['Résultats enregistrés sous : ', fullfile(savepath, savefile)]);
    else
        disp('Résultats non enregistrés.');
    end
end
