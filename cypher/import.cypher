
// Clients

LOAD CSV WITH HEADERS FROM 'file:///clients.csv' AS line FIELDTERMINATOR ','
CREATE (client:Client {id: toInteger(line.id) })
SET client.name = line.name;

// VENUES

LOAD CSV WITH HEADERS FROM 'file:///venues.csv' AS line FIELDTERMINATOR ','
MATCH (client:Client {id: toInteger(line.client_id) })
CREATE (venue:Venue {id: toInteger(line.id)})-[:HAS_CLIENT]->(client)
SET venue.name = line.name
SET venue.id = toInteger(line.id)
SET venue.coord = point({latitude: toFloat(line.lat),longitude: toFloat(line.lon)});



// Users

LOAD CSV WITH HEADERS FROM 'file:///users.csv' AS line FIELDTERMINATOR ','
MATCH (client:Client {id: toInteger(line.client_id) })
CREATE (user:User {id: toInteger(line.id) })-[:HAS_CLIENT]->(client)
SET user.username = line.username;

// Visits

LOAD CSV WITH HEADERS FROM 'file:///visits.csv' AS line FIELDTERMINATOR ','
MATCH (user:User {id: toInteger(line.user_id) })
MATCH (venue:Venue {id: toInteger(line.venue_id) })
CREATE (visit:Visit {id: toInteger(line.id) })-[:HAS_USER]->(user)-[:HAS_VENUE]->(venue)
SET visit.date = line.created_at;
