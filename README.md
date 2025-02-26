# Project Name
 CoachPro Management App

## Description

The CoachPro Management App aims to develop a comprehensive system for managing group coaching programs within a company. This feature will streamline the creation, administration, and participation processes for both coaches and employees. The project involves the creation of an administration panel, coach assignment functionality, company landing pages, employee and coach dashboards, as well as robust unit testing. The solution will be built using Ruby on Rails (RoR) with considerations for incorporating React to enhance the user interface.

## Table of Contents

- [Clone](#clone)
- [Installation](#installation)
- [Usage](#usage)
  
## Clone 
1. *Clone the repository*
   ```bash
   https://github.com/prashantror/CoachPro-Management.git

## Installation

1. **Install RVM:**
   Ensure you have RVM installed.
   If not, install it from here.
   ```bash
   ubuntu - [https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-20-04-quickstart](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rvm-on-ubuntu-20-04)
   
2. **Install Ruby:**
   Ensure you have Ruby installed.
   ##
   If not, install it from here using rvm .
   ```bash
   rvm install ruby-3.0.0

3. **Install Install Postgres:**
   Ensure you have Postgres installed.
   ##
   If not, install it from here .
   ```bash
   ubuntu - https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-20-04-quickstart
   mac - https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-macos

4. **Install Node:**
   Ensure you have Node installed.
   ##
   If not, install it from here .
   ```bash
   ubuntu - https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-20-04
   mac - https://www.digitalocean.com/community/tutorials/how-to-install-node-js-and-create-a-local-development-environment-on-macos

5. **Install Yarn:**
   Ensure you have Node installed.
   ##
   If not, install it from here .
   ```bash
   https://www.digitalocean.com/community/tutorials/how-to-install-and-use-the-yarn-package-manager-for-node-js

## Usage

1. **Navigate to the project directory:**
   ```bash
   cd CoachPro-Management
   
2. **Set the Postgres username and password:**
   ##
   Navigate the **database.yml** file and update the your postgres **username** and **password**

3. **Run Bundle install :**
   Execute the following command:
   ```bash
   bundle install

4. **Run yarn install :**
   Execute the following command for the install the react js packages and dependencies libraries:
   ```bash
   yarn install

5. **Create the Database :**
   Ensure you have updated Postgres username and password.
   ##
   Execute the following command for create database:
   ```bash
   rails db:create

6. **Migrate the Database :**
   Ensure you have updated Postgres username and password.
   ##
   Execute the following command for migrate database:
   ```bash
   rails db:migrate

7. **Run the seed file :**
   Ensure you have updated Postgres username and password.
   ##
   Execute the following command to get the dummy data on local:
   ```bash
   rails db:seed

9. **Run the Project :**
   Execute the following command to start the rails server:
   ```bash
   rails s
