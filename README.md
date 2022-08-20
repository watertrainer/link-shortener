# link-shortener
A simple link-shortener implementation like bit.ly!
## Build and Deploy
1. Clone the repository to a local folder `git clone https://github.com/watertrainer/link-shortener`
2. Change directory to local folder `cd link-shortener`
3. Init all submodules `git submodule update --init --recursive`
4. Build the docker-container `docker compose up`
5. The app is now running on `localhost:8080`

There are multiple ways to deploy the app, a few examples are shown [here](https://docs.docker.com/language/java/deploy/)
## Architecture
Using Angular as a frontend and a node.js server with a postgres database as a backend
### Database
The postgres database consists of one table, which has four fields
```
                      Table "public.shortls"
  Column   |         Type         | Collation | Nullable | Default
-----------+----------------------+-----------+----------+---------
 shortl    | character varying(7) |           | not null |
 url       | text                 |           | not null |
 viewed    | integer              |           |          | 0
 shortened | integer              |           |          | 0
Indexes:
    "shortls_pkey" PRIMARY KEY, btree (shortl)
    "shortls_url_key" UNIQUE CONSTRAINT, btree (url)
```
    
    
    
### Shortening a link
When the user tries to shorten a link in the frontend, it sends the link unfiltered to the backend.

There the link is checked to be a valid http or https link. All other protocols are disallowed as they could be used to run code or trigger unexpected actions (e.g. the javascript: protcol).

The backend then generates a random 6 character short link (called a **shortl**). This shortl is then inserted along with the url into the table. If the url already exists, shortened is incremented instead.
