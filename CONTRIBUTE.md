# TdBench Contributing Guide

Thank-you for taking the time to contribute to TdBench. Your contributions will improve the quality and productivity of testing 
- new application workloads
- platform software and physical data model changes
- comparative platform evaluations
- DBMS Feature engineering

Submitted materials would likely be for one existing or new DBMS directory under the setup subdirectory. 
The files in that directory would likely be:
- .sh - shell scripts for Linux
- .bat - shell scripts for Windows
- .txt - documentation and parameters
- .md - markdown files for documentation
- .sql - SQL scripts to execute against your DBMS
- .tdb - TdBench scripts
- setup.menu - The file used by the SETUP command in TdBench

We can't validate binary files to be free of viruses so we probably can't accept them in a pull request.
DBMS Vendors have license restrictions on the use of their JDBC modules and anything posted to github may quickly be out-of-date. 
Instead provide instructions or links to vendor's OFFICIAL site for the user to download the JDBC driver.
Don't make links to sites that can't easily be validated. 

Do not contribute material that is proprietary or that may have ownership claims by others. 

### Steps to submit

You will need to have a copy of GitHub on your PC or server.  

#### 1. Create a fork of this repository

- in the upper right of this GitHub web page is a button to create a Fork
- It will initialize the name of the forked repository with you as the owner name
- It will default the name of the forked repository as "tdbench" (under your user name)
- Put in a description of what you intend to develop
- Leave the check mark to "Copy the main branch only"
- click the "Create fork" button

This merely creates a list of pointers to the contents of the current repository

#### 2. Get a copy of the forked repository to your PC

git clone https://github.com/<your-github-username>/tdbench.git<br>
cd tdbench

#### 3. create a branch:
git checkout -b <new feature name>

<i> Make your changes or additions to the setup directory. 

If there is significant elapsed time between cloning to your PC, the following will ensure your main branch is up to date: </i>

git remote add upstream https://github.com/Teradata/tdbench.git<br>
git fetch upstream<br>
git checkout main<br>
git merge upstream/main<br>

#### 4. Stage and Commit the Changes
git add setup/\<your DBMS\><br>
git commit -m " ... describe your changes ... "

#### 5. Push the changes to your Fork
git push origin <new feature name>

#### 6. Create a pull request

- go to the GitHub page of your forked repository
- click the "Compare & pull request" button next to your feature branch
- Add a descriptive title to your pull request
- <B>Important</B> - We would like to give credit for any contributions. In the description for your pull request, provide your name, company and confirm if we may document you as the contributor in the version_history.txt file.
- <B>Important</B> - Make a simple statement confirming that you are the author of the materials and is not copyrighted by any organization.

We will evaluate your submission and get back to you. 

# THANK-YOU
