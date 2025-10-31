extends Node

var currentTime = 240
var hour = 4
var isDay = true
var curDay = 1
var quota = 100
var quotaTime = 239
const maxTime = 1440

var paused = false

signal timeOfDay(time, isDay)
