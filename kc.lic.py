#!/usr/bin/env python

from __future__ import with_statement
from __future__ import print_function
import os
import sys
import platform
import base64
import webbrowser
import subprocess
import time
try:
  input = raw_input
except NameError:
  pass

qhome = os.getenv('QHOME')
if not qhome or not os.path.isdir(qhome):
  print('QHOME env is not set to a directory.', file=sys.stderr)
  sys.exit(2)

qlic = os.getenv('QLIC', qhome)
if not os.path.isdir(qlic):
  print('QLIC env is not set to a directory.', file=sys.stderr)
  sys.exit(2)

qarch = {'Linux':'l64', 'Darwin':'m64', 'Windows':'w64'}
plat = platform.system()
if not plat in qarch:
  print("Unknown platform: '{}'.".format(plat), file=sys.stderr)
  sys.exit(2)
qplat = qarch[plat]
qbin, cbin = ("q.exe", "q.py") if qplat == "w64" else ("q", "q")
qpath = os.path.join(qhome, qplat, qbin)
if not os.path.isfile(qpath):
  print("Missing q binary at {}".format(qpath), file=sys.stderr)
  sys.exit(2)

lic_found = False
for l in ['kx.lic', 'kc.lic', 'k4.lic']:
  for p in ['.', qlic, qhome]:
    lic_path = os.path.join(p, l)
    if os.path.isfile(lic_path):
      lic_found = True
      break
  if lic_found:
    break

if not lic_found:
  lic_path = None

for env_name, lic_name in [('QLIC_KC', 'kc.lic'), ('QLIC_K4', 'k4.lic')]:
  b64lic = os.getenv(env_name)
  if b64lic:
    if lic_path:
      print("Ignoring environment variable {}, as license found at {}".format(env_name, lic_path), file=sys.stderr)
      print("Please remove {}, or unset {}, as appropriate.\n".format(lic_path, env_name), file=sys.stderr)
      break
    try:
      lic = base64.b64decode(b64lic)
    except base64.binascii.Error:
      print("Invalid license code in environment variable {}.".format(env_name), file=sys.stderr)
      sys.exit(1)
    lic_path = os.path.join(qlic, lic_name)
    print("Writing out license code from environment variable {} to {}".format(env_name, lic_path))
    print()
    with open(lic_path, 'wb') as file:
      file.write(lic)
    break

headless = """\
Headless detected and no license found.

If you do not have a license, run q interactively from the command line before running headless.

If you do have a license, copy it to {}

Alternatively, set environment variable QLIC_KC (for kc.lic) or QLIC_K4 (for k4.lic) with the base-64 encoded contents of your license.
""".format(qhome)

lic_url = "https://kx.com/kdb-personal-edition-download/"

if not lic_path:
  if not (sys.stdin.isatty() and sys.stdout.isatty()):
    print(headless, file=sys.stderr)
    sys.exit(1)
  else:
    print("No license found. Would you like to visit kx.com now to obtain a license?")
    while True:
      ret = input("y/n: ").lower()
      print()
      if ret in ["n", "no"]:
          print("Please contact KX to request a license.")
          print("You can install a license manually by copying it to {}".format(qlic))
          sys.exit(1)
      if ret in ["y", "yes"]:
          break
      print("Invalid option.", file=sys.stderr)
    print("Redirecting browser to {}".format(lic_url))
    print("Please fill out your details to obtain a license via email.")
    webbrowser.open(lic_url)
    time.sleep(2)
    print()
    b64lic = input('Input base64 license code here (or press enter to install manually): ')
    print()
    if(len(b64lic) == 0):
      print("To install license manually, copy to {}".format(qlic))
      sys.exit(1)
    try:
      lic = base64.b64decode(b64lic)
    except base64.binascii.Error:
      print("Invalid license code.", file=sys.stderr)
      sys.exit(1)
    lic_name = 'kc.lic'
    lic_path = os.path.join(qlic, lic_name)
    print("Writing out license to {}".format(lic_path))
    print()
    with open(lic_path, "wb") as binary_file:
      binary_file.write(lic)

proc = subprocess.Popen([qpath], stdin=subprocess.PIPE, stderr=subprocess.PIPE)
proc.stdin.write(b"\\\\\n")
proc.stdin.close()
while proc.returncode is None:
    proc.poll()
errstr = proc.stderr.read()
if not type(errstr) == str:
    errstr = errstr.decode()
for errline in errstr.split('\n'):
    if "licence error:" in errline:
        print("Error detected: {}".format(errline), file=sys.stderr)
        print("Check file {}".format(lic_path), file=sys.stderr)
        sys.exit(1)

args = list(sys.argv)
if os.path.basename(args[0].lower()) == cbin:
    args[0] = qpath
    retcode = subprocess.call(args)
    sys.exit(retcode)
