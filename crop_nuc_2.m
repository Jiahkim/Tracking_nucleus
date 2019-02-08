function crop_nuc_2()
for f=3:3
%%%% + cnnt_nuc.m & nuc_cuc.m%%%%%%%%%%%%%%%%
%%%%%%%%%%%%file path&name%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fname_path='/Users/jiahK/Desktop/TRL/';
fname_fileI='C7MCP_TRL_every2minfor2hr_visit_'
fname_fileII=[fname_fileI num2str(f)];
fname_file=[fname_fileII '_D3D_PRJ'];
fname=[fname_path fname_file '.dv'];
fname_folder2=[fname_path fname_file '/'];%%%%%dir for outputs!!
fname_folder=[fname_path fname_file];
mkdir(fname_folder)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cc=[50.00   1.2  1.5  1.5]; %%%Edit this for each image%%%%%%%
dist=cc(1);% distance to link cells fr to fr
thr1=cc(2);% n<13
thr2=cc(3);%n>12 && n<20
thr3=cc(4);%n>19
fname_nuc2=[fname_folder2 fname_file '-cond.txt'];
cond= fopen(fname_nuc2,'a');
fprintf(cond,'%6.2f %6.2f %6.2f %6.2f\n',cc);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[nuc_coord,a,numb_frame]=nuc_nuc_2(fname,fname_folder2,fname_file,thr1,thr2,thr3);
[III]=cnnt_nuc_2(nuc_coord,a,numb_frame,dist);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=size(III);
%    bfsave(I, outputPath, dimensionOrder) specifies the dimension order of
%    the input matrix. Default valuse is XYZCT.


for n=1:s(2)
    
    for i=1:s(1)/2
         IV(:,:,1,2,i)=III{i,n}; %%XYZCT.XYZCT
    end
    for i=s(1)/2+1:s(1)
        IV(:,:,1,1,i-s(1)/2)=III{i,n};
    end
  
     numb0=num2str(n);
     fname_nuc=[fname_folder2 fname_file '-' numb0 '.ome.tiff']; %file name generated.
     bfsave(IV, fname_nuc)
  
end

     
%%%%%%%% Lets save original metadata%%%%%
% fname_text=[fname_folder2 fname_file '.txt'];
% fileID = fopen(fname_text,'w');
% metadataKeys = metadata.keySet().iterator();
% for i=1:metadata.size()
%   key = metadataKeys.nextElement();
%   value = metadata.get(key);
%   fprintf(fileID,'%s = %s\n', key, value);
% end
    
end