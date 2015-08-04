# Users for email

ubuntu:
    user.absent:
        - purge: True

okso:
    group.present:
        - gid: 1000

    user.present:
        - fullname: "OKso"
        - password: "$6$V28UEzoY$ZNPdW6hjAZuiYzCR2T1VWKGKo754YoBz7VHc/b/gb33ZrewGqjU/fFuj7AF7azaVzu8X0FMrHrDAUXRfYAh3q1"
        - uid: 1000
        - gid_from_name: True

