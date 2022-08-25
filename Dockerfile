FROM ubuntu:latest

RUN apt update -y
RUN apt install wget -y
RUN apt install curl -y
RUN apt install jq -y