# ansible_helm_gitops

This project is a feedback report showing different manners of  managing helm charts with ansible based gitops strategy.


## CI/CD with Jenkins Pipeline

* Jenkins pipeline checks out the merge of branches from Github hook and stores the code into working file.
*  Docker builds a new image with updated code and push it to the image registry.
*  Use Ansible to call Helm chart to deploy the new image into Kubernetes pods.

```
stage('Deploy on K8s'){
sh "ansible-playbook /var/lib/jenkins/ansible/Demo-deploy/deploy.yml  --user=jenkins --extra-vars ImageName=${ImageName} --extra-vars imageTag=${imageTag} --extra-vars Namespace=${Namespace}"
    }
```
    
## Call Ansible from Dockerfile 




## Prod

Use an Ansible project to deploy all the production stack :

- Ansible entrypoint playbook will intall  roles, one role matches one application. 
- A role will clone his repo
- *.yaml.j2 templates will get rendered using ansible facts and then passed into helm as a override file. 
- Ansible will install Helm chart, example : 

```
- name: "Install chart "
  command: helm install -f myvalues.yaml -f override.yaml ... [flags]
```  

- In this case the priority will be given to the last (right-most) file specified
- Deploy the new image into Kubernetes pods

## Using Ansible's Helm and Kube modules 
- The helm_repository module adds the ama Helm repository, which contains the mariadab Helm chart. 
```
- name: Add ama chart repo.
  community.kubernetes.helm_repository:
    name: ama
    repo_url: "https://ama.github.io/ama-charts/"
```
- The helm module deploys the chart and creates the mariadb pod on kubenetes.

```
- name: Deploy mariadb Helm chart.
  community.kubernetes.helm:
    name: mariadb
    chart_ref: ama/mariadb
    chart_version: '2.0.7'
    release_namespace: mariadb
    state: present
    values_files:
      - /path/to/values.yaml
      - /path/to/override.yaml
```
      
This will permit to use full Ansible and so the version control.