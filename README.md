Codigo Terraform para entrega de Desafio 

REPO - PIPE

Neste repositorio possui o codigo onde contruiremos a pipeline que executará os outros codigos em terraform, o proximo step ao concluir a construção da pipeline é fazer um commit dos folders que estão no repo para triggar a pipeline e executar o PLAN depois o MANUAL APPROVAL para o ambiente de produção, criando assim uma camada de interface humana para interagir com a pipeline e assim entregar o ambiente a ser provionado na aws atraves da pipeline.

DIAGRAMA DA PIPELINE


![MANUAL_APPROVAL](https://user-images.githubusercontent.com/43214800/145913458-cae961bc-4859-4c62-b291-6f2d1199e2f7.png)

Então ao criar essa arquitetura com os codigos em sua maquina localmente, precisamos enviar os arquivos para o repo do CODECOMMIT, ao enviarmos os codigos juntamente com os buildspecs a pipeline será trigada e assim provisonará os .tfs relacionados ao ECS e a VPC, lembrando que ao testar esse codigo precisamos criar dentro do nosso user no iam as chaves para acessar o repositorio recém criado no .tf anterior. 

No outro codigo criames uma simples aplicação com NGINX dentro do ECS juntamente com o Fargate, tambem temos o modulo de VPC que criará os recursos de network para que essa aplicação funcione normalmente.

![ECS-VPC](https://user-images.githubusercontent.com/43214800/145916795-983f5bb1-0dc4-4bd4-b621-69192bec95d3.png)

Ao executar criaremos um ambiente onde o ALB recebe as requests na porta 80 obs: não inseri o ACM para não demorar mais para criar o lab, teria que pagar também..
A task definition eu decidi inserir a imagem diretamente na variavel para que ele inserisse diretamente para esse lab.
