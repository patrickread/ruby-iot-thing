# IoT Thing

A Ruby client library that uses AWS IoT over MQTT protocol

## Setup

1. Add the bin folder to your path
2. Add a certs folder at the root of this repo. Add three files to that folder listed below. See [Amazon documentation](http://docs.aws.amazon.com/iot/latest/developerguide/secure-communication.html) for how to get all of those files. The root CA can come from [here](https://www.symantec.com/content/en/us/enterprise/verisign/roots/VeriSign-Class%203-Public-Primary-Certification-Authority-G5.pem).
  1. cert.pem
  2. privateKey.pem
  3. rootCA.pem
3. Run `iotthing` with two arguments listed below. E.g., `iotthing "Garage_Door" "<subdomain>"
  1. The name of your thing. Should coordinate to a thing already set up on AWS IoT.
  2. Your subdomain on AWS IoT. Obtain this by running `aws iot describe-endpoint` on the AWS CLI.
  
At this point, you should be able to connect to your thing ON AWS. For now, this client just subscribes.

## TODO

1. Publishing on MQTT
2. A GPIO controller, to actually talk to physical things
