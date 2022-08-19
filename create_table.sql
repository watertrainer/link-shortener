CREATE Table shortls (shortl varchar(7) Primary key not null,
url TEXT unique not null,
viewed integer default 0,
shortened integer default 0);