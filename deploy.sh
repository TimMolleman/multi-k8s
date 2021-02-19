# Build
docker build -t timmolleman/multi-client:latest -t timmolleman/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t timmolleman/multi-server:latest -t timmolleman/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t timmolleman/multi-worker:latest -t timmolleman/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push
docker push timmolleman/multi-client:latest
docker push timmolleman/multi-server:latest
docker push timmolleman/multi-worker:latest

docker push timmolleman/multi-client:$SHA
docker push timmolleman/multi-server:$SHA
docker push timmolleman/multi-worker:$SHA

# k8s apply
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=timmolleman/multi-server:$SHA
kubectl set image deployments/client-deployment client=timmolleman/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=timmolleman/multi-worker:$SHA
