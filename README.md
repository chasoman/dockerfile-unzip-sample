# dockerfile-unzip-sample
A sample Dockerfile that demonstrates the un-taring of contents of a *.tar.gz* archive inside the image. 

**Note:** This sample requires access to the RedHat Container Image Registry - [registry.redhat.io](https://registry.redhat.io) 

Before you build this Dockerfile ensure that you are logged into the registry by issuing the following command -
```
docker login registry.redhat.io
```
## The Dockerfile
- Extends the RedHat Linux Universal Base Image (ubi).
  - **Note:** access to registry.redhat.io required for this step.
- Installs httpd. The Apache HTTP Server.
- Extracts and copies the contents of the *custom-chasoman-greeting.tar.gz* to the /var/www/html/ directory.
- Inline comments in the Dockerfile are self explanatory.
## The archive *custom-chasoman-greeting.tar.gz*
- Contains a single file *index.html* with the following content -
```html
<!DOCTYPE html>
<html>
<body style="font-family: calibri">
<h1 style="color: blue">Greetings!</h1>
<p>Chaitanya Soman says Hello to the World!</p>
<p>This content was untarred from a tar.gz archive</p>
</body>
</html>
```
## Building the docker image
- Clone this repository to your local filesystem.
- From a shell change directory to the cloned repository directory *dockerfile-unzip-sample*.
- Change to the for-tar-files branch by issuing the following command -
```
git checkout for-tar-files
```
- Assuming you have docker installed locally, you can issue the following command - 
```
docker build -t custom-chasoman-greeting-httpd .
```
## Creating a local container from the image
- Issue the following command to create a container locally - 
```
docker run --name custom-chasoman-greeting -d -p 8080:8080 custom-chasoman-greeting-httpd
```
  - **Note:** The *-p 8080:8080* option maps the local port 8080 onto the container port 8080
## Testing the container
- Point your browser to [http://localhost:8080](http://localhost:8080). You should see the following greeting show up - 
## Summary
This sample demonstrates a Dockerfile that extracts a *.tar.gz* archive's contents to the image that gets built from it.
