docker build -t jdsoftwarestudio/multi-client:latest -t jdsoftwarestudio/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jdsoftwarestudio/multi-server:latest -t jdsoftwarestudio/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jdsoftwarestudio/multi-worker:latest -t jdsoftwarestudio/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jdsoftwarestudio/multi-client:latest
docker push jdsoftwarestudio/multi-client:$SHA
docker push jdsoftwarestudio/multi-server:latest
docker push jdsoftwarestudio/multi-server:$SHA
docker push jdsoftwarestudio/multi-worker:latest
docker push jdsoftwarestudio/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jdsoftwarestudio/multi-server:$SHA
kubectl set image deployments/client-deployment client=jdsoftwarestudio/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jdsoftwarestudio/multi-worker:$SHA