#!/usr/bin/env python3
# Author: Mikey Redmond

import discord
import os
import sys
import shlex
import subprocess
from discord.ext import commands


client = commands.Bot(command_prefix = '.')

@client.event
async def on_ready():
    print('We have logged in as {0.user}'.format(client))

@client.event
async def on_message(message):
    if message.author == client.user:
        return

    if message.content.startswith('.hello'):
        await message.channel.send('Hello!')

    if message.content.startswith('.ping'):
        await message.channel.send(f'Pong! {round (client.latency * 1000)}ms ')

    if message.content.startswith('.getprice'):
        userInput = message.content[9:]
        unproc = subprocess.check_output(shlex.split(f"sh getprice.sh {userInput}"))
        await message.channel.send("$"+unproc.strip().decode('ascii'))

    if message.content.startswith('.covid'):
        unproc = subprocess.check_output(shlex.split("sh covid.sh"))
        await message.channel.send(unproc.strip().decode('ascii'))

    if message.content.startswith('.shutdown'):
        await message.channel.send("Shutting down")
        unproc = subprocess.check_output(shlex.split("sudo halt"))

    if message.content.startswith('.reboot'):
        await message.channel.send("Rebooting")
        unproc = subprocess.check_output(shlex.split("sudo reboot"))

    if message.content.startswith('.restart'):
        await message.channel.send("Restarting")
        unproc = subprocess.check_output(shlex.split("sudo systemctl restart EZ.service"))


client.run('YOUR TOKEN HERE')
