select * from dept; -- 部门
select * from emp; -- 人员
select * from job; -- 职称描述
select * from salarygrade; -- 工资等级
select * from emp,dept,job;
select * from emp,dept where dept.`id` = emp.`dept_id`;
select 员工.`ename` 姓名,职务.`dname` 分部 from emp 员工 join dept 职务 on 员工.`dept_id`=职务.`id` ;
select 员工.`ename` 姓名,职务.`dname` 分部 from emp 员工 join dept 职务 on 员工.`dept_id`=职务.`id` ;
select * from emp  left join dept  on emp.`dept_id`= dept.`id` ;
select * from emp where emp.`salary` <(select AVG(salary) from emp) ;
select * from emp e
where e.`dept_id` in (select id from dept d where d.dname in( '教研部' ,'学工部'));
select * from dept d,(select  ename,joindate, salary from emp e where e.`joindate`>'2001-01-01')
where ;


-- 1.查询所有员工信息。查询员工编号，员工姓名，工资，职务名称，职务描述
select 
	e.id 员工编号,
	e.`ename` 员工姓名,
	e.`salary` 工资,
	j.`jname` 职务名称 ,
	j.`description` 职务描述 
from emp e join job j 
on e.`job_id`=j.`id`;  

-- 2.查询员工编号，员工姓名，工资，职务名称，职务描述，部门名称，部门位置
select 
	e.id 员工编号,
	e.`ename` 员工姓名,
	e.`salary` 工资,
	j.`jname` 职务名称 ,
	j.`description` 职务描述 ,
	d.`dname` 部门名称,
	d.`loc` 部门位置
from emp e , job j ,dept d 
where e.`job_id`=j.`id` and e.`dept_id`=d.`id` ;  

-- 3.查询员工姓名，工资，工资等级
select 
	e.`ename` 员工姓名,
	e.`salary` 工资 ,
	 s.`grade` 工资等级 
from emp e , salarygrade s 
where e.`salary`>=s.`losalary`&& e.`salary`<=s.`hisalary`;

-- 4.查询员工姓名，工资，职务名称，职务描述，部门名称，部门位置，工资等级
select 
	 e.`ename` 姓名,
	 e.`salary` 工资 ,
	 j.`jname` 职务名称 ,
	 j.`description` 职务描述 ,
	 d.`dname` 部门名称,
	 d.`loc` 部门位置,
	 s.`grade` 工资等级 
from emp e , salarygrade s ,job j ,dept d 
where  
	e.`job_id`=j.`id`
	and e.`dept_id`=d.`id`
	and e.`salary` between s.`losalary` and s.`hisalary` ;
	

-- 5.查询出部门编号、部门名称、部门位置、部门人数
select 
	d.`id` 部门编号 , 
	d.`dname` 部门名称,
	d.loc 部门位置,
	count(e.`id`) 部门人数
from dept d  left join emp e 
on e.`dept_id`=d.`id`
group by d.`id`;

-- 6.查询所有员工的姓名及其直接上级的姓名,没有领导的员工也需要查询
SELECT 
	e1.`id` 员工编号,
	e1.ename 员工姓名,
	e1.mgr 上司编号,
	e2.`ename` 上司姓名
FROM emp e1
LEFT JOIN emp e2
ON e1.`mgr` = e2.`id`;

-- 查询和唐僧同一职务的员工编号、员工姓名、部门名称
select e1.`id`,e1.`ename`,d.`dname`
from emp e1, dept d ,(select job_id from emp  where ename='唐僧') e2
where  e1.`dept_id`=d.`id` and e1.`job_id`= e2.job_id and e1.`ename`<>'唐僧';



-- 查询出每个部门的平均工资与员工数量
select d.`dname`平均工资 , avg(ifnull(salary,0)) 平均工资, count(e.`id`) 员工数量 
from emp e right join dept d
on e.`dept_id`=d.`id`
group by d.`dname`;

-- 查询出每一个部门的最低工资，和最低工资员工姓名，和该员工所在部门名称

select e1.最低工资, e1.姓名 员工姓名,d.`dname` 员工部门;
select d.`dname` 员工部门 ,e1.最低工资 ,e1.姓名
from emp e , dept d , 
	(select d.id 部门号, d.dname 部门, e.salary 最低工资 ,e.`ename` 姓名
	from emp e,dept d  
	where e.`dept_id`=d.`id`
	) e1
where e.dept_id =e1.部门号 and e.`dept_id`=d.`id` 
group by d.`dname`;




 select * 
 from emp 
 where 
 salary in
 (select min(salary) from emp where dept_id is not null group by dept_id);




dept_id  in
 (select dept_id from emp where dept_id is not null group by dept_id)
 and







select *
from emp e

group by e.dept_id;



SELECT * 
FROM emp e,(SELECT dept_id,MIN(salary) mi FROM emp WHERE dept_id IS NOT NULL GROUP BY dept_id) a
WHERE e.dept_id=a.dept_id AND e.salary=a.mi ;

select *
from emp e,
	(select dept_id id,min(salary) mi
	from emp
	where dept_id is not null 
	group by dept_id) e2
where e.`dept_id`=e2.id and e.`salary`=e2.mi;










