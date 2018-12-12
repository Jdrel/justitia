



/* ControlTag Loader for Mapfre  e40f967e-2362-4e02-bb8b-8e1d8583eca0 */
(function(w, cs) {
  
  if (/Twitter for iPhone/.test(w.navigator.userAgent || '')) {
    return;
  }

  var debugging = /kxdebug/.test(w.location);
  var log = function() {
    
    debugging && w.console && w.console.log([].slice.call(arguments).join(' '));
  };

  var load = function(url, callback) {
    log('Loading script from:', url);
    var node = w.document.createElement('script');
    node.async = true;  
    node.src = url;

    
    node.onload = node.onreadystatechange = function () {
      var state = node.readyState;
      if (!callback.done && (!state || /loaded|complete/.test(state))) {
        log('Script loaded from:', url);
        callback.done = true;  
        callback();
      }
    };

    
    var sibling = w.document.getElementsByTagName('script')[0];
    sibling.parentNode.insertBefore(node, sibling);
  };

  var config = {"app":{"name":"krux-scala-config-webservice","version":"3.41.0","schema_version":3},"confid":"spqypfamu","context_terms":[],"publisher":{"name":"Mapfre ","active":true,"uuid":"e40f967e-2362-4e02-bb8b-8e1d8583eca0","version_bucket":"stable","id":3152},"params":{"link_header_bidder":false,"site_level_supertag_config":"site","recommend":false,"control_tag_pixel_throttle":100,"fingerprint":false,"optout_button_optout_text":"Browser Opt Out","channel":"display","user_data_timing":"load","consent_active":true,"use_central_usermatch":true,"store_realtime_segments":false,"tag_source":false,"link_hb_start_event":"ready","optout_button_optin_text":"Browser Opt In","first_party_uid":false,"dcm_profile_ids":"4430585","link_hb_timeout":2000,"link_hb_adserver_subordinate":true,"optimize_realtime_segments":false,"link_hb_adserver":"dfp","client_type":"marketer","target_fingerprint":false,"context_terms":false,"optout_button_id":"kx-optout-button","dfp_premium":true,"control_tag_namespace":"mapfre"},"prioritized_segments":[],"realtime_segments":[],"services":{"userdata":"//cdn.krxd.net/userdata/get","contentConnector":"https://connector.krxd.net/content_connector","stats":"//apiservices.krxd.net/stats","optout":"//cdn.krxd.net/userdata/optout/status","event":"//beacon.krxd.net/event.gif","set_optout":"https://consumer.krxd.net/consumer/optout","data":"//beacon.krxd.net/data.gif","link_hb_stats":"//beacon.krxd.net/link_bidder_stats.gif","userData":"//cdn.krxd.net/userdata/get","link_hb_mas":"https://link.krxd.net/hb","config":"//cdn.krxd.net/controltag/{{ confid }}.js","social":"//beacon.krxd.net/social.gif","addSegment":"//cdn.krxd.net/userdata/add","pixel":"//beacon.krxd.net/pixel.gif","um":"https://usermatch.krxd.net/um/v2","controltag":"//cdn.krxd.net/ctjs/controltag.js.{hash}","loopback":"https://consumer.krxd.net/consumer/tmp_cookie","remove":"https://consumer.krxd.net/consumer/remove/e40f967e-2362-4e02-bb8b-8e1d8583eca0","click":"https://apiservices.krxd.net/click_tracker/track","stats_export":"//beacon.krxd.net/controltag_stats.gif","userdataApi":"//cdn.krxd.net/userdata/v1/segments/get","cookie":"//beacon.krxd.net/cookie2json","proxy":"//cdn.krxd.net/partnerjs/xdi","consent_get":"https://consumer.krxd.net/consent/get/e40f967e-2362-4e02-bb8b-8e1d8583eca0","consent_set":"https://consumer.krxd.net/consent/set/e40f967e-2362-4e02-bb8b-8e1d8583eca0","is_optout":"https://beacon.krxd.net/optout_check","impression":"//beacon.krxd.net/ad_impression.gif","transaction":"//beacon.krxd.net/transaction.gif","log":"//jslog.krxd.net/jslog.gif","portability":"https://consumer.krxd.net/consumer/portability/e40f967e-2362-4e02-bb8b-8e1d8583eca0","set_optin":"https://consumer.krxd.net/consumer/optin","usermatch":"//beacon.krxd.net/usermatch.gif"},"experiments":[],"site":{"name":"Mapfre - Display","cap":255,"id":1661267,"organization_id":3152,"uid":"spqypfamu"},"tags":[{"id":34941,"name":"UTM DTC","content":"<script>\n(function(){\n\n\tvar params = Krux('require:util').urlParams();\n\t\n\tKrux ('set', { \n\t'page_attr_utm_source': params.utm_source,\n\t'page_attr_utm_medium': params.utm_medium,\n\t'page_attr_utm_campaign': params.utm_campaign,\n\t'page_attr_utm_content': params.utm_content,\n\t'page_attr_utm_term': params.utm_term \n\t});\n\t\n})();\n</script>","target":null,"target_action":"append","timing":"onload","method":"document","priority":null,"template_replacement":true,"internal":true,"criteria":[],"collects_data":true},{"id":37224,"name":"Facebook Pixel","content":"<!-- Facebook Pixel Code -->\n\n<script>\ntry {\n  if (localStorage.kxmapfre_allsegs != undefined){\n    if (localStorage.kxmapfre_allsegs.indexOf ('taol6iuts')!= -1){\n\n      !function(f,b,e,v,n,t,s)\n\n      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n\n      n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n\n      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\n\n      n.queue=[];t=b.createElement(e);t.async=!0;\n\n      t.src=v;s=b.getElementsByTagName(e)[0];\n\n      s.parentNode.insertBefore(t,s)}(window, document,'script',\n\n      'https://connect.facebook.net/en_US/fbevents.js');\n\n      fbq('init', '385350931798257');\n\n      fbq('track', 'analytics_User info_tipo de usuario_mix_0_1st_dataLayer_cliente_mapfre_es');\n\n    } else if (localStorage.kxmapfre_allsegs.indexOf ('tcy65wrbs')!= -1){\n\n      !function(f,b,e,v,n,t,s)\n\n      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n\n      n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n\n      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\n\n      n.queue=[];t=b.createElement(e);t.async=!0;\n\n      t.src=v;s=b.getElementsByTagName(e)[0];\n\n      s.parentNode.insertBefore(t,s)}(window, document,'script',\n\n      'https://connect.facebook.net/en_US/fbevents.js');\n\n      fbq('init', '385350931798257');\n\n      fbq('track', 'analytics_User info_tipo de usuario_mix_0_1st_dataLayer_cliente_mapfre_es');\n\n    } \n\n    if (localStorage.kxmapfre_allsegs.indexOf ('tb4rquxzc')!= -1){\n\n      !function(f,b,e,v,n,t,s)\n\n      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n\n      n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n\n      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\n\n      n.queue=[];t=b.createElement(e);t.async=!0;\n\n      t.src=v;s=b.getElementsByTagName(e)[0];\n\n      s.parentNode.insertBefore(t,s)}(window, document,'script',\n\n      'https://connect.facebook.net/en_US/fbevents.js');\n\n      fbq('init', '385350931798257');\n\n      fbq('track', 'analytics_cliente_producto contratado_accidentes_0_1st_dataLayer_0_mapfre_es');\n\n    } else if (localStorage.kxmapfre_allsegs.indexOf ('tcy7cmnye')!= -1){\n\n      !function(f,b,e,v,n,t,s)\n\n      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n\n      n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n\n      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\n\n      n.queue=[];t=b.createElement(e);t.async=!0;\n\n      t.src=v;s=b.getElementsByTagName(e)[0];\n\n      s.parentNode.insertBefore(t,s)}(window, document,'script',\n\n      'https://connect.facebook.net/en_US/fbevents.js');\n\n      fbq('init', '385350931798257');\n\n      fbq('track', 'analytics_cliente_producto contratado_accidentes_0_1st_dataLayer_0_mapfre_es');\n\n    } \n\n    if (localStorage.kxmapfre_allsegs.indexOf ('tb0au1oik')!= -1){\n\n      !function(f,b,e,v,n,t,s)\n\n      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n\n      n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n\n      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\n\n      n.queue=[];t=b.createElement(e);t.async=!0;\n\n      t.src=v;s=b.getElementsByTagName(e)[0];\n\n      s.parentNode.insertBefore(t,s)}(window, document,'script',\n\n      'https://connect.facebook.net/en_US/fbevents.js');\n\n      fbq('init', '385350931798257');\n\n      fbq('track', 'analytics_cliente_producto contratado_p.pensiones_0_1st_dataLayer_0_mapfre_es');\n\n    } else if (localStorage.kxmapfre_allsegs.indexOf ('tcy7f0ttc')!= -1){\n\n      !function(f,b,e,v,n,t,s)\n\n      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n\n      n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n\n      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\n\n      n.queue=[];t=b.createElement(e);t.async=!0;\n\n      t.src=v;s=b.getElementsByTagName(e)[0];\n\n      s.parentNode.insertBefore(t,s)}(window, document,'script',\n\n      'https://connect.facebook.net/en_US/fbevents.js');\n\n      fbq('init', '385350931798257');\n\n      fbq('track', 'analytics_cliente_producto contratado_p.pensiones_0_1st_dataLayer_0_mapfre_es');\n\n    } \n\n    if (localStorage.kxmapfre_allsegs.indexOf ('tbcu928lf')!= -1){\n\n      !function(f,b,e,v,n,t,s)\n\n      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n\n      n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n\n      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\n\n      n.queue=[];t=b.createElement(e);t.async=!0;\n\n      t.src=v;s=b.getElementsByTagName(e)[0];\n\n      s.parentNode.insertBefore(t,s)}(window, document,'script',\n\n      'https://connect.facebook.net/en_US/fbevents.js');\n\n      fbq('init', '385350931798257');\n\n      fbq('track', 'analytics_cliente_producto contratado_vida_0_1st_dataLayer_0_mapfre_es');\n\n    } else if (localStorage.kxmapfre_allsegs.indexOf ('tcy7ncm74')!= -1){\n\n      !function(f,b,e,v,n,t,s)\n\n      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n\n      n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n\n      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\n\n      n.queue=[];t=b.createElement(e);t.async=!0;\n\n      t.src=v;s=b.getElementsByTagName(e)[0];\n\n      s.parentNode.insertBefore(t,s)}(window, document,'script',\n\n      'https://connect.facebook.net/en_US/fbevents.js');\n\n      fbq('init', '385350931798257');\n\n      fbq('track', 'analytics_cliente_producto contratado_vida_0_1st_dataLayer_0_mapfre_es');\n\n    } \n\n    if (localStorage.kxmapfre_allsegs.indexOf ('tbcu4plav')!= -1){\n\n      !function(f,b,e,v,n,t,s)\n\n      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n\n      n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n\n      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\n\n      n.queue=[];t=b.createElement(e);t.async=!0;\n\n      t.src=v;s=b.getElementsByTagName(e)[0];\n\n      s.parentNode.insertBefore(t,s)}(window, document,'script',\n\n      'https://connect.facebook.net/en_US/fbevents.js');\n\n      fbq('init', '385350931798257');\n\n      fbq('track', 'analytics_cliente_producto contratado_te cuidamos_0_1st_dataLayer_0_mapfre_es');\n\n    } else if (localStorage.kxmapfre_allsegs.indexOf ('tcy7rkjm6')!= -1){\n\n      !function(f,b,e,v,n,t,s)\n\n      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n\n      n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n\n      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\n\n      n.queue=[];t=b.createElement(e);t.async=!0;\n\n      t.src=v;s=b.getElementsByTagName(e)[0];\n\n      s.parentNode.insertBefore(t,s)}(window, document,'script',\n\n      'https://connect.facebook.net/en_US/fbevents.js');\n\n      fbq('init', '385350931798257');\n\n      fbq('track', 'analytics_cliente_producto contratado_te cuidamos_0_1st_dataLayer_0_mapfre_es');\n\n    } \n\n    if (localStorage.kxmapfre_allsegs.indexOf ('tbcu1zm3j')!= -1){\n\n      !function(f,b,e,v,n,t,s)\n\n      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n\n      n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n\n      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\n\n      n.queue=[];t=b.createElement(e);t.async=!0;\n\n      t.src=v;s=b.getElementsByTagName(e)[0];\n\n      s.parentNode.insertBefore(t,s)}(window, document,'script',\n\n      'https://connect.facebook.net/en_US/fbevents.js');\n\n      fbq('init', '385350931798257');\n\n      fbq('track', 'analytics_cliente_producto contratado_hogar_0_1st_dataLayer_0_mapfre_es');\n\n    } else if (localStorage.kxmapfre_allsegs.indexOf ('tcy7vh41n')!= -1){\n\n      !function(f,b,e,v,n,t,s)\n\n      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n\n      n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n\n      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\n\n      n.queue=[];t=b.createElement(e);t.async=!0;\n\n      t.src=v;s=b.getElementsByTagName(e)[0];\n\n      s.parentNode.insertBefore(t,s)}(window, document,'script',\n\n      'https://connect.facebook.net/en_US/fbevents.js');\n\n      fbq('init', '385350931798257');\n\n      fbq('track', 'analytics_cliente_producto contratado_hogar_0_1st_dataLayer_0_mapfre_es');\n\n    } \n\n    if (localStorage.kxmapfre_allsegs.indexOf ('tbcuuidia')!= -1){\n\n      !function(f,b,e,v,n,t,s)\n\n      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n\n      n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n\n      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\n\n      n.queue=[];t=b.createElement(e);t.async=!0;\n\n      t.src=v;s=b.getElementsByTagName(e)[0];\n\n      s.parentNode.insertBefore(t,s)}(window, document,'script',\n\n      'https://connect.facebook.net/en_US/fbevents.js');\n\n      fbq('init', '385350931798257');\n\n      fbq('track', 'analytics_cliente_producto contratado_auto_0_1st_dataLayer_0_mapfre_es');\n\n    } else if (localStorage.kxmapfre_allsegs.indexOf ('tcy70lerp')!= -1){\n\n      !function(f,b,e,v,n,t,s)\n\n      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n\n      n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n\n      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\n\n      n.queue=[];t=b.createElement(e);t.async=!0;\n\n      t.src=v;s=b.getElementsByTagName(e)[0];\n\n      s.parentNode.insertBefore(t,s)}(window, document,'script',\n\n      'https://connect.facebook.net/en_US/fbevents.js');\n\n      fbq('init', '385350931798257');\n\n      fbq('track', 'analytics_cliente_producto contratado_auto_0_1st_dataLayer_0_mapfre_es');\n\n    } \n\n    if (localStorage.kxmapfre_allsegs.indexOf ('tbcuo4zqs')!= -1){\n\n      !function(f,b,e,v,n,t,s)\n\n      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n\n      n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n\n      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\n\n      n.queue=[];t=b.createElement(e);t.async=!0;\n\n      t.src=v;s=b.getElementsByTagName(e)[0];\n\n      s.parentNode.insertBefore(t,s)}(window, document,'script',\n\n      'https://connect.facebook.net/en_US/fbevents.js');\n\n      fbq('init', '385350931798257');\n\n      fbq('track', 'analytics_cliente_producto contratado_salud_0_1st_dataLayer_cliente salud_mapfre_es');\n\n    } else if (localStorage.kxmapfre_allsegs.indexOf ('tcy748zh0')!= -1){\n\n      !function(f,b,e,v,n,t,s)\n\n      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n\n      n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n\n      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';\n\n      n.queue=[];t=b.createElement(e);t.async=!0;\n\n      t.src=v;s=b.getElementsByTagName(e)[0];\n\n      s.parentNode.insertBefore(t,s)}(window, document,'script',\n\n      'https://connect.facebook.net/en_US/fbevents.js');\n\n      fbq('init', '385350931798257');\n\n      fbq('track', 'analytics_cliente_producto contratado_salud_0_1st_dataLayer_cliente salud_mapfre_es');\n\n    } \n  }\n}\ncatch(e){\n    console.error(e)\n}\n\n</script>\n<!-- End Facebook Pixel Code -->","target":null,"target_action":"append","timing":"onload","method":"document","priority":null,"template_replacement":true,"internal":false,"criteria":[],"collects_data":true},{"id":38017,"name":"RLSA","content":"<!-- RLSA Pixel Code -->\n\n<script>\ntry {\n  if (localStorage.kxmapfre_allsegs != undefined){\n    if (localStorage.kxmapfre_allsegs.indexOf ('taol6iuts')!= -1){\n\t\t  var track = new Image();\n    \t  track.src=\"https://googleads.g.doubleclick.net/pagead/viewthroughconversion/948545244/?value=0&guid=ON&script=0&label=du2RCJnH54sBENzNpsQD\"\n  }\n}\n}\ncatch(e){\n    console.error(e);\n}\n</script>\n<!-- End RLSA Pixel Code -->","target":null,"target_action":"append","timing":"onload","method":"document","priority":null,"template_replacement":true,"internal":false,"criteria":[],"collects_data":true}],"usermatch_tags":[{"id":6,"name":"Google User Match","content":"<script>\n(function() {\n  if (Krux('get', 'user') != null) {\n      new Image().src = 'https://usermatch.krxd.net/um/v2?partner=google';\n  }\n})();\n</script>","target":null,"target_action":"append","timing":"onload","method":"document","priority":1,"template_replacement":false,"internal":true,"criteria":[],"collects_data":true},{"id":71,"name":"AppNexus Connect","content":"<script>\r\n(function(){\r\n        var kuid = Krux('get', 'user');\r\n        if (kuid) {\r\n            var prefix = location.protocol == 'https:' ? \"https:\" : \"http:\";\r\n            var kurl = prefix + '//beacon.krxd.net/usermatch.gif?adnxs_uid=$UID';\r\n            var appnexus_url = '//ib.adnxs.com/getuid?' + kurl\r\n            var i = new Image();\r\n            i.src = appnexus_url;\r\n        }\r\n})();\r\n</script>","target":null,"target_action":"append","timing":"onload","method":"document","priority":1,"template_replacement":false,"internal":true,"criteria":[],"collects_data":true},{"id":72,"name":"AppNexus Extension User Match","content":"<script>\n(function(){\n  var kuid = Krux('get', 'user');\n  var cbust = Math.round(new Date().getTime() / 1000);\n  if (kuid) {\n    Krux('require:http').pixel({\n      url: \"//ib.adnxs.com/pxj\",\n      data: {\n          bidder: '140',\n          seg: '381342',\n          action: \"setuid('\" + kuid + \"')\",\n          bust: cbust\n      }});\n  }\n  })();\n</script>","target":null,"target_action":"append","timing":"onload","method":"document","priority":3,"template_replacement":false,"internal":true,"criteria":[],"collects_data":true}],"link":{"adslots":{},"bidders":{}}};
  
  for (var i = 0, tags = config.tags, len = tags.length, tag; (tag = tags[i]); ++i) {
    if (String(tag.id) in cs) {
      tag.content = cs[tag.id];
    }
  }

  
  var esiGeo = String(function(){/*
   <esi:include src="/geoip_esi"/>
  */}).replace(/^.*\/\*[^{]+|[^}]+\*\/.*$/g, '');

  if (esiGeo) {
    log('Got a request for:', esiGeo, 'adding geo to config.');
    try {
      config.geo = w.JSON.parse(esiGeo);
    } catch (__) {
      
      log('Unable to parse geo from:', config.geo);
      config.geo = {};
    }
  }



  var proxy = (window.Krux && window.Krux.q && window.Krux.q[0] && window.Krux.q[0][0] === 'proxy');

  if (!proxy || true) {
    

  load('//cdn.krxd.net/ctjs/controltag.js.c18d2ea515480e99b9a7056becfa6a91', function() {
    log('Loaded stable controltag resource');
    Krux('config', config);
  });

  }

})(window, (function() {
  var obj = {};
  
  return obj;
})());
