-- DDL
drop table user;
create table user(
	no int unsigned not null auto_increment,
    email varchar(100) not null default '',
    passwd varchar(64) not null default '',
    name varchar(25),
	dept_name varchar(25),
    
    primary key(no)
);

insert into user values(null,'dltjdgnsok1@naver.com',password('1234'), '이성훈', '개발팀');

alter table user add juminbunho char(13) not null after no;
alter table user drop juminbunho;
alter table user add join_date datetime default now();
alter table user change email email varchar(200) not null default 'no email';
alter table user change dept_name department_name varchar(25);
alter table user rename users;


-- update(DML)
update user
   set email = 'dltjdgnsok1@naver.com',
		name = '이성훈'
where no = 1;

-- delete(DML)
delete 
 from user
 where no = 4;


select * from user;
