function morph_size = findMorphSize(path)
    % hard-coded environmental structures in current morphing paradigm
    env_list   = ["Sq1","Sq2","Sq3","G1","G2","G3"];
    morph_size = [ 0     3     5    7     9    11];
    % find which environment it is given the path
    env = cat(1, regexp(path, 'G[123]', 'match'), regexp(path, 'Sq[123]', 'match'));
    morph_size = morph_size(strcmp(env_list, env(1)));
end
