# BiBi - Transporte Escolar
## PAC - Projeto de Aprendizagem Colaborativa Extensionista do Curso de Engenharia de Software da Católica de Santa Catarina;

### Justificativa de Projeto
O BiBi - Transporte Escolar é um projeto que se justifica para a empresa Sutiltur Transporte de Passageiros LTDA, bem como de trabalhadores no ramo tido como público alvo da aplicação é a simplificação de tarefas cotidianas e a possiblidade de tornar mais fácil a comunicação com pais e alunos no período de trabalho, de forma a reduzir atrasos e garantir mais tempo livre aos motoristas, tempo este que pode ser utilizado para tarefas pessoais bem como para outras atividades de trabalho que normalmente seriam deixadas de lado pela necessidade de cumprir com os deveres usuais da profissão.

### Escopo de Projeto
Aplicação mobile para o controle e gerenciamento de atividades de um transportador escolar, com o intuito de aumentar a eficiência de comunicação com os responsáveis e o exercimento das atividades diárias do transportador, de forma a ajudar e simplificar a viagem de crianças, demarcando a sua respectiva instituição de ensino de maneira segura e automática.

### Requisitos de Desenvolvimento
### Requisitos lado Motorista
**Cadastro e Gerenciamento de Alunos:**
O sistema deve permitir o transportador cadastrar, editar e excluir dados dos alunos cadastrados no sistema, bem como dados de contato dos pais ou responsáveis por esse aluno;

**Comunicação Direta:**
O sistema deve ser capaz de enviar notificações e mensagens aos pais de forma automática, informando datas de pagamento, valores e horários de chegada da van na residência dos mesmos (sendo todas essas informações definidas pelo transportador na interface do sistema);

**Controle de Pagamento:**
O sistema deve ser capaz de verificar o status de pagamento baseado na data definida como limite, permitir o transportador de definir essas datas e alterá-las mediante negociação, bem como alterar manualmente os status de pagamento entre as seguintes opções: 

Pago: Status a ser definido automaticamente pelo sistema quando o usuário der a mensalidade como paga;
Em atraso: Status a ser definido automaticamente pelo sistema quando a data de pgto. definida vencer e o pagamento não for computado;
Futuros: Status a ser definido por padrão pelo sistema, mediante situação na qual o pagamento não tenha sido computado ainda, bem como a data limite não venceu.

**Autenticação e Segurança:**
O sistema deve fornecer uma forma de autenticação aos pais e transportadores por meio de login e senha gerenciado pelo usuário administrador, garantindo acesso a informações pessoais sobre alunos e responsáveis de forma controlada e somente a usuários autorizados;

**Emissão de Recibo:**
O sistema deve possuir uma interface para emissão de recibos, sendo este opcional e de decisão do condutor realizar a emissão, ou não. O sistema deve preencher as informações com base nas informações do banco de dados, resgatando as informações com base no cadastrado no banco de dados. 

### Requisitos lado Cliente
**Autenticação de segurança:**
O usuário, pai de um aluno, deve ter um login e senha único, armazenado e controlado, e de posse somente usuários administradores e o próprio usuário relacionado ao login (pai e responsável), sendo qualquer alteração de informações de login, requisitada e aprovada por um administrador, evitando falhas no sistema e igualdade de informações com campo e sistema (banco de dados);

**Acesso à Informações:**
Um usuário, pai de aluno, terá acesso a informações condizentes com seu cadastro, sendo elas:
  1.	Informações de Pagamento: Informações como data de vencimento, valores e número de parcelas (caso informado mediante assinatura de contrato e cadastro do aluno) serão exibidas na interface principal, facilitando a passagem de informações entre condutor e pai de aluno;
  2.	Visualização de Recibos: O cliente pode visualizar as informações de recibos pagos e, se necessário, imprimi-los em formato PDF no seu celular.

**Notificações:**
Localização: Com base em proximidade, o responsável receberá notificações informando a aproximação da van de sua residência, seguindo uma lógica de metade do caminho e 2/3 do caminho percorrido.

**Interface Simplificada**
A interface desse aplicativo terá como intuito principal a simplicidade, tendo como principal objetivo fornecer informações úteis ao pai ou responsável pelo aluno de forma simples e direta, evitando desconfortos na utilização e dificuldades com acesso as informações.

### Links Confluence e Jira:
[![Jira](https://img.shields.io/badge/Jira-0052CC.svg?style=for-the-badge&logo=Jira&logoColor=white)](https://pac-quarto-semestre.atlassian.net/jira/software/projects/PB/boards/34?atlOrigin=eyJpIjoiODVhM2MyNTA3MGMzNDY4MThlYTc1NmNmNDU0MmU0YzkiLCJwIjoiaiJ9)
[![Confluence](https://img.shields.io/badge/Confluence-172B4D.svg?style=for-the-badge&logo=Confluence&logoColor=white)](https://pac-quarto-semestre.atlassian.net/l/cp/bWQhD1fh)
[![Canva](https://img.shields.io/badge/Canva-%2300C4CC.svg?style=for-the-badge&logo=Canva&logoColor=white)](https://www.canva.com/design/DAGX50bJoZ8/Nf-9LuNJ_nhOLeVHckdCNw/edit?utm_content=DAGX50bJoZ8&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)


### Alunos:
- Eric Gabriel Caetano
- Felipe da Silva Chawischi
- Francisco Marcelo Caetano Costa
- Gabriel Felipe Alves Bandoch
- João Guilherme T. Dalmarco
- Lucas Grimes Ceola
