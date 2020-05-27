# Kubernetes

[![N|Solid](https://raw.githubusercontent.com/kubernetes/kubernetes/master/logo/logo.png)](https://kubernetes.io)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

### Command

kubernetes command
```sh
$ kubectl run kubia --image=luksa/kubia --port=8080 --generator=run/v1
```
запуск имеджа + replicaset
```sh
$ kubectl expose rc kubia --type=LoadBalancer --name kubia-http
```
добавления к нашему имеджу лоадбалансера
```sh
$ kubectl explain pods
```
для вывода описания манифеста для пода
```sh
$ kubectl get po kubia-manual -o yaml 
```
описание пода девопс
```sh
$ kubectl get po --show-labels 
```
вывод инф о pods  с метками
```sh
$ kubectl get po -L creation_method,env 
```
с конкретными метками
```sh
$ kubectl label po kubia-manual creation_method=manual
```
дать метку меток
```sh
$ kubectl label po kubia-manual-v2 env=debug --overwrite
```
изменить метку
```sh
$ kubectl get po -l creation_method=manual
```
вывести под с конкретной меткой
```sh
$ kubectl get po -l env
```
вывести с любым значением метки или же не имеют такую метку '!env'
```sh
$ kubectl get svc --all-namespaces
```
посмотреть во всех нэймспэсах
```sh
$ kubectl delete po -l rel=canary
```
удаление всех подов с конкретными метками

```sh
$ kubectl logs mypod --previous
```
вывести логи удаленного контейнера 
```sh
$ kubectl scale rc kubia --replicas=10
```
изменить количство подов
```sh
$ kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="ExternalIP")].address}'
```
узнать ip node
```sh
$ kubectl get endpoints
```
обновить имедж на лету 
```sh
$ kubectl set image deployment my-deployment `*=nginx:1.13`
```
узнать все endpoints
откатить на старый деплоймент 
```sh 
$ kubectl rollout undo deployment my-deployment
```
посмотреть историю отката
```sh
kubectl rollout history deployment deployment_name
```
откатиться на канкретную ревизию

```sh
kubectl rollout undo deployment deployment_name --to-revision=1
```
статус компанентов
```sh
$ kubectl get componentstatuses
```
вынести порт на локал хост
```sh
$ kubectl port-forward pod_name 8000:80
```

###HELM

[![N|Solid](https://d33wubrfki0l68.cloudfront.net/d9a3dd9398904a13c211c703709d7ad7daaef72f/3f473/images/kubernetes-helm.png)](https://https://helm.sh/)


```sh
$ helm upgrade test-deploy  --install  ./test-helm/ --set "TEST=test125"
```
