function [III]=cnnt_nuc_2(nuc_coord,a,numb_frame,dist)
%%%%MASTER m-FILE>>crop_nuc.m%%%%%%%%%%%
%%%%%%%%%%%%%genrate 1st tiff file of individual nuleus%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% just of 1st frame%%%%%%%%%%%%%%%%%
 img1=a{1,1};               %%%%%%%%%%%
 cellsinfr=nuc_coord{1,1};  %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
III=cell(numb_frame,length(cellsinfr));

            for celln=1:length(cellsinfr)

                cell_loc=cellsinfr(celln,:); % 1 cell
                 st=fix(cell_loc)-128;
                img_cr=imcrop(img1,[st(1) st(2) 255 255]);
                img_cr_size=size(img_cr);
                 if img_cr_size(1)~=256 || img_cr_size(2)~=256
                        disp('This cell locates at the edge  of img!')
                        ic_s=size(img_cr)-1; % (length width)remove 1 row&colume negative x or y +256 turns into 257
                        min(min(img_cr))
                        minimum=min(min(img_cr));
                        blackimg=uint16(zeros(256))+uint16(minimum);blackimg_cent=[128,128];
                       
                        bl_st=round(([256,256]-size(img_cr))/2);
                            if bl_st(1)==0 
                                bl_st(1)=bl_st(1)+1;
                            end
                            if bl_st(2)==0 
                                bl_st(2)=bl_st(2)+1;
                            end 
                          
                        nx_last=bl_st(1,1)+ic_s(1,1);
                        ny_last=bl_st(1,2)+ic_s(1,2);
                        blackimg([bl_st(1):nx_last],[bl_st(2):ny_last])=img_cr; 
                        img_cr=blackimg;
                    end
%                 figure,imshow(img_cr,[]);   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        %%%%%%%%%%%%Keep images in cell format%%%%%%%%%%%%%%%
         III{1,celln}=img_cr;
             end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%keep run it for the rest of frames, 2nd fr~%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%  
% %a=>whole image file(2DxT)
% full inf for green.
% %output>> 2nd fr~
fullcoord=cell(floor(numb_frame/2),1); %Check if # of frame is even!
for m=1:floor(numb_frame/2.-1) %frame
    if m==1
        I=nuc_coord{1,1};
        fullcoord{m,1}=I;
    else
        I=next_coord;
    end 
    II=nuc_coord{m+1,1};
    D = pdist2(I,II,'euclidean'); %distance all cells fr1xfr2 
    %%pick the next location <50 in dist. 
    % discarded cells appears in thelater time point.
         for p=1:length(I);
           
          if min(D(p,:))<dist %%%%%%%%If cells jump around, increase the dist for connectivity.
             next=find(D(p,:)==min(D(p,:)));
             next_coord(p,:)=II(next,:);
          else  
            next_coord(p,:)=I(p,:); %coordinate remained .
          end
         end
     fullcoord{m+1,1}=next_coord;%all coordinate collected(#of cell in 1st fr x #fr/2)    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%%%%%%%%%%Lets crop the next img%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   ;
    img1=a{m+1};
%         for celln=1:length(next_coord)
%                 cell_loc=next_coord(celln,:); % 1 cell
%                 st=fix(cell_loc)-128;
%                 img_cr=imcrop(img1,[st(1) st(2) 255 255]);
%                 img_cr_size=size(img_cr);
%                  if img_cr_size(1)~=256 || img_cr_size(2)~=256
%                         disp('This cell locates at the edge  of img!')
%                           ic_s=size(img_cr)-1; % (length width)remove 1 row&colume negative x or y +256 turns into 257
%                           minimum=min(min(img_cr));
%                         blackimg=uint16(zeros(256))+uint16(minimum);%min(min(img_cr))%;blackimg_cent=[128,128];
%                        
%                         bl_st=round(([256,256]-size(img_cr))/2);
%                             if bl_st(1)==0 
%                                 bl_st(1)=bl_st(1)+1;
%                             end
%                             if bl_st(2)==0 
%                                 bl_st(2)=bl_st(2)+1;
%                             end 
%                             last=bl_st+ic_s;
%                             ic_s=ic_s;
%                         nx_last=bl_st(1,1)+ic_s(1,1);
%                         ny_last=bl_st(1,2)+ic_s(1,2);
%                         blackimg([bl_st(1):nx_last],[bl_st(2):ny_last])=img_cr; 
%                         img_cr=blackimg;
%                  end
%                  
%                
%                  % figure,imshow(img_cr,[])
% disp('GREEN:almost done, check collected&saved images!')
% %   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%     %%%%%%%%%%%%Keep images in cell format%%%%%%%%%%%%%%%            
%         III{m+1,celln}=img_cr;        
%         end
end
%%%%%%%%%%Lets crop MCH img%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    

    for m=numb_frame/2.+1):numb_frame %visit each cell in full coord
     img1=a{m,1};
     c=m-numb_frame/2);
     coord=fullcoord{c,1};
        
        for celln=1:length(cellsinfr) 
           cell_loc=coord(celln,:);
           st=fix(cell_loc)-128;
                img_cr=imcrop(img1,[st(1) st(2) 255 255]);
                img_cr_size=size(img_cr);
                 if img_cr_size(1)~=256 || img_cr_size(2)~=256
                        ic_s=size(img_cr)-1; % (length width)remove 1 row&colume negative x or y +256 turns into 257
                        minimum=min(min(img_cr));
                        blackimg=uint16(zeros(256))+uint16(minimum);% min(min(img_cr));blackimg_cent=[128,128];
                       
                        bl_st=round(([256,256]-size(img_cr))/2);
                            if bl_st(1)==0 
                                bl_st(1)=bl_st(1)+1;
                            end
                            if bl_st(2)==0 
                                bl_st(2)=bl_st(2)+1;
                            end 
                            last=bl_st+ic_s;
                            ic_s=ic_s;
                        nx_last=bl_st(1,1)+ic_s(1,1);
                        ny_last=bl_st(1,2)+ic_s(1,2);
                        blackimg([bl_st(1):nx_last],[bl_st(2):ny_last])=img_cr; 
                        img_cr=blackimg;
                    end
% figure,imshow(img_cr,[])
disp('MCH:almost done, check collected&saved images!')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    %%%%%%%%%%%%Keep images in cell format%%%%%%%%%%%%%%%  
    III{m,celln}=img_cr;           
    end

end

