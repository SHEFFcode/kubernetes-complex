docker build -t sheffdocker/multi-client:latest -t sheffdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sheffdocker/multi-server:latest -t sheffdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sheffdocker/multi-worker:latest -t sheffdocker/multi-worker:$SHA -f ./worker/Dockerfiel ./worker

docker push sheffdocker/multi-client:latest
docker push sheffdocker/multi-server:latest
docker push sheffdocker/multi-worker:latest

docker push sheffdocker/multi-client:$SHA
docker push sheffdocker/multi-server:$SHA
docker push sheffdocker/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment server=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment server=stephengrider/multi-worker:$SHA