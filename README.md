# docker-php7-apache2

Docker container with php7.0.1, apache 2.4 and composer 

    docker build -t mysite .
  
    docker run -it -p 8000:80 -v path/to/workspace:/var/www/html -d mysite /bin/bash
