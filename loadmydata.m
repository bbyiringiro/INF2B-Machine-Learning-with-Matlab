dset_dir = 'dataset';
  [Xtrn, Ytrn, Xtst, Ytst] = load_my_data_set(dset_dir);
  Xtrn = double(Xtrn)/255.0;
  Xtst = double(Xtst)/255.0;