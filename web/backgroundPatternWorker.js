(function dartProgram(){function copyProperties(a,b){var s=Object.keys(a)
for(var r=0;r<s.length;r++){var q=s[r]
b[q]=a[q]}}function mixinPropertiesHard(a,b){var s=Object.keys(a)
for(var r=0;r<s.length;r++){var q=s[r]
if(!b.hasOwnProperty(q)){b[q]=a[q]}}}function mixinPropertiesEasy(a,b){Object.assign(b,a)}var z=function(){var s=function(){}
s.prototype={p:{}}
var r=new s()
if(!(Object.getPrototypeOf(r)&&Object.getPrototypeOf(r).p===s.prototype.p))return false
try{if(typeof navigator!="undefined"&&typeof navigator.userAgent=="string"&&navigator.userAgent.indexOf("Chrome/")>=0)return true
if(typeof version=="function"&&version.length==0){var q=version()
if(/^\d+\.\d+\.\d+\.\d+$/.test(q))return true}}catch(p){}return false}()
function inherit(a,b){a.prototype.constructor=a
a.prototype["$i"+a.name]=a
if(b!=null){if(z){Object.setPrototypeOf(a.prototype,b.prototype)
return}var s=Object.create(b.prototype)
copyProperties(a.prototype,s)
a.prototype=s}}function inheritMany(a,b){for(var s=0;s<b.length;s++){inherit(b[s],a)}}function mixinEasy(a,b){mixinPropertiesEasy(b.prototype,a.prototype)
a.prototype.constructor=a}function mixinHard(a,b){mixinPropertiesHard(b.prototype,a.prototype)
a.prototype.constructor=a}function lazy(a,b,c,d){var s=a
a[b]=s
a[c]=function(){if(a[b]===s){a[b]=d()}a[c]=function(){return this[b]}
return a[b]}}function lazyFinal(a,b,c,d){var s=a
a[b]=s
a[c]=function(){if(a[b]===s){var r=d()
if(a[b]!==s){A.jO(b)}a[b]=r}var q=a[b]
a[c]=function(){return q}
return q}}function makeConstList(a,b){if(b!=null)A.u(a,b)
a.$flags=7
return a}function convertToFastObject(a){function t(){}t.prototype=a
new t()
return a}function convertAllToFastObject(a){for(var s=0;s<a.length;++s){convertToFastObject(a[s])}}var y=0
function instanceTearOffGetter(a,b){var s=null
return a?function(c){if(s===null)s=A.eT(b)
return new s(c,this)}:function(){if(s===null)s=A.eT(b)
return new s(this,null)}}function staticTearOffGetter(a){var s=null
return function(){if(s===null)s=A.eT(a).prototype
return s}}var x=0
function tearOffParameters(a,b,c,d,e,f,g,h,i,j){if(typeof h=="number"){h+=x}return{co:a,iS:b,iI:c,rC:d,dV:e,cs:f,fs:g,fT:h,aI:i||0,nDA:j}}function installStaticTearOff(a,b,c,d,e,f,g,h){var s=tearOffParameters(a,true,false,c,d,e,f,g,h,false)
var r=staticTearOffGetter(s)
a[b]=r}function installInstanceTearOff(a,b,c,d,e,f,g,h,i,j){c=!!c
var s=tearOffParameters(a,false,c,d,e,f,g,h,i,!!j)
var r=instanceTearOffGetter(c,s)
a[b]=r}function setOrUpdateInterceptorsByTag(a){var s=v.interceptorsByTag
if(!s){v.interceptorsByTag=a
return}copyProperties(a,s)}function setOrUpdateLeafTags(a){var s=v.leafTags
if(!s){v.leafTags=a
return}copyProperties(a,s)}function updateTypes(a){var s=v.types
var r=s.length
s.push.apply(s,a)
return r}function updateHolder(a,b){copyProperties(b,a)
return a}var hunkHelpers=function(){var s=function(a,b,c,d,e){return function(f,g,h,i){return installInstanceTearOff(f,g,a,b,c,d,[h],i,e,false)}},r=function(a,b,c,d){return function(e,f,g,h){return installStaticTearOff(e,f,a,b,c,[g],h,d)}}
return{inherit:inherit,inheritMany:inheritMany,mixin:mixinEasy,mixinHard:mixinHard,installStaticTearOff:installStaticTearOff,installInstanceTearOff:installInstanceTearOff,_instance_0u:s(0,0,null,["$0"],0),_instance_1u:s(0,1,null,["$1"],0),_instance_2u:s(0,2,null,["$2"],0),_instance_0i:s(1,0,null,["$0"],0),_instance_1i:s(1,1,null,["$1"],0),_instance_2i:s(1,2,null,["$2"],0),_static_0:r(0,null,["$0"],0),_static_1:r(1,null,["$1"],0),_static_2:r(2,null,["$2"],0),makeConstList:makeConstList,lazy:lazy,lazyFinal:lazyFinal,updateHolder:updateHolder,convertToFastObject:convertToFastObject,updateTypes:updateTypes,setOrUpdateInterceptorsByTag:setOrUpdateInterceptorsByTag,setOrUpdateLeafTags:setOrUpdateLeafTags}}()
function initializeDeferredHunk(a){x=v.types.length
a(hunkHelpers,v,w,$)}var J={
f0(a,b,c,d){return{i:a,p:b,e:c,x:d}},
eX(a){var s,r,q,p,o,n=a[v.dispatchPropertyName]
if(n==null)if($.eZ==null){A.jD()
n=a[v.dispatchPropertyName]}if(n!=null){s=n.p
if(!1===s)return n.i
if(!0===s)return a
r=Object.getPrototypeOf(a)
if(s===r)return n.i
if(n.e===r)throw A.c(A.bm("Return interceptor for "+A.j(s(a,n))))}q=a.constructor
if(q==null)p=null
else{o=$.dX
if(o==null)o=$.dX=v.getIsolateTag("_$dart_js")
p=q[o]}if(p!=null)return p
p=A.jJ(a)
if(p!=null)return p
if(typeof a=="function")return B.B
s=Object.getPrototypeOf(a)
if(s==null)return B.p
if(s===Object.prototype)return B.p
if(typeof q=="function"){o=$.dX
if(o==null)o=$.dX=v.getIsolateTag("_$dart_js")
Object.defineProperty(q,o,{value:B.j,enumerable:false,writable:true,configurable:true})
return B.j}return B.j},
hF(a,b){if(a<0||a>4294967295)throw A.c(A.bi(a,0,4294967295,"length",null))
return J.hH(new Array(a),b)},
hG(a,b){if(a<0)throw A.c(A.H("Length must be a non-negative integer: "+a,null))
return A.u(new Array(a),b.h("o<0>"))},
da(a,b){if(a<0)throw A.c(A.H("Length must be a non-negative integer: "+a,null))
return A.u(new Array(a),b.h("o<0>"))},
hH(a,b){var s=A.u(a,b.h("o<0>"))
s.$flags=1
return s},
ar(a){if(typeof a=="number"){if(Math.floor(a)==a)return J.b5.prototype
return J.c8.prototype}if(typeof a=="string")return J.ay.prototype
if(a==null)return J.b6.prototype
if(typeof a=="boolean")return J.c7.prototype
if(Array.isArray(a))return J.o.prototype
if(typeof a!="object"){if(typeof a=="function")return J.a7.prototype
if(typeof a=="symbol")return J.b9.prototype
if(typeof a=="bigint")return J.b7.prototype
return a}if(a instanceof A.b)return a
return J.eX(a)},
h1(a){if(typeof a=="string")return J.ay.prototype
if(a==null)return a
if(Array.isArray(a))return J.o.prototype
if(typeof a!="object"){if(typeof a=="function")return J.a7.prototype
if(typeof a=="symbol")return J.b9.prototype
if(typeof a=="bigint")return J.b7.prototype
return a}if(a instanceof A.b)return a
return J.eX(a)},
O(a){if(a==null)return a
if(Array.isArray(a))return J.o.prototype
if(typeof a!="object"){if(typeof a=="function")return J.a7.prototype
if(typeof a=="symbol")return J.b9.prototype
if(typeof a=="bigint")return J.b7.prototype
return a}if(a instanceof A.b)return a
return J.eX(a)},
jz(a){if(typeof a=="number")return J.ax.prototype
if(a==null)return a
if(!(a instanceof A.b))return J.aF.prototype
return a},
Y(a,b){if(a==null)return b==null
if(typeof a!="object")return b!=null&&a===b
return J.ar(a).E(a,b)},
U(a,b){if(typeof b==="number")if(Array.isArray(a)||A.h5(a,a[v.dispatchPropertyName]))if(b>>>0===b&&b<a.length)return a[b]
return J.O(a).j(a,b)},
ae(a,b,c){if(typeof b==="number")if((Array.isArray(a)||A.h5(a,a[v.dispatchPropertyName]))&&!(a.$flags&2)&&b>>>0===b&&b<a.length)return a[b]=c
return J.O(a).B(a,b,c)},
hm(a,b){return J.O(a).N(a,b)},
hn(a,b){return J.O(a).O(a,b)},
ho(a){return J.O(a).gaD(a)},
G(a){return J.ar(a).gt(a)},
f4(a){return J.O(a).gn(a)},
f5(a){return J.O(a).gaK(a)},
f6(a){return J.h1(a).gk(a)},
ez(a){return J.ar(a).gp(a)},
f7(a,b,c){return J.O(a).Y(a,b,c)},
f8(a){return J.jz(a).bj(a)},
au(a){return J.ar(a).i(a)},
c4:function c4(){},
c7:function c7(){},
b6:function b6(){},
b8:function b8(){},
a8:function a8(){},
cn:function cn(){},
aF:function aF(){},
a7:function a7(){},
b7:function b7(){},
b9:function b9(){},
o:function o(a){this.$ti=a},
c6:function c6(){},
db:function db(a){this.$ti=a},
av:function av(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=null
_.$ti=c},
ax:function ax(){},
b5:function b5(){},
c8:function c8(){},
ay:function ay(){}},A={eD:function eD(){},
hI(a){return new A.az("Field '"+a+"' has not been initialized.")},
a1(a,b){a=a+b&536870911
a=a+((a&524287)<<10)&536870911
return a^a>>>6},
dp(a){a=a+((a&67108863)<<3)&536870911
a^=a>>>11
return a+((a&16383)<<15)&536870911},
el(a,b,c){return a},
f_(a){var s,r
for(s=$.at.length,r=0;r<s;++r)if(a===$.at[r])return!0
return!1},
hK(a,b,c,d){if(t.V.b(a))return new A.aX(a,b,c.h("@<0>").D(d).h("aX<1,2>"))
return new A.ak(a,b,c.h("@<0>").D(d).h("ak<1,2>"))},
b4(){return new A.al("No element")},
aT:function aT(a,b){this.a=a
this.$ti=b},
aU:function aU(a,b,c){var _=this
_.a=a
_.b=b
_.d=_.c=null
_.$ti=c},
az:function az(a){this.a=a},
ev:function ev(){},
dk:function dk(){},
e:function e(){},
a_:function a_(){},
aA:function aA(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=null
_.$ti=c},
ak:function ak(a,b,c){this.a=a
this.b=b
this.$ti=c},
aX:function aX(a,b,c){this.a=a
this.b=b
this.$ti=c},
cd:function cd(a,b,c){var _=this
_.a=null
_.b=a
_.c=b
_.$ti=c},
a0:function a0(a,b,c){this.a=a
this.b=b
this.$ti=c},
aZ:function aZ(){},
h3(a,b){var s=new A.b1(a,b.h("b1<0>"))
s.bp(a)
return s},
h9(a){var s=v.mangledGlobalNames[a]
if(s!=null)return s
return"minified:"+a},
h5(a,b){var s
if(b!=null){s=b.x
if(s!=null)return s}return t.E.b(a)},
j(a){var s
if(typeof a=="string")return a
if(typeof a=="number"){if(a!==0)return""+a}else if(!0===a)return"true"
else if(!1===a)return"false"
else if(a==null)return"null"
s=J.au(a)
return s},
bh(a){var s,r=$.fk
if(r==null)r=$.fk=Symbol("identityHashCode")
s=a[r]
if(s==null){s=Math.random()*0x3fffffff|0
a[r]=s}return s},
co(a){var s,r,q,p
if(a instanceof A.b)return A.M(A.ac(a),null)
s=J.ar(a)
if(s===B.z||s===B.C||t.cr.b(a)){r=B.k(a)
if(r!=="Object"&&r!=="")return r
q=a.constructor
if(typeof q=="function"){p=q.name
if(typeof p=="string"&&p!=="Object"&&p!=="")return p}}return A.M(A.ac(a),null)},
fl(a){var s,r,q
if(a==null||typeof a=="number"||A.cJ(a))return J.au(a)
if(typeof a=="string")return JSON.stringify(a)
if(a instanceof A.af)return a.i(0)
if(a instanceof A.bA)return a.ba(!0)
s=$.hk()
for(r=0;r<1;++r){q=s[r].c9(a)
if(q!=null)return q}return"Instance of '"+A.co(a)+"'"},
A(a){var s
if(a<=65535)return String.fromCharCode(a)
if(a<=1114111){s=a-65536
return String.fromCharCode((B.a.b7(s,10)|55296)>>>0,s&1023|56320)}throw A.c(A.bi(a,0,1114111,null,null))},
aD(a){if(a.date===void 0)a.date=new Date(a.a)
return a.date},
hS(a){var s=A.aD(a).getUTCFullYear()+0
return s},
hQ(a){var s=A.aD(a).getUTCMonth()+1
return s},
hM(a){var s=A.aD(a).getUTCDate()+0
return s},
hN(a){var s=A.aD(a).getUTCHours()+0
return s},
hP(a){var s=A.aD(a).getUTCMinutes()+0
return s},
hR(a){var s=A.aD(a).getUTCSeconds()+0
return s},
hO(a){var s=A.aD(a).getUTCMilliseconds()+0
return s},
hL(a){var s=a.$thrownJsError
if(s==null)return null
return A.P(s)},
fm(a,b){var s
if(a.$thrownJsError==null){s=new Error()
A.z(a,s)
a.$thrownJsError=s
s.stack=b.i(0)}},
eW(a,b){var s,r="index"
if(!A.fO(b))return new A.Z(!0,b,r,null)
s=J.f6(a)
if(b<0||b>=s)return A.fg(b,s,a,r)
return new A.aE(null,null,!0,b,r,"Value not in range")},
jm(a){return new A.Z(!0,a,null,null)},
c(a){return A.z(a,new Error())},
z(a,b){var s
if(a==null)a=new A.a2()
b.dartException=a
s=A.jQ
if("defineProperty" in Object){Object.defineProperty(b,"message",{get:s})
b.name=""}else b.toString=s
return b},
jQ(){return J.au(this.dartException)},
S(a,b){throw A.z(a,b==null?new Error():b)},
cM(a,b,c){var s
if(b==null)b=0
if(c==null)c=0
s=Error()
A.S(A.iI(a,b,c),s)},
iI(a,b,c){var s,r,q,p,o,n,m,l,k
if(typeof b=="string")s=b
else{r="[]=;add;removeWhere;retainWhere;removeRange;setRange;setInt8;setInt16;setInt32;setUint8;setUint16;setUint32;setFloat32;setFloat64".split(";")
q=r.length
p=b
if(p>q){c=p/q|0
p%=q}s=r[p]}o=typeof c=="string"?c:"modify;remove from;add to".split(";")[c]
n=t.j.b(a)?"list":"ByteData"
m=a.$flags|0
l="a "
if((m&4)!==0)k="constant "
else if((m&2)!==0){k="unmodifiable "
l="an "}else k=(m&1)!==0?"fixed-length ":""
return new A.bn("'"+s+"': Cannot "+o+" "+l+k+n)},
cL(a){throw A.c(A.ag(a))},
a3(a){var s,r,q,p,o,n
a=A.jN(a.replace(String({}),"$receiver$"))
s=a.match(/\\\$[a-zA-Z]+\\\$/g)
if(s==null)s=A.u([],t.s)
r=s.indexOf("\\$arguments\\$")
q=s.indexOf("\\$argumentsExpr\\$")
p=s.indexOf("\\$expr\\$")
o=s.indexOf("\\$method\\$")
n=s.indexOf("\\$receiver\\$")
return new A.dr(a.replace(new RegExp("\\\\\\$arguments\\\\\\$","g"),"((?:x|[^x])*)").replace(new RegExp("\\\\\\$argumentsExpr\\\\\\$","g"),"((?:x|[^x])*)").replace(new RegExp("\\\\\\$expr\\\\\\$","g"),"((?:x|[^x])*)").replace(new RegExp("\\\\\\$method\\\\\\$","g"),"((?:x|[^x])*)").replace(new RegExp("\\\\\\$receiver\\\\\\$","g"),"((?:x|[^x])*)"),r,q,p,o,n)},
ds(a){return function($expr$){var $argumentsExpr$="$arguments$"
try{$expr$.$method$($argumentsExpr$)}catch(s){return s.message}}(a)},
fq(a){return function($expr$){try{$expr$.$method$}catch(s){return s.message}}(a)},
eE(a,b){var s=b==null,r=s?null:b.method
return new A.c9(a,r,s?null:b.receiver)},
F(a){if(a==null)return new A.dj(a)
if(a instanceof A.aY)return A.ad(a,a.a)
if(typeof a!=="object")return a
if("dartException" in a)return A.ad(a,a.dartException)
return A.jk(a)},
ad(a,b){if(t.C.b(b))if(b.$thrownJsError==null)b.$thrownJsError=a
return b},
jk(a){var s,r,q,p,o,n,m,l,k,j,i,h,g
if(!("message" in a))return a
s=a.message
if("number" in a&&typeof a.number=="number"){r=a.number
q=r&65535
if((B.a.b7(r,16)&8191)===10)switch(q){case 438:return A.ad(a,A.eE(A.j(s)+" (Error "+q+")",null))
case 445:case 5007:A.j(s)
return A.ad(a,new A.bf())}}if(a instanceof TypeError){p=$.ha()
o=$.hb()
n=$.hc()
m=$.hd()
l=$.hg()
k=$.hh()
j=$.hf()
$.he()
i=$.hj()
h=$.hi()
g=p.H(s)
if(g!=null)return A.ad(a,A.eE(s,g))
else{g=o.H(s)
if(g!=null){g.method="call"
return A.ad(a,A.eE(s,g))}else if(n.H(s)!=null||m.H(s)!=null||l.H(s)!=null||k.H(s)!=null||j.H(s)!=null||m.H(s)!=null||i.H(s)!=null||h.H(s)!=null)return A.ad(a,new A.bf())}return A.ad(a,new A.cr(typeof s=="string"?s:""))}if(a instanceof RangeError){if(typeof s=="string"&&s.indexOf("call stack")!==-1)return new A.bk()
s=function(b){try{return String(b)}catch(f){}return null}(a)
return A.ad(a,new A.Z(!1,null,null,typeof s=="string"?s.replace(/^RangeError:\s*/,""):s))}if(typeof InternalError=="function"&&a instanceof InternalError)if(typeof s=="string"&&s==="too much recursion")return new A.bk()
return a},
P(a){var s
if(a instanceof A.aY)return a.b
if(a==null)return new A.bB(a)
s=a.$cachedTrace
if(s!=null)return s
s=new A.bB(a)
if(typeof a==="object")a.$cachedTrace=s
return s},
ew(a){if(a==null)return J.G(a)
if(typeof a=="object")return A.bh(a)
return J.G(a)},
jy(a,b){var s,r,q,p=a.length
for(s=0;s<p;s=q){r=s+1
q=r+1
b.B(0,a[s],a[r])}return b},
iV(a,b,c,d,e,f){switch(b){case 0:return a.$0()
case 1:return a.$1(c)
case 2:return a.$2(c,d)
case 3:return a.$3(c,d,e)
case 4:return a.$4(c,d,e,f)}throw A.c(new A.dI("Unsupported number of arguments for wrapped closure"))},
bR(a,b){var s=a.$identity
if(!!s)return s
s=A.ju(a,b)
a.$identity=s
return s},
ju(a,b){var s
switch(b){case 0:s=a.$0
break
case 1:s=a.$1
break
case 2:s=a.$2
break
case 3:s=a.$3
break
case 4:s=a.$4
break
default:s=null}if(s!=null)return s.bind(a)
return function(c,d,e){return function(f,g,h,i){return e(c,d,f,g,h,i)}}(a,b,A.iV)},
hv(a2){var s,r,q,p,o,n,m,l,k,j,i=a2.co,h=a2.iS,g=a2.iI,f=a2.nDA,e=a2.aI,d=a2.fs,c=a2.cs,b=d[0],a=c[0],a0=i[b],a1=a2.fT
a1.toString
s=h?Object.create(new A.dl().constructor.prototype):Object.create(new A.aS(null,null).constructor.prototype)
s.$initialize=s.constructor
r=h?function static_tear_off(){this.$initialize()}:function tear_off(a3,a4){this.$initialize(a3,a4)}
s.constructor=r
r.prototype=s
s.$_name=b
s.$_target=a0
q=!h
if(q)p=A.fe(b,a0,g,f)
else{s.$static_name=b
p=a0}s.$S=A.hr(a1,h,g)
s[a]=p
for(o=p,n=1;n<d.length;++n){m=d[n]
if(typeof m=="string"){l=i[m]
k=m
m=l}else k=""
j=c[n]
if(j!=null){if(q)m=A.fe(k,m,g,f)
s[j]=m}if(n===e)o=m}s.$C=o
s.$R=a2.rC
s.$D=a2.dV
return r},
hr(a,b,c){if(typeof a=="number")return a
if(typeof a=="string"){if(b)throw A.c("Cannot compute signature for static tearoff.")
return function(d,e){return function(){return e(this,d)}}(a,A.hp)}throw A.c("Error in functionType of tearoff")},
hs(a,b,c,d){var s=A.fd
switch(b?-1:a){case 0:return function(e,f){return function(){return f(this)[e]()}}(c,s)
case 1:return function(e,f){return function(g){return f(this)[e](g)}}(c,s)
case 2:return function(e,f){return function(g,h){return f(this)[e](g,h)}}(c,s)
case 3:return function(e,f){return function(g,h,i){return f(this)[e](g,h,i)}}(c,s)
case 4:return function(e,f){return function(g,h,i,j){return f(this)[e](g,h,i,j)}}(c,s)
case 5:return function(e,f){return function(g,h,i,j,k){return f(this)[e](g,h,i,j,k)}}(c,s)
default:return function(e,f){return function(){return e.apply(f(this),arguments)}}(d,s)}},
fe(a,b,c,d){if(c)return A.hu(a,b,d)
return A.hs(b.length,d,a,b)},
ht(a,b,c,d){var s=A.fd,r=A.hq
switch(b?-1:a){case 0:throw A.c(new A.cp("Intercepted function with no arguments."))
case 1:return function(e,f,g){return function(){return f(this)[e](g(this))}}(c,r,s)
case 2:return function(e,f,g){return function(h){return f(this)[e](g(this),h)}}(c,r,s)
case 3:return function(e,f,g){return function(h,i){return f(this)[e](g(this),h,i)}}(c,r,s)
case 4:return function(e,f,g){return function(h,i,j){return f(this)[e](g(this),h,i,j)}}(c,r,s)
case 5:return function(e,f,g){return function(h,i,j,k){return f(this)[e](g(this),h,i,j,k)}}(c,r,s)
case 6:return function(e,f,g){return function(h,i,j,k,l){return f(this)[e](g(this),h,i,j,k,l)}}(c,r,s)
default:return function(e,f,g){return function(){var q=[g(this)]
Array.prototype.push.apply(q,arguments)
return e.apply(f(this),q)}}(d,r,s)}},
hu(a,b,c){var s,r
if($.fb==null)$.fb=A.fa("interceptor")
if($.fc==null)$.fc=A.fa("receiver")
s=b.length
r=A.ht(s,c,a,b)
return r},
eT(a){return A.hv(a)},
hp(a,b){return A.bH(v.typeUniverse,A.ac(a.a),b)},
fd(a){return a.a},
hq(a){return a.b},
fa(a){var s,r,q,p=new A.aS("receiver","interceptor"),o=Object.getOwnPropertyNames(p)
o.$flags=1
s=o
for(o=s.length,r=0;r<o;++r){q=s[r]
if(p[q]===a)return q}throw A.c(A.H("Field name "+a+" not found.",null))},
jA(a){return v.getIsolateTag(a)},
jJ(a){var s,r,q,p,o,n=$.h2.$1(a),m=$.en[n]
if(m!=null){Object.defineProperty(a,v.dispatchPropertyName,{value:m,enumerable:false,writable:true,configurable:true})
return m.i}s=$.er[n]
if(s!=null)return s
r=v.interceptorsByTag[n]
if(r==null){q=$.fZ.$2(a,n)
if(q!=null){m=$.en[q]
if(m!=null){Object.defineProperty(a,v.dispatchPropertyName,{value:m,enumerable:false,writable:true,configurable:true})
return m.i}s=$.er[q]
if(s!=null)return s
r=v.interceptorsByTag[q]
n=q}}if(r==null)return null
s=r.prototype
p=n[0]
if(p==="!"){m=A.eu(s)
$.en[n]=m
Object.defineProperty(a,v.dispatchPropertyName,{value:m,enumerable:false,writable:true,configurable:true})
return m.i}if(p==="~"){$.er[n]=s
return s}if(p==="-"){o=A.eu(s)
Object.defineProperty(Object.getPrototypeOf(a),v.dispatchPropertyName,{value:o,enumerable:false,writable:true,configurable:true})
return o.i}if(p==="+")return A.h6(a,s)
if(p==="*")throw A.c(A.bm(n))
if(v.leafTags[n]===true){o=A.eu(s)
Object.defineProperty(Object.getPrototypeOf(a),v.dispatchPropertyName,{value:o,enumerable:false,writable:true,configurable:true})
return o.i}else return A.h6(a,s)},
h6(a,b){var s=Object.getPrototypeOf(a)
Object.defineProperty(s,v.dispatchPropertyName,{value:J.f0(b,s,null,null),enumerable:false,writable:true,configurable:true})
return b},
eu(a){return J.f0(a,!1,null,!!a.$iJ)},
jL(a,b,c){var s=b.prototype
if(v.leafTags[a]===true)return A.eu(s)
else return J.f0(s,c,null,null)},
jD(){if(!0===$.eZ)return
$.eZ=!0
A.jE()},
jE(){var s,r,q,p,o,n,m,l
$.en=Object.create(null)
$.er=Object.create(null)
A.jC()
s=v.interceptorsByTag
r=Object.getOwnPropertyNames(s)
if(typeof window!="undefined"){window
q=function(){}
for(p=0;p<r.length;++p){o=r[p]
n=$.h7.$1(o)
if(n!=null){m=A.jL(o,s[o],n)
if(m!=null){Object.defineProperty(n,v.dispatchPropertyName,{value:m,enumerable:false,writable:true,configurable:true})
q.prototype=n}}}}for(p=0;p<r.length;++p){o=r[p]
if(/^[A-Za-z_]/.test(o)){l=s[o]
s["!"+o]=l
s["~"+o]=l
s["-"+o]=l
s["+"+o]=l
s["*"+o]=l}}},
jC(){var s,r,q,p,o,n,m=B.r()
m=A.aO(B.t,A.aO(B.u,A.aO(B.l,A.aO(B.l,A.aO(B.v,A.aO(B.w,A.aO(B.x(B.k),m)))))))
if(typeof dartNativeDispatchHooksTransformer!="undefined"){s=dartNativeDispatchHooksTransformer
if(typeof s=="function")s=[s]
if(Array.isArray(s))for(r=0;r<s.length;++r){q=s[r]
if(typeof q=="function")m=q(m)||m}}p=m.getTag
o=m.getUnknownTag
n=m.prototypeForTag
$.h2=new A.eo(p)
$.fZ=new A.ep(o)
$.h7=new A.eq(n)},
aO(a,b){return a(b)||b},
jw(a,b){var s=b.length,r=v.rttc[""+s+";"+a]
if(r==null)return null
if(s===0)return r
if(s===r.length)return r.apply(null,b)
return r(b)},
jN(a){if(/[[\]{}()*+?.\\^$|]/.test(a))return a.replace(/[[\]{}()*+?.\\^$|]/g,"\\$&")
return a},
x:function x(a,b){this.a=a
this.b=b},
aV:function aV(){},
cT:function cT(a,b,c){this.a=a
this.b=b
this.c=c},
aW:function aW(a,b,c){this.a=a
this.b=b
this.$ti=c},
bv:function bv(a,b){this.a=a
this.$ti=b},
cF:function cF(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=null
_.$ti=c},
d1:function d1(){},
b1:function b1(a,b){this.a=a
this.$ti=b},
bj:function bj(){},
dr:function dr(a,b,c,d,e,f){var _=this
_.a=a
_.b=b
_.c=c
_.d=d
_.e=e
_.f=f},
bf:function bf(){},
c9:function c9(a,b,c){this.a=a
this.b=b
this.c=c},
cr:function cr(a){this.a=a},
dj:function dj(a){this.a=a},
aY:function aY(a,b){this.a=a
this.b=b},
bB:function bB(a){this.a=a
this.b=null},
af:function af(){},
cR:function cR(){},
cS:function cS(){},
dq:function dq(){},
dl:function dl(){},
aS:function aS(a,b){this.a=a
this.b=b},
cp:function cp(a){this.a=a},
ah:function ah(a){var _=this
_.a=0
_.f=_.e=_.d=_.c=_.b=null
_.r=0
_.$ti=a},
df:function df(a,b){this.a=a
this.b=b
this.c=null},
aj:function aj(a,b){this.a=a
this.$ti=b},
cc:function cc(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=null
_.$ti=d},
ai:function ai(a,b){this.a=a
this.$ti=b},
cb:function cb(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=null
_.$ti=d},
eo:function eo(a){this.a=a},
ep:function ep(a){this.a=a},
eq:function eq(a){this.a=a},
bA:function bA(){},
cH:function cH(){},
jO(a){throw A.z(new A.az("Field '"+a+"' has been assigned during initialization."),new Error())},
jP(){throw A.z(A.hI(""),new Error())},
i2(){var s=new A.dE()
return s.b=s},
dE:function dE(){this.b=null},
a5(a,b,c){if(a>>>0!==a||a>=c)throw A.c(A.eW(b,a))},
aB:function aB(){},
bd:function bd(){},
ce:function ce(){},
aC:function aC(){},
bb:function bb(){},
bc:function bc(){},
cf:function cf(){},
cg:function cg(){},
ch:function ch(){},
ci:function ci(){},
cj:function cj(){},
ck:function ck(){},
cl:function cl(){},
be:function be(){},
cm:function cm(){},
bw:function bw(){},
bx:function bx(){},
by:function by(){},
bz:function bz(){},
eI(a,b){var s=b.c
return s==null?b.c=A.bF(a,"V",[b.x]):s},
fn(a){var s=a.w
if(s===6||s===7)return A.fn(a.x)
return s===11||s===12},
hW(a){return a.as},
aP(a){return A.e8(v.typeUniverse,a,!1)},
h4(a,b){var s,r,q,p,o
if(a==null)return null
s=b.y
r=a.Q
if(r==null)r=a.Q=new Map()
q=b.as
p=r.get(q)
if(p!=null)return p
o=A.ab(v.typeUniverse,a.x,s,0)
r.set(q,o)
return o},
ab(a1,a2,a3,a4){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0=a2.w
switch(a0){case 5:case 1:case 2:case 3:case 4:return a2
case 6:s=a2.x
r=A.ab(a1,s,a3,a4)
if(r===s)return a2
return A.fD(a1,r,!0)
case 7:s=a2.x
r=A.ab(a1,s,a3,a4)
if(r===s)return a2
return A.fC(a1,r,!0)
case 8:q=a2.y
p=A.aN(a1,q,a3,a4)
if(p===q)return a2
return A.bF(a1,a2.x,p)
case 9:o=a2.x
n=A.ab(a1,o,a3,a4)
m=a2.y
l=A.aN(a1,m,a3,a4)
if(n===o&&l===m)return a2
return A.eO(a1,n,l)
case 10:k=a2.x
j=a2.y
i=A.aN(a1,j,a3,a4)
if(i===j)return a2
return A.fE(a1,k,i)
case 11:h=a2.x
g=A.ab(a1,h,a3,a4)
f=a2.y
e=A.jh(a1,f,a3,a4)
if(g===h&&e===f)return a2
return A.fB(a1,g,e)
case 12:d=a2.y
a4+=d.length
c=A.aN(a1,d,a3,a4)
o=a2.x
n=A.ab(a1,o,a3,a4)
if(c===d&&n===o)return a2
return A.eP(a1,n,c,!0)
case 13:b=a2.x
if(b<a4)return a2
a=a3[b-a4]
if(a==null)return a2
return a
default:throw A.c(A.bT("Attempted to substitute unexpected RTI kind "+a0))}},
aN(a,b,c,d){var s,r,q,p,o=b.length,n=A.e9(o)
for(s=!1,r=0;r<o;++r){q=b[r]
p=A.ab(a,q,c,d)
if(p!==q)s=!0
n[r]=p}return s?n:b},
ji(a,b,c,d){var s,r,q,p,o,n,m=b.length,l=A.e9(m)
for(s=!1,r=0;r<m;r+=3){q=b[r]
p=b[r+1]
o=b[r+2]
n=A.ab(a,o,c,d)
if(n!==o)s=!0
l.splice(r,3,q,p,n)}return s?l:b},
jh(a,b,c,d){var s,r=b.a,q=A.aN(a,r,c,d),p=b.b,o=A.aN(a,p,c,d),n=b.c,m=A.ji(a,n,c,d)
if(q===r&&o===p&&m===n)return b
s=new A.cz()
s.a=q
s.b=o
s.c=m
return s},
u(a,b){a[v.arrayRti]=b
return a},
cK(a){var s=a.$S
if(s!=null){if(typeof s=="number")return A.jB(s)
return a.$S()}return null},
jF(a,b){var s
if(A.fn(b))if(a instanceof A.af){s=A.cK(a)
if(s!=null)return s}return A.ac(a)},
ac(a){if(a instanceof A.b)return A.t(a)
if(Array.isArray(a))return A.bI(a)
return A.eQ(J.ar(a))},
bI(a){var s=a[v.arrayRti],r=t.x
if(s==null)return r
if(s.constructor!==r.constructor)return r
return s},
t(a){var s=a.$ti
return s!=null?s:A.eQ(a)},
eQ(a){var s=a.constructor,r=s.$ccache
if(r!=null)return r
return A.iU(a,s)},
iU(a,b){var s=a instanceof A.af?Object.getPrototypeOf(Object.getPrototypeOf(a)).constructor:b,r=A.il(v.typeUniverse,s.name)
b.$ccache=r
return r},
jB(a){var s,r=v.types,q=r[a]
if(typeof q=="string"){s=A.e8(v.typeUniverse,q,!1)
r[a]=s
return s}return q},
aQ(a){return A.N(A.t(a))},
eY(a){var s=A.cK(a)
return A.N(s==null?A.ac(a):s)},
eS(a){var s
if(a instanceof A.bA)return a.b2()
s=a instanceof A.af?A.cK(a):null
if(s!=null)return s
if(t.bW.b(a))return J.ez(a).a
if(Array.isArray(a))return A.bI(a)
return A.ac(a)},
N(a){var s=a.r
return s==null?a.r=new A.e7(a):s},
jx(a,b){var s,r,q=b,p=q.length
if(p===0)return t.cD
s=A.bH(v.typeUniverse,A.eS(q[0]),"@<0>")
for(r=1;r<p;++r)s=A.fF(v.typeUniverse,s,A.eS(q[r]))
return A.bH(v.typeUniverse,s,a)},
T(a){return A.N(A.e8(v.typeUniverse,a,!1))},
iT(a){var s=this
s.b=A.jf(s)
return s.b(a)},
jf(a){var s,r,q,p
if(a===t.K)return A.j0
if(A.as(a))return A.j4
s=a.w
if(s===6)return A.iQ
if(s===1)return A.fQ
if(s===7)return A.iW
r=A.je(a)
if(r!=null)return r
if(s===8){q=a.x
if(a.y.every(A.as)){a.f="$i"+q
if(q==="i")return A.iZ
if(a===t.m)return A.iY
return A.j3}}else if(s===10){p=A.jw(a.x,a.y)
return p==null?A.fQ:p}return A.iO},
je(a){if(a.w===8){if(a===t.S)return A.fO
if(a===t.i||a===t.p)return A.j_
if(a===t.N)return A.j2
if(a===t.y)return A.cJ}return null},
iS(a){var s=this,r=A.iN
if(A.as(s))r=A.iA
else if(s===t.K)r=A.eb
else if(A.aR(s)){r=A.iP
if(s===t.a3)r=A.iu
else if(s===t.aD)r=A.iz
else if(s===t.cG)r=A.iq
else if(s===t.ae)r=A.iy
else if(s===t.I)r=A.is
else if(s===t.aQ)r=A.iw}else if(s===t.S)r=A.it
else if(s===t.N)r=A.ec
else if(s===t.y)r=A.ip
else if(s===t.p)r=A.ix
else if(s===t.i)r=A.ir
else if(s===t.m)r=A.iv
s.a=r
return s.a(a)},
iO(a){var s=this
if(a==null)return A.aR(s)
return A.jG(v.typeUniverse,A.jF(a,s),s)},
iQ(a){if(a==null)return!0
return this.x.b(a)},
j3(a){var s,r=this
if(a==null)return A.aR(r)
s=r.f
if(a instanceof A.b)return!!a[s]
return!!J.ar(a)[s]},
iZ(a){var s,r=this
if(a==null)return A.aR(r)
if(typeof a!="object")return!1
if(Array.isArray(a))return!0
s=r.f
if(a instanceof A.b)return!!a[s]
return!!J.ar(a)[s]},
iY(a){var s=this
if(a==null)return!1
if(typeof a=="object"){if(a instanceof A.b)return!!a[s.f]
return!0}if(typeof a=="function")return!0
return!1},
fP(a){if(typeof a=="object"){if(a instanceof A.b)return t.m.b(a)
return!0}if(typeof a=="function")return!0
return!1},
iN(a){var s=this
if(a==null){if(A.aR(s))return a}else if(s.b(a))return a
throw A.z(A.fI(a,s),new Error())},
iP(a){var s=this
if(a==null||s.b(a))return a
throw A.z(A.fI(a,s),new Error())},
fI(a,b){return new A.bD("TypeError: "+A.fu(a,A.M(b,null)))},
fu(a,b){return A.bZ(a)+": type '"+A.M(A.eS(a),null)+"' is not a subtype of type '"+b+"'"},
R(a,b){return new A.bD("TypeError: "+A.fu(a,b))},
iW(a){var s=this
return s.x.b(a)||A.eI(v.typeUniverse,s).b(a)},
j0(a){return a!=null},
eb(a){if(a!=null)return a
throw A.z(A.R(a,"Object"),new Error())},
j4(a){return!0},
iA(a){return a},
fQ(a){return!1},
cJ(a){return!0===a||!1===a},
ip(a){if(!0===a)return!0
if(!1===a)return!1
throw A.z(A.R(a,"bool"),new Error())},
iq(a){if(!0===a)return!0
if(!1===a)return!1
if(a==null)return a
throw A.z(A.R(a,"bool?"),new Error())},
ir(a){if(typeof a=="number")return a
throw A.z(A.R(a,"double"),new Error())},
is(a){if(typeof a=="number")return a
if(a==null)return a
throw A.z(A.R(a,"double?"),new Error())},
fO(a){return typeof a=="number"&&Math.floor(a)===a},
it(a){if(typeof a=="number"&&Math.floor(a)===a)return a
throw A.z(A.R(a,"int"),new Error())},
iu(a){if(typeof a=="number"&&Math.floor(a)===a)return a
if(a==null)return a
throw A.z(A.R(a,"int?"),new Error())},
j_(a){return typeof a=="number"},
ix(a){if(typeof a=="number")return a
throw A.z(A.R(a,"num"),new Error())},
iy(a){if(typeof a=="number")return a
if(a==null)return a
throw A.z(A.R(a,"num?"),new Error())},
j2(a){return typeof a=="string"},
ec(a){if(typeof a=="string")return a
throw A.z(A.R(a,"String"),new Error())},
iz(a){if(typeof a=="string")return a
if(a==null)return a
throw A.z(A.R(a,"String?"),new Error())},
iv(a){if(A.fP(a))return a
throw A.z(A.R(a,"JSObject"),new Error())},
iw(a){if(a==null)return a
if(A.fP(a))return a
throw A.z(A.R(a,"JSObject?"),new Error())},
fW(a,b){var s,r,q
for(s="",r="",q=0;q<a.length;++q,r=", ")s+=r+A.M(a[q],b)
return s},
jb(a,b){var s,r,q,p,o,n,m=a.x,l=a.y
if(""===m)return"("+A.fW(l,b)+")"
s=l.length
r=m.split(",")
q=r.length-s
for(p="(",o="",n=0;n<s;++n,o=", "){p+=o
if(q===0)p+="{"
p+=A.M(l[n],b)
if(q>=0)p+=" "+r[q];++q}return p+"})"},
fJ(a1,a2,a3){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a=", ",a0=null
if(a3!=null){s=a3.length
if(a2==null)a2=A.u([],t.s)
else a0=a2.length
r=a2.length
for(q=s;q>0;--q)a2.push("T"+(r+q))
for(p=t.X,o="<",n="",q=0;q<s;++q,n=a){o=o+n+a2[a2.length-1-q]
m=a3[q]
l=m.w
if(!(l===2||l===3||l===4||l===5||m===p))o+=" extends "+A.M(m,a2)}o+=">"}else o=""
p=a1.x
k=a1.y
j=k.a
i=j.length
h=k.b
g=h.length
f=k.c
e=f.length
d=A.M(p,a2)
for(c="",b="",q=0;q<i;++q,b=a)c+=b+A.M(j[q],a2)
if(g>0){c+=b+"["
for(b="",q=0;q<g;++q,b=a)c+=b+A.M(h[q],a2)
c+="]"}if(e>0){c+=b+"{"
for(b="",q=0;q<e;q+=3,b=a){c+=b
if(f[q+1])c+="required "
c+=A.M(f[q+2],a2)+" "+f[q]}c+="}"}if(a0!=null){a2.toString
a2.length=a0}return o+"("+c+") => "+d},
M(a,b){var s,r,q,p,o,n,m=a.w
if(m===5)return"erased"
if(m===2)return"dynamic"
if(m===3)return"void"
if(m===1)return"Never"
if(m===4)return"any"
if(m===6){s=a.x
r=A.M(s,b)
q=s.w
return(q===11||q===12?"("+r+")":r)+"?"}if(m===7)return"FutureOr<"+A.M(a.x,b)+">"
if(m===8){p=A.jj(a.x)
o=a.y
return o.length>0?p+("<"+A.fW(o,b)+">"):p}if(m===10)return A.jb(a,b)
if(m===11)return A.fJ(a,b,null)
if(m===12)return A.fJ(a.x,b,a.y)
if(m===13){n=a.x
return b[b.length-1-n]}return"?"},
jj(a){var s=v.mangledGlobalNames[a]
if(s!=null)return s
return"minified:"+a},
im(a,b){var s=a.tR[b]
for(;typeof s=="string";)s=a.tR[s]
return s},
il(a,b){var s,r,q,p,o,n=a.eT,m=n[b]
if(m==null)return A.e8(a,b,!1)
else if(typeof m=="number"){s=m
r=A.bG(a,5,"#")
q=A.e9(s)
for(p=0;p<s;++p)q[p]=r
o=A.bF(a,b,q)
n[b]=o
return o}else return m},
ik(a,b){return A.fG(a.tR,b)},
ij(a,b){return A.fG(a.eT,b)},
e8(a,b,c){var s,r=a.eC,q=r.get(b)
if(q!=null)return q
s=A.fz(A.fx(a,null,b,!1))
r.set(b,s)
return s},
bH(a,b,c){var s,r,q=b.z
if(q==null)q=b.z=new Map()
s=q.get(c)
if(s!=null)return s
r=A.fz(A.fx(a,b,c,!0))
q.set(c,r)
return r},
fF(a,b,c){var s,r,q,p=b.Q
if(p==null)p=b.Q=new Map()
s=c.as
r=p.get(s)
if(r!=null)return r
q=A.eO(a,b,c.w===9?c.y:[c])
p.set(s,q)
return q},
aa(a,b){b.a=A.iS
b.b=A.iT
return b},
bG(a,b,c){var s,r,q=a.eC.get(c)
if(q!=null)return q
s=new A.W(null,null)
s.w=b
s.as=c
r=A.aa(a,s)
a.eC.set(c,r)
return r},
fD(a,b,c){var s,r=b.as+"?",q=a.eC.get(r)
if(q!=null)return q
s=A.ih(a,b,r,c)
a.eC.set(r,s)
return s},
ih(a,b,c,d){var s,r,q
if(d){s=b.w
r=!0
if(!A.as(b))if(!(b===t.P||b===t.T))if(s!==6)r=s===7&&A.aR(b.x)
if(r)return b
else if(s===1)return t.P}q=new A.W(null,null)
q.w=6
q.x=b
q.as=c
return A.aa(a,q)},
fC(a,b,c){var s,r=b.as+"/",q=a.eC.get(r)
if(q!=null)return q
s=A.ie(a,b,r,c)
a.eC.set(r,s)
return s},
ie(a,b,c,d){var s,r
if(d){s=b.w
if(A.as(b)||b===t.K)return b
else if(s===1)return A.bF(a,"V",[b])
else if(b===t.P||b===t.T)return t.bc}r=new A.W(null,null)
r.w=7
r.x=b
r.as=c
return A.aa(a,r)},
ii(a,b){var s,r,q=""+b+"^",p=a.eC.get(q)
if(p!=null)return p
s=new A.W(null,null)
s.w=13
s.x=b
s.as=q
r=A.aa(a,s)
a.eC.set(q,r)
return r},
bE(a){var s,r,q,p=a.length
for(s="",r="",q=0;q<p;++q,r=",")s+=r+a[q].as
return s},
id(a){var s,r,q,p,o,n=a.length
for(s="",r="",q=0;q<n;q+=3,r=","){p=a[q]
o=a[q+1]?"!":":"
s+=r+p+o+a[q+2].as}return s},
bF(a,b,c){var s,r,q,p=b
if(c.length>0)p+="<"+A.bE(c)+">"
s=a.eC.get(p)
if(s!=null)return s
r=new A.W(null,null)
r.w=8
r.x=b
r.y=c
if(c.length>0)r.c=c[0]
r.as=p
q=A.aa(a,r)
a.eC.set(p,q)
return q},
eO(a,b,c){var s,r,q,p,o,n
if(b.w===9){s=b.x
r=b.y.concat(c)}else{r=c
s=b}q=s.as+(";<"+A.bE(r)+">")
p=a.eC.get(q)
if(p!=null)return p
o=new A.W(null,null)
o.w=9
o.x=s
o.y=r
o.as=q
n=A.aa(a,o)
a.eC.set(q,n)
return n},
fE(a,b,c){var s,r,q="+"+(b+"("+A.bE(c)+")"),p=a.eC.get(q)
if(p!=null)return p
s=new A.W(null,null)
s.w=10
s.x=b
s.y=c
s.as=q
r=A.aa(a,s)
a.eC.set(q,r)
return r},
fB(a,b,c){var s,r,q,p,o,n=b.as,m=c.a,l=m.length,k=c.b,j=k.length,i=c.c,h=i.length,g="("+A.bE(m)
if(j>0){s=l>0?",":""
g+=s+"["+A.bE(k)+"]"}if(h>0){s=l>0?",":""
g+=s+"{"+A.id(i)+"}"}r=n+(g+")")
q=a.eC.get(r)
if(q!=null)return q
p=new A.W(null,null)
p.w=11
p.x=b
p.y=c
p.as=r
o=A.aa(a,p)
a.eC.set(r,o)
return o},
eP(a,b,c,d){var s,r=b.as+("<"+A.bE(c)+">"),q=a.eC.get(r)
if(q!=null)return q
s=A.ig(a,b,c,r,d)
a.eC.set(r,s)
return s},
ig(a,b,c,d,e){var s,r,q,p,o,n,m,l
if(e){s=c.length
r=A.e9(s)
for(q=0,p=0;p<s;++p){o=c[p]
if(o.w===1){r[p]=o;++q}}if(q>0){n=A.ab(a,b,r,0)
m=A.aN(a,c,r,0)
return A.eP(a,n,m,c!==m)}}l=new A.W(null,null)
l.w=12
l.x=b
l.y=c
l.as=d
return A.aa(a,l)},
fx(a,b,c,d){return{u:a,e:b,r:c,s:[],p:0,n:d}},
fz(a){var s,r,q,p,o,n,m,l=a.r,k=a.s
for(s=l.length,r=0;r<s;){q=l.charCodeAt(r)
if(q>=48&&q<=57)r=A.i7(r+1,q,l,k)
else if((((q|32)>>>0)-97&65535)<26||q===95||q===36||q===124)r=A.fy(a,r,l,k,!1)
else if(q===46)r=A.fy(a,r,l,k,!0)
else{++r
switch(q){case 44:break
case 58:k.push(!1)
break
case 33:k.push(!0)
break
case 59:k.push(A.ap(a.u,a.e,k.pop()))
break
case 94:k.push(A.ii(a.u,k.pop()))
break
case 35:k.push(A.bG(a.u,5,"#"))
break
case 64:k.push(A.bG(a.u,2,"@"))
break
case 126:k.push(A.bG(a.u,3,"~"))
break
case 60:k.push(a.p)
a.p=k.length
break
case 62:A.i9(a,k)
break
case 38:A.i8(a,k)
break
case 63:p=a.u
k.push(A.fD(p,A.ap(p,a.e,k.pop()),a.n))
break
case 47:p=a.u
k.push(A.fC(p,A.ap(p,a.e,k.pop()),a.n))
break
case 40:k.push(-3)
k.push(a.p)
a.p=k.length
break
case 41:A.i6(a,k)
break
case 91:k.push(a.p)
a.p=k.length
break
case 93:o=k.splice(a.p)
A.fA(a.u,a.e,o)
a.p=k.pop()
k.push(o)
k.push(-1)
break
case 123:k.push(a.p)
a.p=k.length
break
case 125:o=k.splice(a.p)
A.ib(a.u,a.e,o)
a.p=k.pop()
k.push(o)
k.push(-2)
break
case 43:n=l.indexOf("(",r)
k.push(l.substring(r,n))
k.push(-4)
k.push(a.p)
a.p=k.length
r=n+1
break
default:throw"Bad character "+q}}}m=k.pop()
return A.ap(a.u,a.e,m)},
i7(a,b,c,d){var s,r,q=b-48
for(s=c.length;a<s;++a){r=c.charCodeAt(a)
if(!(r>=48&&r<=57))break
q=q*10+(r-48)}d.push(q)
return a},
fy(a,b,c,d,e){var s,r,q,p,o,n,m=b+1
for(s=c.length;m<s;++m){r=c.charCodeAt(m)
if(r===46){if(e)break
e=!0}else{if(!((((r|32)>>>0)-97&65535)<26||r===95||r===36||r===124))q=r>=48&&r<=57
else q=!0
if(!q)break}}p=c.substring(b,m)
if(e){s=a.u
o=a.e
if(o.w===9)o=o.x
n=A.im(s,o.x)[p]
if(n==null)A.S('No "'+p+'" in "'+A.hW(o)+'"')
d.push(A.bH(s,o,n))}else d.push(p)
return m},
i9(a,b){var s,r=a.u,q=A.fw(a,b),p=b.pop()
if(typeof p=="string")b.push(A.bF(r,p,q))
else{s=A.ap(r,a.e,p)
switch(s.w){case 11:b.push(A.eP(r,s,q,a.n))
break
default:b.push(A.eO(r,s,q))
break}}},
i6(a,b){var s,r,q,p=a.u,o=b.pop(),n=null,m=null
if(typeof o=="number")switch(o){case-1:n=b.pop()
break
case-2:m=b.pop()
break
default:b.push(o)
break}else b.push(o)
s=A.fw(a,b)
o=b.pop()
switch(o){case-3:o=b.pop()
if(n==null)n=p.sEA
if(m==null)m=p.sEA
r=A.ap(p,a.e,o)
q=new A.cz()
q.a=s
q.b=n
q.c=m
b.push(A.fB(p,r,q))
return
case-4:b.push(A.fE(p,b.pop(),s))
return
default:throw A.c(A.bT("Unexpected state under `()`: "+A.j(o)))}},
i8(a,b){var s=b.pop()
if(0===s){b.push(A.bG(a.u,1,"0&"))
return}if(1===s){b.push(A.bG(a.u,4,"1&"))
return}throw A.c(A.bT("Unexpected extended operation "+A.j(s)))},
fw(a,b){var s=b.splice(a.p)
A.fA(a.u,a.e,s)
a.p=b.pop()
return s},
ap(a,b,c){if(typeof c=="string")return A.bF(a,c,a.sEA)
else if(typeof c=="number"){b.toString
return A.ia(a,b,c)}else return c},
fA(a,b,c){var s,r=c.length
for(s=0;s<r;++s)c[s]=A.ap(a,b,c[s])},
ib(a,b,c){var s,r=c.length
for(s=2;s<r;s+=3)c[s]=A.ap(a,b,c[s])},
ia(a,b,c){var s,r,q=b.w
if(q===9){if(c===0)return b.x
s=b.y
r=s.length
if(c<=r)return s[c-1]
c-=r
b=b.x
q=b.w}else if(c===0)return b
if(q!==8)throw A.c(A.bT("Indexed base must be an interface type"))
s=b.y
if(c<=s.length)return s[c-1]
throw A.c(A.bT("Bad index "+c+" for "+b.i(0)))},
jG(a,b,c){var s,r=b.d
if(r==null)r=b.d=new Map()
s=r.get(c)
if(s==null){s=A.y(a,b,null,c,null)
r.set(c,s)}return s},
y(a,b,c,d,e){var s,r,q,p,o,n,m,l,k,j,i
if(b===d)return!0
if(A.as(d))return!0
s=b.w
if(s===4)return!0
if(A.as(b))return!1
if(b.w===1)return!0
r=s===13
if(r)if(A.y(a,c[b.x],c,d,e))return!0
q=d.w
p=t.P
if(b===p||b===t.T){if(q===7)return A.y(a,b,c,d.x,e)
return d===p||d===t.T||q===6}if(d===t.K){if(s===7)return A.y(a,b.x,c,d,e)
return s!==6}if(s===7){if(!A.y(a,b.x,c,d,e))return!1
return A.y(a,A.eI(a,b),c,d,e)}if(s===6)return A.y(a,p,c,d,e)&&A.y(a,b.x,c,d,e)
if(q===7){if(A.y(a,b,c,d.x,e))return!0
return A.y(a,b,c,A.eI(a,d),e)}if(q===6)return A.y(a,b,c,p,e)||A.y(a,b,c,d.x,e)
if(r)return!1
p=s!==11
if((!p||s===12)&&d===t.Z)return!0
o=s===10
if(o&&d===t.cY)return!0
if(q===12){if(b===t.L)return!0
if(s!==12)return!1
n=b.y
m=d.y
l=n.length
if(l!==m.length)return!1
c=c==null?n:n.concat(c)
e=e==null?m:m.concat(e)
for(k=0;k<l;++k){j=n[k]
i=m[k]
if(!A.y(a,j,c,i,e)||!A.y(a,i,e,j,c))return!1}return A.fN(a,b.x,c,d.x,e)}if(q===11){if(b===t.L)return!0
if(p)return!1
return A.fN(a,b,c,d,e)}if(s===8){if(q!==8)return!1
return A.iX(a,b,c,d,e)}if(o&&q===10)return A.j1(a,b,c,d,e)
return!1},
fN(a3,a4,a5,a6,a7){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0,a1,a2
if(!A.y(a3,a4.x,a5,a6.x,a7))return!1
s=a4.y
r=a6.y
q=s.a
p=r.a
o=q.length
n=p.length
if(o>n)return!1
m=n-o
l=s.b
k=r.b
j=l.length
i=k.length
if(o+j<n+i)return!1
for(h=0;h<o;++h){g=q[h]
if(!A.y(a3,p[h],a7,g,a5))return!1}for(h=0;h<m;++h){g=l[h]
if(!A.y(a3,p[o+h],a7,g,a5))return!1}for(h=0;h<i;++h){g=l[m+h]
if(!A.y(a3,k[h],a7,g,a5))return!1}f=s.c
e=r.c
d=f.length
c=e.length
for(b=0,a=0;a<c;a+=3){a0=e[a]
for(;!0;){if(b>=d)return!1
a1=f[b]
b+=3
if(a0<a1)return!1
a2=f[b-2]
if(a1<a0){if(a2)return!1
continue}g=e[a+1]
if(a2&&!g)return!1
g=f[b-1]
if(!A.y(a3,e[a+2],a7,g,a5))return!1
break}}for(;b<d;){if(f[b+1])return!1
b+=3}return!0},
iX(a,b,c,d,e){var s,r,q,p,o,n=b.x,m=d.x
for(;n!==m;){s=a.tR[n]
if(s==null)return!1
if(typeof s=="string"){n=s
continue}r=s[m]
if(r==null)return!1
q=r.length
p=q>0?new Array(q):v.typeUniverse.sEA
for(o=0;o<q;++o)p[o]=A.bH(a,b,r[o])
return A.fH(a,p,null,c,d.y,e)}return A.fH(a,b.y,null,c,d.y,e)},
fH(a,b,c,d,e,f){var s,r=b.length
for(s=0;s<r;++s)if(!A.y(a,b[s],d,e[s],f))return!1
return!0},
j1(a,b,c,d,e){var s,r=b.y,q=d.y,p=r.length
if(p!==q.length)return!1
if(b.x!==d.x)return!1
for(s=0;s<p;++s)if(!A.y(a,r[s],c,q[s],e))return!1
return!0},
aR(a){var s=a.w,r=!0
if(!(a===t.P||a===t.T))if(!A.as(a))if(s!==6)r=s===7&&A.aR(a.x)
return r},
as(a){var s=a.w
return s===2||s===3||s===4||s===5||a===t.X},
fG(a,b){var s,r,q=Object.keys(b),p=q.length
for(s=0;s<p;++s){r=q[s]
a[r]=b[r]}},
e9(a){return a>0?new Array(a):v.typeUniverse.sEA},
W:function W(a,b){var _=this
_.a=a
_.b=b
_.r=_.f=_.d=_.c=null
_.w=0
_.as=_.Q=_.z=_.y=_.x=null},
cz:function cz(){this.c=this.b=this.a=null},
e7:function e7(a){this.a=a},
cy:function cy(){},
bD:function bD(a){this.a=a},
hZ(){var s,r,q
if(self.scheduleImmediate!=null)return A.jn()
if(self.MutationObserver!=null&&self.document!=null){s={}
r=self.document.createElement("div")
q=self.document.createElement("span")
s.a=null
new self.MutationObserver(A.bR(new A.dz(s),1)).observe(r,{childList:true})
return new A.dy(s,r,q)}else if(self.setImmediate!=null)return A.jo()
return A.jp()},
i_(a){self.scheduleImmediate(A.bR(new A.dA(a),0))},
i0(a){self.setImmediate(A.bR(new A.dB(a),0))},
i1(a){A.ic(0,a)},
ic(a,b){var s=new A.e5()
s.bs(a,b)
return s},
bP(a){return new A.cs(new A.k($.h,a.h("k<0>")),a.h("cs<0>"))},
bM(a,b){a.$2(0,null)
b.b=!0
return b.a},
bJ(a,b){A.iB(a,b)},
bL(a,b){b.a7(a)},
bK(a,b){b.aB(A.F(a),A.P(a))},
iB(a,b){var s,r,q=new A.ed(b),p=new A.ee(b)
if(a instanceof A.k)a.b9(q,p,t.z)
else{s=t.z
if(a instanceof A.k)a.aS(q,p,s)
else{r=new A.k($.h,t.aY)
r.a=8
r.c=a
r.b9(q,p,s)}}},
bQ(a){var s=function(b,c){return function(d,e){while(true){try{b(d,e)
break}catch(r){e=r
d=c}}}}(a,1)
return $.h.aa(new A.eh(s))},
cO(a){var s
if(t.C.b(a)){s=a.ga_()
if(s!=null)return s}return B.e},
hz(a,b){var s,r,q,p,o,n,m,l,k,j,i,h={},g=null,f=!1,e=new A.k($.h,b.h("k<i<0>>"))
h.a=null
h.b=0
h.c=h.d=null
s=new A.cY(h,g,f,e)
try{for(n=t.P,m=0,l=0;m<4;++m){r=a[m]
q=l
r.aS(new A.cX(h,q,e,b,g,f),s,n)
l=++h.b}if(l===0){n=e
n.a3(A.u([],b.h("o<0>")))
return n}h.a=A.dg(l,null,!1,b.h("0?"))}catch(k){p=A.F(k)
o=A.P(k)
if(h.b===0||f){n=e
l=p
j=o
i=A.fL(l,j)
l=new A.B(l,j==null?A.cO(l):j)
n.a1(l)
return n}else{h.d=p
h.c=o}}return e},
fL(a,b){if($.h===B.d)return null
return null},
fM(a,b){if($.h!==B.d)A.fL(a,b)
if(b==null)if(t.C.b(a)){b=a.ga_()
if(b==null){A.fm(a,B.e)
b=B.e}}else b=B.e
else if(t.C.b(a))A.fm(a,b)
return new A.B(a,b)},
eK(a,b){var s=new A.k($.h,b.h("k<0>"))
s.a=8
s.c=a
return s},
eL(a,b,c){var s,r,q,p={},o=p.a=a
for(;s=o.a,(s&4)!==0;){o=o.c
p.a=o}if(o===b){s=A.hX()
b.a1(new A.B(new A.Z(!0,o,null,"Cannot complete a future with itself"),s))
return}r=b.a&1
s=o.a=s|r
if((s&24)===0){q=b.c
b.a=b.a&1|4
b.c=o
o.b6(q)
return}if(!c)if(b.c==null)o=(s&16)===0||r!==0
else o=!1
else o=!0
if(o){q=b.W()
b.a2(p.a)
A.ao(b,q)
return}b.a^=2
A.aM(null,null,b.b,new A.dM(p,b))},
ao(a,b){var s,r,q,p,o,n,m,l,k,j,i,h,g={},f=g.a=a
for(;!0;){s={}
r=f.a
q=(r&16)===0
p=!q
if(b==null){if(p&&(r&1)===0){f=f.c
A.aL(f.a,f.b)}return}s.a=b
o=b.a
for(f=b;o!=null;f=o,o=n){f.a=null
A.ao(g.a,f)
s.a=o
n=o.a}r=g.a
m=r.c
s.b=p
s.c=m
if(q){l=f.c
l=(l&1)!==0||(l&15)===8}else l=!0
if(l){k=f.b.b
if(p){r=r.b===k
r=!(r||r)}else r=!1
if(r){A.aL(m.a,m.b)
return}j=$.h
if(j!==k)$.h=k
else j=null
f=f.c
if((f&15)===8)new A.dQ(s,g,p).$0()
else if(q){if((f&1)!==0)new A.dP(s,m).$0()}else if((f&2)!==0)new A.dO(g,s).$0()
if(j!=null)$.h=j
f=s.c
if(f instanceof A.k){r=s.a.$ti
r=r.h("V<2>").b(f)||!r.y[1].b(f)}else r=!1
if(r){i=s.a.b
if((f.a&24)!==0){h=i.c
i.c=null
b=i.a5(h)
i.a=f.a&30|i.a&1
i.c=f.c
g.a=f
continue}else A.eL(f,i,!0)
return}}i=s.a.b
h=i.c
i.c=null
b=i.a5(h)
f=s.b
r=s.c
if(!f){i.a=8
i.c=r}else{i.a=i.a&1|16
i.c=r}g.a=i
f=i}},
jc(a,b){if(t.Q.b(a))return b.aa(a)
if(t.v.b(a))return a
throw A.c(A.f9(a,"onError",u.c))},
j6(){var s,r
for(s=$.aK;s!=null;s=$.aK){$.bO=null
r=s.b
$.aK=r
if(r==null)$.bN=null
s.a.$0()}},
jg(){$.eR=!0
try{A.j6()}finally{$.bO=null
$.eR=!1
if($.aK!=null)$.f3().$1(A.h_())}},
fY(a){var s=new A.ct(a),r=$.bN
if(r==null){$.aK=$.bN=s
if(!$.eR)$.f3().$1(A.h_())}else $.bN=r.b=s},
jd(a){var s,r,q,p=$.aK
if(p==null){A.fY(a)
$.bO=$.bN
return}s=new A.ct(a)
r=$.bO
if(r==null){s.b=p
$.aK=$.bO=s}else{q=r.b
s.b=q
$.bO=r.b=s
if(q==null)$.bN=s}},
h8(a){var s=null,r=$.h
if(B.d===r){A.aM(s,s,B.d,a)
return}A.aM(s,s,r,r.bb(a))},
jX(a,b){A.el(a,"stream",t.K)
return new A.cI(b.h("cI<0>"))},
fo(a){return new A.bo(null,null,a.h("bo<0>"))},
fX(a){return},
fs(a,b){return b==null?A.jq():b},
ft(a,b){if(b==null)b=A.js()
if(t.k.b(b))return a.aa(b)
if(t.u.b(b))return b
throw A.c(A.H(u.h,null))},
j7(a){},
j9(a,b){A.aL(a,b)},
j8(){},
aL(a,b){A.jd(new A.eg(a,b))},
fT(a,b,c,d){var s,r=$.h
if(r===c)return d.$0()
$.h=c
s=r
try{r=d.$0()
return r}finally{$.h=s}},
fV(a,b,c,d,e){var s,r=$.h
if(r===c)return d.$1(e)
$.h=c
s=r
try{r=d.$1(e)
return r}finally{$.h=s}},
fU(a,b,c,d,e,f){var s,r=$.h
if(r===c)return d.$2(e,f)
$.h=c
s=r
try{r=d.$2(e,f)
return r}finally{$.h=s}},
aM(a,b,c,d){if(B.d!==c){d=c.bb(d)
d=d}A.fY(d)},
dz:function dz(a){this.a=a},
dy:function dy(a,b,c){this.a=a
this.b=b
this.c=c},
dA:function dA(a){this.a=a},
dB:function dB(a){this.a=a},
e5:function e5(){},
e6:function e6(a,b){this.a=a
this.b=b},
cs:function cs(a,b){this.a=a
this.b=!1
this.$ti=b},
ed:function ed(a){this.a=a},
ee:function ee(a){this.a=a},
eh:function eh(a){this.a=a},
B:function B(a,b){this.a=a
this.b=b},
a9:function a9(a,b){this.a=a
this.$ti=b},
aG:function aG(a,b,c,d,e,f,g){var _=this
_.ay=0
_.CW=_.ch=null
_.w=a
_.a=b
_.b=c
_.c=d
_.d=e
_.e=f
_.r=_.f=null
_.$ti=g},
cu:function cu(){},
bo:function bo(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.r=_.e=_.d=null
_.$ti=c},
cY:function cY(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=d},
cX:function cX(a,b,c,d,e,f){var _=this
_.a=a
_.b=b
_.c=c
_.d=d
_.e=e
_.f=f},
cv:function cv(){},
an:function an(a,b){this.a=a
this.$ti=b},
aH:function aH(a,b,c,d,e){var _=this
_.a=null
_.b=a
_.c=b
_.d=c
_.e=d
_.$ti=e},
k:function k(a,b){var _=this
_.a=0
_.b=a
_.c=null
_.$ti=b},
dJ:function dJ(a,b){this.a=a
this.b=b},
dN:function dN(a,b){this.a=a
this.b=b},
dM:function dM(a,b){this.a=a
this.b=b},
dL:function dL(a,b){this.a=a
this.b=b},
dK:function dK(a,b){this.a=a
this.b=b},
dQ:function dQ(a,b,c){this.a=a
this.b=b
this.c=c},
dR:function dR(a,b){this.a=a
this.b=b},
dS:function dS(a){this.a=a},
dP:function dP(a,b){this.a=a
this.b=b},
dO:function dO(a,b){this.a=a
this.b=b},
ct:function ct(a){this.a=a
this.b=null},
X:function X(){},
dm:function dm(a,b){this.a=a
this.b=b},
dn:function dn(a,b){this.a=a
this.b=b},
bq:function bq(){},
br:function br(){},
bp:function bp(){},
dD:function dD(a,b,c){this.a=a
this.b=b
this.c=c},
dC:function dC(a){this.a=a},
aJ:function aJ(){},
cx:function cx(){},
cw:function cw(a,b){this.b=a
this.a=null
this.$ti=b},
dG:function dG(a,b){this.b=a
this.c=b
this.a=null},
dF:function dF(){},
cG:function cG(a){var _=this
_.a=0
_.c=_.b=null
_.$ti=a},
e0:function e0(a,b){this.a=a
this.b=b},
bs:function bs(a,b){var _=this
_.a=1
_.b=a
_.c=null
_.$ti=b},
cI:function cI(a){this.$ti=a},
ea:function ea(){},
eg:function eg(a,b){this.a=a
this.b=b},
e3:function e3(){},
e4:function e4(a,b){this.a=a
this.b=b},
fv(a,b){var s=a[b]
return s===a?null:s},
eN(a,b,c){if(c==null)a[b]=a
else a[b]=c},
eM(){var s=Object.create(null)
A.eN(s,"<non-identifier-key>",s)
delete s["<non-identifier-key>"]
return s},
v(a,b,c){return A.jy(a,new A.ah(b.h("@<0>").D(c).h("ah<1,2>")))},
eF(a,b){return new A.ah(a.h("@<0>").D(b).h("ah<1,2>"))},
eG(a){var s,r
if(A.f_(a))return"{...}"
s=new A.bl("")
try{r={}
$.at.push(a)
s.a+="{"
r.a=!0
a.K(0,new A.dh(r,s))
s.a+="}"}finally{$.at.pop()}r=s.a
return r.charCodeAt(0)==0?r:r},
bt:function bt(){},
aI:function aI(a){var _=this
_.a=0
_.e=_.d=_.c=_.b=null
_.$ti=a},
bu:function bu(a,b){this.a=a
this.$ti=b},
cA:function cA(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=null
_.$ti=c},
r:function r(){},
L:function L(){},
dh:function dh(a,b){this.a=a
this.b=b},
ja(a,b){var s,r,q,p=null
try{p=JSON.parse(a)}catch(r){s=A.F(r)
q=String(s)
throw A.c(new A.cW(q))}q=A.ef(p)
return q},
ef(a){var s
if(a==null)return null
if(typeof a!="object")return a
if(!Array.isArray(a))return new A.cD(a,Object.create(null))
for(s=0;s<a.length;++s)a[s]=A.ef(a[s])
return a},
fi(a,b,c){return new A.ba(a,b)},
iH(a){return a.ac()},
i4(a,b){return new A.dY(a,[],A.jv())},
i5(a,b,c){var s,r=new A.bl(""),q=A.i4(r,b)
q.ad(a)
s=r.a
return s.charCodeAt(0)==0?s:s},
cD:function cD(a,b){this.a=a
this.b=b
this.c=null},
cE:function cE(a){this.a=a},
bU:function bU(){},
bW:function bW(){},
ba:function ba(a,b){this.a=a
this.b=b},
ca:function ca(a,b){this.a=a
this.b=b},
dc:function dc(){},
de:function de(a){this.b=a},
dd:function dd(a){this.a=a},
dZ:function dZ(){},
e_:function e_(a,b){this.a=a
this.b=b},
dY:function dY(a,b,c){this.c=a
this.a=b
this.b=c},
hx(a,b){a=A.z(a,new Error())
a.stack=b.i(0)
throw a},
dg(a,b,c,d){var s,r=c?J.hG(a,d):J.hF(a,d)
if(a!==0&&b!=null)for(s=0;s<r.length;++s)r[s]=b
return r},
hJ(a,b,c){var s,r,q=A.u([],c.h("o<0>"))
for(s=a.length,r=0;r<a.length;a.length===s||(0,A.cL)(a),++r)q.push(a[r])
q.$flags=1
return q},
fp(a,b,c){var s=J.f4(b)
if(!s.l())return a
if(c.length===0){do a+=A.j(s.gm())
while(s.l())}else{a+=A.j(s.gm())
for(;s.l();)a=a+c+A.j(s.gm())}return a},
hX(){return A.P(new Error())},
hw(a){var s=Math.abs(a),r=a<0?"-":""
if(s>=1000)return""+a
if(s>=100)return r+"0"+s
if(s>=10)return r+"00"+s
return r+"000"+s},
ff(a){if(a>=100)return""+a
if(a>=10)return"0"+a
return"00"+a},
bY(a){if(a>=10)return""+a
return"0"+a},
bZ(a){if(typeof a=="number"||A.cJ(a)||a==null)return J.au(a)
if(typeof a=="string")return JSON.stringify(a)
return A.fl(a)},
hy(a,b){A.el(a,"error",t.K)
A.el(b,"stackTrace",t.l)
A.hx(a,b)},
bT(a){return new A.bS(a)},
H(a,b){return new A.Z(!1,null,b,a)},
f9(a,b,c){return new A.Z(!0,a,b,c)},
hT(a){var s=null
return new A.aE(s,s,!1,s,s,a)},
bi(a,b,c,d,e){return new A.aE(b,c,!0,a,d,"Invalid value")},
hV(a,b,c){if(0>a||a>c)throw A.c(A.bi(a,0,c,"start",null))
if(b!=null){if(a>b||b>c)throw A.c(A.bi(b,a,c,"end",null))
return b}return c},
hU(a,b){if(a<0)throw A.c(A.bi(a,0,null,b,null))
return a},
fg(a,b,c,d){return new A.c3(b,!0,a,d,"Index out of range")},
dx(a){return new A.bn(a)},
bm(a){return new A.cq(a)},
eJ(a){return new A.al(a)},
ag(a){return new A.bV(a)},
hE(a,b,c){var s,r
if(A.f_(a)){if(b==="("&&c===")")return"(...)"
return b+"..."+c}s=A.u([],t.s)
$.at.push(a)
try{A.j5(a,s)}finally{$.at.pop()}r=A.fp(b,s,", ")+c
return r.charCodeAt(0)==0?r:r},
fh(a,b,c){var s,r
if(A.f_(a))return b+"..."+c
s=new A.bl(b)
$.at.push(a)
try{r=s
r.a=A.fp(r.a,a,", ")}finally{$.at.pop()}s.a+=c
r=s.a
return r.charCodeAt(0)==0?r:r},
j5(a,b){var s,r,q,p,o,n,m,l=a.gn(a),k=0,j=0
while(!0){if(!(k<80||j<3))break
if(!l.l())return
s=A.j(l.gm())
b.push(s)
k+=s.length+2;++j}if(!l.l()){if(j<=5)return
r=b.pop()
q=b.pop()}else{p=l.gm();++j
if(!l.l()){if(j<=4){b.push(A.j(p))
return}r=A.j(p)
q=b.pop()
k+=r.length+2}else{o=l.gm();++j
for(;l.l();p=o,o=n){n=l.gm();++j
if(j>100){while(!0){if(!(k>75&&j>3))break
k-=b.pop().length+2;--j}b.push("...")
return}}q=A.j(p)
r=A.j(o)
k+=r.length+q.length+4}}if(j>b.length+2){k+=5
m="..."}else m=null
while(!0){if(!(k>80&&b.length>3))break
k-=b.pop().length+2
if(m==null){k+=5
m="..."}}if(m!=null)b.push(m)
b.push(q)
b.push(r)},
eH(a,b,c,d){var s
if(B.f===c){s=J.G(a)
b=J.G(b)
return A.dp(A.a1(A.a1($.cN(),s),b))}if(B.f===d){s=J.G(a)
b=J.G(b)
c=J.G(c)
return A.dp(A.a1(A.a1(A.a1($.cN(),s),b),c))}s=J.G(a)
b=J.G(b)
c=J.G(c)
d=J.G(d)
d=A.dp(A.a1(A.a1(A.a1(A.a1($.cN(),s),b),c),d))
return d},
fj(a){var s,r=$.cN()
for(s=J.f4(a);s.l();)r=A.a1(r,J.G(s.gm()))
return A.dp(r)},
bX:function bX(a,b,c){this.a=a
this.b=b
this.c=c},
dH:function dH(){},
p:function p(){},
bS:function bS(a){this.a=a},
a2:function a2(){},
Z:function Z(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=d},
aE:function aE(a,b,c,d,e,f){var _=this
_.e=a
_.f=b
_.a=c
_.b=d
_.c=e
_.d=f},
c3:function c3(a,b,c,d,e){var _=this
_.f=a
_.a=b
_.b=c
_.c=d
_.d=e},
bn:function bn(a){this.a=a},
cq:function cq(a){this.a=a},
al:function al(a){this.a=a},
bV:function bV(a){this.a=a},
bk:function bk(){},
dI:function dI(a){this.a=a},
cW:function cW(a){this.a=a},
d:function d(){},
E:function E(a,b,c){this.a=a
this.b=b
this.$ti=c},
w:function w(){},
b:function b(){},
bC:function bC(a){this.a=a},
bl:function bl(a){this.a=a},
fK(a){var s
if(typeof a=="function")throw A.c(A.H("Attempting to rewrap a JS function.",null))
s=function(b,c){return function(d){return b(c,d,arguments.length)}}(A.iC,a)
s[$.f1()]=a
return s},
iC(a,b,c){if(c>=1)return a.$1(b)
return a.$0()},
fS(a){return a==null||A.cJ(a)||typeof a=="number"||typeof a=="string"||t.U.b(a)||t.bX.b(a)||t.ca.b(a)||t.O.b(a)||t.c0.b(a)||t.e.b(a)||t.bk.b(a)||t.B.b(a)||t.q.b(a)||t.J.b(a)||t.Y.b(a)},
es(a){if(A.fS(a))return a
return new A.et(new A.aI(t.A)).$1(a)},
jM(a,b){var s=new A.k($.h,b.h("k<0>")),r=new A.an(s,b.h("an<0>"))
a.then(A.bR(new A.ex(r),1),A.bR(new A.ey(r),1))
return s},
fR(a){return a==null||typeof a==="boolean"||typeof a==="number"||typeof a==="string"||a instanceof Int8Array||a instanceof Uint8Array||a instanceof Uint8ClampedArray||a instanceof Int16Array||a instanceof Uint16Array||a instanceof Int32Array||a instanceof Uint32Array||a instanceof Float32Array||a instanceof Float64Array||a instanceof ArrayBuffer||a instanceof DataView},
eV(a){if(A.fR(a))return a
return new A.em(new A.aI(t.A)).$1(a)},
et:function et(a){this.a=a},
ex:function ex(a){this.a=a},
ey:function ey(a){this.a=a},
em:function em(a){this.a=a},
di:function di(a){this.a=a},
dW:function dW(){},
e1:function e1(){this.b=this.a=0},
jt(a){var s=t.N
A.d7(a,!1,!1,new A.ei(),new A.ej(),new A.ek(),s,s)},
iJ(a,b,c,d,e){var s,r,q,p=null,o=t.N,n=t.K,m=e.a.a
m.C(B.c.F(A.v(["progress",40,"message","Generating particle groups..."],o,n),p))
s=A.iR(b,c,d)
m.C(B.c.F(A.v(["progress",50,"message","Filling particles in grid..."],o,n),p))
for(r=s.length,q=0;q<s.length;s.length===r||(0,A.cL)(s),++q)A.iM(a,s[q],s,c,d)
m.C(B.c.F(A.v(["progress",60,"message","Creating liquid bridges..."],o,n),p))
A.iG(a,s,c,d)
m.C(B.c.F(A.v(["progress",70,"message","Applying isolation rules..."],o,n),p))
A.iK(a,c,d)
m.C(B.c.F(A.v(["progress",75,"message","Filling gaps between particles..."],o,n),p))
A.iL(a,c,d)
m.C(B.c.F(A.v(["progress",80,"message","Converting adjacent particles..."],o,n),p))
A.iD(a,c,d)
m.C(B.c.F(A.v(["progress",85,"message","Upgrading surrounded particles..."],o,n),p))
A.jl(a,c,d)
m.C(B.c.F(A.v(["progress",90,"message","Creating diagonal bridges..."],o,n),p))
A.iF(a,c,d)
m.C(B.c.F(A.v(["progress",95,"message","Applying distance-based sizing..."],o,n),p))
A.io(a,c,d)},
iR(b3,b4,b5){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,b0,b1=A.u([],t.W),b2=new A.e1()
b2.br(b3.e)
s=b4*b5
r=B.b.v(B.b.q(s/2200,10,14))
q=B.a.q(B.b.v(r*0.1),0,3)
p=Math.max(10,Math.min(14,r+(b2.c1()?q:-q)))
o=Math.max(1,B.b.a6(Math.sqrt(p)*0.25))
n=B.b.a6(p/o)
m=Math.sqrt(b4*b4+b5*b5)
for(l=b4-1,k=b5-1,j=b4/o,i=b5/n,h=s/35e3,g=m*0.04,f=m*0.12,e=0;e<p;++e){d=B.a.U(e,o)
c=B.a.bo(e,o)
b=B.a.q(B.b.v(d*j+b2.L()*j),0,l)
a=B.a.q(B.b.v(c*i+b2.L()*i),0,k)
a0=B.b.q(Math.pow(Math.sqrt(h),1.25),1,2.5)
a1=B.b.v(B.b.q(4*a0,2,999))
a2=a1+b2.aN(Math.max(1,B.b.v(B.b.q(10*a0,a1,999))-a1+1))
b1.push(new A.bg(b,a,5+b2.aN(8)))
for(a3=f-g,a4=1;a4<a2;++a4){a5=g+b2.L()*a3
a6=1-(a5-g)/a3
a7=(b2.L()-0.5)*3.141592653589793+(b2.L()-0.5)*3.141592653589793*0.06*(0.08*a6)
a8=B.a.q(B.b.v(b+Math.cos(a7)*a5),0,l)
a9=B.a.q(B.b.v(a+Math.sin(a7)*a5),0,k)
b0=2+B.b.v(3*a6)
b1.push(new A.bg(a8,a9,b0+b2.aN(B.a.q(5+B.b.v(7*a6)-b0+1,1,100))))}}return b1},
iM(a4,a5,a6,a7,a8){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0=a5.a,a1=a5.b,a2=a5.c,a3=B.b.v(a2*1.9)
for(s=a7-1,r=B.a.q(a0-a3,0,s),q=a0+a3,p=a1-a3,o=a8-1,n=a1+a3,m=a2*0.5,l=m*m,k=a2*a2;r<=B.a.q(q,0,s);++r)for(j=B.a.q(p,0,o),i=r-a0,h=i*i/l,g=Math.abs(i);j<=B.a.q(n,0,o);++j){f=j-a1
e=Math.sqrt(h+f*f/k)
if(e<=1)d=1
else{d=0
if(e<=1.9)if(B.a.U(r,2)===B.a.U(j,2)){c=0.85-(e-1)/1.4*0.6
if(Math.abs(f)>g)d=c
else d=g<=3?c*0.5:c*0.25}}if(d>0){b=a4[r]
a=J.O(b)
a.B(b,j,Math.max(a.j(b,j),d))}}},
iG(a,b,c,d){var s,r,q,p,o,n,m,l,k
for(s=0;s<b.length;s=r)for(r=s+1,q=r;q<b.length;++q){p=b[s]
o=b[q]
n=p.a-o.a
m=p.b-o.b
l=Math.sqrt(n*n+m*m)
k=Math.abs(m)>Math.abs(n)*2.4
if(l<(p.c+o.c)*1.1&&l>0&&k)A.iE(a,p,o,c,d)}},
iE(b2,b3,b4,b5,b6){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0,a1=b4.a,a2=b3.a,a3=a1-a2,a4=b4.b,a5=b3.b,a6=a4-a5,a7=Math.sqrt(a3*a3+a6*a6),a8=b3.c,a9=b4.c,b0=Math.min(a8,a9)*1.9*B.b.q(1-a7/(a8+a9+5),0.5,1),b1=B.b.v(a7*4)
for(s=-a6/a7,r=a3/a7,a8=b5-1,a9=b6-1,q=0;q<=b1;++q){p=q/b1
o=Math.sin(p*3.141592653589793)*1.4
n=B.b.v(a2+p*a3+s*o)
m=B.b.v(a5+p*a6+r*o)
l=B.b.v(b0*Math.sin((1-Math.abs(p-0.5)*2)*3.141592653589793/2))
if(l>0)for(k=B.a.q(n-l,0,a8),j=n+l,i=m-l,h=m+l;k<=B.a.q(j,0,a8);++k)for(g=B.a.q(i,0,a9),f=k-n,f*=f,e=k-a2,e*=e,d=k-a1,d*=d;g<=B.a.q(h,0,a9);++g){c=g-m
if(Math.sqrt(f+c*c)<=l){c=g-a5
b=g-a4
a=Math.min(Math.sqrt(e+c*c),Math.sqrt(d+b*b))
a0=a<=1?0.97:B.b.q(0.97-(a-1)/2.6*0.7,0.3,0.92)
c=b2[k]
b=J.O(c)
b.B(c,g,Math.max(b.j(c,g),a0))}}}},
iK(a,b,c){var s,r,q,p,o,n,m,l,k,j=J.da(b,t.o)
for(s=t.n,r=c<0,q="Length must be a non-negative integer: "+c,p=0;p<b;++p){if(r)A.S(A.H(q,null))
o=A.u(new Array(c),s)
for(n=0;n<c;++n)o[n]=J.U(a[p],n)
j[p]=o}for(m=0;m<b;++m)for(l=0;l<c;++l){k=j[m][l]
if(k>0&&k<0.99)if(B.a.U(m,2)!==B.a.U(l,2))J.ae(a[m],l,0)}},
iL(a,b,c){var s,r,q,p,o,n,m,l,k,j,i,h,g
for(s=0;s<b;++s)for(r=0;r<c;++r)if(J.U(a[s],r)<0.99){for(q=1;p=!1,o=0,q<=4;++q){n=s-q
if(n>=0){if(J.U(a[n],r)>=0.99){o=q-1
p=!0
break}}else break}for(q=1;m=!1,q<=4;++q){n=s+q
if(n<b){if(J.U(a[n],r)>=0.99){l=o+(q-1)
o=l
m=!0
break}}else break}for(k=1;j=!1,i=0,k<=4;++k){n=r-k
if(n>=0){if(J.U(a[s],n)>=0.99){i=k-1
j=!0
break}}else break}for(k=1;h=!1,k<=4;++k){n=r+k
if(n<c){if(J.U(a[s],n)>=0.99){g=i+(k-1)
i=g
h=!0
break}}else break}if(!(p&&m&&o<=2))n=j&&h&&i<=2
else n=!0
if(n)J.ae(a[s],r,1)}},
iD(a,b,c){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d=J.da(b,t.o)
for(s=t.n,r=c<0,q="Length must be a non-negative integer: "+c,p=0;p<b;++p){if(r)A.S(A.H(q,null))
o=A.u(new Array(c),s)
for(n=0;n<c;++n)o[n]=J.U(a[p],n)
d[p]=o}for(m=0;m<b;m=l)for(s=m-1,l=m+1,k=0;k<c;++k){j=d[m][k]
if(j>0&&j<0.99){i=[new A.x(s,k),new A.x(l,k),new A.x(m,k-1),new A.x(m,k+1)]
g=0
while(!0){if(!(g<4)){h=!1
break}r=i[g]
f=r.a
e=r.b
if(f>=0&&f<b&&e>=0&&e<c)if(d[f][e]>=0.99){h=!0
break}++g}if(h)J.ae(a[m],k,1)}}},
jl(a6,a7,a8){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c="Length must be a non-negative integer: ",b=t.n,a=a8<0,a0=c+a8,a1=t.b,a2=a7<0,a3=c+a7,a4=!0,a5=0
while(!0){if(!(a4&&a5<10))break;++a5
if(a2)A.S(A.H(a3,null))
s=A.u(new Array(a7),a1)
for(r=0;r<a7;++r){if(a)A.S(A.H(a0,null))
q=A.u(new Array(a8),b)
for(p=0;p<a8;++p)q[p]=J.U(a6[r],p)
s[r]=q}for(a4=!1,o=0;o<a7;o=m)for(n=o-1,m=o+1,l=0;l<a8;++l)if(s[o][l]<0.99){k=l-1
j=l+1
i=[new A.x(n,k),new A.x(o,k),new A.x(m,k),new A.x(n,l),new A.x(m,l),new A.x(n,j),new A.x(o,j),new A.x(m,j)]
for(h=0,g=0,f=0;f<8;++f){k=i[f]
e=k.a
d=k.b
if(e>=0&&e<a7&&d>=0&&d<a8){++g
if(s[e][d]>=0.99)++h}}if(g>0&&h===g){J.ae(a6[o],l,1)
a4=!0}}}},
iF(a1,a2,a3){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0
for(s=0;s<a2;s=q)for(r=s-1,q=s+1,p=0;p<a3;++p){o=J.U(a1[s],p)
if(o>0&&o<0.99){n=p-1
m=p+1
l=[new A.x(r,n),new A.x(q,n),new A.x(r,m),new A.x(q,m)]
for(k=0;k<4;++k){n=l[k]
j=n.a
i=n.b
if(j>=0&&j<a2&&i>=0&&i<a3){h=J.U(a1[j],i)
if(h>0&&h<0.99){g=j-s
f=i-p
e=Math.sqrt(g*g+f*f)
if(e<=3.5){d=B.b.v(e*2)
for(c=0;c<=d;++c){b=c/d
a=B.b.v(s+b*g)
a0=B.b.v(p+b*f)
if(a>=0&&a<a2&&a0>=0&&a0<a3){n=a1[a]
m=J.O(n)
m.B(n,a0,Math.max(m.j(n,a0),0.51))}}}}}}}}},
io(a,b,c){var s,r,q,p,o,n,m,l,k,j,i=A.u([],t.w)
for(s=0;s<b;++s)for(r=0;r<c;++r)if(J.U(a[s],r)>=0.99)i.push(new A.x(s,r))
for(s=0;s<b;++s)for(r=0;r<c;++r){q=J.U(a[s],r)
if(q>0&&q<0.99){for(p=i.length,o=1/0,n=0;n<i.length;i.length===p||(0,A.cL)(i),++n){m=i[n]
l=s-m.a
k=r-m.b
o=Math.min(o,Math.sqrt(l*l+k*k))}if(o<=1)j=0.95
else if(o<=2)j=0.8
else if(o<=3)j=0.6
else if(o<=4)j=0.3
else j=o<=6?0.4:0.25
if(B.m.L()<0.5)j*=1-(0.1+B.m.L()*0.4)
j=Math.max(j,0.25)
J.ae(a[s],r,j)}}},
cP:function cP(a,b,c,d,e){var _=this
_.a=a
_.b=b
_.c=c
_.d=d
_.e=e},
cQ:function cQ(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=d},
bg:function bg(a,b,c){this.a=a
this.b=b
this.c=c},
ej:function ej(){},
ek:function ek(){},
ei:function ei(){},
d6:function d6(a,b,c,d,e,f,g,h){var _=this
_.a=a
_.b=b
_.c=c
_.d=d
_.e=e
_.r=$
_.w=f
_.x=g
_.$ti=h},
aw:function aw(a,b,c,d,e,f,g){var _=this
_.a=a
_.b=b
_.c=c
_.e=d
_.f=e
_.r=f
_.$ti=g},
c5:function c5(a){this.b=a},
b3:function b3(a){this.b=a},
Q:function Q(a,b){this.a=a
this.$ti=b},
i3(a,b,c,d){var s=new A.cC(a,A.fo(d),c.h("@<0>").D(d).h("cC<1,2>"))
s.bq(a,b,c,d)
return s},
b2:function b2(a,b){this.a=a
this.$ti=b},
cC:function cC(a,b,c){this.a=a
this.c=b
this.$ti=c},
dV:function dV(a,b){this.a=a
this.b=b},
cB:function cB(){},
d7(a,b,c,d,e,f,g,h){return A.hD(a,!1,!1,d,e,f,g,h)},
hD(a,b,c,d,e,f,g,h){var s=0,r=A.bP(t.H),q,p,o
var $async$d7=A.bQ(function(i,j){if(i===1)return A.bK(j,r)
while(true)switch(s){case 0:p={}
o=A.i2()
p.a=null
q=new A.d8(p,d,o)
q=J.ez(a)===B.q?A.i3(a,q,g,h):A.hA(a,A.h3(A.h0(),g),!1,q,A.h3(A.h0(),g),g,h)
o.b=new A.Q(new A.b2(q,g.h("@<0>").D(h).h("b2<1,2>")),g.h("@<0>").D(h).h("Q<1,2>"))
q=f.$1(o.P())
s=2
return A.bJ(q instanceof A.k?q:A.eK(q,t.H),$async$d7)
case 2:p.a=o.P().a.a.gaO().bf(new A.d9(e,o,!1,!1,h,g))
o.P().a.a.aE()
return A.bL(null,r)}})
return A.bM($async$d7,r)},
d8:function d8(a,b,c){this.a=a
this.b=b
this.c=c},
d9:function d9(a,b,c,d,e,f){var _=this
_.a=a
_.b=b
_.c=c
_.d=d
_.e=e
_.f=f},
d0:function d0(){},
eC(a,b,c){return new A.I(c,a,b)},
hB(a){var s,r,q,p=A.ec(a.j(0,"name")),o=t.G.a(a.j(0,"value")),n=o.j(0,"e")
if(n==null)n=A.eb(n)
s=new A.bC(A.ec(o.j(0,"s")))
for(r=0;r<2;++r){q=$.hC[r].$2(n,s)
if(q.gaM()===p)return q}return new A.I("",n,s)},
hY(a,b){return new A.am("",a,b)},
fr(a,b){return new A.am("",a,b)},
I:function I(a,b,c){this.a=a
this.b=b
this.c=c},
am:function am(a,b,c){this.a=a
this.b=b
this.c=c},
c2(a,b){var s
$label0$0:{if(b.b(a)){s=a
break $label0$0}if(typeof a=="number"){s=new A.c0(a)
break $label0$0}if(typeof a=="string"){s=new A.c1(a)
break $label0$0}if(A.cJ(a)){s=new A.c_(a)
break $label0$0}if(t.R.b(a)){s=new A.b_(J.f7(a,new A.cZ(),t.f),B.F)
break $label0$0}if(t.G.b(a)){s=t.f
s=new A.b0(a.aL(0,new A.d_(),s,s),B.G)
break $label0$0}s=A.S(A.hY("Unsupported type "+J.ez(a).i(0)+" when wrapping an IsolateType",B.e))}return b.a(s)},
m:function m(){},
cZ:function cZ(){},
d_:function d_(){},
c0:function c0(a){this.a=a},
c1:function c1(a){this.a=a},
c_:function c_(a){this.a=a},
b_:function b_(a,b){this.b=a
this.a=b},
b0:function b0(a,b){this.b=a
this.a=b},
a4:function a4(){},
dT:function dT(a){this.a=a},
D:function D(){},
dU:function dU(a){this.a=a},
jK(){A.jt(v.G.self)},
hA(a,b,c,d,e,f,g){var s,r,q
if(t.j.b(a))t.r.a(J.f5(a)).gaC()
s=$.h
r=t.j.b(a)
q=r?t.r.a(J.f5(a)).gaC():a
if(r)J.ho(a)
s=new A.aw(q,d,e,A.fo(f),!1,new A.an(new A.k(s,t.D),t.h),f.h("@<0>").D(g).h("aw<1,2>"))
q.onmessage=A.fK(s.gbC())
return s},
eU(a,b,c,d){var s=b==null?null:b.$1(a)
return s==null?d.a(a):s}},B={}
var w=[A,J,B]
var $={}
A.eD.prototype={}
J.c4.prototype={
E(a,b){return a===b},
gt(a){return A.bh(a)},
i(a){return"Instance of '"+A.co(a)+"'"},
gp(a){return A.N(A.eQ(this))}}
J.c7.prototype={
i(a){return String(a)},
gt(a){return a?519018:218159},
gp(a){return A.N(t.y)},
$in:1,
$iaq:1}
J.b6.prototype={
E(a,b){return null==b},
i(a){return"null"},
gt(a){return 0},
gp(a){return A.N(t.P)},
$in:1,
$iw:1}
J.b8.prototype={$iq:1}
J.a8.prototype={
gt(a){return 0},
gp(a){return B.q},
i(a){return String(a)}}
J.cn.prototype={}
J.aF.prototype={}
J.a7.prototype={
i(a){var s=a[$.f1()]
if(s==null)return this.bn(a)
return"JavaScript function for "+J.au(s)}}
J.b7.prototype={
gt(a){return 0},
i(a){return String(a)}}
J.b9.prototype={
gt(a){return 0},
i(a){return String(a)}}
J.o.prototype={
N(a,b){a.$flags&1&&A.cM(a,29)
a.push(b)},
bR(a,b){var s
a.$flags&1&&A.cM(a,"addAll",2)
for(s=b.gn(b);s.l();)a.push(s.gm())},
Y(a,b,c){return new A.a0(a,b,A.bI(a).h("@<1>").D(c).h("a0<1,2>"))},
c_(a,b){var s,r=A.dg(a.length,"",!1,t.N)
for(s=0;s<a.length;++s)r[s]=A.j(a[s])
return r.join(b)},
O(a,b){return a[b]},
gaD(a){if(a.length>0)return a[0]
throw A.c(A.b4())},
gaK(a){var s=a.length
if(s>0)return a[s-1]
throw A.c(A.b4())},
gu(a){return a.length===0},
gaJ(a){return a.length!==0},
i(a){return A.fh(a,"[","]")},
gn(a){return new J.av(a,a.length,A.bI(a).h("av<1>"))},
gt(a){return A.bh(a)},
gk(a){return a.length},
j(a,b){if(!(b>=0&&b<a.length))throw A.c(A.eW(a,b))
return a[b]},
B(a,b,c){a.$flags&2&&A.cM(a)
if(!(b>=0&&b<a.length))throw A.c(A.eW(a,b))
a[b]=c},
gp(a){return A.N(A.bI(a))},
$ie:1,
$id:1,
$ii:1}
J.c6.prototype={
c9(a){var s,r,q
if(!Array.isArray(a))return null
s=a.$flags|0
if((s&4)!==0)r="const, "
else if((s&2)!==0)r="unmodifiable, "
else r=(s&1)!==0?"fixed, ":""
q="Instance of '"+A.co(a)+"'"
if(r==="")return q
return q+" ("+r+"length: "+a.length+")"}}
J.db.prototype={}
J.av.prototype={
gm(){var s=this.d
return s==null?this.$ti.c.a(s):s},
l(){var s,r=this,q=r.a,p=q.length
if(r.b!==p)throw A.c(A.cL(q))
s=r.c
if(s>=p){r.d=null
return!1}r.d=q[s]
r.c=s+1
return!0}}
J.ax.prototype={
aA(a,b){var s
if(a<b)return-1
else if(a>b)return 1
else if(a===b){if(a===0){s=this.gaI(b)
if(this.gaI(a)===s)return 0
if(this.gaI(a))return-1
return 1}return 0}else if(isNaN(a)){if(isNaN(b))return 0
return 1}else return-1},
gaI(a){return a===0?1/a<0:a<0},
a6(a){var s,r
if(a>=0){if(a<=2147483647){s=a|0
return a===s?s:s+1}}else if(a>=-2147483648)return a|0
r=Math.ceil(a)
if(isFinite(r))return r
throw A.c(A.dx(""+a+".ceil()"))},
v(a){if(a>0){if(a!==1/0)return Math.round(a)}else if(a>-1/0)return 0-Math.round(0-a)
throw A.c(A.dx(""+a+".round()"))},
q(a,b,c){if(this.aA(b,c)>0)throw A.c(A.jm(b))
if(this.aA(a,b)<0)return b
if(this.aA(a,c)>0)return c
return a},
bj(a){return a},
i(a){if(a===0&&1/a<0)return"-0.0"
else return""+a},
gt(a){var s,r,q,p,o=a|0
if(a===o)return o&536870911
s=Math.abs(a)
r=Math.log(s)/0.6931471805599453|0
q=Math.pow(2,r)
p=s<1?s/q:q/s
return((p*9007199254740992|0)+(p*3542243181176521|0))*599197+r*1259&536870911},
U(a,b){var s=a%b
if(s===0)return 0
if(s>0)return s
if(b<0)return s-b
else return s+b},
bo(a,b){if((a|0)===a)if(b>=1||b<-1)return a/b|0
return this.b8(a,b)},
J(a,b){return(a|0)===a?a/b|0:this.b8(a,b)},
b8(a,b){var s=a/b
if(s>=-2147483648&&s<=2147483647)return s|0
if(s>0){if(s!==1/0)return Math.floor(s)}else if(s>-1/0)return Math.ceil(s)
throw A.c(A.dx("Result of truncating division is "+A.j(s)+": "+A.j(a)+" ~/ "+b))},
b7(a,b){var s
if(a>0)s=this.bO(a,b)
else{s=b>31?31:b
s=a>>s>>>0}return s},
bO(a,b){return b>31?0:a>>>b},
gp(a){return A.N(t.p)},
$il:1,
$ia6:1}
J.b5.prototype={
gp(a){return A.N(t.S)},
$in:1,
$ia:1}
J.c8.prototype={
gp(a){return A.N(t.i)},
$in:1}
J.ay.prototype={
a0(a,b,c){return a.substring(b,A.hV(b,c,a.length))},
i(a){return a},
gt(a){var s,r,q
for(s=a.length,r=0,q=0;q<s;++q){r=r+a.charCodeAt(q)&536870911
r=r+((r&524287)<<10)&536870911
r^=r>>6}r=r+((r&67108863)<<3)&536870911
r^=r>>11
return r+((r&16383)<<15)&536870911},
gp(a){return A.N(t.N)},
gk(a){return a.length},
$in:1,
$if:1}
A.aT.prototype={
S(a,b,c,d){var s=this.a.bg(null,b,c),r=new A.aU(s,$.h,this.$ti.h("aU<1,2>"))
s.a8(r.gbG())
r.a8(a)
r.a9(d)
return r},
bf(a){return this.S(a,null,null,null)},
bg(a,b,c){return this.S(a,b,c,null)}}
A.aU.prototype={
X(){return this.a.X()},
a8(a){this.c=a==null?null:a},
a9(a){var s=this
s.a.a9(a)
if(a==null)s.d=null
else if(t.k.b(a))s.d=s.b.aa(a)
else if(t.u.b(a))s.d=a
else throw A.c(A.H(u.h,null))},
bH(a){var s,r,q,p,o,n=this,m=n.c
if(m==null)return
s=null
try{s=n.$ti.y[1].a(a)}catch(o){r=A.F(o)
q=A.P(o)
p=n.d
if(p==null)A.aL(r,q)
else{m=n.b
if(t.k.b(p))m.bi(p,r,q)
else m.ab(t.u.a(p),r)}return}n.b.ab(m,s)}}
A.az.prototype={
i(a){return"LateInitializationError: "+this.a}}
A.ev.prototype={
$0(){var s=new A.k($.h,t.D)
s.V(null)
return s},
$S:4}
A.dk.prototype={}
A.e.prototype={}
A.a_.prototype={
gn(a){var s=this
return new A.aA(s,s.gk(s),A.t(s).h("aA<a_.E>"))},
gu(a){return this.gk(this)===0},
Y(a,b,c){return new A.a0(this,b,A.t(this).h("@<a_.E>").D(c).h("a0<1,2>"))}}
A.aA.prototype={
gm(){var s=this.d
return s==null?this.$ti.c.a(s):s},
l(){var s,r=this,q=r.a,p=J.h1(q),o=p.gk(q)
if(r.b!==o)throw A.c(A.ag(q))
s=r.c
if(s>=o){r.d=null
return!1}r.d=p.O(q,s);++r.c
return!0}}
A.ak.prototype={
gn(a){var s=this.a
return new A.cd(s.gn(s),this.b,A.t(this).h("cd<1,2>"))},
gk(a){var s=this.a
return s.gk(s)},
gu(a){var s=this.a
return s.gu(s)}}
A.aX.prototype={$ie:1}
A.cd.prototype={
l(){var s=this,r=s.b
if(r.l()){s.a=s.c.$1(r.gm())
return!0}s.a=null
return!1},
gm(){var s=this.a
return s==null?this.$ti.y[1].a(s):s}}
A.a0.prototype={
gk(a){return J.f6(this.a)},
O(a,b){return this.b.$1(J.hn(this.a,b))}}
A.aZ.prototype={}
A.x.prototype={$r:"+(1,2)",$s:1}
A.aV.prototype={
gu(a){return this.gk(this)===0},
i(a){return A.eG(this)},
aL(a,b,c,d){var s=A.eF(c,d)
this.K(0,new A.cT(this,b,s))
return s},
$iK:1}
A.cT.prototype={
$2(a,b){var s=this.b.$2(a,b)
this.c.B(0,s.a,s.b)},
$S(){return A.t(this.a).h("~(1,2)")}}
A.aW.prototype={
gk(a){return this.b.length},
gb3(){var s=this.$keys
if(s==null){s=Object.keys(this.a)
this.$keys=s}return s},
R(a){if(typeof a!="string")return!1
if("__proto__"===a)return!1
return this.a.hasOwnProperty(a)},
j(a,b){if(!this.R(b))return null
return this.b[this.a[b]]},
K(a,b){var s,r,q=this.gb3(),p=this.b
for(s=q.length,r=0;r<s;++r)b.$2(q[r],p[r])},
gG(){return new A.bv(this.gb3(),this.$ti.h("bv<1>"))}}
A.bv.prototype={
gk(a){return this.a.length},
gu(a){return 0===this.a.length},
gn(a){var s=this.a
return new A.cF(s,s.length,this.$ti.h("cF<1>"))}}
A.cF.prototype={
gm(){var s=this.d
return s==null?this.$ti.c.a(s):s},
l(){var s=this,r=s.c
if(r>=s.b){s.d=null
return!1}s.d=s.a[r]
s.c=r+1
return!0}}
A.d1.prototype={
bp(a){if(false)A.h4(0,0)},
E(a,b){if(b==null)return!1
return b instanceof A.b1&&this.a.E(0,b.a)&&A.eY(this)===A.eY(b)},
gt(a){return A.eH(this.a,A.eY(this),B.f,B.f)},
i(a){var s=B.o.c_([A.N(this.$ti.c)],", ")
return this.a.i(0)+" with "+("<"+s+">")}}
A.b1.prototype={
$1(a){return this.a.$1$1(a,this.$ti.y[0])},
$S(){return A.h4(A.cK(this.a),this.$ti)}}
A.bj.prototype={}
A.dr.prototype={
H(a){var s,r,q=this,p=new RegExp(q.a).exec(a)
if(p==null)return null
s=Object.create(null)
r=q.b
if(r!==-1)s.arguments=p[r+1]
r=q.c
if(r!==-1)s.argumentsExpr=p[r+1]
r=q.d
if(r!==-1)s.expr=p[r+1]
r=q.e
if(r!==-1)s.method=p[r+1]
r=q.f
if(r!==-1)s.receiver=p[r+1]
return s}}
A.bf.prototype={
i(a){return"Null check operator used on a null value"}}
A.c9.prototype={
i(a){var s,r=this,q="NoSuchMethodError: method not found: '",p=r.b
if(p==null)return"NoSuchMethodError: "+r.a
s=r.c
if(s==null)return q+p+"' ("+r.a+")"
return q+p+"' on '"+s+"' ("+r.a+")"}}
A.cr.prototype={
i(a){var s=this.a
return s.length===0?"Error":"Error: "+s}}
A.dj.prototype={
i(a){return"Throw of null ('"+(this.a===null?"null":"undefined")+"' from JavaScript)"}}
A.aY.prototype={}
A.bB.prototype={
i(a){var s,r=this.b
if(r!=null)return r
r=this.a
s=r!==null&&typeof r==="object"?r.stack:null
return this.b=s==null?"":s},
$iC:1}
A.af.prototype={
i(a){var s=this.constructor,r=s==null?null:s.name
return"Closure '"+A.h9(r==null?"unknown":r)+"'"},
gp(a){var s=A.cK(this)
return A.N(s==null?A.ac(this):s)},
gcc(){return this},
$C:"$1",
$R:1,
$D:null}
A.cR.prototype={$C:"$0",$R:0}
A.cS.prototype={$C:"$2",$R:2}
A.dq.prototype={}
A.dl.prototype={
i(a){var s=this.$static_name
if(s==null)return"Closure of unknown static method"
return"Closure '"+A.h9(s)+"'"}}
A.aS.prototype={
E(a,b){if(b==null)return!1
if(this===b)return!0
if(!(b instanceof A.aS))return!1
return this.$_target===b.$_target&&this.a===b.a},
gt(a){return(A.ew(this.a)^A.bh(this.$_target))>>>0},
i(a){return"Closure '"+this.$_name+"' of "+("Instance of '"+A.co(this.a)+"'")}}
A.cp.prototype={
i(a){return"RuntimeError: "+this.a}}
A.ah.prototype={
gk(a){return this.a},
gu(a){return this.a===0},
gG(){return new A.aj(this,A.t(this).h("aj<1>"))},
R(a){var s=this.bY(a)
return s},
bY(a){var s=this.d
if(s==null)return!1
return this.aG(s[this.aF(a)],a)>=0},
j(a,b){var s,r,q,p,o=null
if(typeof b=="string"){s=this.b
if(s==null)return o
r=s[b]
q=r==null?o:r.b
return q}else if(typeof b=="number"&&(b&0x3fffffff)===b){p=this.c
if(p==null)return o
r=p[b]
q=r==null?o:r.b
return q}else return this.bZ(b)},
bZ(a){var s,r,q=this.d
if(q==null)return null
s=q[this.aF(a)]
r=this.aG(s,a)
if(r<0)return null
return s[r].b},
B(a,b,c){var s,r,q,p,o,n,m=this
if(typeof b=="string"){s=m.b
m.aV(s==null?m.b=m.ao():s,b,c)}else if(typeof b=="number"&&(b&0x3fffffff)===b){r=m.c
m.aV(r==null?m.c=m.ao():r,b,c)}else{q=m.d
if(q==null)q=m.d=m.ao()
p=m.aF(b)
o=q[p]
if(o==null)q[p]=[m.ap(b,c)]
else{n=m.aG(o,b)
if(n>=0)o[n].b=c
else o.push(m.ap(b,c))}}},
K(a,b){var s=this,r=s.e,q=s.r
for(;r!=null;){b.$2(r.a,r.b)
if(q!==s.r)throw A.c(A.ag(s))
r=r.c}},
aV(a,b,c){var s=a[b]
if(s==null)a[b]=this.ap(b,c)
else s.b=c},
ap(a,b){var s=this,r=new A.df(a,b)
if(s.e==null)s.e=s.f=r
else s.f=s.f.c=r;++s.a
s.r=s.r+1&1073741823
return r},
aF(a){return J.G(a)&1073741823},
aG(a,b){var s,r
if(a==null)return-1
s=a.length
for(r=0;r<s;++r)if(J.Y(a[r].a,b))return r
return-1},
i(a){return A.eG(this)},
ao(){var s=Object.create(null)
s["<non-identifier-key>"]=s
delete s["<non-identifier-key>"]
return s}}
A.df.prototype={}
A.aj.prototype={
gk(a){return this.a.a},
gu(a){return this.a.a===0},
gn(a){var s=this.a
return new A.cc(s,s.r,s.e,this.$ti.h("cc<1>"))}}
A.cc.prototype={
gm(){return this.d},
l(){var s,r=this,q=r.a
if(r.b!==q.r)throw A.c(A.ag(q))
s=r.c
if(s==null){r.d=null
return!1}else{r.d=s.a
r.c=s.c
return!0}}}
A.ai.prototype={
gk(a){return this.a.a},
gu(a){return this.a.a===0},
gn(a){var s=this.a
return new A.cb(s,s.r,s.e,this.$ti.h("cb<1,2>"))}}
A.cb.prototype={
gm(){var s=this.d
s.toString
return s},
l(){var s,r=this,q=r.a
if(r.b!==q.r)throw A.c(A.ag(q))
s=r.c
if(s==null){r.d=null
return!1}else{r.d=new A.E(s.a,s.b,r.$ti.h("E<1,2>"))
r.c=s.c
return!0}}}
A.eo.prototype={
$1(a){return this.a(a)},
$S:5}
A.ep.prototype={
$2(a,b){return this.a(a,b)},
$S:11}
A.eq.prototype={
$1(a){return this.a(a)},
$S:12}
A.bA.prototype={
gp(a){return A.N(this.b2())},
b2(){return A.jx(this.$r,this.b1())},
i(a){return this.ba(!1)},
ba(a){var s,r,q,p,o,n=this.bA(),m=this.b1(),l=(a?"Record ":"")+"("
for(s=n.length,r="",q=0;q<s;++q,r=", "){l+=r
p=n[q]
if(typeof p=="string")l=l+p+": "
o=m[q]
l=a?l+A.fl(o):l+A.j(o)}l+=")"
return l.charCodeAt(0)==0?l:l},
bA(){var s,r=this.$s
for(;$.e2.length<=r;)$.e2.push(null)
s=$.e2[r]
if(s==null){s=this.by()
$.e2[r]=s}return s},
by(){var s,r,q,p=this.$r,o=p.indexOf("("),n=p.substring(1,o),m=p.substring(o),l=m==="()"?0:m.replace(/[^,]/g,"").length+1,k=t.K,j=J.da(l,k)
for(s=0;s<l;++s)j[s]=s
if(n!==""){r=n.split(",")
s=r.length
for(q=l;s>0;){--q;--s
j[q]=r[s]}}j=A.hJ(j,!1,k)
j.$flags=3
return j}}
A.cH.prototype={
b1(){return[this.a,this.b]},
E(a,b){if(b==null)return!1
return b instanceof A.cH&&this.$s===b.$s&&J.Y(this.a,b.a)&&J.Y(this.b,b.b)},
gt(a){return A.eH(this.$s,this.a,this.b,B.f)}}
A.dE.prototype={
P(){var s=this.b
if(s===this)throw A.c(new A.az("Local '' has not been initialized."))
return s}}
A.aB.prototype={
gp(a){return B.I},
$in:1,
$ieA:1}
A.bd.prototype={}
A.ce.prototype={
gp(a){return B.J},
$in:1,
$ieB:1}
A.aC.prototype={
gk(a){return a.length},
$iJ:1}
A.bb.prototype={
j(a,b){A.a5(b,a,a.length)
return a[b]},
B(a,b,c){a.$flags&2&&A.cM(a)
A.a5(b,a,a.length)
a[b]=c},
$ie:1,
$id:1,
$ii:1}
A.bc.prototype={
B(a,b,c){a.$flags&2&&A.cM(a)
A.a5(b,a,a.length)
a[b]=c},
$ie:1,
$id:1,
$ii:1}
A.cf.prototype={
gp(a){return B.K},
$in:1,
$icU:1}
A.cg.prototype={
gp(a){return B.L},
$in:1,
$icV:1}
A.ch.prototype={
gp(a){return B.M},
j(a,b){A.a5(b,a,a.length)
return a[b]},
$in:1,
$id2:1}
A.ci.prototype={
gp(a){return B.N},
j(a,b){A.a5(b,a,a.length)
return a[b]},
$in:1,
$id3:1}
A.cj.prototype={
gp(a){return B.O},
j(a,b){A.a5(b,a,a.length)
return a[b]},
$in:1,
$id4:1}
A.ck.prototype={
gp(a){return B.Q},
j(a,b){A.a5(b,a,a.length)
return a[b]},
$in:1,
$idt:1}
A.cl.prototype={
gp(a){return B.R},
j(a,b){A.a5(b,a,a.length)
return a[b]},
$in:1,
$idu:1}
A.be.prototype={
gp(a){return B.S},
gk(a){return a.length},
j(a,b){A.a5(b,a,a.length)
return a[b]},
$in:1,
$idv:1}
A.cm.prototype={
gp(a){return B.T},
gk(a){return a.length},
j(a,b){A.a5(b,a,a.length)
return a[b]},
$in:1,
$idw:1}
A.bw.prototype={}
A.bx.prototype={}
A.by.prototype={}
A.bz.prototype={}
A.W.prototype={
h(a){return A.bH(v.typeUniverse,this,a)},
D(a){return A.fF(v.typeUniverse,this,a)}}
A.cz.prototype={}
A.e7.prototype={
i(a){return A.M(this.a,null)}}
A.cy.prototype={
i(a){return this.a}}
A.bD.prototype={$ia2:1}
A.dz.prototype={
$1(a){var s=this.a,r=s.a
s.a=null
r.$0()},
$S:6}
A.dy.prototype={
$1(a){var s,r
this.a.a=a
s=this.b
r=this.c
s.firstChild?s.removeChild(r):s.appendChild(r)},
$S:13}
A.dA.prototype={
$0(){this.a.$0()},
$S:7}
A.dB.prototype={
$0(){this.a.$0()},
$S:7}
A.e5.prototype={
bs(a,b){if(self.setTimeout!=null)self.setTimeout(A.bR(new A.e6(this,b),0),a)
else throw A.c(A.dx("`setTimeout()` not found."))}}
A.e6.prototype={
$0(){this.b.$0()},
$S:0}
A.cs.prototype={
a7(a){var s,r=this
if(a==null)a=r.$ti.c.a(a)
if(!r.b)r.a.V(a)
else{s=r.a
if(r.$ti.h("V<1>").b(a))s.aX(a)
else s.a3(a)}},
aB(a,b){var s=this.a
if(this.b)s.M(new A.B(a,b))
else s.a1(new A.B(a,b))}}
A.ed.prototype={
$1(a){return this.a.$2(0,a)},
$S:1}
A.ee.prototype={
$2(a,b){this.a.$2(1,new A.aY(a,b))},
$S:14}
A.eh.prototype={
$2(a,b){this.a(a,b)},
$S:15}
A.B.prototype={
i(a){return A.j(this.a)},
$ip:1,
ga_(){return this.b}}
A.a9.prototype={}
A.aG.prototype={
aq(){},
ar(){}}
A.cu.prototype={
gan(){return this.c<4},
bM(a){var s=a.CW,r=a.ch
if(s==null)this.d=r
else s.ch=r
if(r==null)this.e=s
else r.CW=s
a.CW=a
a.ch=a},
bQ(a,b,c,d){var s,r,q,p,o,n,m,l,k=this
if((k.c&4)!==0){s=new A.bs($.h,A.t(k).h("bs<1>"))
A.h8(s.gbI())
if(c!=null)s.c=c
return s}s=$.h
r=d?1:0
q=b!=null?32:0
p=A.fs(s,a)
o=A.ft(s,b)
n=c==null?A.jr():c
m=new A.aG(k,p,o,n,s,r|q,A.t(k).h("aG<1>"))
m.CW=m
m.ch=m
m.ay=k.c&1
l=k.e
k.e=m
m.ch=null
m.CW=l
if(l==null)k.d=m
else l.ch=m
if(k.d===m)A.fX(k.a)
return m},
bL(a){var s,r=this
A.t(r).h("aG<1>").a(a)
if(a.ch===a)return null
s=a.ay
if((s&2)!==0)a.ay=s|4
else{r.bM(a)
if((r.c&2)===0&&r.d==null)r.bu()}return null},
af(){if((this.c&4)!==0)return new A.al("Cannot add new events after calling close")
return new A.al("Cannot add new events while doing an addStream")},
N(a,b){if(!this.gan())throw A.c(this.af())
this.au(b)},
az(a,b){var s
if(!this.gan())throw A.c(this.af())
s=A.fM(a,b)
this.aw(s.a,s.b)},
bS(a){return this.az(a,null)},
A(){var s,r,q=this
if((q.c&4)!==0){s=q.r
s.toString
return s}if(!q.gan())throw A.c(q.af())
q.c|=4
r=q.r
if(r==null)r=q.r=new A.k($.h,t.D)
q.av()
return r},
bu(){if((this.c&4)!==0){var s=this.r
if((s.a&30)===0)s.V(null)}A.fX(this.b)}}
A.bo.prototype={
au(a){var s,r
for(s=this.d,r=this.$ti.h("cw<1>");s!=null;s=s.ch)s.ah(new A.cw(a,r))},
aw(a,b){var s
for(s=this.d;s!=null;s=s.ch)s.ah(new A.dG(a,b))},
av(){var s=this.d
if(s!=null)for(;s!=null;s=s.ch)s.ah(B.y)
else this.r.V(null)}}
A.cY.prototype={
$2(a,b){var s=this,r=s.a,q=--r.b
if(r.a!=null){r.a=null
r.d=a
r.c=b
if(q===0||s.c)s.d.M(new A.B(a,b))}else if(q===0&&!s.c){q=r.d
q.toString
r=r.c
r.toString
s.d.M(new A.B(q,r))}},
$S:2}
A.cX.prototype={
$1(a){var s,r,q,p,o,n,m=this,l=m.a,k=--l.b,j=l.a
if(j!=null){J.ae(j,m.b,a)
if(J.Y(k,0)){l=m.d
s=A.u([],l.h("o<0>"))
for(q=j,p=q.length,o=0;o<q.length;q.length===p||(0,A.cL)(q),++o){r=q[o]
n=r
if(n==null)n=l.a(n)
J.hm(s,n)}m.c.a3(s)}}else if(J.Y(k,0)&&!m.f){s=l.d
s.toString
l=l.c
l.toString
m.c.M(new A.B(s,l))}},
$S(){return this.d.h("w(0)")}}
A.cv.prototype={
aB(a,b){var s=this.a
if((s.a&30)!==0)throw A.c(A.eJ("Future already completed"))
s.a1(A.fM(a,b))},
bc(a){return this.aB(a,null)}}
A.an.prototype={
a7(a){var s=this.a
if((s.a&30)!==0)throw A.c(A.eJ("Future already completed"))
s.V(a)},
bT(){return this.a7(null)}}
A.aH.prototype={
c0(a){if((this.c&15)!==6)return!0
return this.b.b.aR(this.d,a.a)},
bX(a){var s,r=this.e,q=null,p=a.a,o=this.b.b
if(t.Q.b(r))q=o.c4(r,p,a.b)
else q=o.aR(r,p)
try{p=q
return p}catch(s){if(t._.b(A.F(s))){if((this.c&1)!==0)throw A.c(A.H("The error handler of Future.then must return a value of the returned future's type","onError"))
throw A.c(A.H("The error handler of Future.catchError must return a value of the future's type","onError"))}else throw s}}}
A.k.prototype={
aS(a,b,c){var s,r=$.h
if(r===B.d){if(!t.Q.b(b)&&!t.v.b(b))throw A.c(A.f9(b,"onError",u.c))}else b=A.jc(b,r)
s=new A.k(r,c.h("k<0>"))
this.ag(new A.aH(s,3,a,b,this.$ti.h("@<1>").D(c).h("aH<1,2>")))
return s},
b9(a,b,c){var s=new A.k($.h,c.h("k<0>"))
this.ag(new A.aH(s,19,a,b,this.$ti.h("@<1>").D(c).h("aH<1,2>")))
return s},
bN(a){this.a=this.a&1|16
this.c=a},
a2(a){this.a=a.a&30|this.a&1
this.c=a.c},
ag(a){var s=this,r=s.a
if(r<=3){a.a=s.c
s.c=a}else{if((r&4)!==0){r=s.c
if((r.a&24)===0){r.ag(a)
return}s.a2(r)}A.aM(null,null,s.b,new A.dJ(s,a))}},
b6(a){var s,r,q,p,o,n=this,m={}
m.a=a
if(a==null)return
s=n.a
if(s<=3){r=n.c
n.c=a
if(r!=null){q=a.a
for(p=a;q!=null;p=q,q=o)o=q.a
p.a=r}}else{if((s&4)!==0){s=n.c
if((s.a&24)===0){s.b6(a)
return}n.a2(s)}m.a=n.a5(a)
A.aM(null,null,n.b,new A.dN(m,n))}},
W(){var s=this.c
this.c=null
return this.a5(s)},
a5(a){var s,r,q
for(s=a,r=null;s!=null;r=s,s=q){q=s.a
s.a=r}return r},
a3(a){var s=this,r=s.W()
s.a=8
s.c=a
A.ao(s,r)},
bx(a){var s,r,q=this
if((a.a&16)!==0){s=q.b===a.b
s=!(s||s)}else s=!1
if(s)return
r=q.W()
q.a2(a)
A.ao(q,r)},
M(a){var s=this.W()
this.bN(a)
A.ao(this,s)},
bw(a,b){this.M(new A.B(a,b))},
V(a){if(this.$ti.h("V<1>").b(a)){this.aX(a)
return}this.bt(a)},
bt(a){this.a^=2
A.aM(null,null,this.b,new A.dL(this,a))},
aX(a){A.eL(a,this,!1)
return},
a1(a){this.a^=2
A.aM(null,null,this.b,new A.dK(this,a))},
$iV:1}
A.dJ.prototype={
$0(){A.ao(this.a,this.b)},
$S:0}
A.dN.prototype={
$0(){A.ao(this.b,this.a.a)},
$S:0}
A.dM.prototype={
$0(){A.eL(this.a.a,this.b,!0)},
$S:0}
A.dL.prototype={
$0(){this.a.a3(this.b)},
$S:0}
A.dK.prototype={
$0(){this.a.M(this.b)},
$S:0}
A.dQ.prototype={
$0(){var s,r,q,p,o,n,m,l,k=this,j=null
try{q=k.a.a
j=q.b.b.bh(q.d)}catch(p){s=A.F(p)
r=A.P(p)
if(k.c&&k.b.a.c.a===s){q=k.a
q.c=k.b.a.c}else{q=s
o=r
if(o==null)o=A.cO(q)
n=k.a
n.c=new A.B(q,o)
q=n}q.b=!0
return}if(j instanceof A.k&&(j.a&24)!==0){if((j.a&16)!==0){q=k.a
q.c=j.c
q.b=!0}return}if(j instanceof A.k){m=k.b.a
l=new A.k(m.b,m.$ti)
j.aS(new A.dR(l,m),new A.dS(l),t.H)
q=k.a
q.c=l
q.b=!1}},
$S:0}
A.dR.prototype={
$1(a){this.a.bx(this.b)},
$S:6}
A.dS.prototype={
$2(a,b){this.a.M(new A.B(a,b))},
$S:16}
A.dP.prototype={
$0(){var s,r,q,p,o,n
try{q=this.a
p=q.a
q.c=p.b.b.aR(p.d,this.b)}catch(o){s=A.F(o)
r=A.P(o)
q=s
p=r
if(p==null)p=A.cO(q)
n=this.a
n.c=new A.B(q,p)
n.b=!0}},
$S:0}
A.dO.prototype={
$0(){var s,r,q,p,o,n,m,l=this
try{s=l.a.a.c
p=l.b
if(p.a.c0(s)&&p.a.e!=null){p.c=p.a.bX(s)
p.b=!1}}catch(o){r=A.F(o)
q=A.P(o)
p=l.a.a.c
if(p.a===r){n=l.b
n.c=p
p=n}else{p=r
n=q
if(n==null)n=A.cO(p)
m=l.b
m.c=new A.B(p,n)
p=m}p.b=!0}},
$S:0}
A.ct.prototype={}
A.X.prototype={
gk(a){var s={},r=new A.k($.h,t.a)
s.a=0
this.S(new A.dm(s,this),!0,new A.dn(s,r),r.gbv())
return r}}
A.dm.prototype={
$1(a){++this.a.a},
$S(){return A.t(this.b).h("~(X.T)")}}
A.dn.prototype={
$0(){var s=this.b,r=this.a.a,q=s.W()
s.a=8
s.c=r
A.ao(s,q)},
$S:0}
A.bq.prototype={
gt(a){return(A.bh(this.a)^892482866)>>>0},
E(a,b){if(b==null)return!1
if(this===b)return!0
return b instanceof A.a9&&b.a===this.a}}
A.br.prototype={
b4(){return this.w.bL(this)},
aq(){},
ar(){}}
A.bp.prototype={
a8(a){this.a=A.fs(this.d,a)},
a9(a){var s=this,r=s.e
if(a==null)s.e=r&4294967263
else s.e=r|32
s.b=A.ft(s.d,a)},
X(){if(((this.e&=4294967279)&8)===0)this.ai()
var s=$.f2()
return s},
ai(){var s,r=this,q=r.e|=8
if((q&128)!==0){s=r.r
if(s.a===1)s.a=3}if((q&64)===0)r.r=null
r.f=r.b4()},
aq(){},
ar(){},
b4(){return null},
ah(a){var s,r,q=this,p=q.r
if(p==null)p=q.r=new A.cG(A.t(q).h("cG<1>"))
s=p.c
if(s==null)p.b=p.c=a
else{s.sZ(a)
p.c=a}r=q.e
if((r&128)===0){r|=128
q.e=r
if(r<256)p.aT(q)}},
au(a){var s=this,r=s.e
s.e=r|64
s.d.ab(s.a,a)
s.e&=4294967231
s.aY((r&4)!==0)},
aw(a,b){var s=this,r=s.e,q=new A.dD(s,a,b)
if((r&1)!==0){s.e=r|16
s.ai()
q.$0()}else{q.$0()
s.aY((r&4)!==0)}},
av(){this.ai()
this.e|=16
new A.dC(this).$0()},
aY(a){var s,r,q=this,p=q.e
if((p&128)!==0&&q.r.c==null){p=q.e=p&4294967167
s=!1
if((p&4)!==0)if(p<256){s=q.r
s=s==null?null:s.c==null
s=s!==!1}if(s){p&=4294967291
q.e=p}}for(;!0;a=r){if((p&8)!==0){q.r=null
return}r=(p&4)!==0
if(a===r)break
q.e=p^64
if(r)q.aq()
else q.ar()
p=q.e&=4294967231}if((p&128)!==0&&p<256)q.r.aT(q)}}
A.dD.prototype={
$0(){var s,r,q=this.a,p=q.e
if((p&8)!==0&&(p&16)===0)return
q.e=p|64
s=q.b
p=this.b
r=q.d
if(t.k.b(s))r.bi(s,p,this.c)
else r.ab(s,p)
q.e&=4294967231},
$S:0}
A.dC.prototype={
$0(){var s=this.a,r=s.e
if((r&16)===0)return
s.e=r|74
s.d.aQ(s.c)
s.e&=4294967231},
$S:0}
A.aJ.prototype={
S(a,b,c,d){return this.a.bQ(a,d,c,b===!0)},
bf(a){return this.S(a,null,null,null)},
bg(a,b,c){return this.S(a,b,c,null)}}
A.cx.prototype={
gZ(){return this.a},
sZ(a){return this.a=a}}
A.cw.prototype={
aP(a){a.au(this.b)}}
A.dG.prototype={
aP(a){a.aw(this.b,this.c)}}
A.dF.prototype={
aP(a){a.av()},
gZ(){return null},
sZ(a){throw A.c(A.eJ("No events after a done."))}}
A.cG.prototype={
aT(a){var s=this,r=s.a
if(r===1)return
if(r>=1){s.a=1
return}A.h8(new A.e0(s,a))
s.a=1}}
A.e0.prototype={
$0(){var s,r,q=this.a,p=q.a
q.a=0
if(p===3)return
s=q.b
r=s.gZ()
q.b=r
if(r==null)q.c=null
s.aP(this.b)},
$S:0}
A.bs.prototype={
a8(a){},
a9(a){},
X(){this.a=-1
this.c=null
return $.f2()},
bJ(){var s,r=this,q=r.a-1
if(q===0){r.a=-1
s=r.c
if(s!=null){r.c=null
r.b.aQ(s)}}else r.a=q}}
A.cI.prototype={}
A.ea.prototype={}
A.eg.prototype={
$0(){A.hy(this.a,this.b)},
$S:0}
A.e3.prototype={
aQ(a){var s,r,q
try{if(B.d===$.h){a.$0()
return}A.fT(null,null,this,a)}catch(q){s=A.F(q)
r=A.P(q)
A.aL(s,r)}},
c8(a,b){var s,r,q
try{if(B.d===$.h){a.$1(b)
return}A.fV(null,null,this,a,b)}catch(q){s=A.F(q)
r=A.P(q)
A.aL(s,r)}},
ab(a,b){return this.c8(a,b,t.z)},
c6(a,b,c){var s,r,q
try{if(B.d===$.h){a.$2(b,c)
return}A.fU(null,null,this,a,b,c)}catch(q){s=A.F(q)
r=A.P(q)
A.aL(s,r)}},
bi(a,b,c){var s=t.z
return this.c6(a,b,c,s,s)},
bb(a){return new A.e4(this,a)},
c3(a){if($.h===B.d)return a.$0()
return A.fT(null,null,this,a)},
bh(a){return this.c3(a,t.z)},
c7(a,b){if($.h===B.d)return a.$1(b)
return A.fV(null,null,this,a,b)},
aR(a,b){var s=t.z
return this.c7(a,b,s,s)},
c5(a,b,c){if($.h===B.d)return a.$2(b,c)
return A.fU(null,null,this,a,b,c)},
c4(a,b,c){var s=t.z
return this.c5(a,b,c,s,s,s)},
c2(a){return a},
aa(a){var s=t.z
return this.c2(a,s,s,s)}}
A.e4.prototype={
$0(){return this.a.aQ(this.b)},
$S:0}
A.bt.prototype={
gk(a){return this.a},
gu(a){return this.a===0},
gG(){return new A.bu(this,this.$ti.h("bu<1>"))},
R(a){var s,r
if(typeof a=="string"&&a!=="__proto__"){s=this.b
return s==null?!1:s[a]!=null}else if(typeof a=="number"&&(a&1073741823)===a){r=this.c
return r==null?!1:r[a]!=null}else return this.bz(a)},
bz(a){var s=this.d
if(s==null)return!1
return this.am(this.b0(s,a),a)>=0},
j(a,b){var s,r,q
if(typeof b=="string"&&b!=="__proto__"){s=this.b
r=s==null?null:A.fv(s,b)
return r}else if(typeof b=="number"&&(b&1073741823)===b){q=this.c
r=q==null?null:A.fv(q,b)
return r}else return this.bB(b)},
bB(a){var s,r,q=this.d
if(q==null)return null
s=this.b0(q,a)
r=this.am(s,a)
return r<0?null:s[r+1]},
B(a,b,c){var s,r,q,p,o,n,m=this
if(typeof b=="string"&&b!=="__proto__"){s=m.b
m.aW(s==null?m.b=A.eM():s,b,c)}else if(typeof b=="number"&&(b&1073741823)===b){r=m.c
m.aW(r==null?m.c=A.eM():r,b,c)}else{q=m.d
if(q==null)q=m.d=A.eM()
p=A.ew(b)&1073741823
o=q[p]
if(o==null){A.eN(q,p,[b,c]);++m.a
m.e=null}else{n=m.am(o,b)
if(n>=0)o[n+1]=c
else{o.push(b,c);++m.a
m.e=null}}}},
K(a,b){var s,r,q,p,o,n=this,m=n.aZ()
for(s=m.length,r=n.$ti.y[1],q=0;q<s;++q){p=m[q]
o=n.j(0,p)
b.$2(p,o==null?r.a(o):o)
if(m!==n.e)throw A.c(A.ag(n))}},
aZ(){var s,r,q,p,o,n,m,l,k,j,i=this,h=i.e
if(h!=null)return h
h=A.dg(i.a,null,!1,t.z)
s=i.b
r=0
if(s!=null){q=Object.getOwnPropertyNames(s)
p=q.length
for(o=0;o<p;++o){h[r]=q[o];++r}}n=i.c
if(n!=null){q=Object.getOwnPropertyNames(n)
p=q.length
for(o=0;o<p;++o){h[r]=+q[o];++r}}m=i.d
if(m!=null){q=Object.getOwnPropertyNames(m)
p=q.length
for(o=0;o<p;++o){l=m[q[o]]
k=l.length
for(j=0;j<k;j+=2){h[r]=l[j];++r}}}return i.e=h},
aW(a,b,c){if(a[b]==null){++this.a
this.e=null}A.eN(a,b,c)},
b0(a,b){return a[A.ew(b)&1073741823]}}
A.aI.prototype={
am(a,b){var s,r,q
if(a==null)return-1
s=a.length
for(r=0;r<s;r+=2){q=a[r]
if(q==null?b==null:q===b)return r}return-1}}
A.bu.prototype={
gk(a){return this.a.a},
gu(a){return this.a.a===0},
gn(a){var s=this.a
return new A.cA(s,s.aZ(),this.$ti.h("cA<1>"))}}
A.cA.prototype={
gm(){var s=this.d
return s==null?this.$ti.c.a(s):s},
l(){var s=this,r=s.b,q=s.c,p=s.a
if(r!==p.e)throw A.c(A.ag(p))
else if(q>=r.length){s.d=null
return!1}else{s.d=r[q]
s.c=q+1
return!0}}}
A.r.prototype={
gn(a){return new A.aA(a,this.gk(a),A.ac(a).h("aA<r.E>"))},
O(a,b){return this.j(a,b)},
gu(a){return this.gk(a)===0},
gaJ(a){return!this.gu(a)},
gaD(a){if(this.gk(a)===0)throw A.c(A.b4())
return this.j(a,0)},
gaK(a){if(this.gk(a)===0)throw A.c(A.b4())
return this.j(a,this.gk(a)-1)},
Y(a,b,c){return new A.a0(a,b,A.ac(a).h("@<r.E>").D(c).h("a0<1,2>"))},
i(a){return A.fh(a,"[","]")}}
A.L.prototype={
K(a,b){var s,r,q,p
for(s=this.gG(),s=s.gn(s),r=A.t(this).h("L.V");s.l();){q=s.gm()
p=this.j(0,q)
b.$2(q,p==null?r.a(p):p)}},
aL(a,b,c,d){var s,r,q,p,o,n=A.eF(c,d)
for(s=this.gG(),s=s.gn(s),r=A.t(this).h("L.V");s.l();){q=s.gm()
p=this.j(0,q)
o=b.$2(q,p==null?r.a(p):p)
n.B(0,o.a,o.b)}return n},
gk(a){var s=this.gG()
return s.gk(s)},
gu(a){var s=this.gG()
return s.gu(s)},
i(a){return A.eG(this)},
$iK:1}
A.dh.prototype={
$2(a,b){var s,r=this.a
if(!r.a)this.b.a+=", "
r.a=!1
r=this.b
s=A.j(a)
r.a=(r.a+=s)+": "
s=A.j(b)
r.a+=s},
$S:8}
A.cD.prototype={
j(a,b){var s,r=this.b
if(r==null)return this.c.j(0,b)
else if(typeof b!="string")return null
else{s=r[b]
return typeof s=="undefined"?this.bK(b):s}},
gk(a){return this.b==null?this.c.a:this.a4().length},
gu(a){return this.gk(0)===0},
gG(){if(this.b==null){var s=this.c
return new A.aj(s,A.t(s).h("aj<1>"))}return new A.cE(this)},
K(a,b){var s,r,q,p,o=this
if(o.b==null)return o.c.K(0,b)
s=o.a4()
for(r=0;r<s.length;++r){q=s[r]
p=o.b[q]
if(typeof p=="undefined"){p=A.ef(o.a[q])
o.b[q]=p}b.$2(q,p)
if(s!==o.c)throw A.c(A.ag(o))}},
a4(){var s=this.c
if(s==null)s=this.c=A.u(Object.keys(this.a),t.s)
return s},
bK(a){var s
if(!Object.prototype.hasOwnProperty.call(this.a,a))return null
s=A.ef(this.a[a])
return this.b[a]=s}}
A.cE.prototype={
gk(a){return this.a.gk(0)},
O(a,b){var s=this.a
return s.b==null?s.gG().O(0,b):s.a4()[b]},
gn(a){var s=this.a
if(s.b==null){s=s.gG()
s=s.gn(s)}else{s=s.a4()
s=new J.av(s,s.length,A.bI(s).h("av<1>"))}return s}}
A.bU.prototype={}
A.bW.prototype={}
A.ba.prototype={
i(a){var s=A.bZ(this.a)
return(this.b!=null?"Converting object to an encodable object failed:":"Converting object did not return an encodable object:")+" "+s}}
A.ca.prototype={
i(a){return"Cyclic error in JSON stringify"}}
A.dc.prototype={
bU(a,b){var s=A.ja(a,this.gbV().a)
return s},
F(a,b){var s=A.i5(a,this.gbW().b,null)
return s},
gbW(){return B.E},
gbV(){return B.D}}
A.de.prototype={}
A.dd.prototype={}
A.dZ.prototype={
bl(a){var s,r,q,p,o,n,m=a.length
for(s=this.c,r=0,q=0;q<m;++q){p=a.charCodeAt(q)
if(p>92){if(p>=55296){o=p&64512
if(o===55296){n=q+1
n=!(n<m&&(a.charCodeAt(n)&64512)===56320)}else n=!1
if(!n)if(o===56320){o=q-1
o=!(o>=0&&(a.charCodeAt(o)&64512)===55296)}else o=!1
else o=!0
if(o){if(q>r)s.a+=B.h.a0(a,r,q)
r=q+1
o=A.A(92)
s.a+=o
o=A.A(117)
s.a+=o
o=A.A(100)
s.a+=o
o=p>>>8&15
o=A.A(o<10?48+o:87+o)
s.a+=o
o=p>>>4&15
o=A.A(o<10?48+o:87+o)
s.a+=o
o=p&15
o=A.A(o<10?48+o:87+o)
s.a+=o}}continue}if(p<32){if(q>r)s.a+=B.h.a0(a,r,q)
r=q+1
o=A.A(92)
s.a+=o
switch(p){case 8:o=A.A(98)
s.a+=o
break
case 9:o=A.A(116)
s.a+=o
break
case 10:o=A.A(110)
s.a+=o
break
case 12:o=A.A(102)
s.a+=o
break
case 13:o=A.A(114)
s.a+=o
break
default:o=A.A(117)
s.a+=o
o=A.A(48)
s.a=(s.a+=o)+o
o=p>>>4&15
o=A.A(o<10?48+o:87+o)
s.a+=o
o=p&15
o=A.A(o<10?48+o:87+o)
s.a+=o
break}}else if(p===34||p===92){if(q>r)s.a+=B.h.a0(a,r,q)
r=q+1
o=A.A(92)
s.a+=o
o=A.A(p)
s.a+=o}}if(r===0)s.a+=a
else if(r<m)s.a+=B.h.a0(a,r,m)},
aj(a){var s,r,q,p
for(s=this.a,r=s.length,q=0;q<r;++q){p=s[q]
if(a==null?p==null:a===p)throw A.c(new A.ca(a,null))}s.push(a)},
ad(a){var s,r,q,p,o=this
if(o.bk(a))return
o.aj(a)
try{s=o.b.$1(a)
if(!o.bk(s)){q=A.fi(a,null,o.gb5())
throw A.c(q)}o.a.pop()}catch(p){r=A.F(p)
q=A.fi(a,r,o.gb5())
throw A.c(q)}},
bk(a){var s,r,q=this
if(typeof a=="number"){if(!isFinite(a))return!1
q.c.a+=B.b.i(a)
return!0}else if(a===!0){q.c.a+="true"
return!0}else if(a===!1){q.c.a+="false"
return!0}else if(a==null){q.c.a+="null"
return!0}else if(typeof a=="string"){s=q.c
s.a+='"'
q.bl(a)
s.a+='"'
return!0}else if(t.j.b(a)){q.aj(a)
q.ca(a)
q.a.pop()
return!0}else if(t.G.b(a)){q.aj(a)
r=q.cb(a)
q.a.pop()
return r}else return!1},
ca(a){var s,r,q=this.c
q.a+="["
s=J.O(a)
if(s.gaJ(a)){this.ad(s.j(a,0))
for(r=1;r<s.gk(a);++r){q.a+=","
this.ad(s.j(a,r))}}q.a+="]"},
cb(a){var s,r,q,p,o,n=this,m={}
if(a.gu(a)){n.c.a+="{}"
return!0}s=a.gk(a)*2
r=A.dg(s,null,!1,t.X)
q=m.a=0
m.b=!0
a.K(0,new A.e_(m,r))
if(!m.b)return!1
p=n.c
p.a+="{"
for(o='"';q<s;q+=2,o=',"'){p.a+=o
n.bl(A.ec(r[q]))
p.a+='":'
n.ad(r[q+1])}p.a+="}"
return!0}}
A.e_.prototype={
$2(a,b){var s,r,q,p
if(typeof a!="string")this.a.b=!1
s=this.b
r=this.a
q=r.a
p=r.a=q+1
s[q]=a
r.a=p+1
s[p]=b},
$S:8}
A.dY.prototype={
gb5(){var s=this.c.a
return s.charCodeAt(0)==0?s:s}}
A.bX.prototype={
E(a,b){var s
if(b==null)return!1
s=!1
if(b instanceof A.bX)if(this.a===b.a)s=this.b===b.b
return s},
gt(a){return A.eH(this.a,this.b,B.f,B.f)},
i(a){var s=this,r=A.hw(A.hS(s)),q=A.bY(A.hQ(s)),p=A.bY(A.hM(s)),o=A.bY(A.hN(s)),n=A.bY(A.hP(s)),m=A.bY(A.hR(s)),l=A.ff(A.hO(s)),k=s.b,j=k===0?"":A.ff(k)
return r+"-"+q+"-"+p+" "+o+":"+n+":"+m+"."+l+j+"Z"}}
A.dH.prototype={
i(a){return this.b_()}}
A.p.prototype={
ga_(){return A.hL(this)}}
A.bS.prototype={
i(a){var s=this.a
if(s!=null)return"Assertion failed: "+A.bZ(s)
return"Assertion failed"}}
A.a2.prototype={}
A.Z.prototype={
gal(){return"Invalid argument"+(!this.a?"(s)":"")},
gak(){return""},
i(a){var s=this,r=s.c,q=r==null?"":" ("+r+")",p=s.d,o=p==null?"":": "+p,n=s.gal()+q+o
if(!s.a)return n
return n+s.gak()+": "+A.bZ(s.gaH())},
gaH(){return this.b}}
A.aE.prototype={
gaH(){return this.b},
gal(){return"RangeError"},
gak(){var s,r=this.e,q=this.f
if(r==null)s=q!=null?": Not less than or equal to "+A.j(q):""
else if(q==null)s=": Not greater than or equal to "+A.j(r)
else if(q>r)s=": Not in inclusive range "+A.j(r)+".."+A.j(q)
else s=q<r?": Valid value range is empty":": Only valid value is "+A.j(r)
return s}}
A.c3.prototype={
gaH(){return this.b},
gal(){return"RangeError"},
gak(){if(this.b<0)return": index must not be negative"
var s=this.f
if(s===0)return": no indices are valid"
return": index should be less than "+s},
gk(a){return this.f}}
A.bn.prototype={
i(a){return"Unsupported operation: "+this.a}}
A.cq.prototype={
i(a){return"UnimplementedError: "+this.a}}
A.al.prototype={
i(a){return"Bad state: "+this.a}}
A.bV.prototype={
i(a){var s=this.a
if(s==null)return"Concurrent modification during iteration."
return"Concurrent modification during iteration: "+A.bZ(s)+"."}}
A.bk.prototype={
i(a){return"Stack Overflow"},
ga_(){return null},
$ip:1}
A.dI.prototype={
i(a){return"Exception: "+this.a}}
A.cW.prototype={
i(a){var s=this.a,r=""!==s?"FormatException: "+s:"FormatException"
return r}}
A.d.prototype={
Y(a,b,c){return A.hK(this,b,A.t(this).h("d.E"),c)},
gk(a){var s,r=this.gn(this)
for(s=0;r.l();)++s
return s},
gu(a){return!this.gn(this).l()},
gaJ(a){return!this.gu(this)},
gaD(a){var s=this.gn(this)
if(!s.l())throw A.c(A.b4())
return s.gm()},
gaK(a){var s,r=this.gn(this)
if(!r.l())throw A.c(A.b4())
do s=r.gm()
while(r.l())
return s},
O(a,b){var s,r
A.hU(b,"index")
s=this.gn(this)
for(r=b;s.l();){if(r===0)return s.gm();--r}throw A.c(A.fg(b,b-r,this,"index"))},
i(a){return A.hE(this,"(",")")}}
A.E.prototype={
i(a){return"MapEntry("+A.j(this.a)+": "+A.j(this.b)+")"}}
A.w.prototype={
gt(a){return A.b.prototype.gt.call(this,0)},
i(a){return"null"}}
A.b.prototype={$ib:1,
E(a,b){return this===b},
gt(a){return A.bh(this)},
i(a){return"Instance of '"+A.co(this)+"'"},
gp(a){return A.aQ(this)},
toString(){return this.i(this)}}
A.bC.prototype={
i(a){return this.a},
$iC:1}
A.bl.prototype={
gk(a){return this.a.length},
i(a){var s=this.a
return s.charCodeAt(0)==0?s:s}}
A.et.prototype={
$1(a){var s,r,q,p
if(A.fS(a))return a
s=this.a
if(s.R(a))return s.j(0,a)
if(t.G.b(a)){r={}
s.B(0,a,r)
for(s=a.gG(),s=s.gn(s);s.l();){q=s.gm()
r[q]=this.$1(a.j(0,q))}return r}else if(t.R.b(a)){p=[]
s.B(0,a,p)
B.o.bR(p,J.f7(a,this,t.z))
return p}else return a},
$S:9}
A.ex.prototype={
$1(a){return this.a.a7(a)},
$S:1}
A.ey.prototype={
$1(a){if(a==null)return this.a.bc(new A.di(a===undefined))
return this.a.bc(a)},
$S:1}
A.em.prototype={
$1(a){var s,r,q,p,o,n,m,l,k,j,i,h
if(A.fR(a))return a
s=this.a
a.toString
if(s.R(a))return s.j(0,a)
if(a instanceof Date){r=a.getTime()
if(r<-864e13||r>864e13)A.S(A.bi(r,-864e13,864e13,"millisecondsSinceEpoch",null))
A.el(!0,"isUtc",t.y)
return new A.bX(r,0,!0)}if(a instanceof RegExp)throw A.c(A.H("structured clone of RegExp",null))
if(typeof Promise!="undefined"&&a instanceof Promise)return A.jM(a,t.X)
q=Object.getPrototypeOf(a)
if(q===Object.prototype||q===null){p=t.X
o=A.eF(p,p)
s.B(0,a,o)
n=Object.keys(a)
m=[]
for(s=J.O(n),p=s.gn(n);p.l();)m.push(A.eV(p.gm()))
for(l=0;l<s.gk(n);++l){k=s.j(n,l)
j=m[l]
if(k!=null)o.B(0,j,this.$1(a[k]))}return o}if(a instanceof Array){i=a
o=[]
s.B(0,a,o)
h=a.length
for(s=J.O(i),l=0;l<h;++l)o.push(this.$1(s.j(i,l)))
return o}return a},
$S:9}
A.di.prototype={
i(a){return"Promise was rejected with a value of `"+(this.a?"undefined":"null")+"`."}}
A.dW.prototype={
L(){return Math.random()}}
A.e1.prototype={
br(a){var s,r,q,p,o,n,m,l=this,k=4294967296,j=a<0?-1:0
do{s=a>>>0
a=B.a.J(a-s,k)
r=a>>>0
a=B.a.J(a-r,k)
q=(~s>>>0)+(s<<21>>>0)
p=q>>>0
r=(~r>>>0)+((r<<21|s>>>11)>>>0)+B.a.J(q-p,k)>>>0
q=((p^(p>>>24|r<<8))>>>0)*265
s=q>>>0
r=((r^r>>>24)>>>0)*265+B.a.J(q-s,k)>>>0
q=((s^(s>>>14|r<<18))>>>0)*21
s=q>>>0
r=((r^r>>>14)>>>0)*21+B.a.J(q-s,k)>>>0
s=(s^(s>>>28|r<<4))>>>0
r=(r^r>>>28)>>>0
q=(s<<31>>>0)+s
p=q>>>0
o=B.a.J(q-p,k)
q=l.a*1037
n=l.a=q>>>0
m=l.b*1037+B.a.J(q-n,k)>>>0
l.b=m
n=(n^p)>>>0
l.a=n
o=(m^r+((r<<31|s>>>1)>>>0)+o>>>0)>>>0
l.b=o}while(a!==j)
if(o===0&&n===0)l.a=23063
l.I()
l.I()
l.I()
l.I()},
I(){var s=this,r=s.a,q=4294901760*r,p=q>>>0,o=55905*r,n=o>>>0,m=n+p+s.b
r=m>>>0
s.a=r
s.b=B.a.J(o-n+(q-p)+(m-r),4294967296)>>>0},
aN(a){var s,r,q,p=this
if(a<=0||a>4294967296)throw A.c(A.hT("max must be in range 0 < max \u2264 2^32, was "+a))
s=a-1
if((a&s)>>>0===0){p.I()
return(p.a&s)>>>0}do{p.I()
r=p.a
q=r%a}while(r-q+a>=4294967296)
return q},
L(){var s,r=this
r.I()
s=r.a
r.I()
return((s&67108863)*134217728+(r.a&134217727))/9007199254740992},
c1(){this.I()
return(this.a&1)===0}}
A.cP.prototype={
ac(){var s=this
return A.v(["width",s.a,"height",s.b,"darkColorValue",s.c,"lightColorValue",s.d,"randomSeed",s.e],t.N,t.z)}}
A.cQ.prototype={
ac(){return A.v(["gridFill",this.a,"gridWidth",this.b,"gridHeight",this.c,"isComplete",!0],t.N,t.z)}}
A.bg.prototype={
ac(){return A.v(["centerX",this.a,"centerY",this.b,"radius",this.c],t.N,t.z)}}
A.ej.prototype={
$2(a4,a5){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0,a1,a2,a3=null
try{s=B.c.bU(a5,a3)
d=s
c=d.j(0,"width")
c=c==null?a3:J.f8(c)
if(c==null)c=0
b=d.j(0,"height")
b=b==null?a3:J.f8(b)
if(b==null)b=0
a=d.j(0,"darkColorValue")
if(a==null)a=4278190080
a0=d.j(0,"lightColorValue")
if(a0==null)a0=4280558628
d=d.j(0,"randomSeed")
r=new A.cP(c,b,a,a0,d==null?43:d)
d=t.N
c=t.K
b=a4.a.a
b.C(B.c.F(A.v(["progress",10,"message","Starting pattern generation..."],d,c),a3))
q=null
p=null
a=r.a
a0=r.b
o=new A.x(B.b.a6(a/5),B.b.a6(a0/3))
q=o.a
p=o.b
b.C(B.c.F(A.v(["progress",20,"message","Grid dimensions calculated: "+A.j(q)+"x"+A.j(p)],d,c),a3))
n=q
m=J.da(n,t.o)
for(l=0,a=t.n;l<n;++l){a0=l
k=p
a1=k
if(a1<0)A.S(A.H("Length must be a non-negative integer: "+A.j(a1),a3))
j=A.u(new Array(a1),a)
for(i=0;i<k;++i)J.ae(j,i,0)
J.ae(m,a0,j)}h=m
b.C(B.c.F(A.v(["progress",30,"message","Grid initialized, generating particle groups..."],d,c),a3))
A.iJ(h,r,q,p,a4)
g=new A.cQ(h,q,p,!0)
b.C(B.c.F(A.v(["result",g.ac(),"message","Pattern generation complete!"],d,c),a3))
return"completed"}catch(a2){f=A.F(a2)
e=A.P(a2)
d=J.au(f)
a4.a.a.ae(new A.I("",d,e))
return"error"}},
$S:17}
A.ek.prototype={
$1(a){},
$S:18}
A.ei.prototype={
$1(a){},
$S:19}
A.d6.prototype={
gbP(){var s=this.r
s===$&&A.jP()
return s},
gaC(){return this.a},
gaO(){var s=this.c
return new A.a9(s,A.t(s).h("a9<1>"))},
aE(){var s=this.a
if(s.gbd())return
s.gaU().N(0,A.v([B.i,B.n],t.g,t.d))},
C(a){var s=this.a
if(s.gbd())return
s.gaU().N(0,A.v([B.i,a],t.g,this.$ti.c))},
ae(a){var s=this.a
if(s.gbd())return
s.gaU().N(0,A.v([B.i,a],t.g,t.t))},
A(){var s=0,r=A.bP(t.H),q=this
var $async$A=A.bQ(function(a,b){if(a===1)return A.bK(b,r)
while(true)switch(s){case 0:s=2
return A.bJ(A.hz(A.u([q.a.A(),q.b.A(),q.c.A(),q.gbP().X()],t.M),t.H),$async$A)
case 2:return A.bL(null,r)}})
return A.bM($async$A,r)},
$id5:1}
A.aw.prototype={
gaC(){return this.a},
gaO(){return A.S(A.bm("onIsolateMessage is not implemented"))},
aE(){return A.S(A.bm("initialized method is not implemented"))},
C(a){return A.S(A.bm("sendResult is not implemented"))},
ae(a){return A.S(A.bm("sendResultError is not implemented"))},
A(){var s=0,r=A.bP(t.H),q=this
var $async$A=A.bQ(function(a,b){if(a===1)return A.bK(b,r)
while(true)switch(s){case 0:q.a.terminate()
s=2
return A.bJ(q.e.A(),$async$A)
case 2:return A.bL(null,r)}})
return A.bM($async$A,r)},
bD(a){var s,r,q,p,o,n,m,l=this
try{s=t.a5.a(A.eV(a.data))
if(s==null)return
if(J.Y(s.j(0,"type"),"data")){r=s.j(0,"value")
if(t.F.b(A.u([],l.$ti.h("o<1>")))){n=r
if(n==null)n=A.eb(n)
r=A.c2(n,t.f)}l.e.N(0,l.c.$1(r))
return}if(B.n.be(s)){n=l.r
if((n.a.a&30)===0)n.bT()
return}if(B.A.be(s)){n=l.b
if(n!=null)n.$0()
l.A()
return}if(J.Y(s.j(0,"type"),"$IsolateException")){q=A.hB(s)
l.e.az(q,q.c)
return}l.e.bS(new A.I("","Unhandled "+s.i(0)+" from the Isolate",B.e))}catch(m){p=A.F(m)
o=A.P(m)
l.e.az(new A.I("",p,o),o)}},
$id5:1}
A.c5.prototype={
b_(){return"IsolatePort."+this.b}}
A.b3.prototype={
b_(){return"IsolateState."+this.b},
be(a){return J.Y(a.j(0,"type"),"$IsolateState")&&J.Y(a.j(0,"value"),this.b)}}
A.Q.prototype={}
A.b2.prototype={$iQ:1}
A.cC.prototype={
bq(a,b,c,d){this.a.onmessage=A.fK(new A.dV(this,d))},
gaO(){var s=this.c,r=A.t(s).h("a9<1>")
return new A.aT(new A.a9(s,r),r.h("@<X.T>").D(this.$ti.y[1]).h("aT<1,2>"))},
C(a){var s=t.N,r=t.X,q=this.a
if(a instanceof A.m)q.postMessage(A.es(A.v(["type","data","value",a.gT()],s,r)))
else q.postMessage(A.es(A.v(["type","data","value",a],s,r)))},
ae(a){var s=t.N
this.a.postMessage(A.es(A.v(["type","$IsolateException","name",a.a,"value",A.v(["e",J.au(a.b),"s",a.c.i(0)],s,s)],s,t.z)))},
aE(){var s=t.N
this.a.postMessage(A.es(A.v(["type","$IsolateState","value","initialized"],s,s)))},
A(){var s=0,r=A.bP(t.H),q=this
var $async$A=A.bQ(function(a,b){if(a===1)return A.bK(b,r)
while(true)switch(s){case 0:q.a.close()
return A.bL(null,r)}})
return A.bM($async$A,r)}}
A.dV.prototype={
$1(a){var s,r=A.eV(a.data),q=this.b
if(t.F.b(A.u([],q.h("o<0>")))){s=r==null?A.eb(r):r
r=A.c2(s,t.f)}this.a.c.N(0,q.a(r))},
$S:21}
A.cB.prototype={}
A.d8.prototype={
$0(){var s=0,r=A.bP(t.H),q=this,p,o
var $async$$0=A.bQ(function(a,b){if(a===1)return A.bK(b,r)
while(true)switch(s){case 0:o=q.c
q.b.$1(o.P())
p=q.a.a
p=p==null?null:p.X()
s=2
return A.bJ(p instanceof A.k?p:A.eK(p,t.H),$async$$0)
case 2:s=3
return A.bJ(o.P().a.a.A(),$async$$0)
case 3:return A.bL(null,r)}})
return A.bM($async$$0,r)},
$S:4}
A.d9.prototype={
$1(a){return this.bm(a)},
bm(a){var s=0,r=A.bP(t.H),q=1,p=[],o=this,n,m,l,k,j,i,h
var $async$$1=A.bQ(function(b,c){if(b===1){p.push(c)
s=q}while(true)switch(s){case 0:q=3
k=o.a.$2(o.b.P(),a)
j=o.f
s=6
return A.bJ(j.h("V<0>").b(k)?k:A.eK(k,j),$async$$1)
case 6:n=c
q=1
s=5
break
case 3:q=2
h=p.pop()
m=A.F(h)
l=A.P(h)
throw h
s=5
break
case 2:s=1
break
case 5:return A.bL(null,r)
case 1:return A.bK(p.at(-1),r)}})
return A.bM($async$$1,r)},
$S(){return this.e.h("V<~>(0)")}}
A.d0.prototype={}
A.I.prototype={
i(a){return this.gaM()+": "+A.j(this.b)+"\n"+this.c.i(0)},
gaM(){return this.a}}
A.am.prototype={
gaM(){return"UnsupportedImTypeException"}}
A.m.prototype={
gT(){return this.a},
E(a,b){var s,r=this
if(b==null)return!1
if(r!==b)s=A.t(r).h("m<m.T>").b(b)&&A.aQ(r)===A.aQ(b)&&J.Y(r.a,b.a)
else s=!0
return s},
gt(a){return J.G(this.a)},
i(a){return"ImType("+A.j(this.a)+")"}}
A.cZ.prototype={
$1(a){return A.c2(a,t.f)},
$S:22}
A.d_.prototype={
$2(a,b){var s=t.f
return new A.E(A.c2(a,s),A.c2(b,s),t.c)},
$S:23}
A.c0.prototype={
bj(a){return this.a},
i(a){return"ImNum("+A.j(this.a)+")"}}
A.c1.prototype={
i(a){return"ImString("+this.a+")"}}
A.c_.prototype={
i(a){return"ImBool("+this.a+")"}}
A.b_.prototype={
E(a,b){var s
if(b==null)return!1
if(this!==b)s=b instanceof A.b_&&A.aQ(this)===A.aQ(b)&&this.bE(b.b)
else s=!0
return s},
gt(a){return A.fj(this.b)},
bE(a){var s,r,q=this.b
if(q.gk(q)!==a.gk(a))return!1
s=q.gn(q)
r=a.gn(a)
while(!0){if(!(s.l()&&r.l()))break
if(!s.gm().E(0,r.gm()))return!1}return!0},
i(a){return"ImList("+this.b.i(0)+")"}}
A.b0.prototype={
i(a){return"ImMap("+this.b.i(0)+")"}}
A.a4.prototype={
gT(){return this.b.Y(0,new A.dT(this),A.t(this).h("a4.T"))}}
A.dT.prototype={
$1(a){return a.gT()},
$S(){return A.t(this.a).h("a4.T(m<a4.T>)")}}
A.D.prototype={
gT(){var s=A.t(this)
return this.b.aL(0,new A.dU(this),s.h("D.K"),s.h("D.V"))},
E(a,b){var s
if(b==null)return!1
if(this!==b)s=b instanceof A.b0&&A.aQ(this)===A.aQ(b)&&this.bF(b.b)
else s=!0
return s},
gt(a){var s=this.b
return A.fj(new A.ai(s,A.t(s).h("ai<1,2>")))},
bF(a){var s,r,q=this.b
if(q.a!==a.a)return!1
for(q=new A.ai(q,A.t(q).h("ai<1,2>")).gn(0);q.l();){s=q.d
r=s.a
if(!a.R(r)||!J.Y(a.j(0,r),s.b))return!1}return!0}}
A.dU.prototype={
$2(a,b){return new A.E(a.gT(),b.gT(),A.t(this.a).h("E<D.K,D.V>"))},
$S(){return A.t(this.a).h("E<D.K,D.V>(m<D.K>,m<D.V>)")}};(function aliases(){var s=J.a8.prototype
s.bn=s.i})();(function installTearOffs(){var s=hunkHelpers._instance_1u,r=hunkHelpers._static_1,q=hunkHelpers._static_0,p=hunkHelpers._static_2,o=hunkHelpers._instance_2u,n=hunkHelpers._instance_0u,m=hunkHelpers.installStaticTearOff
s(A.aU.prototype,"gbG","bH",10)
r(A,"jn","i_",3)
r(A,"jo","i0",3)
r(A,"jp","i1",3)
q(A,"h_","jg",0)
r(A,"jq","j7",1)
p(A,"js","j9",2)
q(A,"jr","j8",0)
o(A.k.prototype,"gbv","bw",2)
n(A.bs.prototype,"gbI","bJ",0)
r(A,"jv","iH",5)
s(A.aw.prototype,"gbC","bD",20)
m(A,"jH",1,null,["$3","$1","$2"],["eC",function(a){return A.eC(a,B.e,"")},function(a,b){return A.eC(a,b,"")}],24,0)
m(A,"jI",1,null,["$2","$1"],["fr",function(a){return A.fr(a,B.e)}],25,0)
m(A,"h0",1,null,["$1$3$customConverter$enableWasmConverter","$1","$1$1"],["eU",function(a){return A.eU(a,null,!0,t.z)},function(a,b){return A.eU(a,null,!0,b)}],26,0)})();(function inheritance(){var s=hunkHelpers.mixin,r=hunkHelpers.inherit,q=hunkHelpers.inheritMany
r(A.b,null)
q(A.b,[A.eD,J.c4,A.bj,J.av,A.X,A.aU,A.p,A.af,A.dk,A.d,A.aA,A.cd,A.aZ,A.bA,A.aV,A.cF,A.dr,A.dj,A.aY,A.bB,A.L,A.df,A.cc,A.cb,A.dE,A.W,A.cz,A.e7,A.e5,A.cs,A.B,A.bp,A.cu,A.cv,A.aH,A.k,A.ct,A.cx,A.dF,A.cG,A.bs,A.cI,A.ea,A.cA,A.r,A.bU,A.bW,A.dZ,A.bX,A.dH,A.bk,A.dI,A.cW,A.E,A.w,A.bC,A.bl,A.di,A.dW,A.e1,A.cP,A.cQ,A.bg,A.d6,A.aw,A.Q,A.cB,A.cC,A.d0,A.I,A.m])
q(J.c4,[J.c7,J.b6,J.b8,J.b7,J.b9,J.ax,J.ay])
q(J.b8,[J.a8,J.o,A.aB,A.bd])
q(J.a8,[J.cn,J.aF,J.a7])
r(J.c6,A.bj)
r(J.db,J.o)
q(J.ax,[J.b5,J.c8])
q(A.X,[A.aT,A.aJ])
q(A.p,[A.az,A.a2,A.c9,A.cr,A.cp,A.cy,A.ba,A.bS,A.Z,A.bn,A.cq,A.al,A.bV])
q(A.af,[A.cR,A.cS,A.d1,A.dq,A.eo,A.eq,A.dz,A.dy,A.ed,A.cX,A.dR,A.dm,A.et,A.ex,A.ey,A.em,A.ek,A.ei,A.dV,A.d9,A.cZ,A.dT])
q(A.cR,[A.ev,A.dA,A.dB,A.e6,A.dJ,A.dN,A.dM,A.dL,A.dK,A.dQ,A.dP,A.dO,A.dn,A.dD,A.dC,A.e0,A.eg,A.e4,A.d8])
q(A.d,[A.e,A.ak,A.bv])
q(A.e,[A.a_,A.aj,A.ai,A.bu])
r(A.aX,A.ak)
q(A.a_,[A.a0,A.cE])
r(A.cH,A.bA)
r(A.x,A.cH)
q(A.cS,[A.cT,A.ep,A.ee,A.eh,A.cY,A.dS,A.dh,A.e_,A.ej,A.d_,A.dU])
r(A.aW,A.aV)
r(A.b1,A.d1)
r(A.bf,A.a2)
q(A.dq,[A.dl,A.aS])
q(A.L,[A.ah,A.bt,A.cD])
q(A.bd,[A.ce,A.aC])
q(A.aC,[A.bw,A.by])
r(A.bx,A.bw)
r(A.bb,A.bx)
r(A.bz,A.by)
r(A.bc,A.bz)
q(A.bb,[A.cf,A.cg])
q(A.bc,[A.ch,A.ci,A.cj,A.ck,A.cl,A.be,A.cm])
r(A.bD,A.cy)
r(A.bq,A.aJ)
r(A.a9,A.bq)
r(A.br,A.bp)
r(A.aG,A.br)
r(A.bo,A.cu)
r(A.an,A.cv)
q(A.cx,[A.cw,A.dG])
r(A.e3,A.ea)
r(A.aI,A.bt)
r(A.ca,A.ba)
r(A.dc,A.bU)
q(A.bW,[A.de,A.dd])
r(A.dY,A.dZ)
q(A.Z,[A.aE,A.c3])
q(A.dH,[A.c5,A.b3])
r(A.b2,A.cB)
r(A.am,A.I)
q(A.m,[A.c0,A.c1,A.c_,A.a4,A.D])
r(A.b_,A.a4)
r(A.b0,A.D)
s(A.bw,A.r)
s(A.bx,A.aZ)
s(A.by,A.r)
s(A.bz,A.aZ)
s(A.cB,A.d0)})()
var v={G:typeof self!="undefined"?self:globalThis,typeUniverse:{eC:new Map(),tR:{},eT:{},tPV:{},sEA:[]},mangledGlobalNames:{a:"int",l:"double",a6:"num",f:"String",aq:"bool",w:"Null",i:"List",b:"Object",K:"Map",q:"JSObject"},mangledNames:{},types:["~()","~(@)","~(b,C)","~(~())","V<~>()","@(@)","w(@)","w()","~(b?,b?)","b?(b?)","~(b?)","@(@,f)","@(f)","w(~())","w(@,C)","~(a,@)","w(b,C)","f(Q<f,f>,f)","w(Q<f,f>)","~(Q<f,f>)","~(q)","w(q)","m<b>(@)","E<m<b>,m<b>>(@,@)","I(b[C,f])","am(b[C])","0^(@{customConverter:0^(@)?,enableWasmConverter:aq})<b?>"],interceptorsByTag:null,leafTags:null,arrayRti:Symbol("$ti"),rttc:{"2;":(a,b)=>c=>c instanceof A.x&&a.b(c.a)&&b.b(c.b)}}
A.ik(v.typeUniverse,JSON.parse('{"cn":"a8","aF":"a8","a7":"a8","jU":"aB","c7":{"aq":[],"n":[]},"b6":{"w":[],"n":[]},"b8":{"q":[]},"a8":{"q":[]},"o":{"i":["1"],"e":["1"],"q":[],"d":["1"]},"c6":{"bj":[]},"db":{"o":["1"],"i":["1"],"e":["1"],"q":[],"d":["1"]},"ax":{"l":[],"a6":[]},"b5":{"l":[],"a":[],"a6":[],"n":[]},"c8":{"l":[],"a6":[],"n":[]},"ay":{"f":[],"n":[]},"aT":{"X":["2"],"X.T":"2"},"az":{"p":[]},"e":{"d":["1"]},"a_":{"e":["1"],"d":["1"]},"ak":{"d":["2"],"d.E":"2"},"aX":{"ak":["1","2"],"e":["2"],"d":["2"],"d.E":"2"},"a0":{"a_":["2"],"e":["2"],"d":["2"],"d.E":"2","a_.E":"2"},"aV":{"K":["1","2"]},"aW":{"aV":["1","2"],"K":["1","2"]},"bv":{"d":["1"],"d.E":"1"},"bf":{"a2":[],"p":[]},"c9":{"p":[]},"cr":{"p":[]},"bB":{"C":[]},"cp":{"p":[]},"ah":{"L":["1","2"],"K":["1","2"],"L.V":"2"},"aj":{"e":["1"],"d":["1"],"d.E":"1"},"ai":{"e":["E<1,2>"],"d":["E<1,2>"],"d.E":"E<1,2>"},"aB":{"q":[],"eA":[],"n":[]},"bd":{"q":[]},"ce":{"eB":[],"q":[],"n":[]},"aC":{"J":["1"],"q":[]},"bb":{"r":["l"],"i":["l"],"J":["l"],"e":["l"],"q":[],"d":["l"]},"bc":{"r":["a"],"i":["a"],"J":["a"],"e":["a"],"q":[],"d":["a"]},"cf":{"cU":[],"r":["l"],"i":["l"],"J":["l"],"e":["l"],"q":[],"d":["l"],"n":[],"r.E":"l"},"cg":{"cV":[],"r":["l"],"i":["l"],"J":["l"],"e":["l"],"q":[],"d":["l"],"n":[],"r.E":"l"},"ch":{"d2":[],"r":["a"],"i":["a"],"J":["a"],"e":["a"],"q":[],"d":["a"],"n":[],"r.E":"a"},"ci":{"d3":[],"r":["a"],"i":["a"],"J":["a"],"e":["a"],"q":[],"d":["a"],"n":[],"r.E":"a"},"cj":{"d4":[],"r":["a"],"i":["a"],"J":["a"],"e":["a"],"q":[],"d":["a"],"n":[],"r.E":"a"},"ck":{"dt":[],"r":["a"],"i":["a"],"J":["a"],"e":["a"],"q":[],"d":["a"],"n":[],"r.E":"a"},"cl":{"du":[],"r":["a"],"i":["a"],"J":["a"],"e":["a"],"q":[],"d":["a"],"n":[],"r.E":"a"},"be":{"dv":[],"r":["a"],"i":["a"],"J":["a"],"e":["a"],"q":[],"d":["a"],"n":[],"r.E":"a"},"cm":{"dw":[],"r":["a"],"i":["a"],"J":["a"],"e":["a"],"q":[],"d":["a"],"n":[],"r.E":"a"},"cy":{"p":[]},"bD":{"a2":[],"p":[]},"B":{"p":[]},"a9":{"aJ":["1"],"X":["1"],"X.T":"1"},"aG":{"bp":["1"]},"bo":{"cu":["1"]},"an":{"cv":["1"]},"k":{"V":["1"]},"bq":{"aJ":["1"],"X":["1"]},"br":{"bp":["1"]},"aJ":{"X":["1"]},"bt":{"L":["1","2"],"K":["1","2"]},"aI":{"bt":["1","2"],"L":["1","2"],"K":["1","2"],"L.V":"2"},"bu":{"e":["1"],"d":["1"],"d.E":"1"},"L":{"K":["1","2"]},"cD":{"L":["f","@"],"K":["f","@"],"L.V":"@"},"cE":{"a_":["f"],"e":["f"],"d":["f"],"d.E":"f","a_.E":"f"},"ba":{"p":[]},"ca":{"p":[]},"l":{"a6":[]},"a":{"a6":[]},"i":{"e":["1"],"d":["1"]},"jW":{"e":["1"],"d":["1"]},"bS":{"p":[]},"a2":{"p":[]},"Z":{"p":[]},"aE":{"p":[]},"c3":{"p":[]},"bn":{"p":[]},"cq":{"p":[]},"al":{"p":[]},"bV":{"p":[]},"bk":{"p":[]},"bC":{"C":[]},"d6":{"d5":["1","2"]},"aw":{"d5":["1","2"]},"b2":{"Q":["1","2"]},"am":{"I":[]},"c0":{"m":["a6"],"m.T":"a6"},"c1":{"m":["f"],"m.T":"f"},"c_":{"m":["aq"],"m.T":"aq"},"b_":{"a4":["b"],"m":["d<b>"],"m.T":"d<b>","a4.T":"b"},"b0":{"D":["b","b"],"m":["K<b,b>"],"m.T":"K<b,b>","D.K":"b","D.V":"b"},"a4":{"m":["d<1>"]},"D":{"m":["K<1,2>"]},"d4":{"i":["a"],"e":["a"],"d":["a"]},"dw":{"i":["a"],"e":["a"],"d":["a"]},"dv":{"i":["a"],"e":["a"],"d":["a"]},"d2":{"i":["a"],"e":["a"],"d":["a"]},"dt":{"i":["a"],"e":["a"],"d":["a"]},"d3":{"i":["a"],"e":["a"],"d":["a"]},"du":{"i":["a"],"e":["a"],"d":["a"]},"cU":{"i":["l"],"e":["l"],"d":["l"]},"cV":{"i":["l"],"e":["l"],"d":["l"]}}'))
A.ij(v.typeUniverse,JSON.parse('{"aZ":1,"aC":1,"bq":1,"br":1,"cx":1,"bU":2,"bW":2}'))
var u={c:"Error handler must accept one Object or one Object and a StackTrace as arguments, and return a value of the returned future's type",h:"handleError callback must take either an Object (the error), or both an Object (the error) and a StackTrace."}
var t=(function rtii(){var s=A.aP
return{J:s("eA"),Y:s("eB"),V:s("e<@>"),C:s("p"),B:s("cU"),q:s("cV"),Z:s("jS"),f:s("m<b>"),O:s("d2"),e:s("d3"),U:s("d4"),r:s("d5<@,@>"),t:s("I"),g:s("c5"),d:s("b3"),R:s("d<@>"),M:s("o<V<~>>"),b:s("o<i<l>>"),W:s("o<bg>"),w:s("o<+(a,a)>"),s:s("o<f>"),n:s("o<l>"),x:s("o<@>"),T:s("b6"),m:s("q"),L:s("a7"),E:s("J<@>"),F:s("i<m<b>>"),o:s("i<l>"),j:s("i<@>"),c:s("E<m<b>,m<b>>"),G:s("K<@,@>"),P:s("w"),K:s("b"),cY:s("jV"),cD:s("+()"),l:s("C"),N:s("f"),bW:s("n"),_:s("a2"),c0:s("dt"),bk:s("du"),ca:s("dv"),bX:s("dw"),cr:s("aF"),h:s("an<~>"),aY:s("k<@>"),a:s("k<a>"),D:s("k<~>"),A:s("aI<b?,b?>"),y:s("aq"),i:s("l"),z:s("@"),v:s("@(b)"),Q:s("@(b,C)"),S:s("a"),bc:s("V<w>?"),aQ:s("q?"),a5:s("K<@,@>?"),X:s("b?"),aD:s("f?"),cG:s("aq?"),I:s("l?"),a3:s("a?"),ae:s("a6?"),p:s("a6"),H:s("~"),u:s("~(b)"),k:s("~(b,C)")}})();(function constants(){var s=hunkHelpers.makeConstList
B.z=J.c4.prototype
B.o=J.o.prototype
B.a=J.b5.prototype
B.b=J.ax.prototype
B.h=J.ay.prototype
B.B=J.a7.prototype
B.C=J.b8.prototype
B.p=J.cn.prototype
B.j=J.aF.prototype
B.k=function getTagFallback(o) {
  var s = Object.prototype.toString.call(o);
  return s.substring(8, s.length - 1);
}
B.r=function() {
  var toStringFunction = Object.prototype.toString;
  function getTag(o) {
    var s = toStringFunction.call(o);
    return s.substring(8, s.length - 1);
  }
  function getUnknownTag(object, tag) {
    if (/^HTML[A-Z].*Element$/.test(tag)) {
      var name = toStringFunction.call(object);
      if (name == "[object Object]") return null;
      return "HTMLElement";
    }
  }
  function getUnknownTagGenericBrowser(object, tag) {
    if (object instanceof HTMLElement) return "HTMLElement";
    return getUnknownTag(object, tag);
  }
  function prototypeForTag(tag) {
    if (typeof window == "undefined") return null;
    if (typeof window[tag] == "undefined") return null;
    var constructor = window[tag];
    if (typeof constructor != "function") return null;
    return constructor.prototype;
  }
  function discriminator(tag) { return null; }
  var isBrowser = typeof HTMLElement == "function";
  return {
    getTag: getTag,
    getUnknownTag: isBrowser ? getUnknownTagGenericBrowser : getUnknownTag,
    prototypeForTag: prototypeForTag,
    discriminator: discriminator };
}
B.x=function(getTagFallback) {
  return function(hooks) {
    if (typeof navigator != "object") return hooks;
    var userAgent = navigator.userAgent;
    if (typeof userAgent != "string") return hooks;
    if (userAgent.indexOf("DumpRenderTree") >= 0) return hooks;
    if (userAgent.indexOf("Chrome") >= 0) {
      function confirm(p) {
        return typeof window == "object" && window[p] && window[p].name == p;
      }
      if (confirm("Window") && confirm("HTMLElement")) return hooks;
    }
    hooks.getTag = getTagFallback;
  };
}
B.t=function(hooks) {
  if (typeof dartExperimentalFixupGetTag != "function") return hooks;
  hooks.getTag = dartExperimentalFixupGetTag(hooks.getTag);
}
B.w=function(hooks) {
  if (typeof navigator != "object") return hooks;
  var userAgent = navigator.userAgent;
  if (typeof userAgent != "string") return hooks;
  if (userAgent.indexOf("Firefox") == -1) return hooks;
  var getTag = hooks.getTag;
  var quickMap = {
    "BeforeUnloadEvent": "Event",
    "DataTransfer": "Clipboard",
    "GeoGeolocation": "Geolocation",
    "Location": "!Location",
    "WorkerMessageEvent": "MessageEvent",
    "XMLDocument": "!Document"};
  function getTagFirefox(o) {
    var tag = getTag(o);
    return quickMap[tag] || tag;
  }
  hooks.getTag = getTagFirefox;
}
B.v=function(hooks) {
  if (typeof navigator != "object") return hooks;
  var userAgent = navigator.userAgent;
  if (typeof userAgent != "string") return hooks;
  if (userAgent.indexOf("Trident/") == -1) return hooks;
  var getTag = hooks.getTag;
  var quickMap = {
    "BeforeUnloadEvent": "Event",
    "DataTransfer": "Clipboard",
    "HTMLDDElement": "HTMLElement",
    "HTMLDTElement": "HTMLElement",
    "HTMLPhraseElement": "HTMLElement",
    "Position": "Geoposition"
  };
  function getTagIE(o) {
    var tag = getTag(o);
    var newTag = quickMap[tag];
    if (newTag) return newTag;
    if (tag == "Object") {
      if (window.DataView && (o instanceof window.DataView)) return "DataView";
    }
    return tag;
  }
  function prototypeForTagIE(tag) {
    var constructor = window[tag];
    if (constructor == null) return null;
    return constructor.prototype;
  }
  hooks.getTag = getTagIE;
  hooks.prototypeForTag = prototypeForTagIE;
}
B.u=function(hooks) {
  var getTag = hooks.getTag;
  var prototypeForTag = hooks.prototypeForTag;
  function getTagFixed(o) {
    var tag = getTag(o);
    if (tag == "Document") {
      if (!!o.xmlVersion) return "!Document";
      return "!HTMLDocument";
    }
    return tag;
  }
  function prototypeForTagFixed(tag) {
    if (tag == "Document") return null;
    return prototypeForTag(tag);
  }
  hooks.getTag = getTagFixed;
  hooks.prototypeForTag = prototypeForTagFixed;
}
B.l=function(hooks) { return hooks; }

B.c=new A.dc()
B.f=new A.dk()
B.y=new A.dF()
B.m=new A.dW()
B.d=new A.e3()
B.i=new A.c5("main")
B.A=new A.b3("dispose")
B.n=new A.b3("initialized")
B.D=new A.dd(null)
B.E=new A.de(null)
B.F=s([],A.aP("o<0&>"))
B.H={}
B.G=new A.aW(B.H,[],A.aP("aW<0&,0&>"))
B.I=A.T("eA")
B.J=A.T("eB")
B.K=A.T("cU")
B.L=A.T("cV")
B.M=A.T("d2")
B.N=A.T("d3")
B.O=A.T("d4")
B.q=A.T("q")
B.P=A.T("b")
B.Q=A.T("dt")
B.R=A.T("du")
B.S=A.T("dv")
B.T=A.T("dw")
B.e=new A.bC("")})();(function staticFields(){$.dX=null
$.at=A.u([],A.aP("o<b>"))
$.fk=null
$.fc=null
$.fb=null
$.h2=null
$.fZ=null
$.h7=null
$.en=null
$.er=null
$.eZ=null
$.e2=A.u([],A.aP("o<i<b>?>"))
$.aK=null
$.bN=null
$.bO=null
$.eR=!1
$.h=B.d
$.hC=A.u([A.jH(),A.jI()],A.aP("o<I(b,C)>"))})();(function lazyInitializers(){var s=hunkHelpers.lazyFinal
s($,"jR","f1",()=>A.jA("_$dart_dartClosure"))
s($,"ka","hl",()=>B.d.bh(new A.ev()))
s($,"k9","hk",()=>A.u([new J.c6()],A.aP("o<bj>")))
s($,"jY","ha",()=>A.a3(A.ds({
toString:function(){return"$receiver$"}})))
s($,"jZ","hb",()=>A.a3(A.ds({$method$:null,
toString:function(){return"$receiver$"}})))
s($,"k_","hc",()=>A.a3(A.ds(null)))
s($,"k0","hd",()=>A.a3(function(){var $argumentsExpr$="$arguments$"
try{null.$method$($argumentsExpr$)}catch(r){return r.message}}()))
s($,"k3","hg",()=>A.a3(A.ds(void 0)))
s($,"k4","hh",()=>A.a3(function(){var $argumentsExpr$="$arguments$"
try{(void 0).$method$($argumentsExpr$)}catch(r){return r.message}}()))
s($,"k2","hf",()=>A.a3(A.fq(null)))
s($,"k1","he",()=>A.a3(function(){try{null.$method$}catch(r){return r.message}}()))
s($,"k6","hj",()=>A.a3(A.fq(void 0)))
s($,"k5","hi",()=>A.a3(function(){try{(void 0).$method$}catch(r){return r.message}}()))
s($,"k7","f3",()=>A.hZ())
s($,"jT","f2",()=>$.hl())
s($,"k8","cN",()=>A.ew(B.P))})();(function nativeSupport(){!function(){var s=function(a){var m={}
m[a]=1
return Object.keys(hunkHelpers.convertToFastObject(m))[0]}
v.getIsolateTag=function(a){return s("___dart_"+a+v.isolateTag)}
var r="___dart_isolate_tags_"
var q=Object[r]||(Object[r]=Object.create(null))
var p="_ZxYxX"
for(var o=0;;o++){var n=s(p+"_"+o+"_")
if(!(n in q)){q[n]=1
v.isolateTag=n
break}}v.dispatchPropertyName=v.getIsolateTag("dispatch_record")}()
hunkHelpers.setOrUpdateInterceptorsByTag({ArrayBuffer:A.aB,SharedArrayBuffer:A.aB,ArrayBufferView:A.bd,DataView:A.ce,Float32Array:A.cf,Float64Array:A.cg,Int16Array:A.ch,Int32Array:A.ci,Int8Array:A.cj,Uint16Array:A.ck,Uint32Array:A.cl,Uint8ClampedArray:A.be,CanvasPixelArray:A.be,Uint8Array:A.cm})
hunkHelpers.setOrUpdateLeafTags({ArrayBuffer:true,SharedArrayBuffer:true,ArrayBufferView:false,DataView:true,Float32Array:true,Float64Array:true,Int16Array:true,Int32Array:true,Int8Array:true,Uint16Array:true,Uint32Array:true,Uint8ClampedArray:true,CanvasPixelArray:true,Uint8Array:false})
A.aC.$nativeSuperclassTag="ArrayBufferView"
A.bw.$nativeSuperclassTag="ArrayBufferView"
A.bx.$nativeSuperclassTag="ArrayBufferView"
A.bb.$nativeSuperclassTag="ArrayBufferView"
A.by.$nativeSuperclassTag="ArrayBufferView"
A.bz.$nativeSuperclassTag="ArrayBufferView"
A.bc.$nativeSuperclassTag="ArrayBufferView"})()
Function.prototype.$0=function(){return this()}
Function.prototype.$1=function(a){return this(a)}
Function.prototype.$2=function(a,b){return this(a,b)}
Function.prototype.$3=function(a,b,c){return this(a,b,c)}
Function.prototype.$4=function(a,b,c,d){return this(a,b,c,d)}
Function.prototype.$1$1=function(a){return this(a)}
Function.prototype.$2$1=function(a){return this(a)}
convertAllToFastObject(w)
convertToFastObject($);(function(a){if(typeof document==="undefined"){a(null)
return}if(typeof document.currentScript!="undefined"){a(document.currentScript)
return}var s=document.scripts
function onLoad(b){for(var q=0;q<s.length;++q){s[q].removeEventListener("load",onLoad,false)}a(b.target)}for(var r=0;r<s.length;++r){s[r].addEventListener("load",onLoad,false)}})(function(a){v.currentScript=a
var s=A.jK
if(typeof dartMainRunner==="function"){dartMainRunner(s,[])}else{s([])}})})()