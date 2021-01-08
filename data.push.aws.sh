#!/bin/bash

### S3CMD ######################################################################
#OPTIONS="--no-check-md5 --access_key=AKIA43N3NPLELWFPBDRU --secret_key=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 --host=s3.amazonaws.com --host-bucket="

## '--delete-removed' option can be used.
#s3cmd ${OPTIONS} sync data/offline/ s3://accu-kubernetes/data/offline/
#s3cmd ${OPTIONS} sync data/service/ s3://accu-kubernetes/data/service/
#s3cmd ${OPTIONS} sync data/system/  s3://accu-kubernetes/data/system/
################################################################################

### AWS S3 #####################################################################
aws s3 sync data/offline/ s3://accu-kubernetes/data/offline/
aws s3 sync data/service/ s3://accu-kubernetes/data/service/
aws s3 sync data/system/  s3://accu-kubernetes/data/system/
################################################################################

