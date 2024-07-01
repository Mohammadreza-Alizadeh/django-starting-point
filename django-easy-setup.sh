#!/bin/bash

# Defining variables
TEMPLATE_URL="https://github.com/Mohammadreza-Alizadeh/django-starting-point.git"
VENV_DIR="./env"
INITIAL_DIRS=$(ls -d */)

main(){

    # creating venv
    create_venv
    activate_venv
    check_cookiecutter
    verify_installation

    # Using cookiecutter to clone my template
    cookiecutter $TEMPLATE_URL
    
    # Finding out the project name via finding new generated directory  
    FINAL_DIRS=$(ls -d */)
    PROJECT_DIR=$(comm -13 <(echo "$INITIAL_DIRS") <(echo "$FINAL_DIRS"))
    

    echo $PROJECT_DIR
    # Going to project root and installing dependencies
    cd $PROJECT_DIR
    install_requirements
    cp .env.example .env

    # Setup docker containers
    docker compose -f docker-compose.dev.yml up -d
    if [ $? -eq 0 ]; then
        echo "Containers are created"
    else
        echo "Failed to create or run the containers."
        exit 1
    fi


    # Migrate tables and runserver
    python manage.py migrate
    python manage.py runserver
    

}

# Function to create a virtual environment if it doesn't exist
create_venv() {
    if [ ! -d "$VENV_DIR" ]; then
        echo "Creating virtual environment..."
        python3 -m venv "$VENV_DIR"
        if [ $? -eq 0 ]; then
            echo "Virtual environment created successfully."
        else
            echo "Failed to create virtual environment."
            exit 1
        fi
    else
        echo "Virtual environment already exists."
    fi
}

# Function to activate the virtual environment
activate_venv() {
    echo "Activating virtual environment..."
    source "$VENV_DIR/bin/activate"
    if [ $? -eq 0 ]; then
        echo "Virtual environment activated."
    else
        echo "Failed to activate virtual environment."
        clear_some_mess
        exit 1
    fi
}

# Function to clear venv directory if it exists ( in case of faliure in operation )
clear_some_mess() {
    if [ -d "$VENV_DIR" ]; then
        echo "Removing existing virtual environment..."
        rm -rf "$VENV_DIR"
        if [ $? -eq 0 ]; then
            echo "Virtual environment removed successfully."
        else
            echo "Failed to remove virtual environment."
            exit 1
        fi
    else
        echo "No existing virtual environment to remove."
    fi
}


check_cookiecutter() {
    if pip list | grep cookiecutter &> /dev/null
    then
        echo "cookiecutter is already installed."
    else
        echo "cookiecutter is not installed."
        install_cookiecutter
    fi
}

# Function to install cookiecutter
install_cookiecutter() {
    echo "Installing cookiecutter..."
    pip install cookiecutter
    if [ $? -eq 0 ]; then
        echo "cookiecutter installed successfully."
    else
        echo "Failed to install cookiecutter."
        clear_some_mess
        exit 1
    fi
}

# Function to verify the installation of cookiecutter
verify_installation() {
    if pip list | grep cookiecutter &> /dev/null
    then
        echo "cookiecutter installation verified."
    else
        echo "cookiecutter installation verification failed."
        clear_some_mess
        exit 1
    fi
}

# Function to install dependencies
install_requirements() {
    echo "Installing dependencies in requirements.txt"
    pip install -r requirements.txt
    
    if [ $? -eq 0 ]; then
        echo "requirements installed successfully."
    else
        echo "Failed to install requirements."
        exit 1
    fi

}


# Function to check the status of docker compose services
check_containers_running() {
    # Get the status of all containers
    status=$(docker compose -f docker-compose.dev.yml ps --services --filter "status=running")

    # Get the total number of services defined in the docker-compose.dev.yml
    total_services=$(docker compose -f docker-compose.dev.yml config --services | wc -l)

    # Get the number of running services
    running_services=$(echo "$status" | wc -l)

    if [ "$running_services" -eq "$total_services" ]; then
        echo "All containers are running."
    else
        echo "Not all containers are running."
        echo "Total services: $total_services"
        echo "Running services: $running_services"
        exit 1
    fi
}


main