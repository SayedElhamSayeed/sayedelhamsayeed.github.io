
-- This Project is based on the American reality television series Monumental Mysteries.
-- The goal of this project is to make it easier to look for specific things in a monument, such as features of monument, location, type, source, subject and more.
-- This project makes great use of logic to create reasonable tables, and reasonable keys such as primary and foreign keys to keep the tables together.



-- Dropping tables if they already exist before creating the actual tables
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE segment_subject';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE subject';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE segment_source';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE source';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE segment_person';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE person';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE segment_secondary_location';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE sec_location';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE segment_monument';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE monument_type';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE type';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;


    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE monument';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE  segment';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE  episode';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE  season';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;


END;
/

-- Creating tables 

CREATE TABLE season (
    season_id            NUMBER PRIMARY KEY
);

CREATE TABLE episode (
    episode_id           NUMBER PRIMARY KEY,
    title                VARCHAR(255),
    season_id            NUMBER,
    FOREIGN KEY (season_id) REFERENCES season(season_id)
);

CREATE TABLE segment (
    segment_id           NUMBER PRIMARY KEY,
    episode_id           NUMBER,
    segment_num          NUMBER,
    segment_primary_loc  VARCHAR(255),
    wiki_description     VARCHAR(255),
    FOREIGN KEY (episode_id) REFERENCES episode(episode_id)
);

CREATE TABLE monument (
    monument_id          NUMBER PRIMARY KEY,
    monument_name        VARCHAR(255),
    decade               NUMBER
);

CREATE TABLE type (
   type_id               NUMBER PRIMARY KEY,
   type_name             VARCHAR(255)
);

CREATE TABLE monument_type (
    monument_id          NUMBER NOT NULL REFERENCES monument(monument_id),
    type_id              NUMBER NOT NULL REFERENCES type(type_id)
);

CREATE TABLE segment_monument (
    segment_id           NUMBER NOT NULL REFERENCES segment(segment_id),
    monument_id          NUMBER NOT NULL REFERENCES monument(monument_id)
);

CREATE TABLE sec_location (
    location_id          NUMBER PRIMARY KEY,
    location_name        VARCHAR(255)
);

CREATE TABLE segment_secondary_location (
    location_id          NUMBER NOT NULL REFERENCES sec_location(location_id),
    segment_id           NUMBER NOT NULL REFERENCES segment(segment_id)
);

CREATE TABLE person (
    person_id            NUMBER PRIMARY KEY,
    name                 VARCHAR(255)
);

CREATE TABLE segment_person (
    person_id            NUMBER NOT NULL REFERENCES person(person_id),
    segment_id           NUMBER NOT NULL REFERENCES segment(segment_id)

);

CREATE TABLE source (
    source_id            NUMBER PRIMARY KEY,
    source_name          VARCHAR(255)
);

CREATE TABLE segment_source (
    source_id            NUMBER NOT NULL REFERENCES source(source_id),
    segment_id           NUMBER NOT NULL REFERENCES segment(segment_id)
  
);

CREATE TABLE subject (
    subject_id           NUMBER PRIMARY KEY,
    subject_name         VARCHAR(255)
); 

CREATE Table segment_subject (
    subject_id           NUMBER NOT NULL REFERENCES subject(subject_id),
    segment_id           NUMBER NOT NULL REFERENCES segment(segment_id)
);

INSERT INTO season (season_id) VALUES (3);

INSERT INTO episode (episode_id, title, season_id) VALUES (1, 'Destiny Stone; Niagara Falls; Madness of Mary Todd', 3);
INSERT INTO episode (episode_id, title, season_id) VALUES (2, 'Freedom Balloon; First Film Star; Freuds Therapy Dog', 3);

INSERT INTO segment (segment_id, episode_id, segment_num, segment_primary_loc, wiki_description) VALUES (1, 1, 1, 'Westminster Abbey, London, England', 'Don visits the famous London church, Westminster Abbey that set the stage for an audacious heist when Scottish Nationalist Ian Hamilton stole the Stone of Destiny.');
INSERT INTO segment (segment_id, episode_id, segment_num, segment_primary_loc, wiki_description) VALUES (2, 1, 2, 'West Orange, New Jersey', 'Don examines the story behind the Thomas Edison bust in West Orange, New Jersey and who invented motion pictures, Edison or French inventor Louis Le Prince.');
INSERT INTO segment (segment_id, episode_id, segment_num, segment_primary_loc, wiki_description) VALUES (3, 1, 3, 'Washington, D.C.', 'Don learns the Washington Monument in Washington, D.C. became a site to a standoff on December 8, 1982 when nine tourists were held hostage by nuclear bomb activist, Norman Mayer, who parked a dynamite-packed truck nearby.');
INSERT INTO segment (segment_id, episode_id, segment_num, segment_primary_loc, wiki_description) VALUES (4, 1, 4, 'Niagara Falls, New York', 'Don discovers the natural wonder of Niagara Falls, Mother Nature threatened to shut down in 1965.');
INSERT INTO segment (segment_id, episode_id, segment_num, segment_primary_loc, wiki_description) VALUES (5, 1, 5, 'Batavia, Illinois', 'Don investigates Bellevue Place in Batavia, Illinois, an insane asylum that once housed first lady Mary Todd Lincoln, who was wrongfully incarcerated, but was freed by lawyer Myra Bradwell.');
INSERT INTO segment (segment_id, episode_id, segment_num, segment_primary_loc, wiki_description) VALUES (6, 1, 6, 'Saratoga Springs, New York', 'Don uncovers the history of potato chips when chef George Crum cooked up the first batch for Cornelius Vanderbilt at Moon''s Lake House in Saratoga Springs, New York in 1853.');
INSERT INTO segment (segment_id, episode_id, segment_num, segment_primary_loc, wiki_description) VALUES (7, 2, 1, 'Berlin, Germany', 'Don visits the East Side Gallery in Berlin, Germany, a reminder of the daring escape of two families from Poessneck, East Germany who risked a flight to freedom in a homemade hot air balloon in 1979.');
INSERT INTO segment (segment_id, episode_id, segment_num, segment_primary_loc, wiki_description) VALUES (8, 2, 2, 'Los Angeles, California', 'Don uncovers the story behind IMP founder Carl Laemmle''s star on the Hollywood Walk of Fame when he started the 1910 publicity stunt of actress Florence Lawrences "death" to lure her away from Biograph Studios.');
INSERT INTO segment (segment_id, episode_id, segment_num, segment_primary_loc, wiki_description) VALUES (9, 2, 3, 'Bar Harbor, Maine', 'Don investigates Hancock Point near Bar Harbor, Maine, once the gateway to Nazi spy Erich Gimpel and defector William Colepaugh''s plan to destroy America''s atomic bomb on Manhattan Project sites during World War II.');
INSERT INTO segment (segment_id, episode_id, segment_num, segment_primary_loc, wiki_description) VALUES (10, 2, 4, 'Clark University, Worcester, Massachusetts', 'Don examines the statue of Austrian neurologist Sigmund Freud at Clark University in Worcester, Massachusetts, whose Chow Chow Jofi, helped him hypothesize the psychological benefits of K-9 companions.');
INSERT INTO segment (segment_id, episode_id, segment_num, segment_primary_loc, wiki_description) VALUES (11, 2, 5, 'San Antonio, Texas', 'Don returns to The Alamo in San Antonio, Texas where in 1908, after ranch heiress Clara Driscoll plan to demolish the Long Barracks, school teacher Adina De Zavala holds her own standoff to preserve the fort''s history.');
INSERT INTO segment (segment_id, episode_id, segment_num, segment_primary_loc, wiki_description) VALUES (12, 2, 6, 'New York, New York', 'Don explores Wall Street in Manhattan''s Financial District, once the scene of a political bombing by Italian Anarchist Mario Buda in 1920.');

INSERT INTO monument (monument_id, monument_name,  decade) VALUES (1, 'Stone of Destiny', 1950);
INSERT INTO monument (monument_id, monument_name,  decade) VALUES (2, 'Bust of Thomas Edison', 1890);
INSERT INTO monument (monument_id, monument_name,  decade) VALUES (3, 'Washington Monument', 1980);
INSERT INTO monument (monument_id, monument_name,  decade) VALUES (4, 'Niagara Falls', 1960);
INSERT INTO monument (monument_id, monument_name,  decade) VALUES (5, 'Bellevue Place Sanatorium', 1870);
INSERT INTO monument (monument_id, monument_name,  decade) VALUES (6, 'Moon''s Lake House', 1850);
INSERT INTO monument (monument_id, monument_name,  decade) VALUES (7, 'East Side Gallery', 1970);
INSERT INTO monument (monument_id, monument_name,  decade) VALUES (8, 'Hollywood Walk of Fame', 1910);
INSERT INTO monument (monument_id, monument_name,  decade) VALUES (9, 'Hancock Point Beach', 1940);
INSERT INTO monument (monument_id, monument_name,  decade) VALUES (10, 'Sigmund Freud Statue', 1920);
INSERT INTO monument (monument_id, monument_name,  decade) VALUES (11, 'The Alamo', 1900);
INSERT INTO monument (monument_id, monument_name,  decade) VALUES (12, 'Wall Street', 1920);

INSERT INTO type (type_id, type_name) VALUES (1, 'Historical Object');
INSERT INTO type (type_id, type_name) VALUES (2, 'Statue');
INSERT INTO type (type_id, type_name) VALUES (3, 'Obelisk');
INSERT INTO type (type_id, type_name) VALUES (4, 'Natural Wonder');
INSERT INTO type (type_id, type_name) VALUES (5, 'Building');
INSERT INTO type (type_id, type_name) VALUES (6, 'Plaque');
INSERT INTO type (type_id, type_name) VALUES (7, 'Historic Location');

INSERT INTO monument_type (monument_id, type_id) VALUES (1, 1);
INSERT INTO monument_type (monument_id, type_id) VALUES (2, 2);
INSERT INTO monument_type (monument_id, type_id) VALUES (3, 3);
INSERT INTO monument_type (monument_id, type_id) VALUES (4, 4);
INSERT INTO monument_type (monument_id, type_id) VALUES (5, 5);
INSERT INTO monument_type (monument_id, type_id) VALUES (6, 5);
INSERT INTO monument_type (monument_id, type_id) VALUES (7, 1);
INSERT INTO monument_type (monument_id, type_id) VALUES (8, 6);
INSERT INTO monument_type (monument_id, type_id) VALUES (9, 7);
INSERT INTO monument_type (monument_id, type_id) VALUES (10, 2);
INSERT INTO monument_type (monument_id, type_id) VALUES (11, 5);
INSERT INTO monument_type (monument_id, type_id) VALUES (12, 7);

INSERT INTO segment_monument (monument_id, segment_id) VALUES (1, 1);
INSERT INTO segment_monument (monument_id, segment_id) VALUES (2, 2);
INSERT INTO segment_monument (monument_id, segment_id) VALUES (3, 3);
INSERT INTO segment_monument (monument_id, segment_id) VALUES (4, 4);
INSERT INTO segment_monument (monument_id, segment_id) VALUES (5, 5);
INSERT INTO segment_monument (monument_id, segment_id) VALUES (6, 6);
INSERT INTO segment_monument (monument_id, segment_id) VALUES (7, 7);
INSERT INTO segment_monument (monument_id, segment_id) VALUES (8, 8);
INSERT INTO segment_monument (monument_id, segment_id) VALUES (9, 9);
INSERT INTO segment_monument (monument_id, segment_id) VALUES (10, 10);
INSERT INTO segment_monument (monument_id, segment_id) VALUES (11, 11);
INSERT INTO segment_monument (monument_id, segment_id) VALUES (12, 12);

INSERT INTO sec_location (location_id, location_name) VALUES (1, 'Arbroath Abbey, Arbroath, Scotland');
INSERT INTO sec_location (location_id, location_name) VALUES (2, 'Edinburgh Castle, Edinburgh, Scotland');
INSERT INTO sec_location (location_id, location_name) VALUES (3, 'Science Museum, London, England');
INSERT INTO sec_location (location_id, location_name) VALUES (4, 'Poessneck, Germany');
INSERT INTO sec_location (location_id, location_name) VALUES (5, 'Vienna, Austria');

INSERT INTO segment_secondary_location (location_id, segment_id) VALUES (1, 1);
INSERT INTO segment_secondary_location (location_id, segment_id) VALUES (2, 1);
INSERT INTO segment_secondary_location (location_id, segment_id) VALUES (3, 2);
INSERT INTO segment_secondary_location (location_id, segment_id) VALUES (4, 7);
INSERT INTO segment_secondary_location (location_id, segment_id) VALUES (5, 10);

INSERT INTO person (person_id, name) VALUES (1, 'Ian Hamilton');
INSERT INTO person (person_id, name) VALUES (2, 'Thomas Edison');
INSERT INTO person (person_id, name) VALUES (3, 'Lizzie Le Prince');
INSERT INTO person (person_id, name) VALUES (4, 'Louis Le Prince');
INSERT INTO person (person_id, name) VALUES (5, 'Norman Mayer');
INSERT INTO person (person_id, name) VALUES (6, 'Steven Komarow');
INSERT INTO person (person_id, name) VALUES (7, 'Mary Todd Lincoln');
INSERT INTO person (person_id, name) VALUES (8, 'Myra Bradwell');
INSERT INTO person (person_id, name) VALUES (9, 'George Crum');
INSERT INTO person (person_id, name) VALUES (10, 'Cornelius Vanderbilt');
INSERT INTO person (person_id, name) VALUES (11, 'Peter Strelzyk');
INSERT INTO person (person_id, name) VALUES (12, 'Gunter Wetzel');
INSERT INTO person (person_id, name) VALUES (13, 'Carl Laemmle');
INSERT INTO person (person_id, name) VALUES (14, 'Florence Lawrence');
INSERT INTO person (person_id, name) VALUES (15, 'Erich Gimpel');
INSERT INTO person (person_id, name) VALUES (16, 'William Colepaugh');
INSERT INTO person (person_id, name) VALUES (17, 'Sigmund Freud');
INSERT INTO person (person_id, name) VALUES (18, 'Adina De Zavala');
INSERT INTO person (person_id, name) VALUES (19, 'Clara Driscoll');
INSERT INTO person (person_id, name) VALUES (20, 'William J. Flynn');
INSERT INTO person (person_id, name) VALUES (21, 'Paul Avrich');
INSERT INTO person (person_id, name) VALUES (22, 'Mario Buda');

INSERT INTO segment_person (person_id, segment_id) VALUES (1, 1);
INSERT INTO segment_person (person_id, segment_id) VALUES (2, 2);
INSERT INTO segment_person (person_id, segment_id) VALUES (3, 2);
INSERT INTO segment_person (person_id, segment_id) VALUES (4, 2);
INSERT INTO segment_person (person_id, segment_id) VALUES (5, 3);
INSERT INTO segment_person (person_id, segment_id) VALUES (6, 3);
INSERT INTO segment_person (person_id, segment_id) VALUES (7, 5);
INSERT INTO segment_person (person_id, segment_id) VALUES (8, 5);
INSERT INTO segment_person (person_id, segment_id) VALUES (9, 6);
INSERT INTO segment_person (person_id, segment_id) VALUES (10, 6);
INSERT INTO segment_person (person_id, segment_id) VALUES (11, 7);
INSERT INTO segment_person (person_id, segment_id) VALUES (12, 7);
INSERT INTO segment_person (person_id, segment_id) VALUES (13, 8);
INSERT INTO segment_person (person_id, segment_id) VALUES (14, 8);
INSERT INTO segment_person (person_id, segment_id) VALUES (15, 9);
INSERT INTO segment_person (person_id, segment_id) VALUES (16, 9);
INSERT INTO segment_person (person_id, segment_id) VALUES (17, 10);
INSERT INTO segment_person (person_id, segment_id) VALUES (18, 11);
INSERT INTO segment_person (person_id, segment_id) VALUES (19, 11);
INSERT INTO segment_person (person_id, segment_id) VALUES (20, 12);
INSERT INTO segment_person (person_id, segment_id) VALUES (21, 12);
INSERT INTO segment_person (person_id, segment_id) VALUES (22, 12);

INSERT INTO source (source_id, source_name) VALUES (1, 'Catherine Cartwright');
INSERT INTO source (source_id, source_name) VALUES (2, 'Tour Guide');
INSERT INTO source (source_id, source_name) VALUES (3, 'Ben Model');
INSERT INTO source (source_id, source_name) VALUES (4, 'Historian');
INSERT INTO source (source_id, source_name) VALUES (5, 'Steven Komarow');
INSERT INTO source (source_id, source_name) VALUES (6, 'Reporter');
INSERT INTO source (source_id, source_name) VALUES (7, 'Ginger Strand');
INSERT INTO source (source_id, source_name) VALUES (8, 'Catherine Filloux');
INSERT INTO source (source_id, source_name) VALUES (9, 'Playwright');
INSERT INTO source (source_id, source_name) VALUES (10, 'Danny Jameson');
INSERT INTO source (source_id, source_name) VALUES (11, 'Businessman');
INSERT INTO source (source_id, source_name) VALUES (12, 'Stegani Jackenthal');
INSERT INTO source (source_id, source_name) VALUES (13, 'Journalist');
INSERT INTO source (source_id, source_name) VALUES (14, 'Kelly Brown');
INSERT INTO source (source_id, source_name) VALUES (15, 'Author');
INSERT INTO source (source_id, source_name) VALUES (16, 'Herb Adams');
INSERT INTO source (source_id, source_name) VALUES (17, 'Robert Tobin');
INSERT INTO source (source_id, source_name) VALUES (18, 'Professor');
INSERT INTO source (source_id, source_name) VALUES (19, 'Andrew Carroll');
INSERT INTO source (source_id, source_name) VALUES (20, 'Tim Weiner');

INSERT INTO segment_source (segment_id, source_id) VALUES (1, 1);
INSERT INTO segment_source (segment_id, source_id) VALUES (1, 2);
INSERT INTO segment_source (segment_id, source_id) VALUES (2, 3);
INSERT INTO segment_source (segment_id, source_id) VALUES (2, 4);
INSERT INTO segment_source (segment_id, source_id) VALUES (3, 5);
INSERT INTO segment_source (segment_id, source_id) VALUES (3, 6);
INSERT INTO segment_source (segment_id, source_id) VALUES (4, 7);
INSERT INTO segment_source (segment_id, source_id) VALUES (4, 4);
INSERT INTO segment_source (segment_id, source_id) VALUES (5, 8);
INSERT INTO segment_source (segment_id, source_id) VALUES (5, 9);
INSERT INTO segment_source (segment_id, source_id) VALUES (6, 10);
INSERT INTO segment_source (segment_id, source_id) VALUES (6, 11);
INSERT INTO segment_source (segment_id, source_id) VALUES (7, 12);
INSERT INTO segment_source (segment_id, source_id) VALUES (7, 13);
INSERT INTO segment_source (segment_id, source_id) VALUES (8, 14);
INSERT INTO segment_source (segment_id, source_id) VALUES (8, 15);
INSERT INTO segment_source (segment_id, source_id) VALUES (9, 16);
INSERT INTO segment_source (segment_id, source_id) VALUES (9, 4);
INSERT INTO segment_source (segment_id, source_id) VALUES (10, 17);
INSERT INTO segment_source (segment_id, source_id) VALUES (10, 18);
INSERT INTO segment_source (segment_id, source_id) VALUES (11, 19);
INSERT INTO segment_source (segment_id, source_id) VALUES (11, 15);
INSERT INTO segment_source (segment_id, source_id) VALUES (12, 20);
INSERT INTO segment_source (segment_id, source_id) VALUES (12, 13);

INSERT INTO subject (subject_id, subject_name) VALUES (1, 'Political Movements');
INSERT INTO subject (subject_id, subject_name) VALUES (2, 'Motion Picture Industry');
INSERT INTO subject (subject_id, subject_name) VALUES (3, 'Terrorism');
INSERT INTO subject (subject_id, subject_name) VALUES (4, 'Nuclear Weapons');
INSERT INTO subject (subject_id, subject_name) VALUES (5, 'Natural Wonders');
INSERT INTO subject (subject_id, subject_name) VALUES (6, 'Engineering Feats');
INSERT INTO subject (subject_id, subject_name) VALUES (7, 'Women''s Rights');
INSERT INTO subject (subject_id, subject_name) VALUES (8, 'Food and Cuisine');
INSERT INTO subject (subject_id, subject_name) VALUES (9, 'Black History');
INSERT INTO subject (subject_id, subject_name) VALUES (10, 'Cold War Era');
INSERT INTO subject (subject_id, subject_name) VALUES (11, 'Daring Escapes');
INSERT INTO subject (subject_id, subject_name) VALUES (12, 'Spies and Espionage');
INSERT INTO subject (subject_id, subject_name) VALUES (13, 'Pets and Animals');
INSERT INTO subject (subject_id, subject_name) VALUES (14, 'Historic Preservation');

INSERT INTO segment_subject(subject_id, segment_id) VALUES (1, 1);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (2, 2);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (1, 3);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (3, 3);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (4, 3);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (5, 4);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (6, 4);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (7, 5);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (8, 6);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (9, 6);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (10, 7);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (11, 7);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (2, 8);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (12, 9);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (4, 9);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (13, 10);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (14, 11);
INSERT INTO segment_subject(subject_id, segment_id) VALUES (3, 12);


