-- Copyright 2012 Steven Oliver <oliver.steven@gmail.com>
--
-- This file is part of balistica.
--
-- balistica is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- balistica is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with balistica. If not, see <http://www.gnu.org/licenses/>.

CREATE TABLE rifles (
        id INTEGER PRIMARY KEY,
        make TEXT NOT NULL,
        model TEXT NOT NULL,
        caliber_id INTEGER,
        FOREIGN KEY(caliber_id) REFERENCES calibers (id)
);

CREATE TABLE shotguns (
        id INTEGER PRIMARY KEY,
        make TEXT NOT NULL,
        model TEXT NOT NULL,
        gauge_id INTEGER,
        action TEXT NOT NULL,
        FOREIGN KEY(gauge_id) REFERENCES gauges (id)
);

CREATE TABLE pistols (
        id INTEGER PRIMARY KEY,
        make TEXT NOT NULL,
        model TEXT NOT NULL,
        caliber_id INTEGER,
        FOREIGN KEY(caliber_id) REFERENCES calibers (id)
);

CREATE TABLE calibers (
        id INTEGER PRIMARY KEY,
        type TEXT,
        caliber TEXT NOT NULL
);

CREATE TABLE gauges (
        id INTEGER PRIMARY KEY,
        gauge TEXT NOT NULL
);

CREATE TABLE bullets (
        id INTEGER PRIMARY KEY,
        brand TEXT NOT NULL,
        caliber_id INTEGER NOT NULL,
        diameter DOUBLE NOT NULL,
        weight DOUBLE NOT NULL
        FOREIGN KEY(caliber_id) REFERENCES calibers (id)
);

CREATE TABLE propellants (
       id INTEGER PRIMARY KEY,
       brand TEXT NOT NULL,
       propellant TEXT NOT NULL
);

CREATE TABLE primers (
       id INTEGER PRIMARY KEY,
       brand TEXT NOT NULL,
       primer TEXT NOT NULL
);

CREATE TABLE cases (
       id INTEGER PRIMARY KEY,
       brand TEXT NOT NULL,
       caliber_id INTEGER NOT NULL,
       FOREIGN KEY(caliber_id) REFERENCES calibers (id)
);

CREATE TABLE custom_load (
       id INTEGER PRIMARY KEY,
       description TEXT,
       bullet_id INTEGER,
       propellant_id INTEGER,
       primer_id INTEGER,
       case_id INTEGER,
       FOREIGN KEY(bullet_id) REFERENCES bullets (id),
       FOREIGN KEY(propellant_id) REFERENCES propellants (id),
       FOREIGN KEY(primer_id) REFERENCES primers (id),
       FOREIGN KEY(case_id) REFERENCES cases (id)
);


