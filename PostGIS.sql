--Create table
Create table buffer_alley (
id serial,
geom geometry(MultiPolygon)
);

--Insert geometrically and topologically correct data in table
Insert into buffer_alley (geom)
SELECT 
    st_buffer(st_buffer(st_makevalid(geom), 0.01), -0.01)
FROM public."Alley_Reproject";

--Create table
Create table buffer_foot (
id serial,
geom geometry(MultiPolygon)
);

--Insert geometrically and topologically correct data in table
Insert into buffer_foot (geom)
SELECT 
    st_buffer(st_buffer(st_makevalid(geom), 0.01), -0.01)
FROM public."Footpath_Reproject";

--Create table
Create table buffer_unc (
id serial,
geom geometry(MultiPolygon)
);

--Insert geometrically and topologically correct data in table
Insert into buffer_unc (geom)
SELECT 
    st_buffer(st_buffer(st_makevalid(geom), 0.01), -0.01)
FROM public."Uncertain_Reproject";

--Create table
Create table Alley_Cleaned (
id serial,
geom geometry(Polygon)
);

--Create table
Create table cntrlAlley (
id serial,
geom geometry(MultiLineString)
);

--Extract centrelines
Insert into cntrlAlley (geom)
SELECT 
      ST_ApproximateMedialAxis( (ST_MakeValid((ST_Dump(geom)).geom))) 
FROM public."buffer_alley";

--Buffer
Insert into Alley_Cleaned (geom)
Select ST_Buffer(geom, 0.2, 'endcap=square join=round')
From public.cntrlalley;

--Create table
Create table Unc_Cleaned (
id serial,
geom geometry(Polygon)
);

--Create table
Create table cntrlUncertain (
id serial,
geom geometry(MultiLineString)
);

--Extract centrelines
Insert into cntrlUncertain (geom)
SELECT 
      ST_ApproximateMedialAxis( (ST_MakeValid((ST_Dump(geom)).geom))) 
FROM public."buffer_unc";

--Buffer
Insert into Alley_Cleaned (geom)
Select ST_Buffer(geom, 0.2, 'endcap=square join=round')
From public.cntrlUncertain;

--Create table
Create table Foot_Cleaned (
id serial,
geom geometry(Polygon)
);

--Create table
Create table cntrlFoot (
id serial,
geom geometry(MultiLineString)
);

--Extract centrelines
Insert into cntrlFoot (geom)
SELECT 
      ST_ApproximateMedialAxis( (ST_MakeValid((ST_Dump(geom)).geom))) 
FROM public."buffer_foot";

--Buffer
Insert into Foot_Cleaned (geom)
Select ST_Buffer(geom, 0.2, 'endcap=square join=round')
From public.cntrlFoot;