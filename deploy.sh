docker build -t jshinney/multi-client:latest -t jshinney/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jshinney/multi-server:latest -t jshinney/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jshinney/multi-worker:latest -t jshinney/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jshinney/multi-client:latest
docker push jshinney/multi-server:latest
docker push jshinney/multi-worker:latest

docker push jshinney/multi-client:$SHA
docker push jshinney/multi-server:$SHA
docker push jshinney/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jshinney/multi-client:$SHA
kubectl set image deployments/server-deployment server=jshinney/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jshinney/multi-worker:$SHA