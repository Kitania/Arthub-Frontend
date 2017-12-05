# Arthub Flanders

A customised Project Blacklight installation for the 
[Arthub Flanders](https://arthub.vlaamsekunstcollectie.be) Project.

## Requirements

* Ruby ~>2.4 with Bundler ~>1.16
* Rails ~>5.1
* SQlite 3
* Oracle [Java 8](http://www.oracle.com/technetwork/java/javase/overview/java8-2100321.html)

**Important: You will need Oracle Java 8 for this project! The packaged version 
of Apache Solr does not work properly with other flavors of Java**

## Installation

Get up and running

```
$ git clone https://github.com/VlaamseKunstcollectie/Arthub-Frontend frontend
$ cd frontend
$ bundle install
$ rake jetty:start
$ rails server
```

Navigate to http://localhost:3000 to see the Arthub application in action. 

It's better to use a suitable proxy HTTP server instead of directly exposing 
the Rails server to the outside world. You can use either Apache or NGinx as a 
proxy. Configure NGinX like this:

```
server {

    listen 80;

    server_name blacklight.box;
    root /vagrant/project-blacklight;
    index index.php index.html index.htm;

    access_log /var/log/nginx/blacklight_project_access.log;
    error_log /var/log/nginx/blacklight_project_error.log error;

    location / {
        proxy_pass         http://127.0.0.1:3000/;
        proxy_redirect     off;

        proxy_set_header   Host             $host;
        proxy_set_header   X-Real-IP        $remote_addr;
        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
    }
}
```

(Change the server_name and root directives to reflect the correct settings)

## Development

### Running a development server

Instead of running `rails server`, use `rails server -e development`. 

### Configuring Apache Solr

The entire Solr configuration is stored in the `jetty` folder. Project 
Blacklight is configured to connect with Solr and use the `blacklight-core` 
core. The entire configuration can be found here:

```
jetty/solr/blacklight-core/conf/*
jetty/solr/blacklight-core/conf/solrconfig.xml
jetty/solr/blacklight-core/conf/schema.xml
```

If you make changes to the configuration, you will need to restart your Solr 
instance and you may even have to delete your entire index. Use the script 
below to do this the brute force way. Save it in the root of the project.

```
#!/bin/bash
rake jetty:stop
rm -r jetty/solr/blacklight-core/data/*
rake jetty:start
```

## Authors

* Matthias Vandermaesen matthias.vandermaesen@vlaamsekunstcollectie.be
* Tine Robbe tine.robbe@vlaamsekunstcollectie.be

## Copyright

Copyright 2016 - PACKED vzw, Vlaamse Kunstcollectie vzw

## License

This library is free software; you can redistribute it and/or modify it under 
the same terms as the license provided with [Project Blacklight](https://github.com/projectblacklight/blacklight/blob/master/LICENSE. 


