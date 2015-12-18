function[]= param_gui(method_param)

%%%% Pop-up menu for method specific parameter settings for MuTE toolbox

%%%%% last modified: 18-12-2015 by Frederik Van de Steen



buttbackgroundvec = [116  175  173]./255;
foregroundvec= [217  133  59]./255;
textcol = [253  243  231]./255;
hfig_method_param=figure('Units','normalized','Visible','off','Position',[0.1,0.1,0.8,0.3],'Color',buttbackgroundvec,'name',getfield(method_param, 'name'),'Menubar','none','NumberTitle','off','Tag','mute_method_param_param');

%%%default parameter values
           
% method_param_def.IdTargets = '[]';
% method_param_def.IdDrivers  = '[]';
% method_param_def.IdOthersLagZero  = '[]';
% method_param_def.ModelOrder   = '[]';
% method_param_def.AnalysisType  = 'multiv';
% method_param_def.Quantumlevels = '6';
% method_param_def.EntropyFun  = '@evaluateNonUniformEntropy';
% method_param_def.PreProcessingFun = '@quantization';
% method_param_def.CaseVect2 = '[1 1]';
% method_param_def.NumSurrogates  = '100';
% method_param_def.AlphaPercentile  = '0.05';
% method_param_def.GenerateCondTermFun  = '@generateConditionalTerm';
% method_param_def.UsePresent    = '0';
% method_param_def.ScalpConduction = '0';
hfig = findobj('Tag','mute_method_param_param');
setappdata(hfig_method_param,'def',method_param);

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
    'String','restore default','Position',[0.45,0.05,0.1,0.1],'FontSize',14,'callback',{@restore_Callback,method_param,names},'BackgroundColor',foregroundvec);

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
main = findobj('Tag','mute_main');
setappdata(main,names{end},method.(names{end}));
main_check = findobj('Tag',[names{end} '_check']);
set(main_check,'Value',1)
% main = findobj('Tag','mute_main');
% 
% method_param_param.Srate =  get(findobj('Tag','Srate'),'String');
% method_param_param.points = get(findobj('Tag','points'),'String');
% method_param_param.chans = get(findobj('Tag','chans'),'String');
% method_param_param.auto = get(findobj('Tag','auto'),'String');
% method_param_param.hand = get(findobj('Tag','hand'),'String');
% method_param_param.ncpu = get(findobj('Tag','ncpu'),'String');
% method_param_param.ext = get(findobj('Tag','extension'),'String');
% method_param_param.filename = get(findobj('Tag','filename'),'String');
% method_param_param.datalabel = get(findobj('Tag','datalabel'),'String');
% method_param_param.folder = get(findobj('Tag','folder'),'String');
% setappdata(main,'method_param_param',method_param_param);
% main_gen = findobj('Tag','method_param_param_check');
% set(main_gen,'Value',1);
% setappdata(main_gen,'gen_check',1);

close

function restore_Callback(~, ~, method,names)
for i = 1:length(names)-1
    
    set(findobj('Tag',names{i}),'String',getfield(method.(names{i}),'value'));
    
end





