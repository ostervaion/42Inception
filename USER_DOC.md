# How to understand what services are provided by the stack.

Use ps aux to see all the running processes

# How to start and stop the project.

From the root of the repository:

- Build and start the containers
    make upb
- Start the containers (already build):
    make up
- Stop the containers:
    make down
- Stop the containers and clear the data:
    make downv
- Build the containers:
    make build

# How to access the website and the administration panel.

To access the wordpress with your favourite browser go to https://localhost:443

To log in search for https://localhost:443/wp-admin and add the credentials

# How to locate and manage credentials.

Inside the project root a secrets directory will be needed with every sensible data in it, this directory will be copied from another path inside the host.

This are the names of the secret files, each one has its value:
- cert.pem (certification for the web server nginx)
- db_name (name for the database)
- db_password (password for the database user)
- db_r_password (password for the root user in the database)
- db_user (username for the database user)
- key.pem (key for the certification for the nginx web server)

Wordpress admin credentials
- wp_admin_email 
- wp_admin_password
- wp_admin_user
Wordpress user credentials
- wp_user
- wp_user_email
- wp_user_password

# How to check that the services are running correctly

Use the command docker ps to see the running containers and their state
