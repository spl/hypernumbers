-define(SALT,      "happyguineapigs").

-type now() :: {integer(),integer(),integer()}.
-type cellidx() :: pos_integer().

%% Core Tables

-record(core_site, {site = [] :: string(),
                    type :: atom()}).

-record(index,
        {
          site,
          path,
          column,
          row
         }).

-record(refX,
        {
          site        = [],
          path        = [],
          obj         = null
         }).

-record(status,
        {
          formula     = [],
          reftree     = [],
          errors      = [],
          refs        = []
         }).

-record(local_obj,
        {
          idx,
          path,
          obj
         }).

-record(item, {idx, attrs}).

-record(relation,
        {cellidx                  :: cellidx(),
         children = ordsets:new() :: ordsets:ordset(cellidx()),
         parents = ordsets:new()  :: ordsets:ordset(cellidx())}).

-record(dirty_queue,
        {id = now(),
         queue}).

-record(group,
        {name = [],
         members = gb_sets:empty()}).

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

-record(magic_style,
        {
          'border-right-style'  = [],
          'border-left-style'   = [],
          'border-top-style'    = [],
          'border-bottom-style' = [],
          'border-right-color'  = [],
          'border-left-color'   = [],
          'border-top-color'    = [],
          'border-bottom-color' = [],
          'border-right-width'  = [],
          'border-left-width'   = [],
          'border-top-width'    = [],
          'border-bottom-width' = [],
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
          'text-align'          = [],
          'white-space'         = []
         }).        

-record(style,
        {
          magic_style = #magic_style{},
          idx
         }).

-record(help,
        {
          name,
          warning,
          arity,
          category,
          text,
          notes= []
         }).

%% HN Mochi Query Parameters. Leave as undefined.
-record(qry, { challenger,
               hypertag,
               mark,
               pages,
               paths,
               permissions,
               rawview,
               return,
               status,
               template,
               templates,
               updates,
               via,
               view,
               views
             }).
