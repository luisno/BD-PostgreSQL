select p.producto , p.nombre, count(v.producto)  from productos p 
left join venta v on p.producto = v.producto
group by p.producto, nombre 
order by count(v.producto) desc;

select c.nom_apelis, p.nombre, p.precio, mr.piso  
from venta v ,cajeros c, productos p, maquinas_registradoras mr
where c.cajero =v.cajero and p.producto = v.producto and mr.maquina = v.maquina;

select mr.piso, sum(p.precio) 
from maquinas_registradoras mr, productos p , venta v
where p.producto = v.producto 
and v.maquina = mr.maquina
group by piso ;


select c.cajero , c.nom_apelis, sum(p.precio)
from cajeros c, venta v , productos p
where c.cajero = v.cajero 
and v.producto = p.producto 
group by c.cajero ;


select c.cajero , c.nom_apelis  
from cajeros c 
where c.cajero in (
select cajero from venta v where v.maquina in (
select mr.maquina  from maquinas_registradoras mr where mr.piso in (
select mr2.piso  from venta v2 , productos p , maquinas_registradoras mr2
where v2.producto = p.producto 
and v2.maquina = mr2.maquina  
group by mr2.piso 
having sum(p.precio::numeric) >5000 )))