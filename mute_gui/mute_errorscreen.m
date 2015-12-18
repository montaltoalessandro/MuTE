function mute_errorscreen(a)

z.f=figure('Units','normalized','Visible','off','Position',[0.35,0.35,0.3,0.3],'name','WARNING!!!!!!','Menubar','none','NumberTitle','off');
z.z_text    = uicontrol('Units','normalized','Style','text','String',a,...
    'Position',[0,0,1,1],'FontSize',16,'ForeGroundColor','r','BackgroundColor',[116  175  173]./255);

string = {a};
[outstring, newpos] = textwrap(z.z_text,string);
set(z.z_text,'String',outstring,'HorizontalAlignment','left');


z.textscreen_quit    = uicontrol('Units','normalized','Style','pushbutton',...
    'String','close','Position',[0.75,0.05,0.2,0.2],'FontSize',14,'BackgroundColor',[217  133  59]./255);
set(z.textscreen_quit ,'callback',{@mute_close_fcn,z});


%
% jButton = findjobj(hButton);
% jButton.setCursor( java.awt.Cursor(java.awt.Cursor.HAND_CURSOR) );
% jButton.setContentAreaFilled(0);

set(z.f,'Visible','on')