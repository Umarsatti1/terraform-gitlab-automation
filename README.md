# Automating AWS Infrastructure Deployment using Terraform and GitLab

This guide provides step-by-step instructions for automating AWS infrastructure deployment using **Terraform** and **GitLab CI/CD**.

---

## Step 1: Clone Basic AWS Infrastructure

Clone the starter infrastructure template from GitHub:

```bash
git clone https://github.com/Umarsatti1/basic-terraform-infra.git
cd basic-terraform-infra
```

---

## Step 2: Configure Terraform Backend

Terraform uses a backend to store the state file and lock the state during changes. We'll use **S3** and **DynamoDB**.

### Step 2.1: Navigate to the Backend Folder

```bash
cd backend
```

### Step 2.2: Deploy S3 Bucket and DynamoDB Table

The backend folder already contains the code for backend resources.

```bash
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

---

## Step 3: Push the Project to GitLab

1. Create a **new repository** on GitLab.
2. Push the local project:

```bash
git remote add origin https://gitlab.com/your-username/your-repo.git
git branch -M main
git push -u origin main
```

---

## Step 4: Add GitLab CI/CD Pipeline

Add a `.gitlab-ci.yml` file to the root of your repository with the following content:

```yaml
image:
  name: hashicorp/terraform:light
  entrypoint:
    - '/usr/bin/env'
    - 'PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'

before_script:
  - export AWS_ACCESS_KEY=${AWS_ACCESS_KEY_ID}
  - export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
  - ssh-keygen -t rsa -b 2048 -f tf-key-pair -N ""
  - terraform --version
  - terraform init

stages:
  - validate
  - plan
  - apply
  - destroy

validate:
  stage: validate
  script:
    - terraform validate

plan:
  stage: plan
  dependencies:
    - validate
  script:
    - terraform plan -out "planfile"
  artifacts:
    paths:
      - planfile

apply:
  stage: apply
  dependencies:
    - plan
  script:
    - terraform apply -auto-approve
  when: manual

destroy:
  stage: destroy
  script:
    - terraform destroy -auto-approve
  when: manual
```

---

## Step 5: Set GitLab CI/CD Environment Variables

Navigate to your GitLab repository ➝ **Settings** ➝ **CI/CD** ➝ **Variables**:

- `AWS_ACCESS_KEY_ID`: Your AWS Access Key
- `AWS_SECRET_ACCESS_KEY`: Your AWS Secret Key

---

## Step 6: Apply Code Changes and Run Pipeline

After committing changes, GitLab will trigger the pipeline automatically.

To apply or destroy infrastructure, **manually trigger** the respective jobs (`apply` or `destroy`) from the pipeline UI.

---

## Additional Notes

- Always ensure backend resources (S3/DynamoDB) are deployed before initializing Terraform.
- Use branches for safer workflow and avoid applying changes directly on `main` unless intended.

---