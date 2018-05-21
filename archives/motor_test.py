#!/usr/bin/python
from Adafruit_MotorHAT import Adafruit_MotorHAT, Adafruit_DCMotor
from Adafruit_MotorHAT.Adafruit_PWM_Servo_Driver import PWM

 
import time
import atexit

pwm = PWM(0x6f, debug=True)
pwm.setPWMFreq(1600)

# create a default object, no changes to I2C address or frequency
mh = Adafruit_MotorHAT(addr=0x6f)


# recommended for auto-disabling motors on shutdown!
def turnOffMotors():
	mh.getMotor(1).run(Adafruit_MotorHAT.RELEASE)
	mh.getMotor(2).run(Adafruit_MotorHAT.RELEASE)
	# mh.getMotor(3).run(Adafruit_MotorHAT.RELEASE)
	# mh.getMotor(4).run(Adafruit_MotorHAT.RELEASE)
 
atexit.register(turnOffMotors)

right = mh.getMotor(1)
left = mh.getMotor(2)

# set the speed to start, from 0 (off) to 255 (max speed)
right.setSpeed(150)
left.setSpeed(150)


while (False):
	print "Forward! "
	right.run(Adafruit_MotorHAT.FORWARD)
	left.run(Adafruit_MotorHAT.FORWARD)
 
	print "\tSpeed up..."
	for i in range(255):
		right.setSpeed(i)
		left.setSpeed(i)
		time.sleep(0.01)
 
	print "\tSlow down..."
	for i in reversed(range(255)):
		right.setSpeed(i)
		left.setSpeed(i)
		time.sleep(0.01)
 
	print "Backward! "
	right.run(Adafruit_MotorHAT.BACKWARD)
	left.run(Adafruit_MotorHAT.BACKWARD)
 
	print "\tSpeed up..."
	for i in range(255):
		right.setSpeed(i)
		left.setSpeed(i)
		time.sleep(0.01)
 
	print "\tSlow down..."
	for i in reversed(range(255)):
		right.setSpeed(i)
		left.setSpeed(i)
		time.sleep(0.01)
 
	print "Release"
	right.run(Adafruit_MotorHAT.RELEASE)
	left.run(Adafruit_MotorHAT.RELEASE)
	time.sleep(1.0)


