image=$1
region=us-west-2
account=$(aws sts get-caller-identity --query Account --output text)
fullname="${account}.dkr.ecr.${region}.amazonaws.com/${image}:latest"

aws --region ${region} ecr get-login-password \
    | docker login \
        --password-stdin \
        --username AWS \
        "${account}.dkr.ecr.${region}.amazonaws.com"

docker pull ${fullname}

docker build  -t ${image} .
docker tag ${image} ${fullname}
