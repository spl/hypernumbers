-define(HN_NAME,    "HyperNumbers").

-define(TIMEOUT,    1000).
-define(HTML_ROOT,  "/html/").

-define(PORTNO,     1935).

-define(HTTP,       $h,$t,$t,$p).
-define(HTTPS,      $h,$t,$t,$p,$s).
-define(SLASH,      47).

-define(SALT,       "salt").

%% Test Macros
-define(HN_URL1,   "http://127.0.0.1:9000").
-define(HN_URL2,   "http://127.0.0.1:9001").

-record(index,
        {
          site,
          path,
          column,
          row
         }).

-record(ref,
        {
          site        = [],
          path        = [],
          ref         = null,
          name        = undef,
          auth        = []
         }).


-record(status,
        {
          formula     = [],
          reftree     = [],
          errors      = [],
          refs        = []
         }).

%% the details_from record is used by the site that has an outstanding request
%% for a hypernumber and is used to authenticate a notification message:
%% - where the remote site should have posted the notification (proxy_URL)
%% - how the remote site should authenticate itself
%%
%% the details of what the remote cell should be are held in the ref_from
%% field in the ref table
%%
%% the 'version' field is used to check that the page structures versions
%% are aligned and that one site is in synch with another
-record(details_from,
        {
          proxy_URL   = [],
          biccie      = [],
          version
         }).

%% the details_to record is used by a site that has to notify another one
%% of a change in a hypernumber. These details are passed to authenticate
%% that request. They are posted to:
%% - the proxy URL (as specified by the registering site)
%%
%% the details that are sent are:
%% - reg_URL (the URL of *A* cell that actually made the request for
%%            a hypernumber - bear in mind many have but there will
%%            only be a single notification per remote site)
%% - biccie  (the authentication token)
%%
%% The record will be formatted according to the value of 'format'
-record(details_to,
        {
          proxy_URL   = [],
          reg_URL     = [],
          biccie      = [],
          format
         }).

-record(hn_item,
        {
          addr        = #ref{},
          val         = []
         }).

-record(local_cell_link, % Link 2 cells on the same sheet together
        {
          parent      = #index{},
          child       = #index{}
         }).

-record(remote_cell_link,         % Link a hypernumber with a cell,
        {                         % is used to link both incoming and outgoing
          parent      = #index{}, % hypernumbers
          child       = #index{},
          type        = null      % incoming or outgoing
         }).

-record(outgoing_hn,
        {
          index       = {[],#index{}},
          biccie      = [],            % A shared token
          child_url   = [],
          version     = 0              % Version for structural updates
         }).

-record(incoming_hn,
        {
          remote            = #index{},  % The address of the number
          value,
          'dependency-tree' = [],       % Cells use in this numbers calculation
          biccie            = [],       % A shared token
          version           = 0         % Version for structural updates
         }).

-record(dirty_cell,
        {
          index       = #index{},
          timestamp   = now()
         }).

-record(dirty_incoming_hn,
        {
          index       = #index{},
          timestamp   = now()
         }).

-record(dirty_incoming_create,
        {
          parent    = #index{},
          child     = #index{},
          timestamp = now()
         }).

-record(dirty_notify_incoming,
        {
          child     = #index{},
          parent    = #index{},
          change    = [],
          timestamp = now()
         }).

% dirty_outgoing_hn contains a snap shot of the value, the 
% dependency tree and the outgoing_hn record because it is 
% asynchronous - needs to know what they were when it was marked dirty
% because if there has been a delete/insert the original may have been
% rewitten by the time the dirty processing is to be done. The 
% protocol/retry between 2 servers has to handle the
% race conditions etc, etc...
-record(dirty_outgoing_hn,
        {
          index             = #index{},
          value             = [],
          'dependency-tree' = [],
          outgoing          = [],
          timestamp         = now()
         }).

-record(dirty_outgoing_update,
        {
          index = #index{},
          change = [],
          timestamp = now()
         }).

-record(hn_user,
        {
          name        = [],
          password    = [],
          authtoken   = null,
          created     = calendar:local_time()
         }).

-record(template,
        {
          name        = [],
          temp_path   = [],
          gui         = index,
          form        = null
         }).

%% magic_style is the container tuple for the table styles
%% NOTE the attribute 'overwrite-color' isn't in a magic style and shouldn't be
%%      it the overwrite text colour generated by the formats and, as the
%%      name suggests, overwrites the style colour

% magic_style commented out to make css styles work in the gui again!
% to switch back to using styles simply comment out and uncomment the 
% one after
%-record(magic_style,
%        {
%          'ha-ha-ha' = []
%         }).

-record(magic_style,
        {
          'border-right'        = [],
          'border-left'         = [],
          'border-top'          = [],
          'border-bottom'       = [],
          'border-color'        = [],
          'border-right-style'  = [],
          'border-left-style'   = [],
          'border-top-style'    = [],
          'border-bottom-style' = [],
          color                 = [],
          'vertical-align'      = [],
          'background-color'    = [],
          'font-weight'         = [],
          'font-size'           = [],
          'font-family'         = [],
          'font-style'          = [],
          'font-stretch'        = [],
          'text-decoration'     = [],
          'text-shadow'         = [],
          'text-align'          = []
         }).        

-record(styles,
        {
          ref         = #ref{},
          index       = 0,
          magic_style = #magic_style{}
         }).

%% this builds the counters for the style table
-record(style_counters,
        {
          ref = #ref{},
          integer
         }).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                  %
% These are the new version of records             %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-record(refX,
        {
          site        = [],
          path        = [],
          obj         = null,
          auth        = []
         }).

%% this record holds the version of a page
-record(page_vsn,
        {
          page_refX    = #refX{},
          action,
          action_refX  = #refX{},
          version = 0
         }).

%% this builds the counters for the page versions
-record(page_vsn_counters,
        {
          refX = #refX{},
          integer
         }).

