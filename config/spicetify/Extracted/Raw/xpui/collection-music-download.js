"use strict";(("undefined"!=typeof self?self:global).webpackChunkopen=("undefined"!=typeof self?self:global).webpackChunkopen||[]).push([[4246],{64508:(e,a,r)=>{r.d(a,{z:()=>m});var s=r(16428),i=r(85802),n=r(53181),t=r(34315),u=r(78710),c=r(16917),o=r(4135),l=r(11527);function m(e,a){switch(e.type){case c.p.ALBUM:return(0,l.jsx)(s.r,{uri:e.uri,name:e.name,images:e.images,sharingInfo:null,artists:e.artists,index:a},e.uri);case c.p.ARTIST:return(0,l.jsx)(i.I,{uri:e.uri,name:e.name,images:e.images,index:a},e.uri);case c.p.SHOW:return(0,l.jsx)(u._,{uri:e.uri,name:e.name,images:e.images,publisher:e.publisher,sharingInfo:null,mediaType:o.E.UNKNOWN,index:a},e.uri);case c.p.AUDIOBOOK:return(0,l.jsx)(n.c,{uri:e.uri,name:e.name,images:e.images,authorName:e.authorName,index:a},e.uri);case c.p.PLAYLIST:return(0,l.jsx)(t.Z,{uri:e.uri,name:e.name,images:e.images,description:"",authorName:e.creatorName,index:a},e.uri);default:return null}}},54029:(e,a,r)=>{r.r(a),r.d(a,{LibraryMusicDownloads:()=>g,default:()=>h});r(99692);var s=r(50959),i=r(29482),n=r(98900),t=r(64508),u=r(77671),c=r(29338),o=r(15192),l=r(81456),m=r(71730),d=r(11527);const g=(0,s.memo)((function(){const{isLoading:e,hasError:a,items:r}=(0,l.G)();return e||a?(0,d.jsx)(u.h,{hasError:a,errorMessage:n.ag.get("error.request-collection-music-downloads-failure")}):(0,d.jsxs)(d.Fragment,{children:[(0,d.jsx)(i.D,{as:"h1",variant:"canon",className:m.Z.header,children:n.ag.get("music_downloads")}),(0,d.jsx)(o.JL,{value:"EntitiesGrid",children:(0,d.jsx)(c.T,{render:()=>r.map(((e,a)=>(0,d.jsx)(o.JL,{value:"card",index:a,children:(0,t.z)(e,a)},e.uri)))})})]})})),h=g},81456:(e,a,r)=>{r.d(a,{G:()=>n});var s=r(50959),i=r(80083);function n(){const e=(0,i.c)(),[a,r]=(0,s.useState)(!0),[n,t]=(0,s.useState)(!1),[u,c]=(0,s.useState)([]);return(0,s.useEffect)((()=>{(async()=>{try{const a=await e.getDownloads();c(a)}catch(e){t(!0)}finally{r(!1)}})()}),[e]),{isLoading:a,hasError:n,items:u}}}}]);
//# sourceMappingURL=collection-music-download.js.map