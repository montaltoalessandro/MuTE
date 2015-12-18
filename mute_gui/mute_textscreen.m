function mute_textscreen(a,b)
c = 'http://mutetoolbox.guru/mutesettings/';
z.f=figure('Units','normalized','Visible','off','Position',[0.5,0.1,0.3,0.5],'name','info','Menubar','none','NumberTitle','off');
z.z_text    = uicontrol('Units','normalized','Style','text','String',a,...
    'Position',[0,0,1,1],'FontSize',16,'ForeGroundColor','b','BackgroundColor',[116  175  173]./255);

string = {a};
[outstring, newpos] = textwrap(z.z_text,string);
set(z.z_text,'String',outstring,'HorizontalAlignment','left');


z.textscreen_quit    = uicontrol('Units','normalized','Style','pushbutton',...
    'String','close','Position',[0.75,0.05,0.2,0.05],'FontSize',14);
set(z.textscreen_quit ,'callback',{@mute_close_fcn,z},'BackgroundColor',[217  133  59]./255);

if nargin==2
    c = b;

end
    str = '<html><a href="">Click here for more information</a></html>';
    hButton = uicontrol('Units','normalized','Style','pushbutton', 'Position',[0.05 0.05 0.7 0.05], ...
        'String',str, 'Callback',@(o,e)web(c),'BackgroundColor',[217  133  59]./255);
%
% jButton = findjobj(hButton);
% jButton.setCursor( java.awt.Cursor(java.awt.Cursor.HAND_CURSOR) );
% jButton.setContentAreaFilled(0);

set(z.f,'Visible','on')