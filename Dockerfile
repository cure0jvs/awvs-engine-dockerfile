FROM ubuntu:latest
RUN mkdir /data
WORKDIR /data
RUN apt-get update && apt-get upgrade -y && apt-get install -y sudo apt-utils net-tools && rm -rf /var/lib/apt/lists/*
RUN apt-get update && sudo apt-get install libxdamage1 libgtk-3-0 libasound2 libnss3 libxss1 libx11-xcb1 -y
COPY ./acunetix_13.0.200217097_x64_.sh .
RUN chmod u+x acunetix_13.0.200217097_x64_.sh
RUN sh -c '/bin/echo -e "\nyes\n" |  ./acunetix_13.0.200217097_x64_.sh --engineonly'
RUN chmod u+x /home/acunetix/.acunetix/start.sh
COPY ./license_info.json /home/acunetix/.acunetix/data/license/license_info.json
COPY ./wvsc /home/acunetix/.acunetix/v_200217097/scanner/wvsc
RUN chown acunetix:acunetix /home/acunetix/.acunetix/data/license/license_info.json
RUN chown acunetix:acunetix /home/acunetix/.acunetix/v_200217097/scanner/wvsc
RUN chmod u+x /home/acunetix/.acunetix/data/license/license_info.json
RUN chmod u+x /home/acunetix/.acunetix/v_200217097/scanner/wvsc
USER acunetix
ENTRYPOINT /home/acunetix/.acunetix/start.sh
