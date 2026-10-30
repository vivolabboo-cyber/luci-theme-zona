/* Zona theme 1.1.0: read-only live summary. */
'use strict';
'require baseclass';
'require rpc';
'require poll';
'require fs';
return baseclass.extend({
__init__:function(){
var ru=document.documentElement.lang.toLowerCase().startsWith('ru');var t=(en,rus)=>ru?rus:en;var main=document.querySelector('#maincontent>.container');if(!main)return;
var wrap=E('section',{'class':'zona-overview-summary'},[E('h2',{'class':'zona-summary-title'},t("System overview","Состояние системы"))]);
var grid=E('div',{'class':'zona-summary'});wrap.appendChild(grid);
var labels=[t("Load \u00b7 1 min","Нагрузка · 1 мин"),t("Memory \u00b7 used","Память · занято"),t("Temperature","Температура"),t("Uptime","Время работы")];var values=[];
labels.forEach(function(label){var v=E('div',{'class':'zona-metric-value'},'—');values.push(v);grid.appendChild(E('div',{'class':'zona-metric'},[E('div',{'class':'zona-metric-label'},label),v,E('div',{'class':'zona-metric-line'})]));});
main.prepend(wrap);
var info=rpc.declare({object:'system',method:'info',expect:{'':{}}});
var update=function(){return Promise.all([info(),fs.exec('/bin/cat',['/sys/class/thermal/thermal_zone0/temp']).then(function(r){return r.stdout;}).catch(function(){return '';})]).then(function(result){var s=result[0],m=s.memory||{};values[0].textContent=s.load?(s.load[0]/65536).toFixed(2):'—';values[1].textContent=m.total?Math.round((m.total-m.free-m.buffered-(m.cached||0))/1048576)+' / '+Math.round(m.total/1048576)+t(" MiB"," МБ"):'—';var temperatureValue=parseFloat(result[1]);values[2].textContent=Number.isFinite(temperatureValue)?(temperatureValue/1000).toFixed(0)+' °C':'—';var u=s.uptime||0;values[3].textContent=Math.floor(u/86400)+t(" d "," д ")+Math.floor(u%86400/3600)+t(" h "," ч ")+Math.floor(u%3600/60)+t(" m"," м");});};update().catch(function(){});poll.add(update,10);
}
});
