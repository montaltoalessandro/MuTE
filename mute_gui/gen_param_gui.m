function[]= gen_param_gui(gen_def)
 %%%%%general parameters and data pop-up window for the MuTE gui
 
 %%%%% last modified: 01-04-2016 by Frederik Van de Steen

%%% put default values in def for the restore button  
def = gen_def;

%%check whether general parameters have been saved previously and put them
%%in gen_def so they appear in the uicontrols
    gen_param_check =  findobj('Tag','gen_param_check');
    gen_check = get(gen_param_check,'Value');

    if gen_check == 1;
         main_mute =  findobj('Tag','mute_main');
         gen_tmp = getappdata(main_mute,'gen_param');
          field_names = fieldnames(gen_tmp);
          field_names2 = fieldnames(gen_def);
         for i = 1:length(fields(gen_tmp))
   gen_def.(field_names2{i}).value = getfield(gen_tmp,field_names{i});
         end
    end
%%% make figure and define colors    
buttbackgroundvec = [116  175  173]./255;
foregroundvec= [217  133  59]./255;
textcol = [253  243  231]./255;
hfig_gen_param=figure('Units','normalized','Visible','off','Position',[0.5,0.1,0.3,0.5],'Color',buttbackgroundvec,'name','general parameters','Menubar','none','NumberTitle','off','Tag','mute_gen_param');


% hfig_gen_param = findobj('Tag','mute_gen_param');
setappdata(hfig_gen_param,'def',def);

%%%%here buttons and editable textboxex and static text are created

z.gen_param_quit    = uicontrol('Units','normalized','Style','pushbutton',...
    'String','Quit','Position',[0.80,0.02,0.15,0.05],'FontSize',14,'BackgroundColor',foregroundvec);
set(z.gen_param_quit,'callback',{@gen_param_quit_fcn,z});


z.gen_param_data    = uicontrol('Units','normalized','Style','pushbutton',...
    'String','select data folder','Position',[0.1,0.92,0.8,0.05],'FontSize',12,'BackgroundColor',foregroundvec);
set(z.gen_param_data,'callback',{@gen_param_data_fcn,z});
z.gen_param_data_text    = uicontrol('Units','normalized','Style','edit','String',gen_def.datafolder.value,...
    'Position',[0.1,0.85,0.8,0.05],'FontSize',12,'Tag','folder','BackgroundColor',foregroundvec, 'ForegroundColor',textcol);
 uicontrol('Units','normalized','Style','pushbutton',...
    'Position',[0.92,0.92,0.03,0.05],'FontSize',12,'BackgroundColor',foregroundvec,'String','?','callback',{@info_callback,gen_def.datafolder.text});

z.gen_param_data1    = uicontrol('Units','normalized','Style','edit','String',gen_def.datafilename.value,...
    'Position',[0.1,0.66,0.2,0.05],'FontSize',12,'Tag','filename','BackgroundColor',foregroundvec, 'ForegroundColor',textcol);
z.gen_param_data1_text    = uicontrol('Units','normalized','Style','text','String','dataFilename',...
    'Position',[0.1,0.73,0.2,0.05],'FontSize',12,'BackgroundColor',foregroundvec);
uicontrol('Units','normalized','Style','pushbutton',...
    'Position',[0.31,0.73,0.03,0.05],'FontSize',12,'BackgroundColor',foregroundvec,'String','?','callback',{@info_callback,gen_def.datafilename.text});



z.gen_param_data2    = uicontrol('Units','normalized','Style','edit','String',gen_def.datalabel.value,...
    'Position',[0.40,0.66,0.20,0.05],'FontSize',12,'Tag','datalabel','BackgroundColor',foregroundvec, 'ForegroundColor',textcol);
z.gen_param_data2_text    = uicontrol('Units','normalized','Style','text','String','datalabel',...
    'Position',[0.40,0.73,0.20,0.05],'FontSize',12,'BackgroundColor',foregroundvec);
uicontrol('Units','normalized','Style','pushbutton',...
    'Position',[0.61,0.73,0.03,0.05],'FontSize',12,'BackgroundColor',foregroundvec,'String','?','callback',{@info_callback,gen_def.datalabel.text});

z.gen_param_data3    = uicontrol('Units','normalized','Style','edit',...
    'String',gen_def.dataExtension.value,'Position',[0.7,0.67,0.20,0.05],'FontSize',12,'Tag','extension','BackgroundColor',foregroundvec,'ForegroundColor',textcol);
z.gen_param_data3_text    = uicontrol('Units','normalized','Style','text','String','dataExtension',...
    'Position',[0.7,0.73,0.20,0.05],'FontSize',10,'BackgroundColor',foregroundvec);
uicontrol('Units','normalized','Style','pushbutton',...
    'Position',[0.91,0.73,0.03,0.05],'FontSize',12,'BackgroundColor',foregroundvec,'String','?','callback',{@info_callback,gen_def.dataExtension.text});

z.gen_param_Srate    = uicontrol('Units','normalized','Style','edit',...
    'String',gen_def.samplingRate.value,'Position',[0.1,0.46,0.2,0.05],'FontSize',12,'Tag','Srate','BackgroundColor',foregroundvec,'ForegroundColor',textcol);
z.gen_param_Srate_text    = uicontrol('Units','normalized','Style','text','String','samplingRate',...
    'Position',[0.1,0.52,0.2,0.05],'FontSize',12,'BackgroundColor',foregroundvec);
uicontrol('Units','normalized','Style','pushbutton',...
    'Position',[0.31,0.52,0.03,0.05],'FontSize',12,'BackgroundColor',foregroundvec,'String','?','callback',{@info_callback,gen_def.samplingRate.text});

z.gen_param_points    = uicontrol('Units','normalized','Style','edit',...
    'String',gen_def.pointsToDiscard.value,'Position',[0.4,0.46,0.2,0.05],'FontSize',12,'Tag','points','BackgroundColor',foregroundvec,'ForegroundColor',textcol);
z.gen_param_points_text    = uicontrol('Units','normalized','Style','text','String','pointsToDiscard',...
    'Position',[0.4,0.52,0.2,0.05],'FontSize',11,'BackgroundColor',foregroundvec);
uicontrol('Units','normalized','Style','pushbutton',...
    'Position',[0.61,0.52,0.03,0.05],'FontSize',12,'BackgroundColor',foregroundvec,'String','?','callback',{@info_callback,gen_def.pointsToDiscard.text});

z.gen_param_chans    = uicontrol('Units','normalized','Style','edit',...
    'String',gen_def.channels.value,'Position',[0.7,0.46,0.20,0.05],'FontSize',12,'Tag','chans','BackgroundColor',foregroundvec,'ForegroundColor',textcol);
z.gen_param_chans_text    = uicontrol('Units','normalized','Style','text','String','Channels',...
    'Position',[0.7,0.52,0.2,0.05],'FontSize',12,'BackgroundColor',foregroundvec);

uicontrol('Units','normalized','Style','pushbutton',...
    'Position',[0.91,0.52,0.03,0.05],'FontSize',12,'BackgroundColor',foregroundvec,'String','?','callback',{@info_callback,gen_def.channels.text});

z.gen_param_auto    = uicontrol('Units','normalized','Style','edit',...
    'String',gen_def.autoPairwiseTarDriv.value,'Position',[0.1,0.26,0.20,0.05],'FontSize',12,'Tag','auto','BackgroundColor',foregroundvec,'ForegroundColor',textcol);
z.gen_param_auto_text    = uicontrol('Units','normalized','Style','text','String','autoPairwiseTardriv',...
    'Position',[0.1,0.32,0.2,0.07],'FontSize',10,'BackgroundColor',foregroundvec);

uicontrol('Units','normalized','Style','pushbutton',...
    'Position',[0.31,0.32,0.03,0.07],'FontSize',12,'BackgroundColor',foregroundvec,'String','?','callback',{@info_callback,gen_def.autoPairwiseTarDriv.text});
% z.gen_param_auto_info    = uicontrol('Units','normalized','Style','pushbutton',...
%     'String','?','Position',[0.1,0.45,0.1,0.05],'FontSize',14,'BackgroundColor',foregroundvec);
% set(z.gen_param_auto_info,'callback',@(o,e)mute_textscreen('here you need to specify in which method the target-drivers are set automatically','http://mutetoolbox.guru/mutesettings/'));

z.gen_param_hand    = uicontrol('Units','normalized','Style','edit',...
    'String',gen_def.handPairwiseTarDriv.value, 'Position',[0.4,0.26,0.20,0.05],'FontSize',12,'Tag','hand','BackgroundColor',foregroundvec,'ForegroundColor',textcol);
z.gen_param_hand_text    = uicontrol('Units','normalized','Style','text','String','handPairwiseTardriv',...
    'Position',[0.4,0.32,0.2,0.07],'FontSize',10,'BackgroundColor',foregroundvec);
uicontrol('Units','normalized','Style','pushbutton',...
    'Position',[0.61,0.32,0.03,0.07],'FontSize',12,'BackgroundColor',foregroundvec,'String','?','callback',{@info_callback,gen_def.handPairwiseTarDriv.text});

% z.gen_param_res    = uicontrol('Units','normalized','Style','edit',...
%     'Position',[0.7,0.26,0.20,0.05],'FontSize',12,'BackgroundColor',foregroundvec,'ForegroundColor',textcol);
% z.gen_param_res_text    = uicontrol('Units','normalized','Style','text','String','name results dir',...
%     'Position',[0.7,0.32,0.2,0.05],'FontSize',10,'BackgroundColor',foregroundvec);
z.gen_param_ncpu    = uicontrol('Units','normalized','Style','edit',...
    'String',gen_def.numProcessors.value,'Position',[0.7,0.26,0.20,0.05],'FontSize',12,'Tag','ncpu','BackgroundColor',foregroundvec,'ForegroundColor',textcol);
z.gen_param_ncpu_text    = uicontrol('Units','normalized','Style','text','String','numProcessors',...
    'Position',[0.7,0.32,0.2,0.07],'FontSize',10,'BackgroundColor',foregroundvec);
uicontrol('Units','normalized','Style','pushbutton',...
    'Position',[0.91,0.32,0.03,0.07],'FontSize',12,'BackgroundColor',foregroundvec,'String','?','callback',{@info_callback,gen_def.numProcessors.text});

z.gen_param_restore    = uicontrol('Units','normalized','Style','pushbutton',...
    'String','Restore default','Position',[0.425,0.02,0.25,0.05],'FontSize',14,'callback',@restore_Callback,'BackgroundColor',foregroundvec);

z.gen_param_save_param    = uicontrol('Units','normalized','Style','pushbutton',...
    'String','Save settings','Position',[0.05,0.02,0.25,0.05],'FontSize',14,'callback',@save_Callback,'BackgroundColor',foregroundvec);


set(hfig_gen_param,'Visible','on')


%%%callback functions for uicontrols


function gen_param_quit_fcn(hObject,eventdata,handles)
close


function gen_param_data_fcn(hObject,eventdata,handles)
dataDir = uigetdir();
set(findobj('Tag','folder'),'String',dataDir);

function save_Callback(hObject, eventdata, handles)
main = findobj('Tag','mute_main');

gen_param.Srate =  get(findobj('Tag','Srate'),'String');
gen_param.points = get(findobj('Tag','points'),'String');
gen_param.chans = get(findobj('Tag','chans'),'String');
gen_param.auto = get(findobj('Tag','auto'),'String');
gen_param.hand = get(findobj('Tag','hand'),'String');
gen_param.ncpu = get(findobj('Tag','ncpu'),'String');
gen_param.ext = get(findobj('Tag','extension'),'String');
gen_param.filename = get(findobj('Tag','filename'),'String');
gen_param.datalabel = get(findobj('Tag','datalabel'),'String');
gen_param.folder = get(findobj('Tag','folder'),'String');
if isempty(str2num(gen_param.datalabel))
    gen_param.datalabel = '';
end
if length(dir([gen_param.folder '/' gen_param.filename '*'  '*' gen_param.ext])) == 0;
    mute_errorscreen(['there are no files in the folder: ' gen_param.folder ' with filename:' gen_param.filename ' and or datalabel: ' gen_param.datalabel]);
    main_gen = findobj('Tag','gen_param_check');
    set(main_gen,'Value',0);
setappdata(main_gen,'gen_check',0);
else
    disp([num2str(length(dir([gen_param.folder '/' gen_param.filename '*' gen_param.datalabel '*' gen_param.ext]))) ' files were selected.']);
    disp('**************************************************************');
    disp('WARNING: the computation is taking place in another workspace.');
      disp('Please wait until ''...COMPUTATION DONE!'' is displayed.');
    disp('**************************************************************');
setappdata(main,'gen_param',gen_param);
main_gen = findobj('Tag','gen_param_check');
set(main_gen,'Value',1);
setappdata(main_gen,'gen_check',1);

close
end


function info_callback(~,~,x)
mute_textscreen(x)

function restore_Callback(hObject, eventdata, handles)
parentfig = get(hObject,'Parent');
currentval = getappdata(parentfig,'def');
h = findobj('Tag','Srate');
set(h,'String',currentval.samplingRate.value);
h = findobj('Tag','points');
set(h,'String',currentval.pointsToDiscard.value);
h = findobj('Tag','chans');
set(h,'String',currentval.channels.value);
h = findobj('Tag','auto');
set(h,'String',currentval.autoPairwiseTarDriv.value);
h = findobj('Tag','hand');
set(h,'String',currentval.handPairwiseTarDriv.value);
h = findobj('Tag','ncpu');
set(h,'String',currentval.numProcessors.value);
h = findobj('Tag','extension');
set(h,'String',currentval.dataExtension.value);
h = findobj('Tag','filename');
set(h,'String',currentval.datafilename.value);
h = findobj('Tag','datalabel');
set(h,'String',currentval.datalabel.value);
h = findobj('Tag','folder');
set(h,'String',currentval.datafolder.value);



     


