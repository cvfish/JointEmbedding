clearvars; close all;
addpath('../'); global_variables;
addpath(genpath(g_minfunc_2012_path));


% g_shape_embedding_space_file_mat_gt = '/home/adrian/JointEmbedding/datasets/shape_embedding/shape_embedding_space_03001627(gt).mat';
g_shape_embedding_space_file_mat_myTraining = '/home/adrian/JointEmbedding/datasets/shape_embedding/shape_embedding_space_03001627(myTraining).mat';


g_shape_embedding_space_file_mat_gt = '/home/adrian/JointEmbedding/datasets/shape_embedding/shape_embedding_space_03001627(gt).txt';


%% Load shape distance matrix

t_begin = clock;
fprintf('Loading shape distance matrix from \"%s\"...\n', g_shape_distance_matrix_file_mat);
load(g_shape_distance_matrix_file_mat);
shape_distance_matrix_squared = squareform(shape_distance_matrix);
t_end = clock;
fprintf('done (%f seconds)!\n', etime(t_end, t_begin));


%% Load GT shape embedding space

t_begin = clock;
fprintf('Loading GT shape embedding space from \"%s\"...\n', g_shape_embedding_space_file_mat_gt);

% load(g_shape_embedding_space_file_mat_gt);
% gt_shape_embedding_space = shape_embedding_space;

g_shape_embedding_space_file_mat_gt = '/home/adrian/JointEmbedding/datasets/shape_embedding/shape_embedding_space_03001627(gt).txt';
gt_shape_embedding_space = dlmread(g_shape_embedding_space_file_mat_gt);

t_end = clock;
fprintf('done (%f seconds)!\n', etime(t_end, t_begin));


%% Load MY shape embedding space

t_begin = clock;
fprintf('Loading MY shape embedding space from \"%s\"...\n', g_shape_embedding_space_file_mat_myTraining);

load(g_shape_embedding_space_file_mat_myTraining);
my_shape_embedding_space = shape_embedding_space;

% g_shape_embedding_space_file_mat_myTraining = '/home/adrian/JointEmbedding/datasets/shape_embedding/shape_embedding_space_03001627(meTrained).txt';
% my_shape_embedding_space = dlmread(g_shape_embedding_space_file_mat_myTraining);

t_end = clock;
fprintf('done (%f seconds)!\n', etime(t_end, t_begin));



%% Compare distances in both embeddings

n_cases = 10000;
gt_n_values = size(gt_shape_embedding_space,1);
my_n_values = size(my_shape_embedding_space,1);




chair35_gt_value = [4.39725685e+00,  -1.33802271e+00,  -5.18214321e+00, ...
        -2.47185493e+00,   1.75274634e+00,   3.30775046e+00, ...
        -1.80154455e+00,  -8.87633264e-01,  -4.63583517e+00, ...
        -5.50321579e-01,  -7.36096263e-01,   6.13134563e-01, ...
        -1.67025709e+00,  -9.82460320e-01,   4.50311720e-01, ...
        -1.56866133e-01,   7.52572715e-01,   1.63861185e-01, ...
         8.07213664e-01,   2.32156366e-01,   1.01834905e+00, ...
         1.17420793e+00,   4.71636206e-01,  -8.39117289e-01, ...
         1.55618155e+00,  -1.47110209e-01,  -2.07141995e+00, ...
        -1.60902429e+00,  -4.40459371e-01,   7.23484516e-01, ...
        -1.09478831e-02,   8.08582962e-01,   1.26930967e-01, ...
        -1.45516062e+00,   6.54624283e-01,  -1.35931957e+00, ...
        -7.12804317e-01,   3.22192013e-01,  -2.89727807e-01, ...
        -1.01695490e+00,  -1.62825453e+00,  -5.68312466e-01, ...
        -1.12824988e+00,   1.21838760e+00,   3.72499287e-01, ...
         6.44643068e-01,  -7.67967701e-01,  -1.10381234e+00, ...
         8.08402777e-01,   9.91247475e-01,   6.29833281e-01, ...
         2.66232640e-02,   8.97576571e-01,  -4.42636728e-01, ...
        -4.71594363e-01,   1.80882215e-01,  -1.03157794e+00, ...
         9.03029025e-01,   7.25239992e-01,  -4.07554060e-01, ...
        -5.40215552e-01,   3.06391567e-02,   6.27997145e-02, ...
        -7.20086157e-01,  -9.36642110e-01,  -4.10603344e-01, ...
        -5.29752553e-01,   9.43275392e-02,  -8.99813056e-01, ...
        -2.50047624e-01,   3.75845015e-01,   5.47998957e-02, ...
        -4.66074526e-01,  -1.25519782e-01,  -5.46845019e-01, ...
        -6.70094132e-01,  -3.93650800e-01,  -1.15767074e+00, ...
        -8.36589113e-02,  -1.08039439e+00,   1.78687334e-01, ...
         1.40668780e-01,   4.57043678e-01,   9.76702273e-02, ...
         2.39530392e-02,  -1.93254545e-01,  -3.16432506e-01, ...
         1.55006066e-01,   7.38560319e-01,  -5.10865450e-01, ...
         1.55653208e-01,   3.47132422e-02,  -1.25988096e-01, ...
        -6.96624458e-01,   6.90053761e-01,   9.34257880e-02, ...
         1.75298735e-01,  -2.18516290e-01,   2.22736269e-01, ...
         3.11059564e-01,   3.83162647e-01,   3.73326331e-01, ...
        -2.47570544e-01,   3.17801863e-01,  -6.27010405e-01, ...
         9.75092407e-05,   4.03419793e-01,  -4.35441919e-02, ...
        -2.20960945e-01,   1.38478920e-01,   1.71340227e-01, ...
         2.10046694e-01,  -9.71193165e-02,   4.99660552e-01, ...
        -5.04483223e-01,  -1.17057055e-01,  -1.05199501e-01, ...
        -6.00918174e-01,  -7.44147301e-01,   4.20572162e-01, ...
        -2.37100288e-01,  -1.98363498e-01,   1.42490536e-01, ...
         5.91307767e-02,  -4.03103173e-01,   2.88446248e-01, ...
         8.07199776e-02,  -3.20408583e-01];

     
     
     
chair35_my_value = [3.23211026e+00,  -7.87490726e-01,  -4.49630356e+00, ...
        -2.02117395e+00,   2.02922320e+00,   1.75700021e+00, ...
        -9.06127810e-01,  -1.93284452e-01,  -2.84897208e+00, ...
        -1.02421594e+00,   2.82012761e-01,   5.49998820e-01, ...
        -9.11285222e-01,  -3.53896588e-01,  -1.70931131e-01, ...
         2.87615806e-01,   4.39780414e-01,  -3.90173852e-01, ...
         1.95062488e-01,  -1.23150676e-01,   5.93391299e-01, ...
         2.99998552e-01,   7.14447856e-01,   6.12241141e-02, ...
         4.04722273e-01,   9.68383402e-02,  -9.87539530e-01, ...
        -7.03200102e-01,  -1.81611255e-03,   2.13627994e-01, ...
        -2.53211737e-01,   4.00052309e-01,  -5.27451932e-02, ...
        -4.32520896e-01,  -9.26777199e-02,  -4.79186416e-01, ...
        -6.04619980e-01,  -8.38987082e-02,  -6.08423278e-02, ...
        -6.46295667e-01,  -7.49649256e-02,  -1.69842988e-01, ...
        -5.63772321e-01,   4.97456342e-01,  -2.89835006e-01, ...
         1.59125254e-01,  -5.88172615e-01,  -3.59385431e-01, ...
         9.35512304e-01,   2.34035417e-01,   5.06196439e-01, ...
         3.13484430e-01,   4.41714883e-01,   9.86719802e-02, ...
         6.51512817e-02,   5.45209385e-02,  -2.28782535e-01, ...
         3.31105173e-01,   4.38770115e-01,   6.01837263e-02, ...
        -3.25814128e-01,   2.48259127e-01,   1.43614203e-01, ...
        -2.54082590e-01,  -6.98815107e-01,  -1.03132062e-01, ...
        -1.72722116e-01,   1.37071908e-02,   1.73782110e-02, ...
         6.06212914e-02,   2.53468305e-01,   4.44069318e-03, ...
        -1.46611199e-01,  -1.58487573e-01,  -2.15254128e-01, ...
        -3.38949144e-01,  -3.37264329e-01,  -5.86870313e-01, ...
        -1.00594833e-02,  -2.58983672e-01,   1.49359584e-01, ...
        -1.06410570e-02,  -2.88107432e-02,   1.10076368e-01, ...
        -1.52888834e-01,  -4.73936759e-02,   1.59721244e-02, ...
        -5.52066080e-02,   3.35420370e-01,   1.22685909e-01, ...
        -1.11762196e-01,   2.52824605e-01,   4.28711176e-01, ...
        -2.47191131e-01,   7.68628949e-03,  -1.36666179e-01, ...
         2.61873156e-01,   1.06901139e-01,   1.29400551e-01, ...
         1.21433832e-01,   2.39316627e-01,   1.08750008e-01, ...
        -9.23888087e-02,   1.00197554e-01,  -1.02561072e-01, ...
        -2.31105331e-02,  -6.90941811e-02,   7.79164210e-03, ...
        -1.15907952e-01,   1.37223974e-01,   1.13098487e-01, ...
         1.93954051e-01,  -1.92447200e-01,   1.85537726e-01, ...
        -6.54094517e-02,  -4.69281971e-02,  -2.85922348e-01, ...
        -9.92413983e-02,  -1.28394663e-01,   1.31390721e-01, ...
         1.81583136e-01,   1.65055152e-02,   1.72769815e-01, ...
        -1.00525014e-01,  -2.72607833e-01,   4.19731364e-02, ...
        -1.57952935e-01,  -7.04967678e-02];
        
        
        

for iterator = 1:n_cases
    val1 = 2565 +1; % randi(gt_n_values-10,1);
    val2 = 2050 +1; % randi(gt_n_values-10,1);
    val3 = 817 +1; % randi(gt_n_values-10,1);
    
    gt_emb_val1 = gt_shape_embedding_space(val1,:); % / norm(gt_shape_embedding_space(val1+10,:));
    gt_emb_val2 = gt_shape_embedding_space(val2,:); % / norm(gt_shape_embedding_space(val2+10,:));
    gt_emb_val3 = gt_shape_embedding_space(val3,:); % / norm(gt_shape_embedding_space(val3+10,:));
    
    
    gt_dist12 = sqrt(sum((gt_emb_val1 - gt_emb_val2) .^ 2));
    gt_dist13 = sqrt(sum((gt_emb_val1 - gt_emb_val3) .^ 2));
    gt_dist23 = sqrt(sum((gt_emb_val2 - gt_emb_val3) .^ 2));
    
    dist1 = sqrt(sum((gt_emb_val1 - chair35_gt_value) .^ 2));
    dist2 = sqrt(sum((gt_emb_val2 - chair35_gt_value) .^ 2));
    dist3 = sqrt(sum((gt_emb_val3 - chair35_gt_value) .^ 2));
    
    mdist1 = sqrt(sum((gt_emb_val1 - chair35_my_value) .^ 2));
    mdist2 = sqrt(sum((gt_emb_val2 - chair35_my_value) .^ 2));
    mdist3 = sqrt(sum((gt_emb_val3 - chair35_my_value) .^ 2));
    
    lolo = 1;
end
    
lolo = 1;


