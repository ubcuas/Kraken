from pymavlink import mavutil
from time import sleep
import sys
# the_connection = mavutil.mavlink_connection('/dev/tty.usbmodem14401', 115200)
the_connection = mavutil.mavlink_connection('udp:localhost:5760')
# print(dir(the_connection.mav))

#wait for a connection
the_connection.wait_heartbeat()
print("Heartbeat from system (system %u component %u)" % (the_connection.target_system, the_connection.target_component))

rate_in_Hz = 1

while True:
    # the_connection.mav.request_data_stream_send(the_connection.target_system, the_connection.target_component,
    #                                     mavutil.mavlink.MAV_DATA_STREAM_EXTENDED_STATUS, rate_in_Hz, 1)
    the_connection.set_message_interval()
    msg = the_connection.recv_match(type='SYS_STATUS',blocking=True)
    if not msg:
        continue
    if msg.get_type() == "BAD_DATA":
        if mavutil.all_printable(msg.data):
            sys.stdout.write(msg.data)
            sys.stdout.flush()
    else:
        #Message is valid
        # Use the attribute
        print(msg)
    # print(len(the_connection.messages))
    # sleep(1)
# from time import sleep
# the_connection.mav.request_data_stream_send(the_connection.target_system, the_connection.target_component,mavutil.mavlink.MAV_DATA_STREAM_ALL, 1, 1)
# while True:
#     sleep(1)
#     print(vars(the_connection.mav))