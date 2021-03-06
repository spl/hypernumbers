%%% @copyright (C) 2009-2014, Hypernumbers Ltd.
%%%-------------------------------------------------------------------
%%%
%%% LICENSE
%%%
%%% This program is free software: you can redistribute it and/or modify
%%% it under the terms of the GNU Affero General Public License as
%%% published by the Free Software Foundation version 3
%%%
%%% This program is distributed in the hope that it will be useful,
%%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%% GNU Affero General Public License for more details.
%%%
%%% You should have received a copy of the GNU Affero General Public License
%%% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%%%-------------------------------------------------------------------
-define(APIEMAIL, "hypernumbersapi.com").
-define(EXPIRY,    259200). % 3 days in seconds = 3*24*60*60

-type now() :: {integer(),integer(),integer()}.
-type cellidx() :: pos_integer().
-type generator() :: fun(() -> string()).
-type resource_addr() :: {string(), integer(), atom()}. %% (IP, Port, Node).


-record(core_site, {site = [] :: string(),
                    type :: atom()}).

%% Zone Tables
-record(zone, { label :: string(),
                min_size :: integer(),
                ideal_size :: integer(),
                pool :: gb_tree(),
                generator :: generator(),
                zone_id :: integer() }).

-record(hns_record, { name, % :: {string(), string()},
                      address,% :: resource_addr(),
                      % Following two used for linode.
                      zone_id,% :: integer(),
                      resource_id }).% :: integer()}).

-record(resource, { address = [] :: resource_addr(),
                    weight = 0 :: integer() }).

%% render addons
-record(render,
        {
          css = [],
          js = [],
          js_head = [],
          js_reload = [],
          title = []
         }).

%% Site Tables
-record(index,
        {
          site,
          path,
          column,
          row
         }).

-record(xrefX,
        {
          idx,
          site        = [],
          path        = [],
          obj         = null
         }).

-record(refX,
        {
          site        = [],
          type,
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

-record(site,
        {
          idx,
          nothing % needed to be a valid mnesia table!
         }).

-record(user_fns,
        {
          name,
          ast,
          pagejson,
          wizardjson
         }).

-record(local_obj,
        {
          idx,
          type,
          path,
          obj,
          revidx
         }).

-record(del_local,
        {
          idx,
          timestamp = util2:get_timestamp()
         }).

-record(revidx,
        {
          revidx,
          idx
         }).

-record(item,
        {
          idx,
          attrs
        }).

-record(relation,
        {
          cellidx                        :: cellidx(),
          children       = ordsets:new() :: ordsets:ordset(cellidx()),
          range_children = ordsets:new() :: ordsets:ordset(cellidx()),
          parents        = ordsets:new() :: ordsets:ordset(cellidx()),
          infparents     = ordsets:new() :: ordsets:ordset(cellidx()),
          z_parents      = ordsets:new() :: ordsets:ordset(#refX{}),
          range_parents  = ordsets:new() :: ordsets:ordset(#refX{}),
          dyn_parents    = ordsets:new() :: ordsets:ordset(cellidx()),
          dyn_infparents = ordsets:new() :: ordsets:ordset(cellidx()),
          attrs          = []
       }).

-record(dirty_queue,
        {
          id = now(),
          dirty = [],
          auth_req
         }).

-record(dirty_queue_cache,
        {
          id = now(),
          dirty = [],
          auth_req
         }).


% this record is for the table that gets all written cells and
% so that the zinf tree can determine if they are 'proper dirty' for dbsrv
-record(dirty_for_zinf,
        {
          id = now(),
          dirty :: #xrefX{}
         }).

% this record is for the table that gets changes to the zinf tree
-record(dirty_zinf,
        {
          id = now(),
          type,
          dirtycellidx :: cellidx(),
          old          :: ordsets:ordset(#refX{}),
          new          :: ordsets:ordset(#refX{}),
          processed = false
         }).

% this record is for the table that logs changes
-record(logging,
        {
          idx,
          timestamp = util2:get_timestamp(),
          uid        = [],
          action     = [],
          actiontype = [],
          type       = [],
          path,
          obj,
          log
         }).

-record(sublog,
        {
          msg,
          oldformula,
          newformula
         }).

-record(group,
        {
          name = [],
          members = gb_sets:empty()
         }).

% this is the general KV store for KV's that need to be under transations
% or distrubuted between servers
-record(kvstore,
        {
          key,
          value
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
%%      it is the overwrite text colour generated by the formats and, as the
%%      name suggests, overwrites the style colour

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

-record(form,
        {
          key, % one form element per unit ref
          id, % {path, transaction, label}
          kind,
          restrictions = none,
          attrs = [],
          callback
         }).

-record(twilio_account,
        {
          account_sid,
          auth_token,
          application_sid,
          site_phone_no,
          type
         }).

-record(contact_log,
        {
          idx,
          type,
          call_sid  = [],
          from      = [],
          to        = [],
          cc        = [],
          subject   = [],
          contents  = [],
          reply_to  = [],
          reference = [],
          status    = []
         }).

-record(siteonly,
        {
          type,
          idx,
          payload
         }).

-record(phone,
        {
          idx,
          twiml,
          capability = none,
          log,
          softphone_type = none,
          softphone_config = none
         }).

-record(webcontrol,
        {
          id,
          command = []
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
-record(qry,
        {
          callback,
          challenger,
          css,
          hypertag,
          ivector,
          jserr,
          mark,
          map,
          nonce, % sometimes for debugging you want to be able to tag requests
          pages,
          paths,
          permissions,
          play,
          rawview,
          return,
          status,
          stamp,
          template,
          templates,
          updates,
          via,
          view,
          views
         }).

%% web controls records

-record(namedpage,
        {
          template,
          name
         }).

-record(numberedpage,
        {
          template,
          type,
          prefix
         }).

-record(datedpage,
        {
          template,
          format
          }).

-record(plainpath,
        {
          path
         }).

-record(destination,
        {
          type = false
         }).

-record(segment,
        {
          page,
          redirect = #destination{},
          addspreadsheetgroups = [],
          addwebpagegroups = [],
          addwikipagegroups = [],
          addtablegroups = []
         }).

% the internal api for include
-record(incs,
        {
          js         = [],
          js_head    = [],
          js_reload  = [],
          css        = []
         }).

% the timer table
-record(timer,
        {
          idx,
          spec
         }).

% the css and javascript tables
-record(include,
        {
          idx,
          path,
          js,
          js_head,
          js_reload,
          css
         }).

% api table records
-record(api,
        {
          publickey,
          privatekey,
          notes = "insert notes about this key here...",
          urls = []
         }).

-record(api_url,
        {
          path         = undefined,    % uninitialised records will crash! Good!
          admin        = false,        % by default not admin
          include_subs = false,
          append_only  = true          % by default can only append
         }).

% used once we have got a signed request is
-record(api_auth,
        {
          publickey,
          authorized,
          admin,
          append_only
         }).


% records for data upload maps
-record(head,
        {
          type,
          filetype,
          template,
          overwrite,
          has_headers = false,
          pagemod = null,
          pagefn = null,
          pagefnargs = []
         }).

-record(templates,
        {
          templates = []
         }).

-record(validation,
        {
          sheet,
          cell,
          constraint
         }).

-record(mapping,
        {
          sheet,
          from,
          to
         }).

-record(site_email,
        {
          email           :: string(),
          email_validated :: boolean(),
          signature       :: string()
         }).

% a record for notifying the CRM system of a site commission
-record(commission,
        {
          timestamp  = util2:get_timestamp(),
          uid,
          email,
          link,
          site,
          sitetype,
          zone,
          comm_site,
          comm_path,
          comm_cell,
          synched    = false
         }).

% these records are for specifiying special returns from fns
-record(spec_val,
        {
          val,
          rawform       = null,
          sp_webcontrol = null,
          sp_phone      = null,
          preview       = null,
          include       = false,
          sp_incs       = null,
          resize        = null,
          sp_timer      = null,
          sp_site       = null,
          unique        = null
         }).

-record(rawform,
        {
          form,
          html
         }).

-record(resize,
        {
          width,
          height
         }).

-record(sp_timer,
        {
          spec
         }).

-record(unique,
        {
          type
         }).
