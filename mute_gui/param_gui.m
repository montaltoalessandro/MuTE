function[]= param_gui(method_param)

%%%% Pop-up menu for method specific parameter settings for MuTE toolbox

%%%%% last modified: 18-12-2015 by Frederik Van de Steen

%%% put default values in def for the resote button 
def = method_param;

%%% make figure and define colors  
buttbackgroundvec = [116  175  173]./255;
foregroundvec= [217  133  59]./255;
textcol = [253  243  231]./255;
hfig_method_param=figure('Units','normalized','Visible','off','Position',[0.1,0.1,0.8,0.3],'Color',buttbackgroundvec,'name',getfield(method_param, 'name'),'Menubar','none','NumberTitle','off','Tag','mute_method_param_param');


           

%%check whether method specific parameters have been saved previously and put them
%%in gen_def so they appear in the uicontrols
param_check =  findobj('Tag',[method_param.name '_check']);
    param_check = get(param_check,'Value');
    
        if param_check == 1;
main = findobj('Tag','mute_main');
method_tmp = getappdata(main,method_param.name);
          field_names = fieldnames(method_tmp);
          field_names2 = fieldnames(method_param);
for i=1:length(fields(method_tmp))-1
     method_param.(field_names2{i}).value = getfield(method_tmp,field_names{i});
end
        end
% hfig = findobj('Tag','mute_method_param_param');
% setappdata(hfig_method_param,'def',method_param);

names = fields(method_param);
names{end} = getfield(method_param,'name');


cols = 6;
rows = ceil(length(names)/cols);
%%%%here buttons and editable textboxex and static text is created
tel = 0;

z.method_param_param_quit    = uicontrol('Units','normalized','Style','pushbutton',...
    'String','quit','Position',[0.65,0.05,0.1,0.1],'FontSize',14,'BackgroundColor',foregroundvec);
set(z.method_param_param_quit,'callback',{@method_param_param_quit_fcn,z});
set(hfig_method_param,'Visible','on')
for i = 1:rows
    
    
    for j = 1:cols
        tel = tel+1;
        if tel==length(names)
            break
        end
        tmp = getfield(method_param,names{tel});
      uicontrol('Units','normalized','Style','edit',...
    'Position',[(0.02+(j-1)*0.165),(0.82-(i-1)*0.20),0.12,0.08],'FontSize',12,'String',tmp.value,'Tag',names{tel},'BackgroundColor',foregroundvec, 'ForegroundColor',textcol);
 uicontrol('Units','normalized','Style','text','String',names{tel},...
    'Position',[(0.02+(j-1)*0.165),(0.92-(i-1)*0.20),0.12,0.05],'FontSize',12,'BackgroundColor',foregroundvec);
 uicontrol('Units','normalized','Style','pushbutton',...
    'Position',[(0.15+(j-1)*0.165),(0.92-(i-1)*0.20),0.01,0.05],'FontSize',12,'BackgroundColor',foregroundvec,'String','?','callback',{@info_callback,getfield(method_param.(names{tel}),'text')});
        
        
    end
            if tel==length(names)+1
            break
        end
end

 uicontrol('Units','normalized','Style','pushbutton',...
    'String','restore default','Position',[0.45,0.05,0.1,0.1],'FontSize',14,'callback',{@restore_Callback,def,names},'BackgroundColor',foregroundvec);

 uicontrol('Units','normalized','Style','pushbutton',...
    'String','save settings','Position',[0.25,0.05,0.1,0.1],'FontSize',14,'callback',{@save_Callback,tel-1,names},'BackgroundColor',foregroundvec);
set(hfig_method_param,'Visible','on')

function info_callback(~,~,x)
mute_textscreen(x)


%%%callback functions for uicontrols


function method_param_param_quit_fcn(hObject,eventdata,handles)
close


function save_Callback(~, ~, x,names)

for i = 1:x
   method.(names{end}).(names{i}) = get(findobj('Tag',names{i}),'String');
    
    
end
method.(names{end}).name = names{end};
main = findobj('Tag','mute_main');
setappdata(main,names{end},method.(names{end}));
main_check = findobj('Tag',[names{end} '_check']);
set(main_check,'Value',1);

close

function restore_Callback(~, ~, method,names)
for i = 1:length(names)-1
    
    set(findobj('Tag',names{i}),'String',getfield(method.(names{i}),'value'));
    
end





