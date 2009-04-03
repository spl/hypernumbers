-define(HN_NAME,   "HyperNumbers").

-define(TIMEOUT,   1000).
-define(HTML_ROOT, "/html/").

-define(HTTP,      $h,$t,$t,$p).
-define(HTTPS,     $h,$t,$t,$p,$s).
-define(SLASH,     47).

-define(SALT,      "salt").

-define(DELAY,     250). % time delay (millisecs) for some dirty updates 

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

-record(refX,
        {
          site        = [],
          path        = [],
          obj         = null,
          auth        = []
         }).

-record(status,
        {
          formula     = [],
          reftree     = [],
          errors      = [],
          refs        = []
         }).

-record(version,
        {
          page,
          version
        }).

-record(hn_item,
        {
          addr        = #ref{},
          val         = []
         }).

-record(local_cell_link, % link 2 cells on the same sheet together
        {
          parent      = #refX{},
          child       = #refX{}
         }).

-record(remote_cell_link,         % link a hypernumber with a cell,
        {                         % is used to link both incoming and outgoing
          parent      = #refX{}, % hypernumbers
          child       = #refX{},
          type        = null      % incoming or outgoing
         }).

-record(outgoing_hn,
        {
          site_and_parent,
          child_site   = [],
          child_proxy  = [],
          biccie       = []       % a shared token
         }).

-record(incoming_hn,
        {
          site_and_parent,
          value,
          'dependency-tree' = [],       % cells use in this numbers calculation
          biccie            = []        % a shared token
         }).

-record(dirty_cell,
        {
          index       = #index{},
          timestamp   = now()
         }).

-record(dirty_inc_hn_create,
        {
          parent     = #refX{},
          child      = #refX{},
          parent_vsn = #version{},
          child_vsn  = #version{},
          timestamp  = now()
         }).

-record(dirty_notify_in,
        {
          parent            = #refX{},
          timestamp         = now()
         }).

% dirty_notify_out contains a snap shot of the value, the 
% dependency tree and the outgoing_hn record because it is 
% asynchronous - needs to know what they were when it was marked dirty
% because if there has been a delete/insert the original may have been
% rewitten by the time the dirty processing is to be done. The 
% protocol/retry between 2 servers has to handle the
% race conditions etc, etc...
% By default dirty_notify_out events are delayed - this smooths
% out the syncronisation process. Events that are 'important' like
% inserting or deleting cells set their delay to zero and slip
% ahead of the cohort of other changes that are sent
% 
% dirty_notify_out doens't contain a child_vsn record because that info
% is wrapped up in the outgoing list...
-record(dirty_notify_out,
        {
          parent     = #refX{},
          change     = [],
          outgoing   = [],
          parent_vsn = #version{},
          delay      = ?DELAY,
          timestamp  = now()
         }).

% By default dirty_notify_back_in events are delayed - this smooths
% out the syncronisation process. Events that are 'important' like
% inserting or deleting cells set their delay to zero and slip
% ahead of the cohort of other changes that are sent
-record(dirty_notify_back_in,
        {
          parent     = #refX{},
          child      = #refX{},
          change     = [],
          biccie     = [],
          child_vsn  = #version{},
          parent_vsn = #version{},
          delay      = ?DELAY,
          timestamp  = now()
         }).

-record(dirty_notify_back_out,
        {
          parent    = #refX{},
          child     = #refX{},
          change    = [],
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
          refX        = #refX{},
          index       = 0,
          magic_style = #magic_style{}
         }).

%% this builds the counters for the style table
-record(style_counters,
        {
          refX = #refX{},
          integer
         }).

-record(help,
        {
          name,
          warning,
          arity,
          category,
          text
         }).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                  %
% These are the new version of records             %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% this record holds the version of a page
-record(page_vsn,
        {
          site_and_pg,
          version
         }).

%% this record holds the page history for a page
-record(page_history,
        {
          site_and_pg,
          action,
          action_refX = #refX{},
          version
         }).

%% this builds the counters for the page versions
-record(page_vsn_counters,
        {
          page,
          integer
         }).

