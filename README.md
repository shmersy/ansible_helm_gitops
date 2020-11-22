# ansible_helm_gitops

This project is a feedback report to how to manage helm charts with ansible


## CI/CD with Jenkins Pipeline

1- Jenkins pipeline checks out the merge of branches from Github hook and stores the code into working file.
2- Docker builds a new image with updated code and push it to the image registry .
3- Use Ansible to call Helm chart to deploy the new image into Kubernetes pods.

stage('Deploy on K8s'){
sh "ansible-playbook /var/lib/jenkins/ansible/Demo-deploy/deploy.yml  --user=jenkins --extra-vars ImageName=${ImageName} --extra-vars imageTag=${imageTag} --extra-vars Namespace=${Namespace}"
    }
     } catch (err) {
      currentBuild.result = 'FAILURE'
    }
    
## Call Ansible from Dockerfile 


##Using Ansible's Helm and Kube modules 

The helm_repository module adds the ama Helm repository, which contains the mariadab Helm chart.
The helm module deploys the chart and creates the mariadb pod on kubenetes.


### Prod

Use an Ansible project to deploy all the production stack :

- Ansible entrypoint playbook will intall  roles, one role matches one application. 
- A role will clone his repo
- *.yaml.j2 templates will get rendered using ansible facts and then passed into helm as a settings file. 
- Ansible will execute Helm chart to deploy the new image into Kubernetes pods
